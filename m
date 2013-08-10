From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 2/2] git p4: implement view spec wildcards with "p4 where"
Date: Sat, 10 Aug 2013 16:15:13 -0400
Message-ID: <1376165713-26170-2-git-send-email-pw@padd.com>
References: <20130810201123.GA31706@padd.com>
Cc: git@vger.kernel.org
To: kazuki saitoh <ksaitoh560@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 22:15:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8FZd-00053w-Qd
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 22:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758774Ab3HJUPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 16:15:38 -0400
Received: from honk.padd.com ([74.3.171.149]:49972 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758703Ab3HJUPh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 16:15:37 -0400
Received: from arf.padd.com (unknown [50.105.10.190])
	by honk.padd.com (Postfix) with ESMTPSA id 76DC85B1F;
	Sat, 10 Aug 2013 13:15:36 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id E6A8C227F1; Sat, 10 Aug 2013 16:15:33 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.rc2.88.ga5463da
In-Reply-To: <20130810201123.GA31706@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232111>

From: kazuki saitoh <ksaitoh560@gmail.com>

Currently, git p4 does not support many of the view
wildcards, such as * and %%n.  It only knows the
common ... mapping, and exclusions.

Redo the entire wildcard code around the idea of
directly querying the p4 server for the mapping.  For each
unique file, invoke "p4 where //depot/path" and use
the client mapping to decide where the file goes in git.

This simplifies a lot of code, and adds support for all
wildcards supported by p4.  The downside is that each file
triggers a query to the p4 server, possibly making high file
count changes very slow.  If it turns out to be a problem,
we might consider resurrecting the old wildcard code just
for use on the "easy" cases it understands.

[pw: redo code and tests]

Signed-off-by: Kazuki Saitoh <ksaitoh560@gmail.com>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py                     | 204 +++++++++---------------------------------
 t/t9809-git-p4-client-view.sh |  88 ++++++++++++------
 2 files changed, 103 insertions(+), 189 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 31e71ff..40522f7 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -780,11 +780,14 @@ def getClientSpec():
     # dictionary of all client parameters
     entry = specList[0]
 
+    # the //client/ name
+    client_name = entry["Client"]
+
     # just the keys that start with "View"
     view_keys = [ k for k in entry.keys() if k.startswith("View") ]
 
     # hold this new View
-    view = View()
+    view = View(client_name)
 
     # append the lines, in order, to the view
     for view_num in range(len(view_keys)):
@@ -1555,8 +1558,8 @@ class P4Submit(Command, P4UserMap):
             for b in body:
                 labelTemplate += "\t" + b + "\n"
             labelTemplate += "View:\n"
-            for mapping in clientSpec.mappings:
-                labelTemplate += "\t%s\n" % mapping.depot_side.path
+            for depot_side in clientSpec.mappings:
+                labelTemplate += "\t%s\n" % depot_side
 
             if self.dry_run:
                 print "Would create p4 label %s for tag" % name
@@ -1568,7 +1571,7 @@ class P4Submit(Command, P4UserMap):
 
                 # Use the label
                 p4_system(["tag", "-l", name] +
-                          ["%s@%s" % (mapping.depot_side.path, changelist) for mapping in clientSpec.mappings])
+                          ["%s@%s" % (depot_side, changelist) for depot_side in clientSpec.mappings])
 
                 if verbose:
                     print "created p4 label for tag %s" % name
@@ -1796,117 +1799,16 @@ class View(object):
     """Represent a p4 view ("p4 help views"), and map files in a
        repo according to the view."""
 
