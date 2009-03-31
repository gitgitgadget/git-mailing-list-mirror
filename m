From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/2] send-email: add tests for refactored prompting
Date: Tue, 31 Mar 2009 10:07:25 -0400
Message-ID: <76718490903310707s75e24e39l63f0d396f60a0583@mail.gmail.com>
References: <1238290751-57461-1-git-send-email-jaysoffian@gmail.com>
	 <1238290751-57461-2-git-send-email-jaysoffian@gmail.com>
	 <20090331103303.GD3307@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 31 16:09:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoeeU-0007Dl-5z
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 16:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573AbZCaOHe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 10:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbZCaOHd
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 10:07:33 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:40727 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbZCaOHc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 10:07:32 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2445108ywb.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 07:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=o4QcaWSOobq1tcnoywRAxeY3Rh8/jNAxtr2AN6Vwfj0=;
        b=xwnB/t/mSiK+HInslN1bfuQL4tdwJ/qZ403tNy4kgoUs0GdMrIffvtYK5tcs/TIUBp
         xi7raTcpzjdktF7D01RAzoxAiP1TA6Z7TI0Y5LZre1BrL/vZgu5b8KkqMsr7UkyjGnww
         pmwzvkrwrV6PGnRPpse0wi0IgfPVjn60hf5zc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BPdE/Mycm9kFtonJjXnTaPfuOCEdakQWFfbMuOZCN4Q0UCEYaFnlkqtVawILJ1B/ID
         Y6kyw3jtBTyiM4ZZNGFL1VzdnMdzia9Jz+8hfBOGXbZMOYgFvWqif80mGd/eBQiYLqya
         kvuO9aKfMaUdX8m2DGV17IawWZqo8Ub4TktFs=
Received: by 10.150.212.14 with SMTP id k14mr3007651ybg.214.1238508445911; 
	Tue, 31 Mar 2009 07:07:25 -0700 (PDT)
In-Reply-To: <20090331103303.GD3307@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115261>

2009/3/31 Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>:
> These two cause interactive prompts for me.

Ah, it's because of going through test_must_fail. Grrr, a test farm
for git would be nice. :-)

This should fix it up:

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index b4de98c..cd34525 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -476,7 +476,8 @@ test_expect_success 'confirm detects EOF (inform
assumes y)' '
 test_expect_success 'confirm detects EOF (auto causes failure)' '
        CONFIRM=3D$(git config --get sendemail.confirm) &&
        git config sendemail.confirm auto &&
-       GIT_SEND_EMAIL_NOTTY=3D1 \
+       GIT_SEND_EMAIL_NOTTY=3D1 &&
+       export GIT_SEND_EMAIL_NOTTY &&
                test_must_fail git send-email \
                        --from=3D"Example <nobody@example.com>" \
                        --to=3Dnobody@example.com \
@@ -490,8 +491,9 @@ test_expect_success 'confirm detects EOF (auto
causes failure)' '
 test_expect_success 'confirm doesnt loop forever' '
        CONFIRM=3D$(git config --get sendemail.confirm) &&
        git config sendemail.confirm auto &&
-       yes "bogus" | GIT_SEND_EMAIL_NOTTY=3D1 \
-               test_must_fail git send-email \
+       GIT_SEND_EMAIL_NOTTY=3D1 &&
+       export GIT_SEND_EMAIL_NOTTY &&
+               yes "bogus" | test_must_fail git send-email \
                        --from=3D"Example <nobody@example.com>" \
                        --to=3Dnobody@example.com \
                        --smtp-server=3D"$(pwd)/fake.sendmail" \

What's your OS and test shell btw?

j.
