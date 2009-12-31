From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] bash completion: factor submodules into dirty state
Date: Thu, 31 Dec 2009 12:48:41 +0100
Message-ID: <9108ae77c6551363407265de60c7f1def3fe60f0.1262259747.git.trast@student.ethz.ch>
References: <200912310240.07741.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johan Herland <johan@herland.net>, Kevin Ballard <kevin@sb.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 31 12:48:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQJWL-0004oy-7D
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 12:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbZLaLsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 06:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbZLaLso
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 06:48:44 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:44630 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747AbZLaLso (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 06:48:44 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.213.0; Thu, 31 Dec
 2009 12:48:42 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Thu, 31 Dec
 2009 12:48:42 +0100
X-Mailer: git-send-email 1.6.6.337.g4932e
In-Reply-To: <200912310240.07741.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135946>

In the implementation of GIT_PS1_SHOWDIRTYSTATE in 738a94a (bash:
offer to show (un)staged changes, 2009-02-03), I cut&pasted the
git-diff invocations from dirty-worktree checks elsewhere, carrying
along the --ignore-submodules option.

As pointed out by Kevin Ballard, this doesn't really make sense: to
the _user_, a changed submodule counts towards uncommitted changes.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Johan Herland wrote:
> On Wednesday 30 December 2009, Kevin Ballard wrote:
> > Why does the __git_ps1 function in git-completion.bash explicitly ignore
> >  submodules when showing the GIT_PS1_SHOWDIRTYSTATE status? The most
> >  common issue with my current repository is not realizing when submodules
> >  need to be updated because I blindly trust my prompt to tell me when I
> >  have dirty state.
> 
> According to git blame, it has been there since GIT_PS1_SHOWDIRTYSTATE was 
> introduced in 738a94a... by Thomas Rast (CCed), but the commit message does 
> not say why submodules are explicitly ignored.
> 
> FWIW, I agree with Kevin, and would like changed submodules to be included 
> in the status.

No good reason; I really do remember cut&pasting the checks, though
I'm not sure from where.

I don't really use submodules, so I'll just trust your judgements that
it's better to factor them into the status.


 contrib/completion/git-completion.bash |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c65462c..a455fe8 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -142,11 +142,9 @@ __git_ps1 ()
 		elif [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
 			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
 				if [ "$(git config --bool bash.showDirtyState)" != "false" ]; then
-					git diff --no-ext-diff --ignore-submodules \
-						--quiet --exit-code || w="*"
+					git diff --no-ext-diff --quiet --exit-code || w="*"
 					if git rev-parse --quiet --verify HEAD >/dev/null; then
-						git diff-index --cached --quiet \
-							--ignore-submodules HEAD -- || i="+"
+						git diff-index --cached --quiet HEAD -- || i="+"
 					else
 						i="#"
 					fi
-- 
1.6.6.337.g4932e
