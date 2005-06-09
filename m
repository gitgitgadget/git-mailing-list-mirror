From: Dan Holmsand <holmsand@gmail.com>
Subject: [PATCH 1/6] Add infrastructure for option parsing to cg-Xlib
Date: Thu, 09 Jun 2005 13:15:14 +0200
Message-ID: <42A824C2.8060207@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010307050408010405010602"
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Jun 09 14:32:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgM0H-0005fD-Pt
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 14:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVFIMXW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 08:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVFIMXW
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 08:23:22 -0400
Received: from main.gmane.org ([80.91.229.2]:35268 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262373AbVFIMVP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 08:21:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DgLXo-0000c7-Vv
	for git@vger.kernel.org; Thu, 09 Jun 2005 13:49:57 +0200
Received: from 81-224-201-139-no45.tbcn.telia.com ([81.224.201.139])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 13:49:56 +0200
Received: from holmsand by 81-224-201-139-no45.tbcn.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 13:49:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 81-224-201-139-no45.tbcn.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------010307050408010405010602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Adds a new function, optparse, that handles combined options
just like optget (cg-log -cf, for example).

When called without any argument, it returns 0 if there is any
option to parse.

When called as "optparse -f" or "optparse --foo" it returns 0
if the current option in $ARGS (at $ARGPOS) matches.

When called as "optparse -f= or "optparse --foo=" it requires
an argument.

For long options, it takes an optional second argument, specifying
the number of characters in the option name that has to be present
(defaults to 1). So "optparse --foo 2" will match "--fo", but not
"--f".

Just as with optget, options can be given after arguments as
well, as in "cg-log Documentation -rorigin". Option parsing
stops after "--".

optparse leaves unparsed arguments in the $ARGS array.

Signed-off-by: Dan Holmsand <holmsand@gmail.com>
---


--------------010307050408010405010602
Content-Type: text/plain;
 name="1-optparse.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="1-optparse.patch.txt"

 cg-Xlib |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -137,11 +137,60 @@ print_help () {
 }
 
 for option in "$@"; do
+	[ "$option" = -- ] && break
 	if [ "$option" = "-h" -o "$option" = "--help" ]; then
 		print_help ${_cg_cmd##cg-}
 	fi
 done
 
+ARGS=("$@")
+ARGPOS=0
+
+optshift() {
+	unset ARGS[$ARGPOS]
+	ARGS=("${ARGS[@]}")
+	[ -z "$1" -o -n "${ARGS[$ARGPOS]}" ] || 
+	die "option \`$1' requires an argument"
+}
+
+optfail() {
+	die "unrecognized option \`${ARGS[$ARGPOS]}'"
+}
+
+optconflict() {
+	die "conflicting option \`$CUROPT'"
+}
+
+optparse() {
+	unset OPTARG
+	[ -z "$1" ] && case ${ARGS[$ARGPOS]} in
+	--)	optshift; return 1 ;;
+	-*)	return 0 ;;
+	*)	while (( ${#ARGS[@]} > ++ARGPOS )); do
+			[[ "${ARGS[$ARGPOS]}" == -- ]] && return 1
+			[[ "${ARGS[$ARGPOS]}" == -* ]] && return 0
+		done; return 1 ;;
+	esac
+
+	CUROPT=${ARGS[$ARGPOS]}
+	local match=${1%=} minmatch=${2:-1} opt=$CUROPT o=$CUROPT val
+	[[ $1 == *= ]] && val=$match
+	case $match in
+	--*)	[ "$val" ] && o=${o%%=*}
+		[ ${#o} -ge $((2 + $minmatch)) -a \
+			"${match:0:${#o}}" = "$o" ] || return 1
+		[[ -n "$val" && "$opt" == *=?* ]] && ARGS[$ARGPOS]=${opt#*=} ||
+		optshift $val ;;
+	-?)	[[ $o == $match* ]] || return 1
+		[[ $o != -?-* || -n "$val" ]] || optfail
+		ARGS[$ARGPOS]=${o#$match}
+		[ "${ARGS[$ARGPOS]}" ] && 
+		{ [ "$val" ] || ARGS[$ARGPOS]=-${ARGS[$ARGPOS]}; } || 
+		optshift $val ;;
+	*)	die "optparse cannot handle $1" ;;
+	esac
+	[ -z "$val" ] || { OPTARG=${ARGS[$ARGPOS]}; optshift; } 
+}
 
 # Check if we have something to work on, unless the script can do w/o it.
 if [ ! "$_git_repo_unneeded" ]; then

--------------010307050408010405010602--

