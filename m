From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: accept indented comments (fixes regression)
Date: Wed, 30 Sep 2015 11:05:49 -0700
Message-ID: <xmqqd1wz9402.fsf@gitster.mtv.corp.google.com>
References: <1443600661-19391-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Galan =?utf-8?Q?R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Sep 30 20:05:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhLlM-0004Mt-NF
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 20:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932728AbbI3SFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 14:05:53 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36748 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932506AbbI3SFv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 14:05:51 -0400
Received: by pablk4 with SMTP id lk4so46832574pab.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 11:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-type;
        bh=OytfTxC1jUzozeUbXrX/WNWmXEf6rq39+YuTY88Pw3o=;
        b=oPO1SY+c1l1sOFnq3UZwg76763xKEo4QF7MoltW0Bw6SImhC3Aaj5w7ic4je/hEgOB
         2iuVJFovzNWoo/tCDobXLhGou/kdgbZ5ABORJu34OtTRlFZ7cnLdPr5zCsgp+q+szLkW
         7z1XlXxjpjo9444SgCUl99Bsijk1cNLnT1p3rOzwYWXYmh1p39RigrOFDwxCzDtmkKHu
         yvVLCBY2+iWiXDSLh9zTQIXf7j1gGf+RNAbkbiDEqHllO234rdtjJ/Hvj/XK9peiWETW
         Vdu+pyTc/qhEiAi4aMXTmDDxseL0Q54lfaUNbyVFkNdqPoNYq8MgmVRQeX95J2GAL4x/
         mN5w==
X-Received: by 10.66.163.228 with SMTP id yl4mr6383225pab.112.1443636350783;
        Wed, 30 Sep 2015 11:05:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2c4a:a656:af73:8140])
        by smtp.gmail.com with ESMTPSA id su3sm1890452pbc.83.2015.09.30.11.05.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Sep 2015 11:05:50 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278849>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> With Git <2.0.6, 'git rebase' used to accept lines starting with
> whitespaces followed with '#' as a comment. This was broken by
> 804098b (git rebase -i: add static check for commands and SHA-1,
> 2015-06-29), which introduced additional checks on the TODO-list using
> "git stripspaces" which only strips comments starting at the first
> column.

I cannot help thinking that this is sidestepping the real issue.

The real issue, I think, is that the new check tokenises the input
differently from how the expand_todo_ids -> transform_todo_ids
callchain parses it.  The problem Nazri Ramliy noticed about the new
check that does not ignore the indentation is merely one aspect of
it.

Stripping leading whilespaces with sed may ignore indented anything
and help Nazri's script, but 804098b tightened checks to disallow
other things that we historically allowed, e.g. if you replace SP
between "pick" and the commit object name with an HT, the new check
will not notice that HT is also a perfectly good token separator
character and barfs.

I am actually tempted to say that we should revert 804098b, which is
the simplest fix.

If we want "check everything before doing a single thing" mode, the
right way to do it would be to base the check on the same loop as
transform_todo_ids (one way to do so would be to give a third mode
to that helper function, but I do not think we mind a small code
duplication).

As far as I can tell, the hand-rolled parsing is there only in oder
to report the incoming $line as-is.  It is much easier to just
identify with which line number the location of the problem, and
show it when it is necessary from the original source, and we do not
care about performance in the error codepath.

Perhaps something along these lines instead, with your new tests
added in?

 git-rebase--interactive.sh | 62 ++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 33 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index dcc3401..ae1806a 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -849,7 +849,8 @@ add_exec_commands () {
 # Check if the SHA-1 passed as an argument is a
 # correct one, if not then print $2 in "$todo".badsha
 # $1: the SHA-1 to test
-# $2: the line to display if incorrect SHA-1
+# $2: the line number of the input
+# $3: the input filename
 check_commit_sha () {
 	badsha=0
 	if test -z $1
@@ -865,9 +866,10 @@ check_commit_sha () {
 
 	if test $badsha -ne 0
 	then
+		line="$(sed -n -e "${2}p" "$3")"
 		warn "Warning: the SHA-1 is missing or isn't" \
 			"a commit in the following line:"
-		warn " - $2"
+		warn " - $line"
 		warn
 	fi
 
@@ -878,37 +880,31 @@ check_commit_sha () {
 # from the todolist in stdin
 check_bad_cmd_and_sha () {
 	retval=0
-	git stripspace --strip-comments |
-	(
-		while read -r line
-		do
-			IFS=' '
-			set -- $line
-			command=$1
-			sha1=$2
-
-			case $command in
-			''|noop|x|"exec")
-				# Doesn't expect a SHA-1
-				;;
-			pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
-				if ! check_commit_sha $sha1 "$line"
-				then
-					retval=1
-				fi
-				;;
-			*)
-				warn "Warning: the command isn't recognized" \
-					"in the following line:"
-				warn " - $line"
-				warn
+	lineno=0
+	while read -r command rest
+	do
+		lineno=$(( $lineno + 1 ))
+		case $command in
+		"$comment_char"*|''|noop|x|exec)
+			# Doesn't expect a SHA-1
+			;;
+		pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
+			if ! check_commit_sha "${rest%% *}" "$lineno" "$1"
+			then
 				retval=1
-				;;
-			esac
-		done
-
-		return $retval
-	)
+			fi
+			;;
+		*)
+			line="$(sed -n -e "${lineno}p" "$1")"
+			warn "Warning: the command isn't recognized" \
+				"in the following line:"
+			warn " - $line"
+			warn
+			retval=1
+			;;
+		esac
+	done <"$1"
+	return $retval
 }
 
 # Print the list of the SHA-1 of the commits
@@ -1002,7 +998,7 @@ check_todo_list () {
 		;;
 	esac
 
-	if ! check_bad_cmd_and_sha <"$todo"
+	if ! check_bad_cmd_and_sha "$todo"
 	then
 		raise_error=t
 	fi
