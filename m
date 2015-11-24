From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH] send-email: die if CA path doesn't exist
Date: Tue, 24 Nov 2015 23:10:41 +0000
Message-ID: <20151124231041.GC18913@serenity.lan>
References: <27f354a4edb166e42006b0c1f778827a3dfd58ac.1447798206.git.john@keeping.me.uk>
 <20151120111848.GC11198@sigill.intra.peff.net>
 <20151120194651.GC21488@serenity.lan>
 <20151124195842.GA7174@sigill.intra.peff.net>
 <20151124221708.GA18913@serenity.lan>
 <20151124222821.GA10058@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 25 00:10:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Mjd-00040O-1f
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 00:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755429AbbKXXKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 18:10:51 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:50961 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbbKXXKu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 18:10:50 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id EC384CDA546;
	Tue, 24 Nov 2015 23:10:49 +0000 (GMT)
X-Quarantine-ID: <6iKX+9GtN94j>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.001
X-Spam-Level: 
X-Spam-Status: No, score=-1.001 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_20=-0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6iKX+9GtN94j; Tue, 24 Nov 2015 23:10:49 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 09C83CDA563;
	Tue, 24 Nov 2015 23:10:43 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20151124222821.GA10058@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281648>

On Tue, Nov 24, 2015 at 05:28:21PM -0500, Jeff King wrote:
> On Tue, Nov 24, 2015 at 10:17:08PM +0000, John Keeping wrote:
> 
> > I wonder if we should do this to help debug SSL issues:
> > 
> > -- >8 --
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index e057051..6d4e0ee 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -1317,6 +1317,10 @@ Message-Id: $message_id
> >  			require Net::SMTP::SSL;
> >  			$smtp_domain ||= maildomain();
> >  			require IO::Socket::SSL;
> > +			if ($debug_net_smtp) {
> > +				no warnings 'once';
> > +				$IO::Socket::SSL::DEBUG = 1;
> > +			}
> >  			# Net::SMTP::SSL->new() does not forward any SSL options
> >  			IO::Socket::SSL::set_client_defaults(
> >  				ssl_verify_params());
> > -- 8< --
> 
> That certainly looks like a reasonable thing to be doing, assuming that
> the output from IO::Socket::SSL is generally helpful.

It's a bit verbose for errors, but it does let you know what went wrong:

DEBUG: .../IO/Socket/SSL.pm:1796: SSL connect attempt failed error:14090086:SSL routines:ssl3_get_server_certificate:certificate verify failed
DEBUG: .../IO/Socket/SSL.pm:673: fatal SSL error: SSL connect attempt failed error:14090086:SSL routines:ssl3_get_server_certificate:certificate verify failed
DEBUG: .../IO/Socket/SSL.pm:1780: IO::Socket::IP configuration failed

It doesn't print anything when the SSL connection is established
successfully, but I don't think that's a problem and if we jump to
level 2 it starts logging things like:

DEBUG: .../IO/Socket/SSL.pm:687: waiting for fd to become ready: SSL wants a read first
DEBUG: .../IO/Socket/SSL.pm:707: socket ready, retrying connect
DEBUG: .../IO/Socket/SSL.pm:677: ssl handshake in progress

without adding anything useful.

> > > > Maybe we shouldn't worry too much about that, but should instead put the
> > > > invalid path into the error message:
> > > > 
> > > > 	die "CA path \"$smtp_ssl_cert_path\" does not exist.";
> > > 
> > > Given what I wrote above, yeah, I'd agree that is sufficient (and I do
> > > think mentioning the path is helpful).
> > 
> > I'll change it to this in a re-roll.
> 
> Thanks.
