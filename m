From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] add -e: ignore dirty submodules
Date: Tue, 7 Feb 2012 01:45:36 -0600 (CST)
Message-ID: <alpine.DEB.1.00.1202070124020.4897@bonsai2>
References: <alpine.DEB.1.00.1202070504340.24259@s15462909.onlinehome-server.info> <7vaa4v42fi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 08:46:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rufkh-0007j7-V3
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 08:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718Ab2BGHpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 02:45:44 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:47102 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750753Ab2BGHpn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 02:45:43 -0500
Received: (qmail invoked by alias); 07 Feb 2012 07:45:41 -0000
Received: from 68-185-171-245.dhcp.mdsn.wi.charter.com (EHLO bonsai2.local) [68.185.171.245]
  by mail.gmx.net (mp039) with SMTP; 07 Feb 2012 08:45:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1++tPkciBa+0E05SeqSgLBCfgNy24ZZj5AeiRm2YH
	bFRsMboEOaW0Iy
X-X-Sender: gene099@bonsai2
In-Reply-To: <7vaa4v42fi.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190150>

Dear Junio C Hamano,

On Mon, 6 Feb 2012, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > We cannot add untracked/modified files in submodules anyway.

The purpose of "add -e" is to stage changes. It does so by presenting a
diff which the user can edit (and applying it after recounting the numbers
in the hunk headers).

If the diff does not apply, it does not make sense to present it to the
user.

Offering to add changes represented by a diff like

diff --git <blub>
<header>
-deadbeef...
+deadbeef...-dirty

does not make sense.

Even a diff like

diff --git <blah>
<header>
-deadbeef...
-coffeebabe...-dirty

would be refused by git-apply.

Indeed, due to the design of the submodules, it is impossible to stage
dirty files in a submodule and a supercommit at the same time. Oh, and this
discussion is not the place to wish for a feature like that, just in case
you want to ask me to implement that in order to be allowed to have my puny
little patch applied. (I guess this is the reason why I waited so long
before I dared to submit the patch to the mailing list.)

Now, due to these concerns, even stripping out the -dirty part can lead to
a comically non-sensical diff like

diff --git <blergh>
<header>
-deadbeef...
+deadbeef...

So keeping the diff generation as-is but preparing the patch by munching
away the -dirty suffix would not fix the problem.

Also, it would be wrong to assume that the user asked to get a status
update. git add -e != git status. If the user wanted to know what changes
are in the worktree, including the worktrees of the submodules, but only
those that have been checked out, git status would be the command to call
(even if it was touted as a git commit --dry-run once upon a time, which
is kind of wrong, see above, you cannot commit the untracked or dirty
files in a submodule, yet git status shows them).

So: showing the fact that a submodule has untracked or dirty files in the
patch that the user wants to edit with git add -e is wrong, wrong, wrong.

The only submodule-related thing we should ever present to the user who
called git add -e is a diff like

diff --git <narf>
<header>
-deadcad...
+beda551ed...

because that is a stageable change.

Alas, salvation is nigh! Yes, just a little line which asks for the level
"dirty" (which implies "untracked", as detailed by diff-options.txt, uhm,
sorry, I was asked to be precise, Documentation/diff-options.txt) fixes
that!

With this flag, there are no more "-dirty" lines in the submodule diffs.
None! Only diffs between different submodule commits are shown, and even
if the worktree of the submodule is dirty, or has untracked files, the
-dirty suffix is omitted. Just what you need for git-apply to work! Yay!

As a plus, it makes the diff generation faster because what cannot be
staged anyway is not even discovered! Super-yay!

I actually enjoyed writing this text so much, may I respectfully ask to
include it verbatim in the commit message?

Thank you very much,
Johannes Schindelin
