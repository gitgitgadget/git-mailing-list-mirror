From: Brian Gerst <bgerst@didntduck.org>
Subject: [PATCH] Show modified files in git-ls-files
Date: Thu, 01 Sep 2005 20:35:37 -0400
Message-ID: <43179E59.80106@didntduck.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030606000707080506020003"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 02:35:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAzWH-0006Ga-R6
	for gcvg-git@gmane.org; Fri, 02 Sep 2005 02:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbVIBAez (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Sep 2005 20:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030609AbVIBAez
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Sep 2005 20:34:55 -0400
Received: from quark.didntduck.org ([69.55.226.66]:65245 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1030302AbVIBAey (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2005 20:34:54 -0400
Received: from [192.168.1.2] (24-236-201-214.dhcp.aldl.mi.charter.com [24.236.201.214])
	(authenticated)
	by quark.didntduck.org (8.11.6/8.11.6) with ESMTP id j820YoI04487;
	Thu, 1 Sep 2005 20:34:51 -0400
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8004>

This is a multi-part message in MIME format.
--------------030606000707080506020003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add -m/--modified to show files that have been modified wrt. the index.

M was already taken so the tag for modifified files is C (changed).

$ git-ls-files -m -t
C Documentation/git-ls-files.txt
C ls-files.c

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

---

  Documentation/git-ls-files.txt |    4 ++++
  ls-files.c                     |   20 +++++++++++++++-----
  2 files changed, 19 insertions(+), 5 deletions(-)


--------------030606000707080506020003
Content-Type: text/plain;
 name="0001-Show-modified-files-in-git-ls-files.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Show-modified-files-in-git-ls-files.txt"

Subject: [PATCH] Show modified files in git-ls-files

Add -m/--modified to show files that have been modified wrt. the index.

M was already taken so the tag for modifified files is C (changed).

$ git-ls-files -m -t
C Documentation/git-ls-files.txt
C ls-files.c

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

---

 Documentation/git-ls-files.txt |    4 ++++
 ls-files.c                     |   20 +++++++++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

9de83ef7cce7ed5c1aa129cf2a81f8bce3aedb4f
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -33,6 +33,9 @@ OPTIONS
 -d|--deleted::
 	Show deleted files in the output
 
+-m|--modified::
+	Show modified files in the output
+
 -o|--others::
 	Show other files in the output
 
@@ -71,6 +74,7 @@ OPTIONS
 	H	cached
 	M	unmerged
 	R	removed/deleted
+	C	modifed (changed)
 	K	to be killed
 	?	other
 
diff --git a/ls-files.c b/ls-files.c
--- a/ls-files.c
+++ b/ls-files.c
@@ -17,6 +17,7 @@ static int show_ignored = 0;
 static int show_stage = 0;
 static int show_unmerged = 0;
 static int show_killed = 0;
+static int show_modified = 0;
 static int line_terminator = '\n';
 
 static int prefix_len = 0, prefix_offset = 0;
@@ -26,6 +27,7 @@ static const char **pathspec = NULL;
 static const char *tag_cached = "";
 static const char *tag_unmerged = "";
 static const char *tag_removed = "";
+static const char *tag_modified = "";
 static const char *tag_other = "";
 static const char *tag_killed = "";
 
@@ -443,15 +445,18 @@ static void show_files(void)
 			show_ce_entry(ce_stage(ce) ? tag_unmerged : tag_cached, ce);
 		}
 	}
-	if (show_deleted) {
+	if (show_deleted | show_modified) {
 		for (i = 0; i < active_nr; i++) {
 			struct cache_entry *ce = active_cache[i];
 			struct stat st;
+			int err;
 			if (excluded(ce->name) != show_ignored)
 				continue;
-			if (!lstat(ce->name, &st))
-				continue;
-			show_ce_entry(tag_removed, ce);
+			err = lstat(ce->name, &st);
+			if (show_deleted && err)
+				show_ce_entry(tag_removed, ce);
+			if (show_modified && ce_match_stat(ce, &st))
+				show_ce_entry(tag_modified, ce);
 		}
 	}
 }
@@ -547,6 +552,7 @@ int main(int argc, char **argv)
 			tag_cached = "H ";
 			tag_unmerged = "M ";
 			tag_removed = "R ";
+			tag_modified = "C ";
 			tag_other = "? ";
 			tag_killed = "K ";
 			continue;
@@ -559,6 +565,10 @@ int main(int argc, char **argv)
 			show_deleted = 1;
 			continue;
 		}
+		if (!strcmp(arg, "-m") || !strcmp(arg, "--modified")) {
+			show_modified = 1;
+			continue;
+		}
 		if (!strcmp(arg, "-o") || !strcmp(arg, "--others")) {
 			show_others = 1;
 			continue;
@@ -630,7 +640,7 @@ int main(int argc, char **argv)
 	}
 
 	/* With no flags, we default to showing the cached files */
-	if (!(show_stage | show_deleted | show_others | show_unmerged | show_killed))
+	if (!(show_stage | show_deleted | show_others | show_unmerged | show_killed | show_modified))
 		show_cached = 1;
 
 	read_cache();

--------------030606000707080506020003--
