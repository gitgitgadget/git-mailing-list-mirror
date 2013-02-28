From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: zsh completion broken for file completion
Date: Thu, 28 Feb 2013 19:43:01 +0100
Message-ID: <vpqtxowp9e2.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 19:43:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UB8S8-00065W-Iw
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 19:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757196Ab3B1SnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2013 13:43:12 -0500
Received: from mx1.imag.fr ([129.88.30.5]:44635 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756486Ab3B1SnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2013 13:43:09 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r1SIgxU7015468
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 28 Feb 2013 19:43:00 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UB8RZ-0005yv-QV; Thu, 28 Feb 2013 19:43:01 +0100
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 28 Feb 2013 19:43:00 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1SIgxU7015468
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1362681781.27151@Kw4lrgkG3QR84Hw956JupA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217248>

Hi,

The completion for e.g. "git add file<tab>" is broken in master. I get
the following result:

git add fo__gitcomp_file:8: command not found: compgen

The guilty commit is fea16b47b60 (Fri Jan 11 19:48:43 2013, Manlio
Perillo, git-completion.bash: add support for path completion), which
introduces a new __gitcomp_file function that uses the bash builtin
"compgen", without redefining the function in git-completion.zsh.

The following proof-of-concept patch seems to fix the problem for me (I
basically copied the __gitcomp_nl function to __gitcomp_file and removed
the '-S "${4- }"'). The bash version does "compopt -o filenames", I
don't know what zsh equivalent is.

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 4577502..0ba1dcf 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -60,6 +60,15 @@ __gitcomp_nl ()
        compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
 }
 
+__gitcomp_file ()
+{
+       emulate -L zsh
+
+       local IFS=$'\n'
+       compset -P '*[=:]'
+       compadd -Q -p "${2-}" -- ${=1} && _ret=0
+}
+
 _git ()
 {
        local _ret=1

Felipe, you know ZSH completion much better than me. Could you turn this
into a real patch?

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
