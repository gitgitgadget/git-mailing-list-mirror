From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git p4: implement view spec wildcards with "p4 where"
Date: Tue, 03 Sep 2013 11:13:04 -0700
Message-ID: <xmqqvc2hsrin.fsf@gitster.dls.corp.google.com>
References: <CACGba4xVs0_TNti-MwDdefGhHNZXXirkk++RX8c7xiUHCWJDwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: kazuki saitoh <ksaitoh560@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 20:13:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGv6N-0006OB-5n
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 20:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759544Ab3ICSNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 14:13:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34318 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757058Ab3ICSNN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 14:13:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F2DF3EA09;
	Tue,  3 Sep 2013 18:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cba6tkgdhBUd/PALltZoDymDoeE=; b=tF9Y9/
	bIzFGHvvC4COlrGPL2VFAcwKLqzOgi91OGD4G9D53XUoPd8GsD52zB+5RGAlsaVw
	y9fjYpkLze9QbCBb3YvsLOvlYQmyHqOLYrGIar131hLMDOuwBL/zg1vhDzf6eaRM
	ULJxMKAW46S/Uu5JEDX4NG7xeiq0d6GsR9CJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BR2KrBcIgEwixBN/XA4uuPwD/hKtIJQj
	ZSGHjHo6uo41PqBaZfqxaHrdYnjA63ZiLseYIjpA04J4XtR1fEy/mj9hnrwZhjQn
	J0rgJwqByxRDn+g6UeDMv1/pAKEr6lCSAlpbpF9Y/aYCm4mwvZRYjOM08BoJ++bZ
	UFgWJKwBJC0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E90C03EA05;
	Tue,  3 Sep 2013 18:13:10 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C29EE3E9ED;
	Tue,  3 Sep 2013 18:13:08 +0000 (UTC)
