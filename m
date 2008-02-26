From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v2] pull: document usage via OPTIONS_SPEC
Date: Tue, 26 Feb 2008 15:42:34 -0500
Message-ID: <1204058554-74593-1-git-send-email-jaysoffian@gmail.com>
References: <7vk5kw5v79.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 21:43:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU6eW-00039U-6v
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 21:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764392AbYBZUmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 15:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764371AbYBZUmn
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 15:42:43 -0500
Received: from an-out-0708.google.com ([209.85.132.245]:21832 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763570AbYBZUml (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 15:42:41 -0500
Received: by an-out-0708.google.com with SMTP id d31so531735and.103
        for <git@vger.kernel.org>; Tue, 26 Feb 2008 12:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        bh=/DUMA1ovCgykg1ZGNNY09gMC88p/2IUti4ef8ZrDiGo=;
        b=q3HHlAv+A3Ca941fa1JvftknX2fGu8DAdl/94zh5Xpj7Xs4Ncp1zia9wc8JB743qv9MorIxGY3F2SgFXO0JCQ4iXMkpG9hiNlrKDWQ/LjD811Na3FrolN986tYlPTMNz/uWQkwaWVeE4w9erj+p0baJQq7i1deg71lRFrPeVqkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=FNCQAhI2aIPNIB96tObsNt/xkovQOH+YtV1Fg+5kmh/E10VZEC6JS5wzKXUbg7Y0hX7tSS/95szqaKXahFUtGKq+/HUQDxnLGy1EH6+mUiVENZ5Q8zcbNCLMe0DnAzv37MVBQV1Yh+H6MaYg4Lb3hePIjZdn5cS89sOx0xSuYeA=
Received: by 10.100.194.17 with SMTP id r17mr10377619anf.84.1204058558426;
        Tue, 26 Feb 2008 12:42:38 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id d38sm9470632and.17.2008.02.26.12.42.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Feb 2008 12:42:37 -0800 (PST)
X-Mailer: git-send-email 1.5.4.3.345.g651f8
In-Reply-To: <7vk5kw5v79.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75170>

Replaced USAGE and LONG_USAGE with OPTIONS_SPEC

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Okay, I'm pretty sure this is correct now. make test passes, and it also
passes my "it looks right" test after having gone over it a few times.

This isn't quite ready for inclusion yet though because I want some feedback:

 * There is one semantic change. You can't use "-s=<strategy>" anymore. That's not
   really proper usage of a short option (it's either "-s<strategy>" or 
   "-s <strategy>"). Is it okay to not accept the "-s=<strategy>" form?

 * Is it worth doing this at all? If the plan is to rewrite everything as
   builtins I kinda feel like I'm wasting my time. If not, I'll work on doing
   this for all the other scripts which are missing an OPTIONS_SPEC. Then maybe
   they can all be merged at once?

 * You can see I added the GIT_PULL_DEBUG_ARGS blob. Frankly, I can't really
   think of a good way to test this change other than to do something like that
   and then add a test for each individual option. But that's going to really
   bloat the test suite. Is it worth it to do this for every script? Or is
   passing the existing test suite and enough eyeballs looking at it in next
   good enough? Can you think of another way to check for regressions?

j.

 git-pull.sh |   94 ++++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 61 insertions(+), 33 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 3ce32b5..8b1d732 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -4,10 +4,36 @@
 #
 # Fetch one or more remote refs and merge it/them into the current HEAD.
 
-USAGE='[-n | --no-summary] [--[no-]commit] [--[no-]squash] [--[no-]ff] [-s strategy]... [<fetch-options>] <repo> <head>...'
-LONG_USAGE='Fetch one or more remote refs and merge it/them into the current HEAD.'
 SUBDIRECTORY_OK=Yes
-OPTIONS_SPEC=
+OPTIONS_SPEC="\
+git pull [options] [<repo>] [<refspec>]
+--
+  fetch options
+q,quiet          make the fetch process less verbose
+v,verbose        make the fetch process more verbose
+a,append         append to FETCH_HEAD instead of overwritting
+upload-pack=,    specify path to git-fetch-pack on remote end
+f,force          force local branch to be updated by remote branch
+t,tags           fetch all remote tags
+no-tags          do not fetch any remote tags
+k,keep           keep downloaded pack
+u,update-head-ok used internally between git pull and git fetch
+depth=           deep shallow history by specified number of commits
+  merge options
+summary          show diffstat at end of merge
+n,no-summary     do not show diff stat at end of merge
+commit           commit the result after merging
+no-commit        do not commit the result after merging
+squash           update the index and working tree only
+no-squash        override --squash, perform a normal merge and commit
+ff               only update branch pointer if merge is a fast-forward
+no-ff            do a merge commit even if the merge is a fast-forward
+s,strategy=      use given merge strategy
+  rebase options
+rebase           rebase after fetching
+no-rebase        merge after fetching
+s,strategy=      use given merge strategy; implies -m to rebase
+"
 . git-sh-setup
 set_reflog_action "pull $*"
 require_work_tree
@@ -23,46 +49,33 @@ rebase=$(git config --bool branch.$curr_branch_short.rebase)
 while :
 do
 	case "$1" in
-	-n|--n|--no|--no-|--no-s|--no-su|--no-sum|--no-summ|\
-		--no-summa|--no-summar|--no-summary)
+	-n|--no-summary)
 		no_summary=-n ;;
 	--summary)
