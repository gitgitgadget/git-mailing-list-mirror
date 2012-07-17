From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/3] Testing: XDG config files: Export a suitable `XDG_CONFIG_HOME' environment variable
Date: Tue, 17 Jul 2012 20:14:00 +0200
Message-ID: <vpqmx2yp85z.fsf@bauges.imag.fr>
References: <82316e5034d940e09fed719ae7bfdc3b-mfwitten@gmail.com>
	<679ad82bd4604d1c903f3c2fff2a8cfb-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 20:14:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrCHn-0008Ea-Nw
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 20:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756003Ab2GQSOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 14:14:10 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55537 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752429Ab2GQSOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 14:14:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6HICMsp028464
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Jul 2012 20:12:22 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SrCHY-0001vR-Tp; Tue, 17 Jul 2012 20:14:00 +0200
In-Reply-To: <679ad82bd4604d1c903f3c2fff2a8cfb-mfwitten@gmail.com> (Michael
	Witten's message of "Tue, 17 Jul 2012 16:41:20 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 17 Jul 2012 20:12:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6HICMsp028464
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1343153545.87368@HA4rmmHUJ4Rh318byDIREQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201615>

Michael Witten <mfwitten@gmail.com> writes:

> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -544,6 +544,9 @@ rm -fr "$test" || {
>  HOME="$TRASH_DIRECTORY"
>  export HOME
>  
> +XDG_CONFIG_HOME=$HOME/.config
> +export XDG_CONFIG_HOME
> +

Why not just unset XDG_CONFIG_HOME?

Your match makes it look like XDG_CONFIG_HOME is required to use the
configuration directory, but it is not. To me, the main feature is the
ability to use $HOME/.config/git/ as a configuration directory (this is
not just a convention, this is a documented feature), and the management
of the variable $XDG_CONFIG_HOME is just a bonnus.

Before your patches, the correct management of $XDG_CONFIG_HOME to
override $HOME/.config/git/ was untested (which is unfortunate, indeed),
but after your patch serie, the fact that the default is
$HOME/.config/git/ is untested, which IMHO is even worse.

Unsetting XDG_CONFIG_HOME and adding one test like this would be better
IMHO.

diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index 3c75c3f..f1ea9f1 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -38,6 +38,19 @@ test_expect_success 'read with --get: xdg file exists and ~/.gitconfig doesn'\''
        test_cmp expected actual
 '
 
+test_expect_success '"$XDG_CONFIG_HOME overrides $HOME/.config/git' '
+       mkdir -p "$HOME"/xdg/git/ &&
+       echo "[user]" >"$HOME"/xdg/git/config &&
+       echo "  name = in_xdg" >>"$HOME"/xdg/git/config &&
+       echo in_xdg >expected &&
+       (
+               XDG_CONFIG_HOME="$HOME"/xdg/ &&
+               export XDG_CONFIG_HOME &&
+               git config --get-all user.name >actual
+       ) &&
+       test_cmp expected actual
+'
+
 
 test_expect_success 'read with --get: xdg file exists and ~/.gitconfig exists' '
        >.gitconfig &&


-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
