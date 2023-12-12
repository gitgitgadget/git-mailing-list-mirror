Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F564B3
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 16:58:08 -0800 (PST)
Received: (qmail 5105 invoked by uid 109); 12 Dec 2023 00:58:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Dec 2023 00:58:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8721 invoked by uid 111); 12 Dec 2023 00:58:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Dec 2023 19:58:07 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 11 Dec 2023 19:58:07 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	Carlos =?utf-8?B?QW5kcsOpcyBSYW3DrXJleiBDYXRhw7Fv?= <antaigroupltda@gmail.com>
Subject: Re: [PATCH 1/7] config: handle NULL value when parsing non-bools
Message-ID: <20231212005807.GC376323@coredump.intra.peff.net>
References: <20231207071030.GA1275835@coredump.intra.peff.net>
 <20231207071114.GA1276005@coredump.intra.peff.net>
 <ZXF-8iNH0qaJSVl9@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZXF-8iNH0qaJSVl9@tanuki>

On Thu, Dec 07, 2023 at 09:14:42AM +0100, Patrick Steinhardt wrote:

> >  	if (!strcmp(k, "uploadpack.blobpackfileuri")) {
> [...]
> This isn't part of the diff and not a new issue, but why don't we
> `return 0` when parsing this config correctly? We fall through to
> `git_default_config()` even if we've successfully parsed the config key,
> which seems like a bug to me.

I don't think it's a functional bug, but merely a pessimization. We can
return early if we know we've handled the option, but the rest of the
code would simply fail to match it. So we are just wasting a few strcmp
calls (and an unknown key already wastes the same number).

So I think it is a good practice to return, but not really a bug if we
don't.

> >  	if (!strcmp(var, "core.checkstat")) {
> > +		if (!value)
> > +			return config_error_nonbool(var);
> >  		if (!strcasecmp(value, "default"))
> >  			check_stat = 1;
> >  		else if (!strcasecmp(value, "minimal"))
> 
> We would ignore `true` here, so should we ignore implicit `true`, as
> well?

IMHO the lack of a final "else" in the strcasecmp if-cascade is a bug
(and I sent a fix as part of the "config fixes on top" series). Even if
we want to leave it for historical reasons, I think it's still worth
returning an error for the NULL case (since we know it would have
segfaulted previously).

(I snipped the rest of your mail, as I think my response to the cover
letter covers the general discussion).

-Peff
