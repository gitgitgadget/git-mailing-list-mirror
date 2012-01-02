From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 5/6] git-p4: rewrite view handling
Date: Mon,  2 Jan 2012 18:05:53 -0500
Message-ID: <1325545554-16540-6-git-send-email-pw@padd.com>
References: <1325545554-16540-1-git-send-email-pw@padd.com>
Cc: Gary Gibbons <ggibbons@perforce.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 03 00:07:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rhqyk-0006lt-KM
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 00:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495Ab2ABXHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jan 2012 18:07:39 -0500
Received: from honk.padd.com ([74.3.171.149]:43667 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335Ab2ABXHh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jan 2012 18:07:37 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id 282D31C7E;
	Mon,  2 Jan 2012 15:07:37 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 83663667D7; Mon,  2 Jan 2012 18:07:34 -0500 (EST)
X-Mailer: git-send-email 1.7.8.1.409.g3e338
In-Reply-To: <1325545554-16540-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187848>

The old code was not very complete or robust.  Redo it.

This new code should be useful for a few possible additions
in the future:

    - support for * and %%n wildcards
    - allowing ... inside paths
    - representing branch specs (not just client specs)
    - tracking changes to views

Mark the remaining 12 tests in t9809 as fixed.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4    |  335 ++++++++++++++++++++++++++++++-----------
 t/t9809-git-p4-client-view.sh |   24 ++--
 2 files changed, 258 insertions(+), 101 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 8f28e0a..3e1aa27 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1169,6 +1169,218 @@ class P4Submit(Command, P4UserMap):
 
         return True
 
+class View(object):
+    """Represent a p4 view ("p4 help views"), and map files in a
+       repo according to the view."""
+
+    class Path(object):
+        """A depot or client path, possibly containing wildcards.
+           The only one supported is ... at the end, currently.
+           Initialize with the full path, with //depot or //client."""
+
+        def __init__(self, path, is_depot):
+            self.path = path
+            self.is_depot = is_depot
+            self.find_wildcards()
+            # remember the prefix bit, useful for relative mappings
+            m = re.match("(//[^/]+/)", self.path)
+            if not m:
+                die("Path %s does not start with //prefix/" % self.path)
+            prefix = m.group(1)
+            if not self.is_depot:
+                # strip //client/ on client paths
+                self.path = self.path[len(prefix):]
+
+        def find_wildcards(self):
+            """Make sure wildcards are valid, and set up internal
+               variables."""
+
+            self.ends_triple_dot = False
+            # There are three wildcards allowed in p4 views
+            # (see "p4 help views").  This code knows how to
+            # handle "..." (only at the end), but cannot deal with
+            # "%%n" or "*".  Only check the depot_side, as p4 should
+            # validate that the client_side matches too.
+            if re.search(r'%%[1-9]', self.path):
+                die("Can't handle %%n wildcards in view: %s" % self.path)
+            if self.path.find("*") >= 0:
+                die("Can't handle * wildcards in view: %s" % self.path)
+            triple_dot_index = self.path.find("...")
+            if triple_dot_index >= 0:
+                if not self.path.endswith("..."):
+                    die("Can handle ... wildcard only at end of path: %s" %
+                        self.path)
+                self.ends_triple_dot = True
+
+        def ensure_compatible(self, other_path):
+            """Make sure the wildcards agree."""
+            if self.ends_triple_dot != other_path.ends_triple_dot:
+                 die("Both paths must end with ... if either does;\n" +
+                     "paths: %s %s" % (self.path, other_path.path))
+
+        def match_wildcards(self, test_path):
+            """See if this test_path matches us, and fill in the value
+               of the wildcards if so.  Returns a tuple of
+               (True|False, wildcards[]).  For now, only the ... at end
+               is supported, so at most one wildcard."""
+            if self.ends_triple_dot:
+                dotless = self.path[:-3]
+                if test_path.startswith(dotless):
+                    wildcard = test_path[len(dotless):]
+                    return (True, [ wildcard ])
+            else:
+                if test_path == self.path:
+                    return (True, [])
+            return (False, [])
+
+        def match(self, test_path):
+            """Just return if it matches; don't bother with the wildcards."""
+            b, _ = self.match_wildcards(test_path)
+            return b
+
+        def fill_in_wildcards(self, wildcards):
+            """Return the relative path, with the wildcards filled in
+               if there are any."""
+            if self.ends_triple_dot:
+                return self.path[:-3] + wildcards[0]
+            else:
+                return self.path
+
+    class Mapping(object):
+        def __init__(self, depot_side, client_side, overlay, exclude):
+            # depot_side is without the trailing /... if it had one
+            self.depot_side = View.Path(depot_side, is_depot=True)
+            self.client_side = View.Path(client_side, is_depot=False)
+            self.overlay = overlay  # started with "+"
+            self.exclude = exclude  # started with "-"
+            assert not (self.overlay and self.exclude)
+            self.depot_side.ensure_compatible(self.client_side)
+
+        def __str__(self):
+            c = " "
+            if self.overlay:
+                c = "+"
+            if self.exclude:
+                c = "-"
+            return "View.Mapping: %s%s -> %s" % \
+                   (c, self.depot_side, self.client_side)
+
+        def map_depot_to_client(self, depot_path):
+            """Calculate the client path if using this mapping on the
+               given depot path; does not consider the effect of other
+               mappings in a view.  Even excluded mappings are returned."""
+            matches, wildcards = self.depot_side.match_wildcards(depot_path)
+            if not matches:
+                return ""
+            client_path = self.client_side.fill_in_wildcards(wildcards)
+            return client_path
+
+    #
+    # View methods
+    #
+    def __init__(self):
+        self.mappings = []
+
+    def append(self, view_line):
+        """Parse a view line, splitting it into depot and client
+           sides.  Append to self.mappings, preserving order."""
+
+        # Split the view line into exactly two words.  P4 enforces
+        # structure on these lines that simplifies this quite a bit.
+        #
+        # Either or both words may be double-quoted.
+        # Single quotes do not matter.
+        # Double-quote marks cannot occur inside the words.
+        # A + or - prefix is also inside the quotes.
+        # There are no quotes unless they contain a space.
+        # The line is already white-space stripped.
+        # The two words are separated by a single space.
+        #
+        if view_line[0] == '"':
+            # First word is double quoted.  Find its end.
+            close_quote_index = view_line.find('"', 1)
+            if close_quote_index <= 0:
+                die("No first-word closing quote found: %s" % view_line)
+            depot_side = view_line[1:close_quote_index]
+            # skip closing quote and space
+            rhs_index = close_quote_index + 1 + 1
+        else:
+            space_index = view_line.find(" ")
+            if space_index <= 0:
+                die("No word-splitting space found: %s" % view_line)
+            depot_side = view_line[0:space_index]
+            rhs_index = space_index + 1
+
+        if view_line[rhs_index] == '"':
+            # Second word is double quoted.  Make sure there is a
+            # double quote at the end too.
+            if not view_line.endswith('"'):
+                die("View line with rhs quote should end with one: %s" %
+                    view_line)
+            # skip the quotes
+            client_side = view_line[rhs_index+1:-1]
+        else:
+            client_side = view_line[rhs_index:]
+
+        # prefix + means overlay on previous mapping
+        overlay = False
+        if depot_side.startswith("+"):
+            overlay = True
+            depot_side = depot_side[1:]
+
+        # prefix - means exclude this path
+        exclude = False
+        if depot_side.startswith("-"):
+            exclude = True
+            depot_side = depot_side[1:]
+
+        m = View.Mapping(depot_side, client_side, overlay, exclude)
+        self.mappings.append(m)
+
+    def map_in_client(self, depot_path):
+        """Return the relative location in the client where this
+           depot file should live.  Returns "" if the file should
+           not be mapped in the client."""
+
+        paths_filled = []
+        client_path = ""
+
+        # look at later entries first
+        for m in self.mappings[::-1]:
+
+            # see where will this path end up in the client
+            p = m.map_depot_to_client(depot_path)
+
+            if p == "":
+                # Depot path does not belong in client.  Must remember
+                # this, as previous items should not cause files to
+                # exist in this path either.  Remember that the list is
+                # being walked from the end, which has higher precedence.
+                # Overlap mappings do not exclude previous mappings.
+                if not m.overlay:
+                    paths_filled.append(m.client_side)
+
+            else:
+                # This mapping matched; no need to search any further.
+                # But, the mapping could be rejected if the client path
+                # has already been claimed by an earlier mapping.
+                already_mapped_in_client = False
+                for f in paths_filled:
+                    # this is View.Path.match
+                    if f.match(p):
+                        already_mapped_in_client = True
+                        break
+                if not already_mapped_in_client:
+                    # Include this file, unless it is from a line that
+                    # explicitly said to exclude it.
+                    if not m.exclude:
+                        client_path = p
+
+                # a match, even if rejected, always stops the search
+                break
+
+        return client_path
+
 class P4Sync(Command, P4UserMap):
     delete_actions = ( "delete", "move/delete", "purge" )
 
@@ -1216,8 +1428,7 @@ class P4Sync(Command, P4UserMap):
         self.p4BranchesInGit = []
         self.cloneExclude = []
         self.useClientSpec = False
-        self.clientSpecDirs = []
-        self.haveSingleFileClientViews = False
+        self.clientSpecDirs = None
 
         if gitConfig("git-p4.syncFromOrigin") == "false":
             self.syncWithOrigin = False
@@ -1268,30 +1479,7 @@ class P4Sync(Command, P4UserMap):
 
     def stripRepoPath(self, path, prefixes):
         if self.useClientSpec:
-
-            # if using the client spec, we use the output directory
-            # specified in the client.  For example, a view
-            #   //depot/foo/branch/... //client/branch/foo/...
-            # will end up putting all foo/branch files into
-            #  branch/foo/
-            for val in self.clientSpecDirs:
-                if self.haveSingleFileClientViews and len(path) == abs(val[1][0]) and path == val[0]:
-                    # since 'path' is a depot file path, if it matches the LeftMap,
-                    # then the View is a single file mapping, so use the entire rightMap
-                    # first two tests above avoid the last == test for common cases
-                    path =  val[1][1]
-                    # now strip out the client (//client/...)
-                    path = re.sub("^(//[^/]+/)", '', path)
-                    # the rest is local client path
-                    return path
-
-                if path.startswith(val[0]):
-                    # replace the depot path with the client path
-                    path = path.replace(val[0], val[1][1])
-                    # now strip out the client (//client/...)
-                    path = re.sub("^(//[^/]+/)", '', path)
-                    # the rest is all path
-                    return path
+            return self.clientSpecDirs.map_in_client(path)
 
         if self.keepRepoPath:
             prefixes = [re.sub("^(//[^/]+/).*", r'\1', prefixes[0])]
@@ -1441,19 +1629,17 @@ class P4Sync(Command, P4UserMap):
         filesToDelete = []
 
         for f in files:
-            includeFile = True
-            for val in self.clientSpecDirs:
-                if f['path'].startswith(val[0]):
-                    if val[1][0] <= 0:
-                        includeFile = False
-                    break
+            # if using a client spec, only add the files that have
+            # a path in the client
+            if self.clientSpecDirs:
+                if self.clientSpecDirs.map_in_client(f['path']) == "":
+                    continue
 
-            if includeFile:
-                filesForCommit.append(f)
-                if f['action'] in self.delete_actions:
-                    filesToDelete.append(f)
-                else:
-                    filesToRead.append(f)
+            filesForCommit.append(f)
+            if f['action'] in self.delete_actions:
+                filesToDelete.append(f)
+            else:
+                filesToRead.append(f)
 
         # deleted files...
         for f in filesToDelete:
@@ -1892,60 +2078,31 @@ class P4Sync(Command, P4UserMap):
 
 
     def getClientSpec(self):
-        specList = p4CmdList( "client -o" )
-        temp = {}
-        for entry in specList:
-            for k,v in entry.iteritems():
-                if k.startswith("View"):
-
-                    # p4 has these %%1 to %%9 arguments in specs to
-                    # reorder paths; which we can't handle (yet :)
-                    if re.search('%%\d', v) != None:
-                        print "Sorry, can't handle %%n arguments in client specs"
-                        sys.exit(1)
-                    if re.search('\*', v) != None:
-                        print "Sorry, can't handle * mappings in client specs"
-                        sys.exit(1)
-
-                    if v.startswith('"'):
-                        start = 1
-                    else:
-                        start = 0
-                    index = v.find("...")
-
-                    # save the "client view"; i.e the RHS of the view
-                    # line that tells the client where to put the
-                    # files for this view.
-
-                    # check for individual file mappings - those which have no '...'
-                    if  index < 0 :
-                        v,cv = v.strip().split()
-                        v = v[start:]
-                        self.haveSingleFileClientViews = True
-                    else:
-                        cv = v[index+3:].strip() # +3 to remove previous '...'
-                        cv=cv[:-3]
-                        v = v[start:index]
-
-                    # now save the view; +index means included, -index
-                    # means it should be filtered out.
-                    if v.startswith("-"):
-                        v = v[1:]
-                        include = -len(v)
-                    else:
-                        include = len(v)
+        specList = p4CmdList("client -o")
+        if len(specList) != 1:
+            die('Output from "client -o" is %d lines, expecting 1' %
+                len(specList))
+
+        # dictionary of all client parameters
+        entry = specList[0]
+
+        # just the keys that start with "View"
+        view_keys = [ k for k in entry.keys() if k.startswith("View") ]
+
+        # hold this new View
+        view = View()
 
-                    # store the View #number for sorting
-                    # and the View string itself (this last for documentation)
-                    temp[v] = (include, cv, int(k[4:]),k)
+        # append the lines, in order, to the view
+        for view_num in range(len(view_keys)):
+            k = "View%d" % view_num
+            if k not in view_keys:
+                die("Expected view key %s missing" % k)
+            view.append(entry[k])
 
-        self.clientSpecDirs = temp.items()
-        # Perforce ViewNN with higher #numbers override those with lower
-        # reverse sort on the View #number
-        self.clientSpecDirs.sort( lambda x, y:  y[1][2] -  x[1][2]  )
+        self.clientSpecDirs = view
         if self.verbose:
-            for val in self.clientSpecDirs:
-                    print "clientSpecDirs: %s %s" % (val[0],val[1])
+            for i, m in enumerate(self.clientSpecDirs.mappings):
+                    print "clientSpecDirs %d: %s" % (i, str(m))
 
     def run(self, args):
         self.depotPaths = []
diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index 1cc83c5..c9471d5 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -107,7 +107,7 @@ test_expect_success 'wildcard ... only supported at end of spec' '
 	test_must_fail "$GITP4" clone --use-client-spec --dest="$git" //depot
 '
 
-test_expect_failure 'basic map' '
+test_expect_success 'basic map' '
 	client_view "//depot/dir1/... //client/cli1/..." &&
 	files="cli1/file11 cli1/file12" &&
 	client_verify $files &&
@@ -116,7 +116,7 @@ test_expect_failure 'basic map' '
 	git_verify $files
 '
 
-test_expect_failure 'client view with no mappings' '
+test_expect_success 'client view with no mappings' '
 	client_view &&
 	client_verify &&
 	test_when_finished cleanup_git &&
@@ -124,7 +124,7 @@ test_expect_failure 'client view with no mappings' '
 	git_verify
 '
 
-test_expect_failure 'single file map' '
+test_expect_success 'single file map' '
 	client_view "//depot/dir1/file11 //client/file11" &&
 	files="file11" &&
 	client_verify $files &&
@@ -144,7 +144,7 @@ test_expect_success 'later mapping takes precedence (entire repo)' '
 	git_verify $files
 '
 
-test_expect_failure 'later mapping takes precedence (partial repo)' '
+test_expect_success 'later mapping takes precedence (partial repo)' '
 	client_view "//depot/dir1/... //client/..." \
 		    "//depot/dir2/... //client/..." &&
 	files="file21 file22" &&
@@ -159,7 +159,7 @@ test_expect_failure 'later mapping takes precedence (partial repo)' '
 #   dir1 cannot go to cli12 since it was filled by dir2
 #   dir1 also does not go to cli3, since the second rule
 #     noticed that it matched, but was already filled
-test_expect_failure 'depot path matching rejected client path' '
+test_expect_success 'depot path matching rejected client path' '
 	client_view "//depot/dir1/... //client/cli3/..." \
 		    "//depot/dir1/... //client/cli12/..." \
 		    "//depot/dir2/... //client/cli12/..." &&
@@ -172,7 +172,7 @@ test_expect_failure 'depot path matching rejected client path' '
 
 # since both have the same //client/..., the exclusion
 # rule keeps everything out
-test_expect_failure 'exclusion wildcard, client rhs same (odd)' '
+test_expect_success 'exclusion wildcard, client rhs same (odd)' '
 	client_view "//depot/... //client/..." \
 		    "-//depot/dir2/... //client/..." &&
 	client_verify &&
@@ -201,7 +201,7 @@ test_expect_success 'exclusion single file' '
 	git_verify $files
 '
 
-test_expect_failure 'overlay wildcard' '
+test_expect_success 'overlay wildcard' '
 	client_view "//depot/dir1/... //client/cli/..." \
 		    "+//depot/dir2/... //client/cli/...\n" &&
 	files="cli/file11 cli/file12 cli/file21 cli/file22" &&
@@ -211,7 +211,7 @@ test_expect_failure 'overlay wildcard' '
 	git_verify $files
 '
 
-test_expect_failure 'overlay single file' '
+test_expect_success 'overlay single file' '
 	client_view "//depot/dir1/... //client/cli/..." \
 		    "+//depot/dir2/file21 //client/cli/file21" &&
 	files="cli/file11 cli/file12 cli/file21" &&
@@ -221,7 +221,7 @@ test_expect_failure 'overlay single file' '
 	git_verify $files
 '
 
-test_expect_failure 'exclusion with later inclusion' '
+test_expect_success 'exclusion with later inclusion' '
 	client_view "//depot/... //client/..." \
 		    "-//depot/dir2/... //client/dir2/..." \
 		    "//depot/dir2/... //client/dir2incl/..." &&
@@ -232,7 +232,7 @@ test_expect_failure 'exclusion with later inclusion' '
 	git_verify $files
 '
 
-test_expect_failure 'quotes on rhs only' '
+test_expect_success 'quotes on rhs only' '
 	client_view "//depot/dir1/... \"//client/cdir 1/...\"" &&
 	client_verify "cdir 1/file11" "cdir 1/file12" &&
 	test_when_finished cleanup_git &&
@@ -266,7 +266,7 @@ test_expect_success 'rename files to introduce spaces' '
 		      "dir 2/file21" "dir 2/file22"
 '
 
-test_expect_failure 'quotes on lhs only' '
+test_expect_success 'quotes on lhs only' '
 	client_view "\"//depot/dir 1/...\" //client/cdir1/..." &&
 	files="cdir1/file11 cdir1/file12" &&
 	client_verify $files &&
@@ -275,7 +275,7 @@ test_expect_failure 'quotes on lhs only' '
 	client_verify $files
 '
 
-test_expect_failure 'quotes on both sides' '
+test_expect_success 'quotes on both sides' '
 	client_view "\"//depot/dir 1/...\" \"//client/cdir 1/...\"" &&
 	client_verify "cdir 1/file11" "cdir 1/file12" &&
 	test_when_finished cleanup_git &&
-- 
1.7.8.1.407.gd70cb
