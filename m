From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 10/10] Add -s option to show log summary
Date: Sat, 4 Jun 2005 16:43:34 +0200
Message-ID: <20050604144334.GN12615@diku.dk>
References: <20050604143831.GD12615@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 16:41:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeZp4-0005sB-1H
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 16:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVFDOnr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 10:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVFDOnr
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 10:43:47 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:36351 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261367AbVFDOng (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2005 10:43:36 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 2FF696E2115; Sat,  4 Jun 2005 16:42:55 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id BC3316E1E77; Sat,  4 Jun 2005 16:42:54 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id DA3C761FE0; Sat,  4 Jun 2005 16:43:34 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050604143831.GD12615@diku.dk>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When passing -s to cg-log each log entry is summarized in one line. The line
carries info about commit date, author, first log line and the commit id. It
will look something like the following (with only:

  2005-05-20 11:46 Linus Torvalds   sparse cleanup   e99d59ff0bff349ef20...

The result ends up being 130 chars wide however the commit id is placed so
that it can easily be hidden if line wrapping in the pager is enabled.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 cg-Xlib |    4 +++-
 cg-log  |   53 ++++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -47,10 +47,12 @@ mktemp () {
 
 showdate () {
 	date="$1"
+	format="$2"
+	[ "$format" ] || format=-R
 	sec=${date[0]}; tz=${date[1]}
 	dtz=${tz/+/}
 	lsec=$(expr $dtz / 100 \* 3600 + $dtz % 100 \* 60 + $sec)
-	pdate="$(date -Rud "1970-01-01 UTC + $lsec sec" 2>/dev/null)"
+	pdate="$(date -ud "1970-01-01 UTC + $lsec sec" "$format" 2>/dev/null)"
 
 	echo "${pdate/+0000/$tz}"
 }
diff --git a/cg-log b/cg-log
--- a/cg-log
+++ b/cg-log
@@ -14,15 +14,21 @@
 # cg-log then displays only changes in those files.
 #
 # -c::
-#	Add color to the output. Currently, the colors are:
-#	- `author`:	'cyan'
-#	- `committer`:	'magenta'
-#	- `header`:	'green'
-#	- `files`:	'blue'
-#	- `signoff`:	'yellow'
+#	Colorize to the output. When getting log summary the `date` is
+#	colored 'green', the `author` is colored 'cyan', the `commit ID`
+#	is colored 'blue' and the special line trimming character (~) is
+#	colored 'magenta'. +
+#	+
+#	When getting the full log the colors are:
+#		- `author`:	'cyan'
+#		- `committer`:	'magenta'
+#		- `header`:	'green'
+#		- `files`:	'blue'
+#		- `signoff`:	'yellow'
 #
 # -f::
-#	List affected files.
+#	List affected files. This option does not make sense when using
+#	`-s` to get a log summary.
 #
 # -r FROM_ID[:TO_ID]::
 #	Limit the log information to a set of revisions using either
@@ -36,6 +42,12 @@
 #	End the log listing at the merge base of the -r arguments
 #	(defaulting to master and origin).
 #
+# -s::
+#	Show a one line summary for each log entry. The summary contains
+#	information about the commit date, the author, the first line
+#	of the commit log and the commit ID. Long author and commit log
+#	titles are trimmed but marked with an ending tilde (~).
+#
 # -uUSERNAME::
 #	List only commits where author or committer contains 'USERNAME'.
 #	The search for 'USERNAME' is case-insensitive.
@@ -55,7 +67,7 @@
 #
 #	$ cg-log -r releasetag-0.9:releasetag-0.10
 
-USAGE="cg-log [-c] [-f] [m] [-uUSERNAME] [-r FROM_ID[:TO_ID] FILE..."
+USAGE="cg-log [-c] [-f] [-m] [-s] [-uUSERNAME] [-r FROM_ID[:TO_ID] FILE..."
 
 . ${COGITO_LIB}cg-Xlib
 # Try to fix the annoying "Broken pipe" output. May not help, but apparently
@@ -71,6 +83,7 @@ coldefault=
 list_files=
 log_start=
 log_end=
+summary=
 user=
 mergebase=
 files=()
@@ -107,6 +120,9 @@ while [ "$1" ]; do
 	-m)
 		mergebase=1
 		;;
+	-s)
+		summary=1
+		;;
 	*)
 		files=("$@")
 		break
@@ -196,6 +212,8 @@ print_commit_log() {
 					echo -e "author $author\ncommitter $committer" \
 						| grep -qi "$user" || return
 				fi
+				[ "$summary" ] && continue
+
 				echo ${colheader}commit ${commit%:*} $coldefault
 				echo ${colheader}tree $tree $coldefault
 
@@ -222,6 +240,23 @@ print_commit_log() {
 					s/./    &/
 				'
 				;;
+			*)
+				# Print summary
+				author="${author% <*}"
+				date=(${committer#*> })
+				date="$(showdate $date '+%F %H:%M')"
+				title="$key $rest"
+				if [ "${#title}" -gt 51 ]; then
+					title="${title:0:50}$colcommitter~"
+				fi
+				if [ "${#author}" -gt 20 ]; then
+					author="${author:0:19}$colcommitter~"
+				fi
+
+				printf "$colheader$date $colauthor%-20s $coldefault%-51s $colfiles${commit%:*}$coldefault\n" \
+					"$author" "$title"
+				return
+				;;
 			esac
 		done
 }
@@ -232,6 +267,6 @@ $revls | $revsort | while read time comm
 	log="$(print_commit_log $commit)"
 	if [ "$log" ]; then
 		echo "$log"
-		echo
+		[ "$summary" ] || echo
 	fi
 done | pager
-- 
Jonas Fonseca
