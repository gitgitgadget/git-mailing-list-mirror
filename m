From: David Kastrup <dak@gnu.org>
Subject: [PATCH] git-commit.sh: Shell script cleanup
Date: Thu, 2 Aug 2007 13:40:04 +0200
Message-ID: <86odhphtp9.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 03 11:08:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGt8i-0002TY-Ja
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 11:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756434AbXHCJIA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 05:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756301AbXHCJIA
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 05:08:00 -0400
Received: from main.gmane.org ([80.91.229.2]:39936 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756183AbXHCJH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 05:07:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IGt8X-0006lU-Ib
	for git@vger.kernel.org; Fri, 03 Aug 2007 11:07:57 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 11:07:57 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 11:07:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:oFzz+0vmUmjcLKKNFFkr18h6I1o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54696>


This moves "shift" out of the argument processing "case".  It also
replaces quite a bit of expr calls with ${parameter#word} constructs,
and uses ${parameter:+word} for avoiding conditionals where possible.

Signed-off-by: David Kastrup <dak@gnu.org>
---
 git-commit.sh |   72 +++++++++++---------------------------------------------
 1 files changed, 14 insertions(+), 58 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index d7e7028..7d5c8f9 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -97,101 +97,71 @@ do
 		no_edit=t
 		log_given=t$log_given
 		logfile="$1"
-		shift
 		;;
 	-F*|-f*)
 		no_edit=t
 		log_given=t$log_given
-		logfile=`expr "z$1" : 'z-[Ff]\(.*\)'`
-		shift
+		logfile="${1#-?}"
 		;;
 	--F=*|--f=*|--fi=*|--fil=*|--file=*)
 		no_edit=t
 		log_given=t$log_given
-		logfile=`expr "z$1" : 'z-[^=]*=\(.*\)'`
-		shift
+		logfile="${1#*=}"
 		;;
 	-a|--a|--al|--all)
 		all=t
-		shift
 		;;
 	--au=*|--aut=*|--auth=*|--autho=*|--author=*)
-		force_author=`expr "z$1" : 'z-[^=]*=\(.*\)'`
-		shift
+		force_author="${1#*=}"
 		;;
 	--au|--aut|--auth|--autho|--author)
 		case "$#" in 1) usage ;; esac
 		shift
 		force_author="$1"
-		shift
 		;;
 	-e|--e|--ed|--edi|--edit)
 		edit_flag=t
-		shift
 		;;
 	-i|--i|--in|--inc|--incl|--inclu|--includ|--include)
 		also=t
-		shift
 		;;
 	--int|--inte|--inter|--intera|--interac|--interact|--interacti|\
 	--interactiv|--interactive)
 		interactive=t
-		shift
 		;;
 	-o|--o|--on|--onl|--only)
 		only=t
-		shift
 		;;
 	-m|--m|--me|--mes|--mess|--messa|--messag|--message)
 		case "$#" in 1) usage ;; esac
 		shift
 		log_given=m$log_given
-		if test "$log_message" = ''
-		then
-		    log_message="$1"
-		else
-		    log_message="$log_message
+		log_message="${log_message:+${log_message}
 
-$1"
-		fi
+}$1"
 		no_edit=t
-		shift
 		;;
 	-m*)
 		log_given=m$log_given
-		if test "$log_message" = ''
-		then
-		    log_message=`expr "z$1" : 'z-m\(.*\)'`
-		else
-		    log_message="$log_message
+		log_message="${log_message:+${log_message}
 
-`expr "z$1" : 'z-m\(.*\)'`"
-		fi
+}${1#-m}"
 		no_edit=t
-		shift
 		;;
 	--m=*|--me=*|--mes=*|--mess=*|--messa=*|--messag=*|--message=*)
 		log_given=m$log_given
-		if test "$log_message" = ''
-		then
-		    log_message=`expr "z$1" : 'z-[^=]*=\(.*\)'`
-		else
-		    log_message="$log_message
+		log_message="${log_message:+${log_message}
 