-		no_summary=$1
-		;;
-	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
+		no_summary=$1 ;;
+	--no-commit)
 		no_commit=--no-commit ;;
-	--c|--co|--com|--comm|--commi|--commit)
+	--commit)
 		no_commit=--commit ;;
-	--sq|--squ|--squa|--squas|--squash)
+	--squash)
 		squash=--squash ;;
-	--no-sq|--no-squ|--no-squa|--no-squas|--no-squash)
+	--no-squash)
 		squash=--no-squash ;;
 	--ff)
 		no_ff=--ff ;;
 	--no-ff)
 		no_ff=--no-ff ;;
-	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
-		--strateg=*|--strategy=*|\
-	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
-		case "$#,$1" in
-		*,*=*)
-			strategy=`expr "z$1" : 'z-[^=]*=\(.*\)'` ;;
-		1,*)
-			usage ;;
-		*)
-			strategy="$2"
-			shift ;;
-		esac
-		strategy_args="${strategy_args}-s $strategy "
-		;;
-	-r|--r|--re|--reb|--reba|--rebas|--rebase)
-		rebase=true
-		;;
-	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
-		rebase=false
+	-s|--strategy)
+		shift
+		strategy_args="${strategy_args}-s $1 "
 		;;
-	-h|--h|--he|--hel|--help)
-		usage
+	-r|--rebase)
+		rebase=true ;;
+	--no-rebase)
+		rebase=false ;;
+	--)
+		shift
+		break
 		;;
 	*)
 		# Pass thru anything that may be meant for fetch.
@@ -72,12 +85,27 @@ do
 	shift
 done
 
+test '' != "$GIT_PULL_DEBUG_ARGS" && {
+	exec >&2
+	for var in strategy_args no_summary no_commit squash no_ff rebase
+	do
+		echo "$var='$(eval echo "\$$var")'"
+	done
+	argnum=1
+	for opt
+	do
+		echo "$argnum='$opt'"
+		argnum=$(($argnum + 1))
+	done
+	exit 0
+}
+
 error_on_no_merge_candidates () {
 	exec >&2
 	for opt
 	do
 		case "$opt" in
-		-t|--t|--ta|--tag|--tags)
+		-t|--tags)
 			echo "Fetching tags only, you probably meant:"
 			echo "  git fetch --tags"
 			exit 1
-- 
1.5.4.3.345.g651f8