-    class Path(object):
-        """A depot or client path, possibly containing wildcards.
-           The only one supported is ... at the end, currently.
-           Initialize with the full path, with //depot or //client."""
-
-        def __init__(self, path, is_depot):
-            self.path = path
-            self.is_depot = is_depot
-            self.find_wildcards()
-            # remember the prefix bit, useful for relative mappings
-            m = re.match("(//[^/]+/)", self.path)
-            if not m:
-                die("Path %s does not start with //prefix/" % self.path)
-            prefix = m.group(1)
-            if not self.is_depot:
-                # strip //client/ on client paths
-                self.path = self.path[len(prefix):]
-
-        def find_wildcards(self):
-            """Make sure wildcards are valid, and set up internal
-               variables."""
-
-            self.ends_triple_dot = False
-            # There are three wildcards allowed in p4 views
-            # (see "p4 help views").  This code knows how to
-            # handle "..." (only at the end), but cannot deal with
-            # "%%n" or "*".  Only check the depot_side, as p4 should
-            # validate that the client_side matches too.
-            if re.search(r'%%[1-9]', self.path):
-                die("Can't handle %%n wildcards in view: %s" % self.path)
-            if self.path.find("*") >= 0:
-                die("Can't handle * wildcards in view: %s" % self.path)
-            triple_dot_index = self.path.find("...")
-            if triple_dot_index >= 0:
-                if triple_dot_index != len(self.path) - 3:
-                    die("Can handle only single ... wildcard, at end: %s" %
-                        self.path)
-                self.ends_triple_dot = True
-
-        def ensure_compatible(self, other_path):
-            """Make sure the wildcards agree."""
-            if self.ends_triple_dot != other_path.ends_triple_dot:
-                 die("Both paths must end with ... if either does;\n" +
-                     "paths: %s %s" % (self.path, other_path.path))
-
-        def match_wildcards(self, test_path):
-            """See if this test_path matches us, and fill in the value
-               of the wildcards if so.  Returns a tuple of
-               (True|False, wildcards[]).  For now, only the ... at end
-               is supported, so at most one wildcard."""
-            if self.ends_triple_dot:
-                dotless = self.path[:-3]
-                if test_path.startswith(dotless):
-                    wildcard = test_path[len(dotless):]
-                    return (True, [ wildcard ])
-            else:
-                if test_path == self.path:
-                    return (True, [])
-            return (False, [])
-
-        def match(self, test_path):
-            """Just return if it matches; don't bother with the wildcards."""
-            b, _ = self.match_wildcards(test_path)
-            return b
-
-        def fill_in_wildcards(self, wildcards):
-            """Return the relative path, with the wildcards filled in
-               if there are any."""
-            if self.ends_triple_dot:
-                return self.path[:-3] + wildcards[0]
-            else:
-                return self.path
-
-    class Mapping(object):
-        def __init__(self, depot_side, client_side, overlay, exclude):
-            # depot_side is without the trailing /... if it had one
-            self.depot_side = View.Path(depot_side, is_depot=True)
-            self.client_side = View.Path(client_side, is_depot=False)
-            self.overlay = overlay  # started with "+"
-            self.exclude = exclude  # started with "-"
-            assert not (self.overlay and self.exclude)
-            self.depot_side.ensure_compatible(self.client_side)
-
-        def __str__(self):
-            c = " "
-            if self.overlay:
-                c = "+"
-            if self.exclude:
-                c = "-"
-            return "View.Mapping: %s%s -> %s" % \
-                   (c, self.depot_side.path, self.client_side.path)
-
-        def map_depot_to_client(self, depot_path):
-            """Calculate the client path if using this mapping on the
-               given depot path; does not consider the effect of other
-               mappings in a view.  Even excluded mappings are returned."""
-            matches, wildcards = self.depot_side.match_wildcards(depot_path)
-            if not matches:
-                return ""
-            client_path = self.client_side.fill_in_wildcards(wildcards)
-            return client_path
-
-    #
-    # View methods
-    #
-    def __init__(self):
+    def __init__(self, client_name):
         self.mappings = []
