From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] gc: call "prune --expire 2.weeks.ago" by default
Date: Wed, 12 Mar 2008 16:39:18 -0700
Message-ID: <7vod9j342h.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site>
 <7vskywadum.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803112234470.2947@xanadu.home>
 <alpine.LSU.1.00.0803121833210.1656@racer.site>
 <47D8193B.901@nrlssc.navy.mil> <m3prtzyens.fsf@localhost.localdomain>
 <47D83532.70103@nrlssc.navy.mil>
 <alpine.LSU.1.00.0803122058430.1656@racer.site>
 <47D83C53.7000602@nrlssc.navy.mil>
 <7vejaf65q0.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803122153440.1656@racer.site>
 <7vwso74p33.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803122348210.1656@racer.site>
 <7vzlt335a5.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803130021520.1656@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Jakub Narebski <jnareb@gmail.com>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 13 00:40:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZaYI-0003W3-Va
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 00:40:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbYCLXj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 19:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbYCLXj2
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 19:39:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60476 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbYCLXj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 19:39:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F3C7F1101;
	Wed, 12 Mar 2008 19:39:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id F30B0105B; Wed, 12 Mar 2008 19:39:20 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0803130021520.1656@racer.site> (Johannes
 Schindelin's message of "Thu, 13 Mar 2008 00:28:08 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77026>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Eh, sorry, but why?
>
> The thing is: I want to prevent invalid dates in gc.pruneExpire from going 
> unnoticed, _especially_ since they would default to "now".  IOW if you 
> said something like "one.weak.ago", it would actually have the same effect 
> as "now" and offer _no_ grace period.
>
> But like you said, comparing the difference of two unsigned longs to >= 0 
> might be quite stupid.  Instead, I compare them _directly_.
>
> Since I compare the value to "now" first, and only if it is not, compare 
> the approxidate() of the value to the current time stamp, I can verify 
> that no invalid date was specified.
>
> Unfortunately, this check includes future dates.  Fortunately, they do not 
> make sense at all.
>
> To make my reasoning clear, how about this comment above that if() clause?
>
> 		/*
> 		 * In case of an invalid date, approxidate() returns the
> 		 * same as approxidate("now").  Since the millisecond
> 		 * boundary could have been crossed between the two calls
> 		 * to approxidate(), we compare not only for equality,
> 		 * but also if the former is greater than the latter.
> 		 *
> 		 * Note: this assumes that future dates are invalid, which
> 		 * makes sense, really.
> 		 */
>
> Hmm?

Ah,...

But C language rules haven't changed in such a way that it guarantees B to
be evaluated before A when you write "A >= B", have it?

So at least I think you would need something like this if you go that
route:

  		if (strcmp(value, "now")) {
                	unsigned long now = approxidate("now");
                	if (approxidate(value) >= now)
				return error("Invalid %s: '%s'", var, value);
			...
		}

Also the resolution of approxidate() is in seconds so millisecond boundary
does not matter, but that issue is, eh, secondary ;-).

I have to wonder if approxidate_with_error() function that takes a pointer
to receive an error condition may be a better way to solve this cleanly.
