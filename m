From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 1/4] engine.pl: Fix a recent breakage of the buildsystem
 generator
Date: Wed, 20 Jan 2010 23:54:37 +0100
Message-ID: <4B5789AD.2080807@gmail.com>
References: <4B575838.2010504@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Jan 20 23:55:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXjS6-0001cD-Hw
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 23:55:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237Ab0ATWy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 17:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181Ab0ATWy5
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 17:54:57 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:10884 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab0ATWy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 17:54:56 -0500
Received: by fg-out-1718.google.com with SMTP id 22so394777fge.1
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 14:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=R3RTCQYHeUi6OYME/YvAstSUjtf3mrdbVSaQ+wnPxDQ=;
        b=eAdpqO4bVugqQv92kPA9TAXNY/VJS+ob9vKyitEKsJ2gPz/0rzLkwMudx6kO1XOHYZ
         Da1DprhbqcfJVF2uzh1f6jZBMqUmrEIJmldAjn+dkMxlnLHL98uIXfLF7oCHfaqU4FAd
         1EQYJN8AUGihVyAog6J5349rw30Q9srEghFo4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=usJbLY1V2akWymKvZkhqARb/DJcQPF7yVfLPDGB6sB/PAHXXE0zrqOA+v0zQWxZ7lb
         WFXWFVTUNvbEp6Svg+aFk2ynkBXzUxgMuj9RNAfB9KD3uitVoiTEtn4dkcH0dhEcjIsw
         DmBeD6vMeu3Mq6+mpi7cSF0MFLLAL3Q1eNeNg=
Received: by 10.102.204.2 with SMTP id b2mr327757mug.80.1264028095192;
        Wed, 20 Jan 2010 14:54:55 -0800 (PST)
Received: from ?192.168.1.11? (91-67-62-42-dynip.superkabel.de [91.67.62.42])
        by mx.google.com with ESMTPS id y6sm1628446mug.1.2010.01.20.14.54.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Jan 2010 14:54:54 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4B575838.2010504@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137598>

On 20.01.2010 20:23, Ramsay Jones wrote:

 > '-o' or connective. This resulted in the buildsystem generator
 > mistaking the conditional 'rm' for a linker command. In order

Thanks for spotting the cause of this! Some comments:

1. How about deleting lines 183-185 in same run? That commented out 
code, too, is missing the escapes for the pipes that Pete mentioned anyway.

-#        } elsif ($text =~ /^test / && $text =~ /|| rm -f /) {
-#            # commands removing executables, if they exist
-#


2. Couldn't we reduce the test to just

+        if ($text =~ /^test /) {
+            # options to test may be mistaken for linker options
+            next;
+        }
+

3. If the above won't do for some reason, I'd still prefer something like

+        if ($text =~ /^test / && $text =~ / -o /) {
+            # options to test may be mistaken for linker options
+            next;
+        }
+

as it makes more clear what's the problem in such lines.

-- 
Sebastian Schuberth