In-Reply-To: <CACGba4xVs0_TNti-MwDdefGhHNZXXirkk++RX8c7xiUHCWJDwA@mail.gmail.com>
	(kazuki saitoh's message of "Fri, 30 Aug 2013 19:02:06 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7CD25BEC-14C4-11E3-8D00-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233754>

kazuki saitoh <ksaitoh560@gmail.com> writes:

> Currently, git p4 does not support many of the view wildcards,
> such as * and %%n.  It only knows the common ... mapping, and
> exclusions.
>
> Redo the entire wildcard code around the idea of
> directly querying the p4 server for the mapping.  For each
> commit, invoke "p4 where" with committed file paths as args and use
> the client mapping to decide where the file goes in git.
>
> This simplifies a lot of code, and adds support for all
> wildcards supported by p4.
> Downside is that there is probably a 20%-ish slowdown with this approach.
>
> [pw: redo code and tests]
>
> Signed-off-by: Kazuki Saitoh <ksaitoh560@gmail.com>
> Signed-off-by: Pete Wyckoff <pw@padd.com>

This was whitespace-damaged in the message I received, so what is
queued is after manual fix-up.  Please double check what will be
queued on 'pu' later and Ack, and then I'll move it to 'next' and
'master'.

Thanks.

> ---
>  git-p4.py | 223 +++++++++++++++++---------------------------------------------
>  1 file changed, 59 insertions(+), 164 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 31e71ff..1793e86 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -780,11 +780,14 @@ def getClientSpec():
>      # dictionary of all client parameters
>      entry = specList[0]
>
> +    # the //client/ name
> +    client_name = entry["Client"]
> +
>      # just the keys that start with "View"
>      view_keys = [ k for k in entry.keys() if k.startswith("View") ]
>
>      # hold this new View
> -    view = View()
> +    view = View(client_name)
>
>      # append the lines, in order, to the view
>      for view_num in range(len(view_keys)):
> @@ -1555,8 +1558,8 @@ class P4Submit(Command, P4UserMap):
>              for b in body:
>                  labelTemplate += "\t" + b + "\n"
>              labelTemplate += "View:\n"
> -            for mapping in clientSpec.mappings:
> -                labelTemplate += "\t%s\n" % mapping.depot_side.path
> +            for depot_side in clientSpec.mappings:
> +                labelTemplate += "\t%s\n" % depot_side
>
>              if self.dry_run:
>                  print "Would create p4 label %s for tag" % name
> @@ -1568,7 +1571,7 @@ class P4Submit(Command, P4UserMap):
>
>                  # Use the label
>                  p4_system(["tag", "-l", name] +
> -                          ["%s@%s" % (mapping.depot_side.path,
> changelist) for mapping in clientSpec.mappings])
> +                          ["%s@%s" % (depot_side, changelist) for
> depot_side in clientSpec.mappings])
>
>                  if verbose:
>                      print "created p4 label for tag %s" % name
> @@ -1796,117 +1799,16 @@ class View(object):
>      """Represent a p4 view ("p4 help views"), and map files in a
>         repo according to the view."""
>
> -    class Path(object):
> -        """A depot or client path, possibly containing wildcards.
> -           The only one supported is ... at the end, currently.
> -           Initialize with the full path, with //depot or //client."""
> -
> -        def __init__(self, path, is_depot):
> -            self.path = path
> -            self.is_depot = is_depot
> -            self.find_wildcards()
> -            # remember the prefix bit, useful for relative mappings
> -            m = re.match("(//[^/]+/)", self.path)
> -            if not m:
> -                die("Path %s does not start with //prefix/" % self.path)
> -            prefix = m.group(1)
> -            if not self.is_depot:
> -                # strip //client/ on client paths
> -                self.path = self.path[len(prefix):]
> -
> -        def find_wildcards(self):
> -            """Make sure wildcards are valid, and set up internal
> -               variables."""
> -
> -            self.ends_triple_dot = False
> -            # There are three wildcards allowed in p4 views
> -            # (see "p4 help views").  This code knows how to
> -            # handle "..." (only at the end), but cannot deal with
> -            # "%%n" or "*".  Only check the depot_side, as p4 should
> -            # validate that the client_side matches too.
> -            if re.search(r'%%[1-9]', self.path):
> -                die("Can't handle %%n wildcards in view: %s" % self.path)
> -            if self.path.find("*") >= 0:
> -                die("Can't handle * wildcards in view: %s" % self.path)
> -            triple_dot_index = self.path.find("...")
> -            if triple_dot_index >= 0:
> -                if triple_dot_index != len(self.path) - 3:
> -                    die("Can handle only single ... wildcard, at end: %s" %
> -                        self.path)
> -                self.ends_triple_dot = True
> -
> -        def ensure_compatible(self, other_path):
> -            """Make sure the wildcards agree."""
> -            if self.ends_triple_dot != other_path.ends_triple_dot:
> -                 die("Both paths must end with ... if either does;\n" +
> -                     "paths: %s %s" % (self.path, other_path.path))
> -
> -        def match_wildcards(self, test_path):
> -            """See if this test_path matches us, and fill in the value
> -               of the wildcards if so.  Returns a tuple of
> -               (True|False, wildcards[]).  For now, only the ... at end
> -               is supported, so at most one wildcard."""
> -            if self.ends_triple_dot:
> -                dotless = self.path[:-3]
> -                if test_path.startswith(dotless):
> -                    wildcard = test_path[len(dotless):]
> -                    return (True, [ wildcard ])
> -            else:
> -                if test_path == self.path:
> -                    return (True, [])
> -            return (False, [])
> -
> -        def match(self, test_path):
> -            """Just return if it matches; don't bother with the wildcards."""
> -            b, _ = self.match_wildcards(test_path)
> -            return b
> -
> -        def fill_in_wildcards(self, wildcards):
> -            """Return the relative path, with the wildcards filled in
> -               if there are any."""
> -            if self.ends_triple_dot:
> -                return self.path[:-3] + wildcards[0]
> -            else:
> -                return self.path
> -
> -    class Mapping(object):
> -        def __init__(self, depot_side, client_side, overlay, exclude):
> -            # depot_side is without the trailing /... if it had one
> -            self.depot_side = View.Path(depot_side, is_depot=True)
> -            self.client_side = View.Path(client_side, is_depot=False)
> -            self.overlay = overlay  # started with "+"
> -            self.exclude = exclude  # started with "-"
> -            assert not (self.overlay and self.exclude)
> -            self.depot_side.ensure_compatible(self.client_side)
> -
> -        def __str__(self):
> -            c = " "
> -            if self.overlay:
> -                c = "+"
> -            if self.exclude:
> -                c = "-"
> -            return "View.Mapping: %s%s -> %s" % \
> -                   (c, self.depot_side.path, self.client_side.path)
> -
> -        def map_depot_to_client(self, depot_path):
> -            """Calculate the client path if using this mapping on the
> -               given depot path; does not consider the effect of other
> -               mappings in a view.  Even excluded mappings are returned."""
> -            matches, wildcards = self.depot_side.match_wildcards(depot_path)
> -            if not matches:
> -                return ""
> -            client_path = self.client_side.fill_in_wildcards(wildcards)
> -            return client_path
> -
> -    #
> -    # View methods
> -    #
> -    def __init__(self):
> +    def __init__(self, client_name):
>          self.mappings = []
> +        self.client_prefix = "//%s/" % client_name
> +        # cache results of "p4 where" to lookup client file locations
> +        self.client_spec_path_cache = {}
>
>      def append(self, view_line):
>          """Parse a view line, splitting it into depot and client
> -           sides.  Append to self.mappings, preserving order."""
> +           sides.  Append to self.mappings, preserving order.  This
> +           is only needed for tag creation."""
>
>          # Split the view line into exactly two words.  P4 enforces
>          # structure on these lines that simplifies this quite a bit.
> @@ -1934,76 +1836,62 @@ class View(object):
>              depot_side = view_line[0:space_index]
>              rhs_index = space_index + 1
>
> -        if view_line[rhs_index] == '"':
> -            # Second word is double quoted.  Make sure there is a
> -            # double quote at the end too.
> -            if not view_line.endswith('"'):
> -                die("View line with rhs quote should end with one: %s" %
> -                    view_line)
> -            # skip the quotes
> -            client_side = view_line[rhs_index+1:-1]
> -        else:
> -            client_side = view_line[rhs_index:]
> -
>          # prefix + means overlay on previous mapping
> -        overlay = False
>          if depot_side.startswith("+"):
> -            overlay = True
>              depot_side = depot_side[1:]
>
> -        # prefix - means exclude this path
> +        # prefix - means exclude this path, leave out of mappings
>          exclude = False
>          if depot_side.startswith("-"):
>              exclude = True
>              depot_side = depot_side[1:]
>
> -        m = View.Mapping(depot_side, client_side, overlay, exclude)
> -        self.mappings.append(m)
> +        if not exclude:
> +            self.mappings.append(depot_side)
>
> -    def map_in_client(self, depot_path):
> -        """Return the relative location in the client where this
> -           depot file should live.  Returns "" if the file should
> -           not be mapped in the client."""
> +    def convert_client_path(self, clientFile):
> +        # chop off //client/ part to make it relative
> +        if not clientFile.startswith(self.client_prefix):
> +            die("No prefix '%s' on clientFile '%s'" %
> +                (self.client_prefix, clientFile))
> +        return clientFile[len(self.client_prefix):]
>
> -        paths_filled = []
> -        client_path = ""
> +    def update_client_spec_path_cache(self, files):
> +        """ Caching file paths by "p4 where" batch query """
>
> -        # look at later entries first
> -        for m in self.mappings[::-1]:
> +        # List depot file paths exclude that already cached
> +        fileArgs = [f['path'] for f in files if f['path'] not in
> self.client_spec_path_cache]
>
> -            # see where will this path end up in the client
> -            p = m.map_depot_to_client(depot_path)
> +        if len(fileArgs) == 0:
> +            return  # All files in cache
>
> -            if p == "":
> -                # Depot path does not belong in client.  Must remember
> -                # this, as previous items should not cause files to
> -                # exist in this path either.  Remember that the list is
> -                # being walked from the end, which has higher precedence.
> -                # Overlap mappings do not exclude previous mappings.
> -                if not m.overlay:
> -                    paths_filled.append(m.client_side)
> +        where_result = p4CmdList(["-x", "-", "where"], stdin=fileArgs)
> +        for res in where_result:
> +            if "code" in res and res["code"] == "error":
> +                # assume error is "... file(s) not in client view"
> +                continue
> +            if "clientFile" not in res:
> +                die("No clientFile from 'p4 where %s'" % depot_path)
> +            if "unmap" in res:
> +                # it will list all of them, but only one not unmap-ped
> +                continue
> +            self.client_spec_path_cache[res['depotFile']] =
> self.convert_client_path(res["clientFile"])
>
> -            else:
> -                # This mapping matched; no need to search any further.
> -                # But, the mapping could be rejected if the client path
> -                # has already been claimed by an earlier mapping (i.e.
> -                # one later in the list, which we are walking backwards).
> -                already_mapped_in_client = False
> -                for f in paths_filled:
> -                    # this is View.Path.match
> -                    if f.match(p):
> -                        already_mapped_in_client = True
> -                        break
> -                if not already_mapped_in_client:
> -                    # Include this file, unless it is from a line that
> -                    # explicitly said to exclude it.
> -                    if not m.exclude:
> -                        client_path = p
> +        # not found files or unmap files set to ""
> +        for depotFile in fileArgs:
> +            if depotFile not in self.client_spec_path_cache:
> +                self.client_spec_path_cache[depotFile] = ""
>
> -                # a match, even if rejected, always stops the search
> -                break
> +    def map_in_client(self, depot_path):
> +        """Return the relative location in the client where this
> +           depot file should live.  Returns "" if the file should
> +           not be mapped in the client."""
>
> -        return client_path
> +        if depot_path in self.client_spec_path_cache:
> +            return self.client_spec_path_cache[depot_path]
> +
> +        die( "Error: %s is not found in client spec path" % depot_path )
> +        return ""
>
>  class P4Sync(Command, P4UserMap):
>      delete_actions = ( "delete", "move/delete", "purge" )
> @@ -2130,6 +2018,10 @@ class P4Sync(Command, P4UserMap):
>          """Look at each depotFile in the commit to figure out to what
>             branch it belongs."""
>
> +        if self.clientSpecDirs:
> +            files = self.extractFilesFromCommit(commit)
> +            self.clientSpecDirs.update_client_spec_path_cache(files)
> +
>          branches = {}
>          fnum = 0
>          while commit.has_key("depotFile%s" % fnum):
> @@ -2379,6 +2271,9 @@ class P4Sync(Command, P4UserMap):
>              else:
>                  sys.stderr.write("Ignoring file outside of prefix:
> %s\n" % f['path'])
>
> +        if self.clientSpecDirs:
> +            self.clientSpecDirs.update_client_spec_path_cache(files)
> +
>          self.gitStream.write("commit %s\n" % branch)
>  #        gitStream.write("mark :%s\n" % details["change"])
>          self.committedChanges.add(int(details["change"]))
