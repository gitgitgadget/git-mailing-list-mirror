From: John Keeping <john@keeping.me.uk>
Subject: Re: Timezone with DATE_STRFTIME
Date: Mon, 8 Feb 2016 15:46:43 +0000
Message-ID: <20160208154643.GQ29880@serenity.lan>
References: <20160208143317.GN29880@serenity.lan>
 <20160208152858.GA17226@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 16:46:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSo1g-0002WY-MG
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 16:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144AbcBHPqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 10:46:53 -0500
Received: from mta1-jackal.aluminati.org ([72.9.247.211]:41787 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755140AbcBHPqv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 10:46:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id ED4F6CDA525;
	Mon,  8 Feb 2016 15:46:50 +0000 (GMT)
X-Quarantine-ID: <sPZh-Fci0xaP>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sPZh-Fci0xaP; Mon,  8 Feb 2016 15:46:50 +0000 (GMT)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 801D9CDA55F;
	Mon,  8 Feb 2016 15:46:44 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20160208152858.GA17226@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285779>

On Mon, Feb 08, 2016 at 10:28:58AM -0500, Jeff King wrote:
> On Mon, Feb 08, 2016 at 02:33:17PM +0000, John Keeping wrote:
> 
> > I have just noticed that with DATE_STRFTIME, the timezone in the output
> > is likely to be incorrect.
> > 
> > For all other time formats, we print the string ourselves and use the
> > correct timezone from the input, but with DATE_STRFTIME strftime(3) will
> > always use the system timezone.
> 
> You mean here that the "%z" formatting will not be correct, right?
> AFAICT the time shown is generally correct for the original of the
> author, and we simply need to communicate the zone to strftime.
> 
> Taking the current tip of master, for instance, I get:
> 
>   $ for i in \
>       default \
>       local \
>       "format:%H:%M %z" \
>       "format-local:%H:%M %z"; do
>             git log -1 --format=%ad --date="$i" ff4ea6004
>     done
>   Fri Feb 5 15:24:02 2016 -0800
>   Fri Feb 5 18:24:02 2016
>   15:24 +0000
>   18:24 +0000
> 
> You can see that my system is in -0500, three hours ahead of the author.
> And as expected, strftime shows the time in the original author's
> timezone. The %z information is totally bogus, but I don't think it has
> anything to do with the system time. It is simply that we don't provide
> it (...but having just looked at _your_ local timezone from your email,
> I can guess how you got confused :) ).
> 
> So I think the fix is probably just that we need to feed the zone
> information to strftime via the "struct tm".

If "struct tm" had a standard field for that...

Obviously "struct tm" does have a field for the offset (which is how we
end up in +0000 above, because our "struct tm" comes from gmtime(3)),
but it's not standardized so I don't think we can rely on it.

AFAICT the only way to pass the timezone into the C library time
functions is via $TZ or the global "timezone" variable, but from looking
at a couple of implementations I don't think strftime() will actually
look at those (the timezone is instead embedded when the "struct tm" is
generated).
