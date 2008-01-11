From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] additional help when editing during interactive rebase
Date: Fri, 11 Jan 2008 12:29:32 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801111147440.14355@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1199845915-sup-797@south> <7vsl17pv1c.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0801091120150.31053@racer.site> <7vprw83g8z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, William Morgan <wmorgan-git@masanjin.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 12:30:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDI5T-0006mF-5o
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 12:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758125AbYAKL3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 06:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756993AbYAKL3g
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 06:29:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:52344 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756150AbYAKL3f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 06:29:35 -0500
Received: (qmail invoked by alias); 11 Jan 2008 11:29:33 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp058) with SMTP; 11 Jan 2008 12:29:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/k2/JVYDfkr3QfmYjc06gvgieXu6MVznJ6ya5IFi
	xydeUUBdpTbTos
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vprw83g8z.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70147>

Hi,

On Fri, 11 Jan 2008, Junio C Hamano wrote:

> Do you mean you would instead suggest "git rebase --continue" in
> the insn, and make the workflow like this:
> 
> 	$ git rebase -i ...
>         Now do whatever you want and say "rebase --continue"
> 	$ edit foo.c
>         $ git add foo.c
>         $ git rebase --continue
> 
> and have "rebase --continue" to continue with the modified
> contents recorded in the index, invoking "git commit --amend",
> but doing so only if the user hasn't run "git commit" with or
> without --amend yet?

Yes, exactly.

> It feels like a better automation than what we currently have,
> but I somewhat worry how that would change the user experience
> for using 'edit' to split a commit into two or more.

If you want to split a commit into two or more, you will already have 
committed twice when you say "--continue", and all is fine.

However, if you do the first commit, and then only add the files for the 
second commit, the HEAD's commit name has changed!  And so, rebase can 
pick up on that, and avoid the --amend.

IOW something like below.  However, this patch does not yet make "rebase 
-i" call "commit --amend" automatically when both the index and HEAD are 
unchanged.

-- snipsnap --
[PATCH] rebase -i: only ever commit --amend when HEAD is untouched

When a commit is marked to edit, and the index is dirty when "rebase
--continue" is called, that state will be committed with the "--amend"
option.

However, this is wrong when the user wanted to split the commit.

Luckily, we can pick up on that, by recording the HEAD's name in the
file "amend", and only --amend when no commit was made in the interim.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 git-rebase--interactive.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index acdcc54..4a8a980 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -257,7 +257,7 @@ do_next () {
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
 		make_patch $sha1
-		: > "$DOTEST"/amend
+		git rev-parse HEAD > "$DOTEST"/amend
 		warn
 		warn "You can amend the commit now, with"
 		warn
@@ -378,7 +378,9 @@ do
 		else
 			. "$DOTEST"/author-script ||
 				die "Cannot find the author identity"
-			if test -f "$DOTEST"/amend
+			if test -f "$DOTEST"/amend &&
+				test $(git rev-parse HEAD) = \
+					$(cat "$DOTEST"/amend)
 			then
 				git reset --soft HEAD^ ||
 				die "Cannot rewind the HEAD"
