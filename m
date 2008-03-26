From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with non-ascii characters
Date: Wed, 26 Mar 2008 10:30:33 +0200
Message-ID: <20080326083033.GA13933@mithlond.arda.local>
References: <7caf19ae394accab538d2f94953bb62b55a2c79f.1206486012.git.peff@peff.net> <200803260759.48922.tlikonen@iki.fi> <20080326062029.GA26286@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 26 09:31:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeR2y-0005FS-Kw
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 09:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210AbYCZIa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 04:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbYCZIa5
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 04:30:57 -0400
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:40281 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751219AbYCZIa4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2008 04:30:56 -0400
Received: from mithlond.arda.local (80.220.180.181) by pne-smtpout4-sn1.fre.skanova.net (7.3.129)
        id 47A7970A002B5D62; Wed, 26 Mar 2008 09:30:35 +0100
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JeR1l-0003dI-Dv; Wed, 26 Mar 2008 10:30:33 +0200
Content-Disposition: inline
In-Reply-To: <20080326062029.GA26286@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78273>

Jeff King wrote:

> On Wed, Mar 26, 2008 at 07:59:48AM +0200, Teemu Likonen wrote:
> > These patches seem to work except that the quoting of Subject field
> > works only if user types a non-Ascii text to the "What subject
> > should the initial email start with?" prompt. If she changes the
> > subject in editor it won't be rfc2047-quoted.
>
> Ah, yes, I hadn't considered that. We should definitely do the quoting
> after all of the user's input. Replace 2/2 from my series with the
> patch below, which handles this case correctly (and as a bonus, the
> user sees the unencoded subject in the editor, which is much more
> readable).

It seems to work nicely after I fixed one unmatching bracket. See below.

> git-format-patch recently got a --cover-letter option which does the
> same thing. I actually use a real MUA (mutt) instead of send-email,
> and this way you can avoid the message-id cutting and pasting that is
> required. It automatically does the right thing with encodings because
> I end up sending the message using my MUA.

I had missed the --cover-letter option completely. It may be useful too.
I'm still trying to find the best way to send pathces. If I send intro
message with real MUA I either need to wait for the message to show up
on a mailing list or check my sent-mail folder to find the Message-Id.
Once I know the Message-Id I can send the actual patch series with 'git
send-email' as replies to the intro message. Well, this is OK.

> > If portable content encoding detection is difficult or considered
> > unnecessary, then I think a documented configurable option is fine
> > (UTF-8 by default).
>
> I think that is sensible. Want to try adding it on top of my patches?

I'd like to, but I can only do sh/bash stuff and possibly some
copy-and-paste programming with other scripting languages. You'd end up
fixing my code anyway, sorry.

As you noticed, I accidentally sent you a couple of test emails because
send-email CCed mails to patches' author (I think). Now I have set
"suppresscc = all" and "suppressfrom = true" which should prevent such
accidents. Shouldn't these be defaults? In my opinion it's generally the
best practice to always explicitly define what parties emails are sent
to.

There is unmatching bracket in your patch:

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 7c4f06c..3694f81 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -536,6 +536,15 @@ EOT
>  		if (!$in_body && /^MIME-Version:/i) {
>  			$need_8bit_cte = 0;
>  		}
> +		if (!$in_body && /^Subject: ?(.*)/i) {
> +			my $subject = $1;
> +			$_ = "Subject: " .
> +				($subject =~ /[^[:ascii:]]/ ?
> +				 quote_rfc2047($subject) :
> +				 $subject) .
> +				"\n";
> +			}
                        ^-- Shouldn't we remove this one?
> +		}
