From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: [PATCH 5/5] git-send-email: allow edit invalid email address
Date: Mon, 26 Nov 2012 18:33:18 +0100
Message-ID: <20121126173318.GA12101@shrek.podlesie.net>
References: <7v8v9vrgc9.fsf@alter.siamese.dyndns.org>
 <1353607932-10436-1-git-send-email-krzysiek@podlesie.net>
 <1353607932-10436-5-git-send-email-krzysiek@podlesie.net>
 <7vobikthpp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Felipe Balbi <balbi@ti.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 18:33:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td2Z1-00060Q-9x
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 18:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756737Ab2KZRdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 12:33:25 -0500
Received: from [93.179.225.50] ([93.179.225.50]:34967 "EHLO shrek.podlesie.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756731Ab2KZRdW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 12:33:22 -0500
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id 0098C61C; Mon, 26 Nov 2012 18:33:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vobikthpp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210457>

On Mon, Nov 26, 2012 at 09:08:34AM -0800, Junio C Hamano wrote:
> Krzysztof Mazur <krzysiek@podlesie.net> writes:
> 
> > In some cases the user may want to send email with "Cc:" line with
> > email address we cannot extract. Now we allow user to extract
> > such email address for us.
> >
> > Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
> > ---
> >  git-send-email.perl | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index d42dca2..9996735 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -851,10 +851,10 @@ sub extract_valid_address_or_die {
> >  
> >  sub validate_address {
> >  	my $address = shift;
> > -	if (!extract_valid_address($address)) {
> > +	while (!extract_valid_address($address)) {
> >  		print STDERR "error: unable to extract a valid address from: $address\n";
> > -		$_ = ask("What to do with this address? ([q]uit|[d]rop): ",
> > -			valid_re => qr/^(?:quit|q|drop|d)/i,
> > +		$_ = ask("What to do with this address? ([q]uit|[d]rop|[e]dit): ",
> > +			valid_re => qr/^(?:quit|q|drop|d|edit|e)/i,
> >  			default => 'q');
> >  		if (/^d/i) {
> >  			return undef;
> > @@ -862,6 +862,9 @@ sub validate_address {
> >  			cleanup_compose_files();
> >  			exit(0);
> >  		}
> > +		$address = ask("Who should the email be sent to (if any)? ",
> > +			default => "",
> > +			valid_re => qr/\@.*\./, confirm_only => 1);
> 
> Not having this new code inside "elsif (/^e/) { }" feels somewhat
> sloppy, even though it is not *too* bad.  Also do we know this

ok, I will fix that.

> function will never be used for addresses other than recipients' (I
> gave a cursory look to see what is done to the $sender and it does
> not seem to go through this function, tho)?

Yes, this function is called only from validate_address_just()
to filter @initial_to, @initial_cc, @bcc_list as early as possible,
and filter @to and @cc added in each email.

Krzysiek
