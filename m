From: kazuki saitoh <ksaitoh560@gmail.com>
Subject: [PATCH v2] git-p4: Ask "p4" to interpret View setting
Date: Tue, 6 Aug 2013 15:45:29 +0900
Message-ID: <CACGba4zdA=3tBE9UR=i9P9kNAL1HUc3UwSHbYeq4s9fwaN4=Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 06 08:45:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6b1V-0003tr-38
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 08:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940Ab3HFGpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 02:45:33 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:48649 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab3HFGpc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 02:45:32 -0400
Received: by mail-lb0-f181.google.com with SMTP id o10so187327lbi.26
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 23:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=O5p6Ats73yDCkQcKCeGZTRcL6vb4JroeWJhoOlgI5/M=;
        b=rIp9qvYn9W6fuDpj2wZ0mPALBPErl0Gv+6h6QgdFiNf3BjeoVmuQodDPaR21rZDoeq
         CjRNt7OYSqrd3oTCFJSAs7VS6atdi7G/kaRb6Sph1UmQek+mZJt1Pfrs0CNO+QNaBH3U
         6g6nEsND860za5uczSPAUC86NAsSHlOqXKrt12AjP6ECJ2dPfwzTQc8Y1MwrYfrVwWQn
         6lDKErWzImZe1mE/SBnz8KUpzC1dhpcH7Sa8DKmthtSuywn8JzgSvg3UYbCGhY6OYXgz
         ChArarPqyc+wD7sCnRAujpYMD3GDPXqxEXAuatTtXVm/FQhJfkBWDszc56tgARa/VRv8
         ovIg==
X-Received: by 10.112.136.37 with SMTP id px5mr553313lbb.16.1375771530066;
 Mon, 05 Aug 2013 23:45:30 -0700 (PDT)
Received: by 10.114.176.232 with HTTP; Mon, 5 Aug 2013 23:45:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231727>

In Perforce, View setting of p4 client can describe
  -//depot/project/files/*.xls //client/project/files/*.xls
to exclude Excel files.
But "git p4 --use-client-spec" cannot support '*'.

In git-p4.py, "map_in_client" method analyzes View setting and return
client file path.
So I modify the method to just ask p4.


> Let me play with this for a bit.  I wonder about the performance
> aspects of doing a "p4 fstat" for every file.  Would it be
> possible to do one or a few batch queries higher up somewhere?
To reduce p4 access, it cache result of asking "client path".
And addition, "fstat" depends on sync status, so modify to use "p4
where" instead of "fstat".



Signed-off-by: KazukiSaitoh <ksaitoh560@gmail.com>
---
 git-p4.py                     | 53 ++++++-----------------------------
 t/lib-git-p4.sh               |  1 +
 t/t9807-git-p4-submit.sh      |  2 +-
 t/t9809-git-p4-client-view.sh | 65 +++++++++++++++++++++++++++++++++++--------
 4 files changed, 64 insertions(+), 57 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 31e71ff..8ec8eb4 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1819,15 +1819,6 @@ class View(object):
                variables."""

             self.ends_triple_dot = False
-            # There are three wildcards allowed in p4 views
-            # (see "p4 help views").  This code knows how to
-            # handle "..." (only at the end), but cannot deal with
-            # "%%n" or "*".  Only check the depot_side, as p4 should
-            # validate that the client_side matches too.
-            if re.search(r'%%[1-9]', self.path):
-                die("Can't handle %%n wildcards in view: %s" % self.path)
-            if self.path.find("*") >= 0:
-                die("Can't handle * wildcards in view: %s" % self.path)
             triple_dot_index = self.path.find("...")
             if triple_dot_index >= 0:
                 if triple_dot_index != len(self.path) - 3:
@@ -1903,6 +1894,7 @@ class View(object):
     #
     def __init__(self):
         self.mappings = []
+        self.client_spec_path_cache = {}  # Caching result of p4
query, use for "--use-client-spec".

     def append(self, view_line):
         """Parse a view line, splitting it into depot and client
