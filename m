From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Give better default modes to merge results.
Date: Sat, 23 Apr 2005 00:03:37 -0700
Message-ID: <7vacnq3rg6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 08:59:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPEbe-0005HX-Th
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 08:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVDWHDw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 03:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVDWHDw
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 03:03:52 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:6807 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261407AbVDWHDo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 03:03:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050423070338.TAQX1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 23 Apr 2005 03:03:38 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

As shipped, the example git-merge-one-file-script often leaves
the merge result with not-so-useful mode bits, especially with
glibc 2.0.7 or later whose mkstemp() creates 0600.  This
contradicts the way checkout-cache creates new files, which is
to use 0666 (or 0777 for files with executable bit on) and let
the umask mechanism to take care of the rest.

This patch fixes this problem by (1) passing the executable bits
for 3 stages from merge-cache to the merge script, and by (2)
adjusting the example script to make use of that information.
Even without the latter "executable bit" change, it results in a
better result (0644 or 0664 vs 0600).

For backward compatibility with existing merge scripts, the
additional 3 arguments are appended after the filename (i.e. as
$5, $6 and $7) as opposed to more logical sha1-1 mode-1 sha1-2,
mode-2, ... order.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

This one is a resend.
Updated to apply on your
  242cdbdd4367c2a2ddd627283aa8da0081b131bc
  New "diff-cache" implementation.

git-merge-one-file-script |   37 +++++++++++++++++++++++++++++--------
merge-cache.c             |   18 ++++++++++++++----
2 files changed, 43 insertions(+), 12 deletions(-)

--- k/git-merge-one-file-script
+++ l/git-merge-one-file-script
@@ -6,7 +6,9 @@
 #   $2 - file in branch1 SHA1 (or empty)
 #   $3 - file in branch2 SHA1 (or empty)
 #   $4 - pathname in repository
-#
+#   $5 - original file executable bit ('x' or '-' or empty)
+#   $6 - file in branch1  executable bit ('x' or '-' or empty)
+#   $7 - file in branch2  executable bit ('x' or '-' or empty)
 #
 # Handle some trivial cases.. The _really_ trivial cases have
 # been handled already by read-tree, but that one doesn't
@@ -24,17 +26,29 @@ case "${1:-.}${2:-.}${3:-.}" in
 #
 "$1.." | "$1.$1" | "$1$1.")
 	rm -f -- "$4"
-	update-cache --remove -- "$4"
-	exit 0
+	exec update-cache --remove -- "$4"
 	;;
 
 #
 # added in one, or added identically in both
 #
 ".$2." | "..$3" | ".$2$2")
-	mv $(unpack-file "${2:-$3}") $4
-	update-cache --add -- $4
-	exit 0
+
+	# This part is convoluted but necessary to get a sane
+	# default mode bits.  We let the shell to honor default
+	# umask when creating the file, and then rely on chmod +x
+	# to again honor umask.  It used to "mv" the file created
+	# in mode 0600 by unpack-file to "$4", which was almost
+	# always wrong.
+
+	tmp=$(unpack-file "${2:-$3}") &&
+	rm -f "$4" &&
+	cat "$tmp" >"$4" &&
+	case "$6$7" in
+	*x*) chmod +x "$4" ;;
+	esac &&
+	rm -f "$tmp" || exit
+	exec update-cache --add -- "$4"
 	;;
 
 #
@@ -50,11 +64,18 @@ case "${1:-.}${2:-.}${3:-.}" in
 		echo Leaving conflict merge in $src2
 		exit 1
 	fi
-	cp "$src2" "$4" && update-cache --add -- "$4" && exit 0
+
+	# See comments for ".$2." | "..$3" | ".$2$2" case.
+	rm -f "$4" &&
+	cat "$src2" >"$4" &&
+	case "$5$6$7" in
+	*x*) chmod +x "$4" ;;
+	esac || exit
+	exec update-cache --add -- "$4"
 	;;
 
 *)
-	echo "Not handling case $1 -> $2 -> $3"
+	echo "Not handling case $1($5) -> $2($6) -> $3($7)"
 	;;
 esac
 exit 1
--- k/merge-cache.c
+++ l/merge-cache.c
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
@@ -36,17 +39,24 @@ static int merge_entry(int pos, const ch
 	arguments[2] = "";
 	arguments[3] = "";
 	arguments[4] = path;
+	arguments[5] = "";
+	arguments[6] = "";
+	arguments[7] = "";
 	found = 0;
 	do {
-		static char hexbuf[4][60];
+		static char hexbuf[3][41];
+		static char xbit[3][2];
 		struct cache_entry *ce = active_cache[pos];
 		int stage = ce_stage(ce);
 
 		if (strcmp(ce->name, path))
 			break;
 		found++;
-		strcpy(hexbuf[stage], sha1_to_hex(ce->sha1));
-		arguments[stage] = hexbuf[stage];
+		strcpy(hexbuf[stage-1], sha1_to_hex(ce->sha1));
+		arguments[stage] = hexbuf[stage-1];
+		xbit[stage-1][0] = (ntohl(ce->ce_mode) & 0100) ? 'x' : '-';
+		xbit[stage-1][1] = 0;
+		arguments[stage+4] = xbit[stage-1];
 	} while (++pos < active_nr);
 	if (!found)
 		die("merge-cache: %s not in the cache", path);

