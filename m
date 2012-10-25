From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-email: skip RFC2047 quoting for ASCII subjects
Date: Thu, 25 Oct 2012 05:01:49 -0400
Message-ID: <20121025090149.GC8390@sigill.intra.peff.net>
References: <1351065815-22416-1-git-send-email-krzysiek@podlesie.net>
 <20121024084636.GA23500@sigill.intra.peff.net>
 <20121024171036.GA18880@shrek.podlesie.net>
 <20121024192530.GA26477@sigill.intra.peff.net>
 <20121024210826.GA23562@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 11:02:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRJKM-0003jC-1Y
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 11:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934921Ab2JYJB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 05:01:57 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55965 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934647Ab2JYJBz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 05:01:55 -0400
Received: (qmail 6531 invoked by uid 107); 25 Oct 2012 09:02:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Oct 2012 05:02:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2012 05:01:49 -0400
Content-Disposition: inline
In-Reply-To: <20121024210826.GA23562@shrek.podlesie.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208368>

On Wed, Oct 24, 2012 at 11:08:26PM +0200, Krzysztof Mazur wrote:

> ok, I'm sending a version that just adds quote_subject() without
> changing any logic, so now we still have in first case:
> 
>  /[^[:ascii:]]/
> 
> and in the latter case:
>  
>  !is_rfc2047_quoted($subject) && /^[:ascii:]]/
> 
> 
> In the next patch I will just add matching for "=?" in 
> subject_needs_rfc2047_quoting() and we will have:
> 
>    /=?/ || /[^[:ascii:]]/
> 
> and in the latter case:
>  
>    !is_rfc2047_quoted($subject) && (/=\?/ || /^[:ascii:]]/)
> 
> This will also add quoting for any rfc2047 quoted subject or any
> other rfc2047-like subject, as you suggested.

Thanks, the two-patch series you outline makes a lot of sense to me.

> Krzysiek
> -- 
> From a70c5385f9b4da69a8ce00a1448f87f63bbd500d Mon Sep 17 00:00:00 2001
> From: Krzysztof Mazur <krzysiek@podlesie.net>
> Date: Wed, 24 Oct 2012 22:46:00 +0200
> Subject: [PATCH] git-send-email: introduce quote_subject()

When sending a patch following some cover letter material, please cut
out any non-essential headers and use the scissors symbol, like this:

  -- >8 --
  Subject: [PATCH] this subject overrides the whole email's subject

  the regular body and diff go here...

That format is understood by "git am" and means I do not have to
manually munge it, which saves a little work.

> +sub quote_subject {
> + 	local $subject = shift;
> + 	my $encoding = shift || 'UTF-8';
> +
> + 	if (subject_needs_rfc2047_quoting($subject)) {
> +		return quote_rfc2047($subject, $encoding);
> + 	}
> + 	return $subject;
> +}

There is some funny whitespace here (space followed by tab).

> -	if ($broken_encoding{$t} && !is_rfc2047_quoted($subject) &&
> -			($subject =~ /[^[:ascii:]]/)) {
> -		$subject = quote_rfc2047($subject, $auto_8bit_encoding);
> +	if ($broken_encoding{$t} && !is_rfc2047_quoted($subject)) {
> +		$subject = quote_subject($subject, $auto_8bit_encoding);
>  	}

Hmm. What is this patch on top of? It looks like it is on top of your
original patch, but when I tried it on top of that, it does not apply
either, and the index lines in the patch do not mention a sha1 that I do
not have.

Do you mind re-rolling a final 2-patch series with:

  1. Your original patch and this one squashed together, with an
     appropriate commit message.

  2. The second "quote when we see '=?'" patch.

Thanks.

-Peff
