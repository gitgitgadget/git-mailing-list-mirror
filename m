From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 (for maint)] git-completion: fix zsh support
Date: Mon,  9 May 2011 23:45:13 +0300
Message-ID: <1304973913-5376-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 22:45:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJXKi-00029v-4z
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 22:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937Ab1EIUpa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 16:45:30 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36904 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758Ab1EIUpa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 16:45:30 -0400
Received: by ewy4 with SMTP id 4so1656890ewy.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 13:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=xwjGlyDPpZXMwTiG+F+RjzI4GFi+3C6MqI56hlO8QZ4=;
        b=CVGbJWr5EmnHjZRTcdWmDV1MLg9fQBQ2SguaFNdK/2bONSSJNqBqpbM8EVLFNQOXWW
         CrKzWgwq7cJEu99QopZ+RcJnvCRUobnwV9Q7XXPXxGBWbRhze1u2xRp08Z8Xdg5SN1Nl
         Y1qf78ndpoHHnE/7JLXqdLOjurb2y14B0GYm0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=OgFwvb/fMgpo/FBmtgZSLgysM7dRhlZNd1emeuMW9C5z1+LfkfGrZfzpYAxYiF+6x2
         X5XZX7Kfe1VBJiJELdVSXHzhSN/XZfbJGAkwP5jZyp9KAKyMfO6Vo0yfvzE4pFAf7Ojd
         MAzGw0/LdhQiw6nw0aiYcuhAYKjXutEkVHRf0=
Received: by 10.14.122.201 with SMTP id t49mr3160179eeh.25.1304973928633;
        Mon, 09 May 2011 13:45:28 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id r12sm3779313eeb.4.2011.05.09.13.45.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2011 13:45:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.1.g638e6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173251>

It turns out 'words' is a special variable used by zsh completion, sort
of like 'COMP_WORDS' in bash. This was not isolated correctly in zsh's
bash completion, so by trying to set it as 'local' in git's completion,
unexpected results occur; assignations are not propagated to upper
levels in the call stack.

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
_get_comp_words_by_ref() that comes from debian's bash_completion
scripts, and relies on the 'words' variable to behave like any normal
variable.

[1] http://zsh.git.sourceforge.net/git/gitweb.cgi?p=3Dzsh/zsh;a=3Dcommi=
tdiff;h=3De880604f029088f32fb1ecc39213d720ae526aaa

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
