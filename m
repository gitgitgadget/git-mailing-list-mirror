From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 (for maint)] git-completion: fix regression in zsh support
Date: Tue, 10 May 2011 15:20:39 +0300
Message-ID: <1305030039-16044-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 14:21:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJlvx-00035F-Kx
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 14:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756198Ab1EJMU4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2011 08:20:56 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45978 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755457Ab1EJMUz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 08:20:55 -0400
Received: by ewy4 with SMTP id 4so1808457ewy.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 05:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=qwFgJVbyN4HDfx1dUtB3AL2wNvszA0F2mUkqBbgkitU=;
        b=Sx0UiLZVg5KhxYShd9kiiLuxo60WXQpYlxxGDeuqeg8EcN56K1VSFYDHBxVHdzSLbM
         DksI8hv7eGKCqCo+PY8chVMS1csNEd/pcsnMC3uj+py/utxorec6MRkqbcOOsDzcwOQ7
         MY2zeIAXpKCfYn6xG/f8ScMuQ40KLidoienUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=AbIyltcwHXZCZA+6bsuyR0/2oEmHl3ZHkcMFKJXmJExgyKBSs4HRBboJ3qfM7PZApy
         z6BHQfn3pRhEZ7xtfmaEn2EzHbAg4gdb8xR96gCRWQu4CyAr3a3YjfhhhcxsWiOKJ2YB
         HLCpZucMEF6ARSt0FaDSqMi1EHXopO+tPrjFY=
Received: by 10.14.13.134 with SMTP id b6mr3599191eeb.94.1305030054224;
        Tue, 10 May 2011 05:20:54 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id s1sm4262367ees.3.2011.05.10.05.20.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 May 2011 05:20:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173330>

Right now zsh is quite broken; the completion doesn't notice when
there's a subcommand. For example: "git log origi<TAB>" gives no
completions because it would try to find a "git origi..." command. The
issue would be gone in zsh 4.3.12, but for now we can workaround it by
porting the same fix.

The problem started after commit v1.7.4-rc0~11^2~2 (bash: get
--pretty=3Dm<tab> completion to work with bash v4), which introduced
_get_comp_words_by_ref() that comes from bash-completion[1] scripts, an=
d
relies on the 'words' variable. However, it turns out 'words' is a
special variable used by zsh completion. From zshcompwid(1):

  [...] the parameters are reset on each function exit (including neste=
d
  function calls from within the completion widget) to the values they
  had when the function was entered.

As a result, subcommand words are lost.

This is now fixed in the latest master branch of zsh[2] by simply
defining 'words' as hidden (typeset -h), which removes the special
meaning inside the emulated bash function. So let's do the same.

Jonathan Nieder helped on the commit message.

[1] http://bash-completion.alioth.debian.org/
[2] http://zsh.git.sourceforge.net/git/gitweb.cgi?p=3Dzsh/zsh;a=3Dcommi=
tdiff;h=3De880604f029088f32fb1ecc39213d720ae526aaa

Reported-by: Stefan Haller <lists@haller-berlin.de>
Comments-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

v2: fix _gitk() too as Szeder suggested.

v3: improve commit message as Jonathan Nieder suggested.
    Also, improve comments.

v4: more commit message improvements

v5: even more commit message improvements from Jonathan's version

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 840ae38..a7d20df 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2710,6 +2710,10 @@ _git ()
 	if [[ -n ${ZSH_VERSION-} ]]; then
 		emulate -L bash
 		setopt KSH_TYPESET
+
+		# workaround zsh's bug that leaves 'words' as a special
+		# variable in versions < 4.3.12
+		typeset -h words
 	fi
=20
 	local cur words cword
@@ -2761,6 +2765,10 @@ _gitk ()
 	if [[ -n ${ZSH_VERSION-} ]]; then
 		emulate -L bash
 		setopt KSH_TYPESET
+
+		# workaround zsh's bug that leaves 'words' as a special
+		# variable in versions < 4.3.12
+		typeset -h words
 	fi
=20
 	__git_has_doubledash && return
--=20
1.7.5.1
