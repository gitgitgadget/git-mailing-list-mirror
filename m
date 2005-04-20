From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Give better default modes to merge results.
Date: Wed, 20 Apr 2005 02:55:23 -0700
Message-ID: <7vsm1lkc1g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 11:52:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOBs6-0007Ne-V3
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 11:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVDTJzt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 05:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVDTJzt
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 05:55:49 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:14070 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261524AbVDTJz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 05:55:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050420095524.ZAWQ7956.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 20 Apr 2005 05:55:24 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

As shipped, the example git-merge-one-file-script often leaves
the merge result with not-so-useful mode bits, especially with
glibc 2.0.7 or later whose mkstemp() creates temporary file with
mode 0600.  This contradicts the way checkout-cache creates new
files, which is to use 0666 (or 0777 for files with executable
bit on) and let the umask mechanism to take care of adjusting it
to the user's preference.

This patch fixes this problem by (1) passing the executable bits
for 3 stages from merge-cache to the merge script, and by (2)
adjusting the example script to make use of that information.

For backward compatibility with existing merge-one-file-script
people may already have developed, the additional 3 arguments
are passed after the filename (i.e. as $5, $6 and $7).  This
does not logically look so nice, but the older scripts can and
would just ignore these new parameters.

The patch also fixes some shell quoting problems the original
sample script had with the resulting filename "$4".  Unlike all
the other arguments, this must be quoted to prevent it from
being split via shell's $IFS mechanism.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 git-merge-one-file-script |   35 +++++++++++++++++++++++++++--------
 merge-cache.c             |   18 ++++++++++++++----
 2 files changed, 41 insertions(+), 12 deletions(-)

--- a/git-merge-one-file-script
+++ b/git-merge-one-file-script
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
-	mv $(unpack-file "${2:-$3}") "$4"
-	update-cache --add -- "$4" ;# needs filemode fix.
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
@@ -50,11 +64,16 @@ case "${1:-.}${2:-.}${3:-.}" in
 		echo Leaving conflict merge in $src2
 		exit 1
 	fi
-	cp "$src2" "$4" && update-cache --add -- "$4" && exit 0
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