-`expr "z$1" : 'zq-[^=]*=\(.*\)'`"
-		fi
+}${1#*=}"
 		no_edit=t
-		shift
 		;;
 	-n|--n|--no|--no-|--no-v|--no-ve|--no-ver|--no-veri|--no-verif|\
 	--no-verify)
 		verify=
-		shift
 		;;
 	--a|--am|--ame|--amen|--amend)
 		amend=t
 		use_commit=HEAD
-		shift
 		;;
 	-c)
 		case "$#" in 1) usage ;; esac
@@ -199,15 +169,13 @@ $1"
 		log_given=t$log_given
 		use_commit="$1"
 		no_edit=
-		shift
 		;;
 	--ree=*|--reed=*|--reedi=*|--reedit=*|--reedit-=*|--reedit-m=*|\
 	--reedit-me=*|--reedit-mes=*|--reedit-mess=*|--reedit-messa=*|\
 	--reedit-messag=*|--reedit-message=*)
 		log_given=t$log_given
-		use_commit=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+		use_commit="${1#*=}"
 		no_edit=
-		shift
 		;;
 	--ree|--reed|--reedi|--reedit|--reedit-|--reedit-m|--reedit-me|\
 	--reedit-mes|--reedit-mess|--reedit-messa|--reedit-messag|\
@@ -217,7 +185,6 @@ $1"
 		log_given=t$log_given
 		use_commit="$1"
 		no_edit=
-		shift
 		;;
 	-C)
 		case "$#" in 1) usage ;; esac
@@ -225,15 +192,13 @@ $1"
 		log_given=t$log_given
 		use_commit="$1"
 		no_edit=t
-		shift
 		;;
 	--reu=*|--reus=*|--reuse=*|--reuse-=*|--reuse-m=*|--reuse-me=*|\
 	--reuse-mes=*|--reuse-mess=*|--reuse-messa=*|--reuse-messag=*|\
 	--reuse-message=*)
 		log_given=t$log_given
-		use_commit=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+		use_commit="${1#*=}"
 		no_edit=t
-		shift
 		;;
 	--reu|--reus|--reuse|--reuse-|--reuse-m|--reuse-me|--reuse-mes|\
 	--reuse-mess|--reuse-messa|--reuse-messag|--reuse-message)
@@ -242,32 +207,26 @@ $1"
 		log_given=t$log_given
 		use_commit="$1"
 		no_edit=t
-		shift
 		;;
 	-s|--s|--si|--sig|--sign|--signo|--signof|--signoff)
 		signoff=t
-		shift
 		;;
 	-t|--t|--te|--tem|--temp|--templ|--templa|--templat|--template)
 		case "$#" in 1) usage ;; esac
 		shift
 		templatefile="$1"
 		no_edit=
-		shift
 		;;
 	-q|--q|--qu|--qui|--quie|--quiet)
 		quiet=t
-		shift
 		;;
 	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
 		verbose=t
-		shift
 		;;
 	-u|--u|--un|--unt|--untr|--untra|--untrac|--untrack|--untracke|\
 	--untracked|--untracked-|--untracked-f|--untracked-fi|--untracked-fil|\
 	--untracked-file|--untracked-files)
 		untracked_files=t
-		shift
 		;;
 	--)
 		shift
@@ -280,6 +239,7 @@ $1"
 		break
 		;;
 	esac
+	shift
 done
 case "$edit_flag" in t) no_edit= ;; esac
 
@@ -437,12 +397,8 @@ esac
 
 if test t = "$verify" && test -x "$GIT_DIR"/hooks/pre-commit
 then
-	if test "$TMP_INDEX"
-	then
-		GIT_INDEX_FILE="$TMP_INDEX" "$GIT_DIR"/hooks/pre-commit
-	else
-		GIT_INDEX_FILE="$USE_INDEX" "$GIT_DIR"/hooks/pre-commit
-	fi || exit
+    GIT_INDEX_FILE="${TMP_INDEX:-${USE_INDEX}}" "$GIT_DIR"/hooks/pre-commit \
+    || exit
 fi
 
 if test "$log_message" != ''
-- 
1.5.3.rc3.129.g974f



-- 
David Kastrup
