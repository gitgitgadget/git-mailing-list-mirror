From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] run-command: encode signal death as a positive integer
Date: Sat, 5 Jan 2013 14:19:09 -0800
Message-ID: <20130105221909.GA3247@elie.Belkin>
References: <20130104124756.GA402@sigill.intra.peff.net>
 <7vsj6gsi7v.fsf@alter.siamese.dyndns.org>
 <20130105140316.GA7272@sigill.intra.peff.net>
 <20130105144949.GA24479@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Bart Trojanowski <bart@jukie.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 05 23:19:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trc5b-0006sU-06
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 23:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916Ab3AEWTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 17:19:19 -0500
Received: from mail-da0-f45.google.com ([209.85.210.45]:64520 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755898Ab3AEWTS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 17:19:18 -0500
Received: by mail-da0-f45.google.com with SMTP id w4so8030382dam.18
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 14:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=kZuByQBnu6iGNi+KKoDqlRE8/K2E61VK1KkT0X/tfk4=;
        b=yV/gls9Zgwnl6jjwUP+ZDf2wduQlClDQuP2lmbHr27wXCUQrKmdsZGOfTMgeBhrwES
         ld+7xM9InriJ31ijy8lln/w+4arnL0zZZnlUbE+9N5LF7dKDkSF1Ta5Ev9LtcWc4psap
         q+kNvPj/z/ite8iMFBzbgNRGkViRECKq+SYpSxSHFNrImERKYdWiVDn5/1yfz6You1ZZ
         TNTjn/q71KJdh0Camn26jDblf7Vycho1fV8A6kEG488PozgFc/CtoRLm3+MRw5fcTwB6
         Fh04u0GyJPwsOWs7GKyiwCn5rnR6veDT3AvB8P6iC58mtzULEF3xZrAEmZhhu+swJqto
         7uOQ==
X-Received: by 10.66.82.35 with SMTP id f3mr164886627pay.49.1357424357976;
        Sat, 05 Jan 2013 14:19:17 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id sb3sm34683220pbc.44.2013.01.05.14.19.15
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 14:19:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130105144949.GA24479@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212730>

Hi,

Jeff King wrote:

> When a sub-command dies due to a signal, we encode the
> signal number into the numeric exit status as "signal -
> 128".
[...]
> So we have a negative value inside the code, but once it
> passes across an exit() barrier, it looks positive (and any
> code we receive from a sub-shell will have the positive
> form).
[...]
> Unfortunately, this means that when the "use_shell" option
> is set, we need to be on the lookout for _both_ forms.
[...]
>             for the callers that do care, we can make life
> slightly easier by just using the consistent positive form.

Makes perfect sense.

>  Documentation/technical/api-run-command.txt | 6 ++----
>  editor.c                                    | 2 +-
>  run-command.c                               | 2 +-
>  3 files changed, 4 insertions(+), 6 deletions(-)

t/test-terminal.perl imitates the same logic.  It doesn't check for
anything other than whether the exit status is 0, but maybe it would
be worth squashing in the below as a futureproofing measure
nonetheless.

Aside from the launch_editor bugfix, the only observable effects of
the above patch I can find are some changed error messages:

	error: external filter cat failed -126
	-> error: external filter cat failed 130

	warning: svnrdump, returned -126
	-> warning: svnrdump, returned 130

Those messages are equally senseless before and after the patch, so
for what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

diff --git i/t/test-terminal.perl w/t/test-terminal.perl
index 10172aee..1fb373f2 100755
--- i/t/test-terminal.perl
+++ w/t/test-terminal.perl
@@ -31,7 +31,7 @@ sub finish_child {
 	} elsif ($? & 127) {
 		my $code = $? & 127;
 		warn "died of signal $code";
-		return $code - 128;
+		return $code + 128;
 	} else {
 		return $? >> 8;
 	}
