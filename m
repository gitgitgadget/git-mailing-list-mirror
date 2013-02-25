From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Fix date checking in case if time was not initialized.
Date: Mon, 25 Feb 2013 14:07:16 -0800
Message-ID: <7v4nh0oxnv.fsf@alter.siamese.dyndns.org>
References: <CAHXAxrOOqn6ZSVT1AFyO3a3paD1tokBtcnaX68a+ddhodOvZ6Q@mail.gmail.com>
	<7vzjysxnb1.fsf@alter.siamese.dyndns.org>
	<CAHXAxrMaQRdBxSvNO+no_9d==v0tVnkpXtguTKyfvnm-VfR_xA@mail.gmail.com>
	<7vr4k4xlie.fsf@alter.siamese.dyndns.org>
	<CAHXAxrOjSS5jGLcCw4KTxP_F_uRQhi0cPSvzbx58jx9dP25XPA@mail.gmail.com>
	<7va9qsxjzk.fsf@alter.siamese.dyndns.org>
	<CAHXAxrO4c=s0pjNpXK171HUbQT06jm-VAxNNK1DAqZEZfz6OtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 23:07:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA6DF-0005Xc-8i
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 23:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758305Ab3BYWHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 17:07:32 -0500
Received: from plane.gmane.org ([80.91.229.3]:36283 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754434Ab3BYWHc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 17:07:32 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UA6D8-0005SZ-HL
	for git@vger.kernel.org; Mon, 25 Feb 2013 23:07:50 +0100
Received: from c-98-234-214-94.hsd1.ca.comcast.net ([98.234.214.94])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Feb 2013 23:07:50 +0100
Received: from gitster by c-98-234-214-94.hsd1.ca.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Feb 2013 23:07:50 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-98-234-214-94.hsd1.ca.comcast.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Cancel-Lock: sha1:p56vKUij+Oe2SuSB1eZTrS+FKTE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217112>

Mike Gorchak <mike.gorchak.qnx@gmail.com> writes:

>>> So is_date() always return negative result for the text string where
>>> date is placed before time like '2008-02-14 20:30:45'.
>> Yes, it returns this -1 on other platforms, but...
>>> It must fail on
>>> other platforms as well.
>
> It also fails under Linux, but real problem is not here, it is just an
> unoptimal date parser.

The test does _not_ fail.  That if condition does return -1 on Linux
and BSD, and making tm_to_time_t() return a failure, but the caller
goes on, ending up with the right values in year/month/date in the
tm struct, which is the primary thing the function is used for.

As you said, what is_date() wants to see is if the caller guessed
the order of three combinations of year/month/date correctly, it
cannot necessarily assume the caller already has seen the
hour/minutes/seconds yet, so _temporarily_ feeding a valud set of
values to hour/minutes/seconds when calling tm_to_time_t() is a good
workaround.  So the change in your patch sounds correct and use of a
temporary tm to avoid contaminating the hour/minutes/seconds passed
to the is_date() function while doing so looks good.

>> ... the input '2008-02-14 20:30:45' still parses fine for others
>> (including me).  That is what is puzzling.
>
>> A shot in the dark: perhaps your time_t is unsigned?
>
> Yeah, it was a headshot :) It really due to unsigned time_t. I will
> send two patches right now with fixes regarding unsigned time_t
> comparison.

If your time_t is unsigned, the error returned from tm_to_time_t()
will appear to be a time in a distant future, which will prevent
is_date() to return "Yeah, you guessed the order of year, month, and
date correctly" to its caller.  The code would need to pick a safer
mechanism to signal a failure from tm_to_time_t() to its callers.
