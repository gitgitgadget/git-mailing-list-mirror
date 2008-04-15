From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] sh updates for 2.6.25
Date: Tue, 15 Apr 2008 12:56:50 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0804151222350.2879@woody.linux-foundation.org>
References: <20080415172333.GA29489@linux-sh.org> <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org> <20080415183023.GA23098@linux-sh.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-sh@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Mundt <lethal@linux-sh.org>
X-From: git-owner@vger.kernel.org Tue Apr 15 21:59:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlrIY-0003PW-2i
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 21:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759400AbYDOT5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 15:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755540AbYDOT5v
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 15:57:51 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37553 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756664AbYDOT5t (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Apr 2008 15:57:49 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3FJup28024422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Apr 2008 12:56:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3FJuoYM012570;
	Tue, 15 Apr 2008 12:56:50 -0700
In-Reply-To: <20080415183023.GA23098@linux-sh.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.983 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79625>



On Wed, 16 Apr 2008, Paul Mundt wrote:
> 
> It was a combination of mbox munging and git-am, I checked with git log
> and thought things were ok, but I wasn't aware that it stripped out empty
> lines. cat-file shows that it was just the 2 patches from Andrew that had
> this particular problem. I had stripped out the subject and thought the
> first line would be used for the merge summary, but it looks like git-am
> simply wrote out an empty line and inserted one after that before the
> rest of the summary.

Ahh, looks like a git-am buglet then. It will indeed turn an empty subject 
line into an empty first line.

We should run "git stripspace" on the whole thing, so maybe a patch 
something like the appended will help.

NOTE! Totally untested! Beware the patch!

> I've pushed out updated patches that have this corrected, so please pull
> again.

Well, since I pulled your previous one anyway, and since we should fix 
git for any fallout like this _anyway_, I didn't so much worry about this 
one-time event, as about avoiding this happening a lot in the future.

We've had other workflows generate empty lines in commits, so we already 
support stripping them out for other reasons.

			Linus
---
 git-am.sh |   23 +++++++++--------------
 1 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index ac5c388..432d9fe 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -107,7 +107,7 @@ It does not apply to blobs recorded in its index."
     # patch did not touch, so recursive ends up canceling them,
     # saying that we reverted all those changes.
 
-    eval GITHEAD_$his_tree='"$SUBJECT"'
+    eval GITHEAD_$his_tree='"$FIRSTLINE"'
     export GITHEAD_$his_tree
     git-merge-recursive $orig_tree -- HEAD $his_tree || {
 	    git rerere
@@ -117,10 +117,6 @@ It does not apply to blobs recorded in its index."
     unset GITHEAD_$his_tree
 }
 
-reread_subject () {
-	git stripspace <"$1" | sed -e 1q
-}
-
 prec=4
 dotest=".dotest"
 sign= utf8=t keep= skip= interactive= resolved= binary= rebasing=
@@ -331,7 +327,11 @@ do
 			echo "Patch is empty.  Was it split wrong?"
 			stop_here $this
 		}
-		git stripspace < "$dotest/msg" > "$dotest/msg-clean"
+		SUBJECT="$(sed -n '/^Subject/ s/Subject: //p' "$dotest/info")"
+		case "$keep_subject" in -k)  SUBJECT="[PATCH] $SUBJECT" ;; esac
+
+		(echo "$SUBJECT" ; echo ; cat "$dotest/msg") |
+			git stripspace > "$dotest/msg-clean"
 		;;
 	esac
 
@@ -347,9 +347,6 @@ do
 
 	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
 
-	SUBJECT="$(sed -n '/^Subject/ s/Subject: //p' "$dotest/info")"
-	case "$keep_subject" in -k)  SUBJECT="[PATCH] $SUBJECT" ;; esac
-
 	case "$resume" in
 	'')
 	    if test '' != "$SIGNOFF"
@@ -368,10 +365,8 @@ do
 		ADD_SIGNOFF=
 	    fi
 	    {
-		printf '%s\n' "$SUBJECT"
 		if test -s "$dotest/msg-clean"
 		then
-			echo
 			cat "$dotest/msg-clean"
 		fi
 		if test '' != "$ADD_SIGNOFF"
@@ -388,6 +383,7 @@ do
 			;;
 		esac
 	esac
+	FIRSTLINE=$(head -1 "$dotest/final-commit")
 
 	resume=
 	if test "$interactive" = t
@@ -408,7 +404,6 @@ do
 		[aA]*) action=yes interactive= ;;
 		[nN]*) action=skip ;;
 		[eE]*) git_editor "$dotest/final-commit"
-		       SUBJECT=$(reread_subject "$dotest/final-commit")
 		       action=again ;;
 		[vV]*) action=again
 		       LESS=-S ${PAGER:-less} "$dotest/patch" ;;
@@ -431,7 +426,7 @@ do
 		stop_here $this
 	fi
 
-	printf 'Applying %s\n' "$SUBJECT"
+	printf 'Applying %s\n' "$FIRSTLINE"
 
 	case "$resolved" in
 	'')
@@ -489,7 +484,7 @@ do
 	tree=$(git write-tree) &&
 	parent=$(git rev-parse --verify HEAD) &&
 	commit=$(git commit-tree $tree -p $parent <"$dotest/final-commit") &&
-	git update-ref -m "$GIT_REFLOG_ACTION: $SUBJECT" HEAD $commit $parent ||
+	git update-ref -m "$GIT_REFLOG_ACTION: $FIRSTLINE" HEAD $commit $parent ||
 	stop_here $this
 
 	if test -x "$GIT_DIR"/hooks/post-applypatch
