From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [PATCH] make file merging respect permissions
Date: Sat, 23 Apr 2005 17:44:40 -0400
Message-ID: <1114292680.4799.4.camel@mulgrave>
References: <1114280570.5068.5.camel@mulgrave>
	 <Pine.LNX.4.58.0504231311300.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 00:33:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPTAq-0008Bh-F1
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 00:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVDWWg4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 18:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbVDWWg4
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 18:36:56 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:61659 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262157AbVDWWcu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 18:32:50 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id j3NMWeA15259;
	Sat, 23 Apr 2005 18:32:40 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504231311300.2344@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-04-23 at 13:17 -0700, Linus Torvalds wrote:
> Yeah, yeah, you obviously meant "$?", but the fact 
> is, your patch is bogus, and I don't trust it. Can you re-send a valid
> one 
> (and sign off on it).]

OK, here it is  .. I have an excuse, honest ... and a note from my mum.

---

This patch fixes two problems

1) permissions aren't respected in the merge script (primarily because
they're never passed in to it in the first place).  Fix that and also
check for permission conflicts in the merge

2) the delete of a file in both branches may indeed be just that, but it
could also be the indicator of a rename conflict (file moved to
different locations in both branches), so error out and ask the
committer for guidance.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

--- a/git-merge-one-file-script
+++ b/git-merge-one-file-script
@@ -20,23 +20,47 @@ mkdir -p "$dir"
 
 case "${1:-.}${2:-.}${3:-.}" in
 #
-# deleted in both, or deleted in one and unchanged in the other
+# deleted in both
+#
+"$1..")
+	echo "ERROR: $4 is removed in both branches"
+	echo "ERROR: This is a potential rename conflict"
+	exit 1;;
+#
+# deleted in one and unchanged in the other
 #
 "$1.." | "$1.$1" | "$1$1.")
 	rm -f -- "$4"
+	echo "Removing $4"
 	update-cache --remove -- "$4"
 	exit 0
 	;;
 
 #
-# added in one, or added identically in both
+# added in one
 #
-".$2." | "..$3" | ".$2$2")
-	mv $(unpack-file "${2:-$3}") $4
+".$2." | "..$3" )
+	echo "Adding $4 with perm $6$7"
+	mv $(unpack-file "$2$3") $4
+	chmod "$6$7" $4
 	update-cache --add -- $4
 	exit 0
 	;;
-
+#
+# Added in both (check for same permissions)
+#
+".$2$2")
+	if [ "$6" != "$7" ]; then
+		echo "ERROR:"
+		echo "ERROR: File $4 added in both branches, permissions conflict $6->$7"
+		echo "ERROR:"
+		exit 1
+	fi
+	echo "Adding $4 with perm $6"
+	mv $(unpack-file "$2") $4
+	chmod "$6" $4
+	update-cache --add -- $4
+	exit 0;;
 #
 # Modified in both, but differently ;(
 #
@@ -46,12 +70,21 @@ case "${1:-.}${2:-.}${3:-.}" in
 	src1=$(unpack-file $2)
 	src2=$(unpack-file $3)
 	merge "$src2" "$orig" "$src1"
-	if [ $? -ne 0 ]; then
-		echo Leaving conflict merge in $src2
+	ret=$?
+	if [ "$6" != "$7" ]; then
+		echo "ERROR: Permissions $5->$6->$7 don't match merging $src2"
+		if [ $ret -ne 0 ]; then
+			echo "ERROR: Leaving conflict merge in $src2"
+		fi
+		exit 1
+	fi
+	chmod -- "$6" "$src2"
+	if [ $ -ne 0 ]; then
+		echo "ERROR: Leaving conflict merge in $src2"
 		exit 1
 	fi
-	cp "$src2" "$4" && update-cache --add -- "$4" && exit 0
+	cp -- "$src2" "$4" && chmod -- "$6" "$4" &&  update-cache --add -- "$4" && exit 0
 	;;
 
 *)
--- a/merge-cache.c
+++ b/merge-cache.c
@@ -4,7 +4,7 @@
 #include "cache.h"
 
 static const char *pgm = NULL;
-static const char *arguments[5];
+static const char *arguments[8];
 
 static void run_program(void)
 {
@@ -18,6 +18,9 @@ static void run_program(void)
 			    arguments[2],
 			    arguments[3],
 			    arguments[4],
+			    arguments[5],
+			    arguments[6],
+			    arguments[7],
 			    NULL);
 		die("unable to execute '%s'", pgm);
 	}
@@ -36,9 +39,13 @@ static int merge_entry(int pos, const ch
 	arguments[2] = "";
 	arguments[3] = "";
 	arguments[4] = path;
+	arguments[5] = "";
+	arguments[6] = "";
+	arguments[7] = "";
 	found = 0;
 	do {
 		static char hexbuf[4][60];
+		static char ownbuf[4][60];
 		struct cache_entry *ce = active_cache[pos];
 		int stage = ce_stage(ce);
 
@@ -46,7 +53,9 @@ static int merge_entry(int pos, const ch
 			break;
 		found++;
 		strcpy(hexbuf[stage], sha1_to_hex(ce->sha1));
+		sprintf(ownbuf[stage], "%o", ntohl(ce->ce_mode) & (~S_IFMT));
 		arguments[stage] = hexbuf[stage];
+		arguments[stage + 4] = ownbuf[stage];
 	} while (++pos < active_nr);
 	if (!found)
 		die("merge-cache: %s not in the cache", path);


