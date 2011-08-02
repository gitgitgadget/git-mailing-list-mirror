From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 09/18] revert: Don't create invalid replay_opts in parse_args
Date: Tue, 2 Aug 2011 08:41:41 +0200
Message-ID: <201108020841.41593.chriscool@tuxfamily.org>
References: <1312222025-28453-1-git-send-email-artagnon@gmail.com> <1312222025-28453-10-git-send-email-artagnon@gmail.com> <201108020828.37904.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 08:42:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo8g1-000706-J1
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 08:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049Ab1HBGlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 02:41:52 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49693 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997Ab1HBGlv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 02:41:51 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 22292A61AD;
	Tue,  2 Aug 2011 08:41:42 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <201108020828.37904.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178445>

On Tuesday 02 August 2011 08:28:37 Christian Couder wrote:
> On Monday 01 August 2011 20:06:56 Ramkumar Ramachandra wrote:
> > +static void verify_opt_compatible(const char *me, const char *base_opt,
> > ...) +{
> > +	const char *this_opt;
> > +	va_list ap;
> > +	int set;
> > +
> > +	va_start(ap, base_opt);
> > +	while ((this_opt = va_arg(ap, const char *))) {
> > +		set = va_arg(ap, int);
> > +		if (set) {
> > +			va_end(ap);
> > +			die(_("%s: %s cannot be used with %s"),
> > +				me, this_opt, base_opt);
> > +		}
> > +	}
> > +	va_end(ap);
> > +}
> 
> Here I'd suggest:
> 
> static void verify_opt_compatible(const char *me, const char *base_opt,
> ...) {
> 	const char *this_opt;
> 	va_list ap;
> 
> 	va_start(ap, base_opt);
> 	while ((this_opt = va_arg(ap, const char *))) {
> 		int set = va_arg(ap, int);
> 		if (set)
> 			break;
> 	}
> 	va_end(ap);
> 
> 	if (this_opt)
> 		die(_("%s: %s cannot be used with %s"), me, this_opt, base_opt);
> }

... and we could remove the "set" variable like this:

	while ((this_opt = va_arg(ap, const char *))) {
		if (va_arg(ap, int))
			break;
	}

This could be done in verify_opt_mutually_compatible() too.

Thanks,
Christian.
