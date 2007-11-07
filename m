From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: apply --suppress-from to S-o-b and cc-cmd
Date: Wed, 07 Nov 2007 12:43:16 -0800
Message-ID: <7vode5aisb.fsf@gitster.siamese.dyndns.org>
References: <1194420852-15822-1-git-send-email-ukleinek@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <Uwe.Kleine-Koenig@digi.com>,
	Ryan Anderson <ryan@michonline.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 21:44:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IprlE-0005mh-GC
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 21:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755488AbXKGUn0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Nov 2007 15:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755374AbXKGUn0
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 15:43:26 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:43800 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165AbXKGUnZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Nov 2007 15:43:25 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id EC7162F0;
	Wed,  7 Nov 2007 15:43:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 3512B933A5;
	Wed,  7 Nov 2007 15:43:41 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63856>

Uwe Kleine-K=C3=B6nig  <ukleinek@informatik.uni-freiburg.de> writes:

> From: Uwe Kleine-K=C3=B6nig <Uwe.Kleine-Koenig@digi.com>
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <Uwe.Kleine-Koenig@digi.com>
> Cc: Ryan Anderson <ryan@michonline.com>
> ---
> Hello,
>
> I don't see the sense in adding the sender to Cc: from Signed-off-by
> lines but not from From:.  If someone is convinced it makes sense, I'=
m
> willing to send a new patch that uses a different option.

I _think_ --suppress-from just means "I know what I'll be
sending out, so do not bother my mailbox with a copy of this
message", so what the patch tries to do makes perfect sense to
me.

> @@ -730,6 +729,7 @@ foreach my $t (@files) {
>  			if (/^(Signed-off-by|Cc): (.*)$/i && $signed_off_cc) {
>  				my $c =3D $2;
>  				chomp $c;
> +				next if ($c eq $sender and $suppress_from);
>  				push @cc, $c;
>  				printf("(sob) Adding cc: %s from line '%s'\n",
>  					$c, $_) unless $quiet;
> @@ -745,6 +745,7 @@ foreach my $t (@files) {
>  			my $c =3D $_;
>  			$c =3D~ s/^\s*//g;
>  			$c =3D~ s/\n$//g;
> +			next if ($c eq $sender and $suppress_from);
>  			push @cc, $c;
>  			printf("(cc-cmd) Adding cc: %s from: '%s'\n",
>  				$c, $cc_cmd) unless $quiet;

By the way, I noticed that in the header part we pick CC: and
=46rom: address, which are rfc2047 quoted, and unquote it to
compare with the sender.  If they are different, we push the
address, still rfc2047 quoted, to @cc, like this:

	} elsif (/^(Cc|From):\s+(.*)$/) {
		if (unquote_rfc2047($2) eq $sender) {
			next if ($suppress_from);
		}
		elsif ($1 eq 'From') {
			$author =3D unquote_rfc2047($2);
		}
		printf("(mbox) Adding cc: %s from line '%s'\n",
			$2, $_) unless $quiet;
		push @cc, $2;
	}

However, in the body part, when we see S-o-b: and CC: address,
which are _not_ rfc2047 quoted, do not unquote to compare with
$sender and we push it direct to @cc (the original text in the
first hunk of your patch).  We do the same for output from
$cc_cmd if specified (the second hunk).

This means that @cc list would be a mixed bag.  Some are rfc2047
quoted, and some are not.  This inconsistency of course is taken
care of by the call to sanitize_address over @cc at the very
beginning of send_message(), but it somehow feels dirty.
