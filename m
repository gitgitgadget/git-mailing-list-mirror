From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] minor: wrong handling of GIT_AUTHOR_DATE
Date: Sat, 16 Aug 2008 22:27:23 -0700
Message-ID: <7vljyw9pok.fsf@gitster.siamese.dyndns.org>
References: <20080816205325.GD10729@mrq1.org>
 <alpine.LFD.1.10.0808161543160.3324@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808161613520.3324@nehalem.linux-foundation.org>
 <7vr68obbpd.fsf@gitster.siamese.dyndns.org>
 <7vk5egbaft.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0808162054050.3324@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hermann Gausterer <git-mailinglist@mrq1.org>,
	Git Mailinglist <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 17 07:28:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUaod-0001FH-1L
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 07:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbYHQF1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 01:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbYHQF1c
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 01:27:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38789 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbYHQF1b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 01:27:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9C5215CCFA;
	Sun, 17 Aug 2008 01:27:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3C2E95CCF9; Sun, 17 Aug 2008 01:27:26 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0808162054050.3324@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Sat, 16 Aug 2008 21:25:40 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2FFFF05E-6C1D-11DD-A029-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92578>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> [ Those four deleted lines I removed just because the cases had already 
>   been handled, eg the ">1900" case was already handled when we checked 
>   for a four-digit year, and the >70 case was handled when we checked for 
>   exactly two digits ]
>
> Hmm?

> @@ -488,10 +504,6 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
>  
>  	if (num > 0 && num < 32) {
>  		tm->tm_mday = num;
> -	} else if (num > 1900) {
> -		tm->tm_year = num - 1900;
> -	} else if (num > 70) {
> -		tm->tm_year = num;
>  	} else if (num > 0 && num < 13) {
>  		tm->tm_mon = num-1;
>  	}

The comment above this part says we always favor mday over mon, but I
wonder why this sequence is not like:

	if (tm->tm_mday is not set && num > 0 && num < 32)
		tm->tm_mday = num;
	else if (tm->tm_mon is not set && num > 0 && num < 13)
		tm->tm_mon = num - 1;

Is this because we do not initialize tm fields to "unknown" in the
beginning?  I admit I haven't bothered to look at this part of the code
for a looong time.
