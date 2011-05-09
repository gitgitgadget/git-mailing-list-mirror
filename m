From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 (for maint)] git-completion: fix zsh support
Date: Tue, 10 May 2011 01:14:59 +0300
Message-ID: <1304979299-6496-1-git-send-email-felipe.contreras@gmail.com>
References: <BANLkTikkhryMa69DSx4EAYjw+aar4icKcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 00:15:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJYja-0001qJ-W3
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 00:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755659Ab1EIWPP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 18:15:15 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:65336 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab1EIWPO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 18:15:14 -0400
Received: by ewy4 with SMTP id 4so1674531ewy.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 15:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=B4hwtGtnQu+weXNxrK1dKF8W/kxBmzoXfULOjegbgxg=;
        b=dFnzI6uGKdBOJK2rFfpUbToBVfOXFy1yMgNjJV9tytHxWJIbmDK4B3CUajtSI6gj55
         nAqvbuySjWOgI0Gixed5iSjacejBgE/tnLcmt9r2JCSwKSmpaiXMEjGuUcVsaDgA6p7f
         uayl1suEPH0OWsGSIEgqDl8P6EQLEdj0oDmKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Og/7Rxn2rk7rmGHJAR/4S+ZDyIKP7/+nfZbLwbmQWajg91lhkMPq5LK8PJRqrhUXfE
         NzkgKNSPILaff+MRz6rUVHLDBp6RLvqiRr1jen4pL7VNmY4pVFB47FbdF4KCuC0th7rr
         YSLypbJ+td15m8D4eyJcYD9MNOJKwkG2K126U=
Received: by 10.14.43.19 with SMTP id k19mr3301507eeb.187.1304979312322;
        Mon, 09 May 2011 15:15:12 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id n55sm3796231een.2.2011.05.09.15.15.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2011 15:15:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.1.g638e6
In-Reply-To: <BANLkTikkhryMa69DSx4EAYjw+aar4icKcQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173275>

It turns out 'words' is a special variable used by zsh completion. This
was not isolated correctly in zsh's bash completion emulation, so by
trying to set it as 'local' in git's completion, unexpected results
occur; assignations are not propagated to outer levels in the call
stack.

This is now fixed in the latest master branch of zsh[1] by simply
defining 'words' as hidden (typeset -h), which removes the special
meaning inside the emulated bash function. It probably won't be release=
d
until version 4.3.12.

In the meantime, we can workaround the issue by doing the same; definin=
g
words as hidden (typeset -h) as soon as possible.

Right now zsh is completely broken after commit da48616 (bash: get
--pretty=3Dm<tab> completion to work with bash v4), which introduced
_get_comp_words_by_ref() that comes from bash-completion[2] scripts, an=
d
relies on the 'words' variable to behave like any normal variable.

[1] http://zsh.git.sourceforge.net/git/gitweb.cgi?p=3Dzsh/zsh;a=3Dcommi=
tdiff;h=3De880604f029088f32fb1ecc39213d720ae526aaa
[2] http://bash-completion.alioth.debian.org/

Comments-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
Comments-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

This patch is meant for the maintenance branch, so Szeder's patches are=
 not
required.

v2: fix _gitk() too as Szeder suggested.

v3: improve commit message as Jonathan Nieder suggested.
    Also, improve comments.

v4: more commit message improvements

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 840ae38..763f145 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2710,6 +2710,10 @@ _git ()
 	if [[ -n ${ZSH_VERSION-} ]]; then
 		emulate -L bash
 		setopt KSH_TYPESET
+
+		# workaround zsh's bashinit's bug that leaves 'words' as a
+		# special variable in versions < 4.3.12
+		typeset -h words
 	fi
=20
 	local cur words cword
@@ -2761,6 +2765,10 @@ _gitk ()
 	if [[ -n ${ZSH_VERSION-} ]]; then
 		emulate -L bash
 		setopt KSH_TYPESET
+
+		# workaround zsh's bashinit's bug that leaves 'words' as a
+		# special variable in versions < 4.3.12
+		typeset -h words
 	fi
=20
 	__git_has_doubledash && return
--=20
1.7.5.1.1.g638e6
