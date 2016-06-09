From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] send-pack: use buffered I/O to talk to pack-objects
Date: Thu, 09 Jun 2016 14:10:24 +0200
Message-ID: <vpqwplypnpr.fsf@anie.imag.fr>
References: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
	<20160606151340.22424-4-william.duclot@ensimag.grenoble-inp.fr>
	<xmqqvb1mxmk4.fsf@gitster.mtv.corp.google.com>
	<20160606203901.GA7667@Messiaen>
	<xmqqfusquedk.fsf@gitster.mtv.corp.google.com>
	<20160606225847.GA22756@sigill.intra.peff.net>
	<xmqqbn3dvr22.fsf@gitster.mtv.corp.google.com>
	<20160607090653.GA4665@Messiaen> <575845D9.2010604@alum.mit.edu>
	<20160608191918.GB19572@sigill.intra.peff.net>
	<20160608194216.GA3731@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	Johannes.Schindelin@gmx.de, mh@glandium.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 09 14:10:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAynU-00083O-1K
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 14:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbcFIMKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 08:10:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38362 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753AbcFIMKr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 08:10:47 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u59CANlA026481
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 9 Jun 2016 14:10:23 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u59CAOJ7003080;
	Thu, 9 Jun 2016 14:10:24 +0200
In-Reply-To: <20160608194216.GA3731@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 8 Jun 2016 15:42:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Thu, 09 Jun 2016 14:10:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u59CANlA026481
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1466079024.30516@0o59Grmqr2ek77Gyn5yoRw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296882>

Jeff King <peff@peff.net> writes:

> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -36,18 +36,15 @@ int option_parse_push_signed(const struct option *opt,
>  	die("bad %s argument: %s", opt->long_name, arg);
>  }
>  
> -static int feed_object(const unsigned char *sha1, int fd, int negative)
> +static void feed_object(const unsigned char *sha1, FILE *fh, int negative)
>  {
> -	char buf[42];
> -
>  	if (negative && !has_sha1_file(sha1))
> -		return 1;
> +		return;
[...]
> @@ -97,21 +95,22 @@ static int pack_objects(int fd, struct ref *refs, struct sha1_array *extra, stru
[...]
>  	for (i = 0; i < extra->nr; i++)
> -		if (!feed_object(extra->sha1[i], po.in, 1))
> -			break;
> +		feed_object(extra->sha1[i], po_in, 1);

I may have missed the obvious, but doesn't this change the behavior when
"negative && !has_sha1_file(sha1)" happens? I understand that you don't
need write_or_whine anymore, but don't understand how you get rid of the
"return 1" here.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
