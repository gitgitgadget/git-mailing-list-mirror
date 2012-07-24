From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/3] test-lib.sh: unset XDG_CONFIG_HOME
Date: Tue, 24 Jul 2012 14:06:43 +0200
Message-ID: <vpqpq7l8iss.fsf@bauges.imag.fr>
References: <20120724115305.GA7328@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Witten <mfwitten@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 24 14:07:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StdtF-00062J-V3
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 14:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753600Ab2GXMG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 08:06:57 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38366 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753534Ab2GXMG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 08:06:56 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6OC4jM1025648
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 24 Jul 2012 14:04:45 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Stdsx-0007OG-LV; Tue, 24 Jul 2012 14:06:43 +0200
In-Reply-To: <20120724115305.GA7328@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 24 Jul 2012 07:53:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 24 Jul 2012 14:04:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6OC4jM1025648
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1343736286.74192@sTPg2xL1acAt7v4hItqc+g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202032>

Thanks (for the 3 patches, all of them look good).

the "unset XDG_CONFIG_HOME" part was already discussed here:

  http://thread.gmane.org/gmane.comp.version-control.git/201609

But Michael did not continue the thread. I think your solution (unset
$XDG_CONFIG_HOME instead of setting it to $HOME/.config/git) is better.

In the thread above, I also proposed checking that $XDG_CONFIG_HOME was
taken into account, but for the "git config" part (while you test the
attributes part).

I think it makes sense to add stg like this to your PATCH 3:


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
