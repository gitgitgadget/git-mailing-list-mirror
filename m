Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83C0219E2
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6647CC
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 11:40:12 -0700 (PDT)
Received: (qmail 22544 invoked by uid 109); 23 Oct 2023 18:40:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Oct 2023 18:40:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14631 invoked by uid 111); 23 Oct 2023 18:40:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Oct 2023 14:40:13 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Oct 2023 14:40:10 -0400
From: Jeff King <peff@peff.net>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Michael Strawbridge <michael.strawbridge@amd.com>,
	Junio C Hamano <gitster@pobox.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] Revert "send-email: extract email-parsing code into
 a subroutine"
Message-ID: <20231023184010.GA1537181@coredump.intra.peff.net>
References: <20231020100343.GA2194322@coredump.intra.peff.net>
 <20231020101310.GB2673716@coredump.intra.peff.net>
 <ZTJaVzt75r0iHPzR@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTJaVzt75r0iHPzR@ugly>

On Fri, Oct 20, 2023 at 12:45:43PM +0200, Oswald Buddenhagen wrote:

> On Fri, Oct 20, 2023 at 06:13:10AM -0400, Jeff King wrote:
> > But one thing that gives me pause is that the neither before or after
> > this patch do we handle continuation lines like:
> > 
> >  Subject: this is the beginning
> >    and this is more subject
> > 
> > And it would probably be a lot easier to add when storing the headers in
> > a hash (it's not impossible to do it the other way, but you basically
> > have to delay processing each line with a small state machine).
> > 
> that seems like a rather significant point, doesn't it?

Maybe. It depends on whether anybody is interested in adding
continuation support. Nobody has in the previous 18 years, and nobody
has asked for it.

> > So another option is to just fix the individual bugs separately.
> > 
> ... so that seems preferable to me, given that the necessary fixes seem
> rather trivial.

They're not too bad. Probably:

  1. lc() the keys we put into the hash

  2. match to/cc/bcc and dereference their arrays

  3. maybe handle 'body' separately from headers to avoid confusion

But there may be other similar bugs lurking. One I didn't mention: the
hash-based version randomly reorders headers!

> > I guess "readable" is up for debate here, but I find the inline handling
> > a lot easier to follow
> > 
> any particular reason for that?

For the reasons I gave in the commit message: namely that the matching
and logic is in one place and doesn't need to be duplicated (e.g., the
special handling of to/cc/bcc, which caused a bug here).

> > (and it's half as many lines; most of the diffstat is the new tests).
> 
> > -	if ($parsed_email{'From'}) {
> > -		$sender = delete($parsed_email{'From'});
> > -	}
> 
> this verbosity could be cut down somewhat using just
> 
>   $sender = delete($parsed_email{'From'});
> 
> and if the value can be pre-set and needs to be preserved,
> 
>   $sender = delete($parsed_email{'From'}) // $sender;
> 
> but this seems kind of counter-productive legibility-wise.

We do need to avoid overwriting the pre-set value. The "//" one would
work, but we support perl versions old enough that they don't have it.

-Peff
