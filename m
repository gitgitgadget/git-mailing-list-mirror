Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114D320DFA
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22001 invoked by uid 109); 21 Dec 2023 08:59:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Dec 2023 08:59:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22397 invoked by uid 111); 21 Dec 2023 08:59:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Dec 2023 03:59:48 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Dec 2023 03:59:48 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC/PATCH] archive: "--list" does not take further options
Message-ID: <20231221085948.GD545870@coredump.intra.peff.net>
References: <xmqqbkakqx6s.fsf@gitster.g>
 <xmqqttocp98r.fsf@gitster.g>
 <296e8d69-c1d7-4ad2-943a-dfc54940abc2@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <296e8d69-c1d7-4ad2-943a-dfc54940abc2@web.de>

On Thu, Dec 21, 2023 at 08:30:36AM +0100, René Scharfe wrote:

> >    I do not like the remote error behaviour this one adds at all.
> >    Do we use a more proper mechanism to propagate a remote error
> >    back for other subcommands we can reuse here?
> 
> Don't we have one?  It would affect other unsupported options as well,
> and this seems to work just fine, e.g.:
> 
>    $ git archive --remote=. --format=foo HEAD
>    remote: fatal: Unknown archive format 'foo'
>    remote: git upload-archive: archiver died with error
>    fatal: sent error to the client: git upload-archive: archiver died with error

Right. The whole idea of upload-archive is to spawn a separate writer
process and mux the conversation (including errors) back over the wire.
There are a zillion reasons it can die (including bad arguments) and we
catch and report them in the muxing process.

> >  	if (list) {
> > +		if (argc) {
> > +			if (!is_remote)
> > +				die(_("extra command line parameter '%s'"), *argv);
> > +			else
> > +				printf("!ERROR! extra command line parameter '%s'\n",
> > +				       *argv);
> > +		}
> 
> So just call die() here?

Yes, exactly.

-Peff