@@ -1965,44 +1957,17 @@ class View(object):
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
+        if self.client_spec_path_cache.has_key(depot_path):
+            return self.client_spec_path_cache[depot_path]

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
+        client_path = ""
+        where_result = p4CmdList(['where', depot_path])
+        for res in where_result:
+            if res["code"] != "error" and not res.has_key("unmap"):
+                client_path = res["path"].replace(getClientRoot()+"/", "")
                 break

+        self.client_spec_path_cache[depot_path] = client_path
         return client_path

 class P4Sync(Command, P4UserMap):
diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 2098b9b..0d631dc 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -48,6 +48,7 @@ P4DPORT=$((10669 + ($testid - $git_p4_test_start)))
 P4PORT=localhost:$P4DPORT
 P4CLIENT=client
 P4EDITOR=:
+P4CHARSET=""
 export P4PORT P4CLIENT P4EDITOR

 db="$TRASH_DIRECTORY/db"
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 1fb7bc7..4caf36e 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -17,7 +17,7 @@ test_expect_success 'init depot' '
  )
 '

-test_expect_failure 'is_cli_file_writeable function' '
+test_expect_success 'is_cli_file_writeable function' '
  (
  cd "$cli" &&
  echo a >a &&
diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index 77f6349..160fd9a 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -75,18 +75,6 @@ test_expect_success 'init depot' '
  )
 '

-# double % for printf
-test_expect_success 'unsupported view wildcard %%n' '
- client_view "//depot/%%%%1/sub/... //client/sub/%%%%1/..." &&
- test_when_finished cleanup_git &&
- test_must_fail git p4 clone --use-client-spec --dest="$git" //depot
-'
-
-test_expect_success 'unsupported view wildcard *' '
- client_view "//depot/*/bar/... //client/*/bar/..." &&
- test_when_finished cleanup_git &&
- test_must_fail git p4 clone --use-client-spec --dest="$git" //depot
-'

 test_expect_success 'wildcard ... only supported at end of spec 1' '
  client_view "//depot/.../file11 //client/.../file11" &&
@@ -836,6 +824,59 @@ test_expect_success 'quotes on both sides' '
  git_verify "cdir 1/file11" "cdir 1/file12"
 '

+#
+# //depot
+#   - dir1
+#     - file11
+#     - file12
+#     - noneed_file11.junk
+#     - noneed_file12.junk
+#   - dir2
+#     - file21
+#     - file22
+#     - noneed_file21.junk
+#     - noneed_file22.junk
+#
+test_expect_success 'wildcard * setup' '
+ client_view "//depot/... //client/..." &&
+ (
+ p4 sync &&
+ cd "$cli" &&
+ rm files &&
+ p4 delete "//depot/..." &&
+ p4 submit -d "delete all files" &&
+ init_depot &&
+
+ cd "$cli" &&
+ p4 sync &&
+
+ echo dir1/noneed_file11.junk >dir1/noneed_file11.junk &&
+ p4 add dir1/noneed_file11.junk &&
+ p4 submit -d "dir1/noneed_file11.junk" &&
+
+ echo dir1/noneed_file12.junk >dir1/noneed_file12.junk &&
+ p4 add dir1/noneed_file12.junk &&
+ p4 submit -d "dir1/noneed_file12.junk" &&
+
+ echo dir2/noneed_file21.junk >dir2/noneed_file21.junk &&
+ p4 add dir2/noneed_file21.junk &&
+ p4 submit -d "dir2/noneed_file21.junk" &&
+
+ echo dir2/noneed_file22.junk >dir2/noneed_file22.junk &&
+ p4 add dir2/noneed_file22.junk &&
+ p4 submit -d "dir2/noneed_file22.junk"
+ )
+'
+test_expect_success 'view wildcard *' '
+ client_view "//depot/... //client/..." \
+ "-//depot/dir1/*.junk //client/dir1/*.junk" \
+ "-//depot/dir2/*.junk //client/dir2/*.junk" &&
+ files="dir1/file11 dir1/file12 dir2/file21 dir2/file22" &&
+ client_verify $files &&
+ git p4 clone --use-client-spec --dest="$git" //depot &&
+ git_verify $files
+'
+
 test_expect_success 'kill p4d' '
  kill_p4d
 '
-- 
1.8.4-rc1