+        self.client_prefix = "//%s/" % client_name
+        # cache results of "p4 where" to lookup client file locations
+        self.client_spec_path_cache = {}
 
     def append(self, view_line):
         """Parse a view line, splitting it into depot and client
-           sides.  Append to self.mappings, preserving order."""
+           sides.  Append to self.mappings, preserving order.  This
+           is only needed for tag creation."""
 
         # Split the view line into exactly two words.  P4 enforces
         # structure on these lines that simplifies this quite a bit.
@@ -1934,75 +1836,49 @@ class View(object):
             depot_side = view_line[0:space_index]
             rhs_index = space_index + 1
 
-        if view_line[rhs_index] == '"':
-            # Second word is double quoted.  Make sure there is a
-            # double quote at the end too.
-            if not view_line.endswith('"'):
-                die("View line with rhs quote should end with one: %s" %
-                    view_line)
-            # skip the quotes
-            client_side = view_line[rhs_index+1:-1]
-        else:
-            client_side = view_line[rhs_index:]
-
         # prefix + means overlay on previous mapping
-        overlay = False
         if depot_side.startswith("+"):
-            overlay = True
             depot_side = depot_side[1:]
 
-        # prefix - means exclude this path
+        # prefix - means exclude this path, leave out of mappings
         exclude = False
         if depot_side.startswith("-"):
             exclude = True
             depot_side = depot_side[1:]
 
-        m = View.Mapping(depot_side, client_side, overlay, exclude)
-        self.mappings.append(m)
+        if not exclude:
+            self.mappings.append(depot_side)
 
     def map_in_client(self, depot_path):
         """Return the relative location in the client where this
            depot file should live.  Returns "" if the file should
            not be mapped in the client."""
 
-        paths_filled = []
-        client_path = ""
-
-        # look at later entries first
-        for m in self.mappings[::-1]:
-
-            # see where will this path end up in the client
-            p = m.map_depot_to_client(depot_path)
-
-            if p == "":
-                # Depot path does not belong in client.  Must remember
-                # this, as previous items should not cause files to
-                # exist in this path either.  Remember that the list is
-                # being walked from the end, which has higher precedence.
-                # Overlap mappings do not exclude previous mappings.
-                if not m.overlay:
-                    paths_filled.append(m.client_side)
-
-            else:
-                # This mapping matched; no need to search any further.
-                # But, the mapping could be rejected if the client path
-                # has already been claimed by an earlier mapping (i.e.
-                # one later in the list, which we are walking backwards).
-                already_mapped_in_client = False
-                for f in paths_filled:
-                    # this is View.Path.match
-                    if f.match(p):
-                        already_mapped_in_client = True
-                        break
-                if not already_mapped_in_client:
-                    # Include this file, unless it is from a line that
-                    # explicitly said to exclude it.
-                    if not m.exclude:
-                        client_path = p
-
-                # a match, even if rejected, always stops the search
-                break
+        if depot_path in self.client_spec_path_cache:
+            return self.client_spec_path_cache[depot_path]
 
+        where_result = p4CmdList(['where', depot_path])
+        if len(where_result) == 0:
+            die("No result from 'p4 where %s'" % depot_path)
+        client_path = ""
+        for res in where_result:
+            if "code" in res and res["code"] == "error":
+                # assume error is "... file(s) not in client view"
+                client_path = ""
+                continue
+            if "clientFile" not in res:
+                die("No clientFile from 'p4 where %s'" % depot_path)
+            if "unmap" in res:
+                # it will list all of them, but only one not unmap-ped
+                continue
+            # chop off //client/ part to make it relative
+            clientFile = res["clientFile"]
+            if not clientFile.startswith(self.client_prefix):
+                die("No prefix '%s' on clientFile '%s'" %
+                    (self.client_prefix, clientFile))
+            client_path = clientFile[len(self.client_prefix):]
+
+        self.client_spec_path_cache[depot_path] = client_path
         return client_path
 
 class P4Sync(Command, P4UserMap):
diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index 77f6349..2ebc6e0 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -75,31 +75,6 @@ test_expect_success 'init depot' '
 	)
 '
 
-# double % for printf
-test_expect_success 'unsupported view wildcard %%n' '
-	client_view "//depot/%%%%1/sub/... //client/sub/%%%%1/..." &&
-	test_when_finished cleanup_git &&
-	test_must_fail git p4 clone --use-client-spec --dest="$git" //depot
-'
-
-test_expect_success 'unsupported view wildcard *' '
-	client_view "//depot/*/bar/... //client/*/bar/..." &&
-	test_when_finished cleanup_git &&
-	test_must_fail git p4 clone --use-client-spec --dest="$git" //depot
-'
-
-test_expect_success 'wildcard ... only supported at end of spec 1' '
-	client_view "//depot/.../file11 //client/.../file11" &&
-	test_when_finished cleanup_git &&
-	test_must_fail git p4 clone --use-client-spec --dest="$git" //depot
-'
-
-test_expect_success 'wildcard ... only supported at end of spec 2' '
-	client_view "//depot/.../a/... //client/.../a/..." &&
-	test_when_finished cleanup_git &&
-	test_must_fail git p4 clone --use-client-spec --dest="$git" //depot
-'
-
 test_expect_success 'basic map' '
 	client_view "//depot/dir1/... //client/cli1/..." &&
 	files="cli1/file11 cli1/file12" &&
@@ -793,6 +768,69 @@ test_expect_success 'overlay sync swap: cleanup' '
 	)
 '
 
+# add a .junk file, make sure it isn't mapped
+test_expect_success 'wildcard * setup' '
+	client_view "//depot/... //client/..." &&
+	(
+		cd "$cli" &&
+		p4 sync &&
+		echo dir1/file13.junk >dir1/file13.junk &&
+		p4 add dir1/file13.junk &&
+		p4 submit -d dir1/file13.junk
+	)
+'
+
+test_expect_success 'wildcard * base case' '
+	client_view "//depot/... //client/..." &&
+	files="dir1/file11 dir1/file12 dir1/file13.junk
+	       dir2/file21 dir2/file22" &&
+	client_verify $files &&
+	test_when_finished cleanup_git &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
+	git_verify $files
+'
+
+test_expect_success 'wildcard * excludes junk file' '
+	client_view "//depot/... //client/..." \
+		    "-//depot/dir1/*.junk //client/dir1/*.junk" &&
+	files="dir1/file11 dir1/file12
+	       dir2/file21 dir2/file22" &&
+	client_verify $files &&
+	test_when_finished cleanup_git &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
+	git_verify $files
+'
+
+test_expect_success 'wildcard * cleanup' '
+	client_view "//depot/... //client/..." &&
+	(
+		cd "$cli" &&
+		p4 sync &&
+		p4 delete dir1/file13.junk &&
+		p4 submit -d "remove dir1/file13.junk"
+	)
+'
+
+test_expect_success 'wildcard ... in middle' '
+	client_view "//depot/.../file11 //client/.../file11" &&
+	files="dir1/file11" &&
+	client_verify $files &&
+	test_when_finished cleanup_git &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
+	git_verify $files
+'
+
+test_expect_success 'wildcard %% mapping' '
+	client_view "//depot/%%1/... //client/map-%%1/..." &&
+	files="map-dir1/file11 map-dir1/file12
+	       map-dir2/file21 map-dir2/file22" &&
+	client_verify $files &&
+	test_when_finished cleanup_git &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
+	git_verify $files
+'
+
+
 #
 # Rename directories to test quoting in depot-side mappings
 # //depot
-- 
1.8.4.rc2.88.ga5463da
