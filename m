From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] git-completion.zsh: define __gitcomp_file compatibility function
Date: Tue,  5 Mar 2013 09:43:55 +0100
Message-ID: <1362473035-5034-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqtxowp9e2.fsf@grenoble-inp.fr>
Cc: felipe.contreras@gmail.com, manlio.perillo@gmail.com,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 05 09:44:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCnUE-0004DU-Sj
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 09:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841Ab3CEIoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 03:44:13 -0500
Received: from mx2.imag.fr ([129.88.30.17]:36775 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753153Ab3CEIoM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 03:44:12 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r258i2n9023393
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 5 Mar 2013 09:44:02 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1UCnTe-0006Ie-V0; Tue, 05 Mar 2013 09:44:02 +0100
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1UCnTe-0001KR-QO; Tue, 05 Mar 2013 09:44:02 +0100
X-Mailer: git-send-email 1.8.1.3.572.g35e1b60
In-Reply-To: <vpqtxowp9e2.fsf@grenoble-inp.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 05 Mar 2013 09:44:02 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r258i2n9023393
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1363077847.55492@MTSTS0hmiZwEEMXZ7u7Q5w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217437>

Commit fea16b47b60 (Fri Jan 11 19:48:43 2013, Manlio Perillo,
git-completion.bash: add support for path completion), introduced a new
__gitcomp_file function that uses the bash builtin "compgen". The
function was redefined for ZSH in the deprecated section of
git-completion.bash, but not in the new git-completion.zsh script.

As a result, users of git-completion.zsh trying to complete "git add
fo<tab>" get an error:

git add fo__gitcomp_file:8: command not found: compgen

This patch adds the redefinition and removes the error.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
> Felipe, you know ZSH completion much better than me. Could you turn this
> into a real patch?

No response from Felipe, so I'm trying my own patch. Compared to the
snippet I already sent, I added the -f option to "compadd", which was
there in the __gitcomp_file function defined in the deprecated ZSH
compatibility section of the bash script, and gives the ZSH equivalent
for "compopt -o filenames".

This fixes an annoying regression for ZSH users, so it may deserve to
be in the future 1.8.2.

 contrib/completion/git-completion.zsh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 4577502..cf8116d 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -60,6 +60,15 @@ __gitcomp_nl ()
 	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
 }
 
+__gitcomp_file ()
+{
+	emulate -L zsh
+
+	local IFS=$'\n'
+	compset -P '*[=:]'
+	compadd -Q -p "${2-}" -f -- ${=1} && _ret=0
+}
+
 _git ()
 {
 	local _ret=1
-- 
1.8.1.3.572.g35e1b60
