From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-email: skip RFC2047 quoting for ASCII subjects
Date: Wed, 24 Oct 2012 15:25:30 -0400
Message-ID: <20121024192530.GA26477@sigill.intra.peff.net>
References: <1351065815-22416-1-git-send-email-krzysiek@podlesie.net>
 <20121024084636.GA23500@sigill.intra.peff.net>
 <20121024171036.GA18880@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Wed Oct 24 21:25:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TR6aH-0005kM-Kc
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 21:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933461Ab2JXTZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 15:25:33 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54132 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933046Ab2JXTZc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 15:25:32 -0400
Received: (qmail 31922 invoked by uid 107); 24 Oct 2012 19:26:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 24 Oct 2012 15:26:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Oct 2012 15:25:30 -0400
Content-Disposition: inline
In-Reply-To: <20121024171036.GA18880@shrek.podlesie.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208322>

On Wed, Oct 24, 2012 at 07:10:36PM +0200, Krzysztof Mazur wrote:

> > > -	if ($broken_encoding{$t} && !is_rfc2047_quoted($subject)) {
> > > +	if ($broken_encoding{$t} && !is_rfc2047_quoted($subject) &&
> > > +			($subject =~ /[^[:ascii:]]/)) {
> > 
> > Is that test sufficient? We would also need to encode if it has rfc2047
> > specials, no?
> 
> For Subject this should be sufficient. According to RFC822 after
> "Subject:" we have "text" token,
> [...]
> So the problem only exists for broken RFC2047-like texts, but I think
> it's ok to just pass such subjects, in most cases the Subject comes
> from already formatted patch file. I think that we just want to fix Subjects
> without specified encoding here.

Right, but I was specifically worried about raw "=?", which is only an
issue due to rfc2047 itself.

However, reading the patch again, we are already checking for that with
is_rfc2047_quoted. It might miss the case where we have =? but not the
rest of a valid encoded word, but any compliant parser should recognize
that and leave it be.

So I think your original patch is actually correct.

> I think we can go even further, we can just add quote_subject(),
> which performs this test and calls quote_rfc2047() if necessary.
> I'm sending bellow patch that does that.

Yeah, it would still be nice to keep the logic in one place.

> diff --git a/git-send-email.perl b/git-send-email.perl
> index efeae4c..e9aec8d 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -657,9 +657,7 @@ EOT
>  			$initial_subject = $1;
>  			my $subject = $initial_subject;
>  			$_ = "Subject: " .
> -				($subject =~ /[^[:ascii:]]/ ?
> -				 quote_rfc2047($subject, $compose_encoding) :
> -				 $subject) .
> +				quote_subject($subject, $compose_encoding) .

Hrm. Isn't this one technically a regression if the $subject contains
encoded words? IOW, in this case we feed quote_subject a known-raw
header; any rfc2047 in it would want to be encoded to be preserved.

But in this case:

> @@ -1327,9 +1341,8 @@ foreach my $t (@files) {
>  		$body_encoding = $auto_8bit_encoding;
>  	}
>  
> -	if ($broken_encoding{$t} && !is_rfc2047_quoted($subject) &&
> -			($subject =~ /[^[:ascii:]]/)) {
> -		$subject = quote_rfc2047($subject, $auto_8bit_encoding);
> +	if ($broken_encoding{$t}) {
> +		$subject = quote_subject($subject, $auto_8bit_encoding);
>  	}

We have a possibly already-encoded header, and we would want to avoid
double-encoding it.

In the first case, the "wants quoting" logic should be:

  is_rfc2047_quoted($subject) || /[^[:ascii:]]/

and in the latter case it would be:

  !is_rfc2047_quoted($subject) && /^[:ascii:]]/

-Peff
