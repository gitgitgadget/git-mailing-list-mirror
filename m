Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEF9C47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 15:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C24861279
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 15:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhFEPoA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 11:44:00 -0400
Received: from bounceout07.ispgateway.de ([134.119.228.227]:6272 "EHLO
        bounceout07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFEPoA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 11:44:00 -0400
X-Greylist: delayed 87902 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Jun 2021 11:43:59 EDT
Received: from [134.119.228.98] (helo=smtprelay08.ispgateway.de)
        by bounceout07.ispgateway.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <alexander.adolf@condition-alpha.com>)
        id 1lpYR5-00017k-Hj
        for git@vger.kernel.org; Sat, 05 Jun 2021 17:42:07 +0200
Received: from [46.244.216.1] (helo=condition-alpha.com)
        by smtprelay08.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <alexander.adolf@condition-alpha.com>)
        id 1lpBY8-0006lu-Pn
        for git@vger.kernel.org; Fri, 04 Jun 2021 17:15:52 +0200
Message-Id: <d8044e41ed12459c405a9a3be522c0f1@condition-alpha.com>
From:   Alexander Adolf <alexander.adolf@condition-alpha.com>
To:     git@vger.kernel.org
Subject: [PATCH] git-prompt.sh not working with vcs_info under zsh
Date:   Fri, 04 Jun 2021 17:17:09 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Df-Sender: YWxleGFuZGVyLmFkb2xmQGNvbmRpdGlvbi1hbHBoYS5jb20=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I discovered and fixed a small glitch in git-prompt.sh in conjunction
with zsh's vcs_info library. I prefer using git-prompt.sh through
vcs_info because it allows me to leverage the support of other version
control systems provided by vcs_info, and still get the more detailed
information provided by git-prompt.sh. Best-of-both-worlds approach. ;-)

The issue is that the prompt_subst option (required for using vcs_info)
breaks the rendering of the percent character to indicate untracked
objects. More details in the attached patch.

For the curious, here is the relevant snippet from my ~/.zshrc:
---------------------------- Begin Quote -----------------------------
setopt prompt_subst
autoload -U promptinit; promptinit
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn cvs hg
zstyle ':vcs_info:*' check-for-changes true
source ~/.zsh/git-prompt.sh	# defines __git_ps1()
GIT_PS1_SHOWCOLORHINTS=3D"1"	# colors are based on the colored output of "g=
it status -sb"
GIT_PS1_SHOWDIRTYSTATE=3D"1"	# '*' unstaged and '+' staged changes
GIT_PS1_SHOWSTASHSTATE=3D"1"	# '$' if something is stashed
GIT_PS1_SHOWUNTRACKEDFILES=3D"1"	# '%' if untracked files exist
GIT_PS1_SHOWUPSTREAM=3D('name' 'verbose' 'git')
function git-ps1-wrapper () { reply=3D" (%s:$(__git_ps1 '%s'))" }
zstyle -e ':vcs_info:git:*' formats       'git-ps1-wrapper'
zstyle -e ':vcs_info:git:*' actionformats 'git-ps1-wrapper'
zstyle  ':vcs_info:*'     formats       ' (%s:%b%u%c)'
zstyle  ':vcs_info:*'     actionformats ' (%s:%b%u%c|%a)'
precmd () { vcs_info }
PROMPT=3D'
%B%m:%2~%b${vcs_info_msg_0_}
%B%(!.#.=E2=96=B6)%b '
----------------------------- End Quote ------------------------------


Many thanks, looking forward to your thoughts, and have a great weekend,

  --alexander



--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline;
 filename=0001-Cannot-Use-__git_ps1-in-normal-mode-for-zsh-vcs_info.patch

From 5a00f8f58a18c87f2a7b9815d832c0beef7b9bff Mon Sep 17 00:00:00 2001
From: Alexander Adolf <c-alpha@users.noreply.github.com>
Date: Fri, 4 Jun 2021 01:41:56 +0200
Subject: [PATCH] Cannot Use __git_ps1 in normal mode for zsh vcs_info

When using the __git_ps1 shell function in normal mode (i.e. passing
it a single argument) in conjunction with the vcs_info library under
zsh, the percent character ('%'), used to indicate untracked objects,
breaks the rendering ('%f' is no longer recognised as ending the
colour code, but appears verbatim in the prompt).

This is because using vcs_info requires the PROMPT_SUBST option to be
set in zsh, but which changes the handling of percent characters. When
PROMPT_SUBST is in effect, one additional 'level' of percent signs is
consumed by the prompt substitution, and to get the desired
effect (resulting in a single, verbatim percent character in the
prompt), four percent signs need to be inserted.

This commit changes the way the needed percent character(s) to
indicate untracked objects are inserted when running under zsh,
depending on whether the PROMPT_SUBST option is in effect or not.
---
 contrib/completion/git-prompt.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index db7c0068fb..f8d19139b6 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -540,7 +540,11 @@ __git_ps1 ()
 		   [ "$(git config --bool bash.showUntrackedFiles)" != "false" ] &&
 		   git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*' >/dev/null 2>/dev/null
 		then
-			u="%${ZSH_VERSION+%}"
+			if [ $ps1_expanded = yes ]; then
+				u="%${ZSH_VERSION+%%%}"
+			else
+				u="%${ZSH_VERSION+%}"
+			fi
 		fi
 
 		if [ -n "${GIT_PS1_COMPRESSSPARSESTATE-}" ] &&
-- 
2.31.1


--=-=-=--
