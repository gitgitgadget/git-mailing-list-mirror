From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [FIXED PATCH] Make rebase save ORIG_HEAD if changing current
 branch
Date: Mon, 07 Jul 2008 14:58:58 -0700
Message-ID: <7vod591hlp.fsf@gitster.siamese.dyndns.org>
References: <1215379370-34265-1-git-send-email-benji@silverinsanity.com>
 <7v7iby9ucx.fsf@gitster.siamese.dyndns.org>
 <803A3528-2451-4C5D-A48D-5E0C37B8E90E@silverinsanity.com>
 <7vbq1a8ay3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 08 00:00:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFyl0-0006ii-A4
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 00:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757226AbYGGV7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 17:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757329AbYGGV7I
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 17:59:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33597 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755685AbYGGV7G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 17:59:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AA4B625539;
	Mon,  7 Jul 2008 17:59:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B07E225538; Mon,  7 Jul 2008 17:59:00 -0400 (EDT)
In-Reply-To: <7vbq1a8ay3.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 06 Jul 2008 23:28:36 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E9B2693C-4C6F-11DD-8C2E-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87659>

Junio C Hamano <gitster@pobox.com> writes:

> The idea behind ORIG_HEAD is to have an anchoring point before an
> operation that moves your HEAD in a drastic way.  Think if it as a
> poor-man's reflog -- in fact it predates reflog.
>
> That is why reset saves away the HEAD before it does its thing, so that
> you can easily say "Oops, I did not mean it -- reset ORIG_HEAD" to flip
> back to the previous state.  Both a fast-forward merge and a real merge
> can be undone by resetting back to ORIG_HEAD.

I've also seen people complain (quite rightfully) that these FOO_HEAD
pseudo refs are not documented in a central place.

How about doing this?  It should make it clear what ORIG_HEAD is meant to
record, while describing others.

And to answer your "git rebase --onto this from that-branch" question, I
think ORIG_HEAD should record the tip of that-branch before rebase takes
place, not the commit you happened to be at before running it.  Switching
branch to that-branch is not the drastic and unforseeable part.  The
drastic and unforseeable change is rebasing and seeing that the rebased
result does not work with the new upstream `from`, and the user would want
to have a way to quickly rewind the tip of the branch back to the state
before the rebase.  The new paragraph added by this patch should hopefully
make this reasoning more clear.

-- >8 --
Documentation: update sections on naming revisions and revision ranges

Various *_HEAD pseudo refs were not documented in any central place.
Especially since we may be teaching rebase and am to record ORIG_HEAD,
it would be a good time to do so.

While at it, reword the explanation on r1..r2 notation to reduce
confusion.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Documentation/git-rev-parse.txt |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 378a312..7184274 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -166,7 +166,7 @@ blobs contained in a commit.
   first match in the following rules:
 
   . if `$GIT_DIR/<name>` exists, that is what you mean (this is usually
-    useful only for `HEAD`, `FETCH_HEAD` and `MERGE_HEAD`);
+    useful only for `HEAD`, `FETCH_HEAD`, `ORIG_HEAD` and `MERGE_HEAD`);
 
   . otherwise, `$GIT_DIR/refs/<name>` if exists;
 
@@ -177,6 +177,16 @@ blobs contained in a commit.
   . otherwise, `$GIT_DIR/refs/remotes/<name>` if exists;
 
   . otherwise, `$GIT_DIR/refs/remotes/<name>/HEAD` if exists.
++
+HEAD names the commit your changes in the working tree is based on.
+FETCH_HEAD records the branch you fetched from a remote repository
+with your last 'git-fetch' invocation.
+ORIG_HEAD is created by commands that moves your HEAD in a drastic
+way, to record the position of the HEAD before their operation, so that
+you can change the tip of the branch back to the state before you ran
+them easily.
+MERGE_HEAD records the commit(s) you are merging into your branch
+when you run 'git-merge'.
 
 * A ref followed by the suffix '@' with a date specification
   enclosed in a brace
@@ -289,10 +299,10 @@ notation is used.  E.g. "`{caret}r1 r2`" means commits reachable
 from `r2` but exclude the ones reachable from `r1`.
 
 This set operation appears so often that there is a shorthand
-for it.  "`r1..r2`" is equivalent to "`{caret}r1 r2`".  It is
-the difference of two sets (subtract the set of commits
-reachable from `r1` from the set of commits reachable from
-`r2`).
+for it.  When you have two commits `r1` and `r2` (named according
+to the syntax explained in SPECIFYING REVISIONS above), you can ask
+for commits that are reachable from r2 but not from r1 by
+"`{caret}r1 r2`" and it can be written as "`r1..r2`".
 
 A similar notation "`r1\...r2`" is called symmetric difference
 of `r1` and `r2` and is defined as
