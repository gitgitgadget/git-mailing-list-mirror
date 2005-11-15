From: Jonas Fonseca <fonseca@diku.dk>
Subject: [RFC] Add support for short help to Cogito commands
Date: Tue, 15 Nov 2005 13:55:16 +0100
Message-ID: <20051115125516.GD13925@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Nov 15 13:55:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec0LJ-0007d4-QV
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 13:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbVKOMzT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 07:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbVKOMzT
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 07:55:19 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:11231 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S932466AbVKOMzR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 07:55:17 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 7045F6DFD6D; Tue, 15 Nov 2005 13:54:51 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 2990F6DF8C8
	for <git@vger.kernel.org>; Tue, 15 Nov 2005 13:54:51 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 4486A6133A; Tue, 15 Nov 2005 13:55:16 +0100 (CET)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11903>

Hi,

I hope I am not the only one feeling that -h can sometimes be a little
too verbose when you want to have a quick overview of a Cogito command.
I'd like to make -h show only a short summary of the available options
and keep the longer help text for --help. I have attached a patch that
does something like this. Example:

  $ cg diff -h
  Usage: cg-diff [-c] [-m] [-s] [-p] [-r FROM_ID[..TO_ID]] [FILE]...

  Options:
    -c                   Colorize the diff output
    -p                   Use parent commit to specified ID
    -s                   Summarize the diff
    -r FROM_ID[..TO_ID]  Specify the revisions to diff
    -m                   Base the diff at the merge base of specified revision
    -h                   Print short usage help
    --help               Print long usage help

If something like this is acceptable, I'd like to know how to proceed
with improving the option captions. I've considered two possibilities:

 - Get the caption from the first line of the option description.  This
   is similar to what the patch does (it also roughly removes everything
   after the first punctuation char). But it will require that all
   option descriptions are changed to have a one line caption at the
   start. Example:

	# ...
	#
	# -r FROM_ID[..TO_ID]::
	#	Specify revisions to diff. Revisions can be specified
	#	using either '-r rev1 ...

 - Add a special line with the caption. Since we already 'filters' the
   help text in the script headers this could go after the '::'.
   Example:

	# ...
	#
	# -r FROM_ID[..TO_ID]:: Specify revisions to diff
	#	Specify the revisions to diff using either '-r rev1
	#	...

   So that it will be easy to remove from the --help output and from the
   generated manpages.

The last option is less intrusive, but does make the syntax of the
script headers less clean. Comments?

diff --git a/cg-Xlib b/cg-Xlib
index fa3a059..a1c89dc 100755
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -347,18 +347,39 @@ deprecated_alias()
 
 print_help()
 {
-	which "cg-$1" >/dev/null 2>&1 || exit 1
+	which "cg-$2" >/dev/null 2>&1 || exit 1
 	sed -n '/^USAGE=/,0s/.*"\(.*\)"/Usage: \1/p;
-	        /^deprecated_alias/,0s/^deprecated_alias \([^ ]*\)/\1 is the new name for/p' < $(which cg-$1) 
+	        /^deprecated_alias/,0s/^deprecated_alias \([^ ]*\)/\1 is the new name for/p' < $(which cg-$2) 
 	echo
-	sed -n '3,/^$/s/^# *//p' < $(which cg-$1)
+	if [ x"$1" = xshort ]; then
+		echo "Options:"
+		_cg_fmt="  %-20s %s\n"
+		sed -n '/# \(-.*::\)/,/^#/s/#//p' < $(which cg-$2) | while read line; do
+			case "$line" in
+			-*::)
+				_cg_option="$(echo -n " $line" | sed 's/ \(-.*\)::/\1/')"
+				;;
+			*)
+				printf "$_cg_fmt" "$_cg_option" \
+					"$(echo "$line" | sed 's/\([^-][^.,]*\)[.,].*/\1/')"
+				_cg_option=
+				;;
+			esac
+		done
+		printf "$_cg_fmt" "-h" "Print short usage help"
+		printf "$_cg_fmt" "--help" "Print long usage help"
+	else
+		sed -n '3,/^$/s/^# *//p' < $(which cg-$2)
+	fi
 	exit
 }
 
 for option in "$@"; do
 	[ x"$option" = x-- ] && break
-	if [ x"$option" = x"-h" -o x"$option" = x"--help" ]; then
-		print_help ${_cg_cmd##cg-}
+	if [ x"$option" = x"-h" ]; then
+		print_help short ${_cg_cmd##cg-}
+	elif [ x"$option" = x"--help" ]; then
+		print_help long ${_cg_cmd##cg-}
 	fi
 done
 
-- 
Jonas Fonseca
