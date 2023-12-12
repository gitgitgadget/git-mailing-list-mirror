Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916F3D1
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 17:37:03 -0800 (PST)
Received: (qmail 5951 invoked by uid 109); 12 Dec 2023 01:37:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Dec 2023 01:37:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9034 invoked by uid 111); 12 Dec 2023 01:37:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Dec 2023 20:37:02 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 11 Dec 2023 20:37:02 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 3/9] imap-send: don't use git_die_config() inside callback
Message-ID: <20231212013702.GG376323@coredump.intra.peff.net>
References: <20231207072338.GA1277727@coredump.intra.peff.net>
 <20231207072458.GC1277973@coredump.intra.peff.net>
 <ZXGJE-pkb3BjlO-d@tanuki>
 <ZXOfrKYsmOjOHGmj@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZXOfrKYsmOjOHGmj@nand.local>

On Fri, Dec 08, 2023 at 05:58:52PM -0500, Taylor Blau wrote:

> On Thu, Dec 07, 2023 at 09:57:55AM +0100, Patrick Steinhardt wrote:
> > On Thu, Dec 07, 2023 at 02:24:58AM -0500, Jeff King wrote:
> > [snip]
> > > diff --git a/imap-send.c b/imap-send.c
> > > index 996651e4f8..5b0fe4f95a 100644
> > > --- a/imap-send.c
> > > +++ b/imap-send.c
> > > @@ -1346,7 +1346,7 @@ static int git_imap_config(const char *var, const char *val,
> > >  		server.port = git_config_int(var, val, ctx->kvi);
> > >  	else if (!strcmp("imap.host", var)) {
> > >  		if (!val) {
> > > -			git_die_config("imap.host", "Missing value for 'imap.host'");
> > > +			return error("Missing value for 'imap.host'");
> >
> > Nit: while at it we might also mark this error for translation. Not
> > worth a reroll on its own though.
> 
> This string goes away entirely in the next patch, so I don't think we
> need to mark it here.

Right. It's a little confusing because it is converted along with some
other spots in the next patch. But in one of those other spots, we
earlier switched it (in patch 2) from die() to error(), and we _did_
mark it for translation as we did so.

I did it there because in patch 2 we touch multiple messages, and the
other ones don't end up as config_error_nonbool(), so we do want them
translated.

I'm not sure if there would have been an easier ordering to the series.
I could have pulled the "mark for translation" bits from patch 2 into
their own patch (after this one makes some of the messages go away), but
then I'd expect somebody would review patch 2 and say "why not mark them
for translation while we're here?". :)

-Peff
