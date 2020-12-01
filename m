Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254E6C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 11:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B86C320705
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 11:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbgLALa5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 06:30:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:47044 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbgLALa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 06:30:57 -0500
Received: (qmail 25951 invoked by uid 109); 1 Dec 2020 11:30:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Dec 2020 11:30:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25515 invoked by uid 111); 1 Dec 2020 11:30:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Dec 2020 06:30:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Dec 2020 06:30:15 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2 0/2] config: allow specifying config entries via
 envvar pairs
Message-ID: <X8YpRyOcPTOztZ8r@coredump.intra.peff.net>
References: <cover.1606214397.git.ps@pks.im>
 <X740yqoYIhrqsNRE@coredump.intra.peff.net>
 <X8YRTPPfkRqo23ll@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X8YRTPPfkRqo23ll@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 01, 2020 at 10:47:56AM +0100, Patrick Steinhardt wrote:

> > +void git_config_push_env(const char *spec)
> > +{
> > +	struct strbuf buf = STRBUF_INIT;
> > +	const char *env_name;
> > +	const char *env_value;
> > +
> > +	env_name = strchr(spec, '=');
> > +	if (!env_name)
> > +		return; /* die or warn? */
> > +	env_name++;
> > +
> > +	env_value = getenv(env_name);
> > +	if (!env_value)
> > +		return; /* die or warn? */
> > +
> > +	strbuf_add(&buf, spec, env_name - spec);
> > +	strbuf_addstr(&buf, env_value);
> > +	git_config_push_parameter(buf.buf);
> > +	strbuf_release(&buf);
> > +}
> 
> I realize that you say it's yet unpolished, but doesn't this have
> parsing issues? The first strchr(3P) probably needs to be a strrchr(3P)
> to correctly parse `includeIf./home/foo/=repo.path=MY_PATH_ENV`.

Without further changes to $GIT_CONFIG_PARAMETERS, there'd be little
point. The value we put in there has the same parsing issue when read
out of the environment (which we resolve by disallowing "=" in the
subsection, just as here).

I don't think it's actually that big of a deal in practice (it _could_
be an injection source, but it seems somewhat implausible that somebody
is generating complex config keys based on untrusted input). But if we
care, then we could pretty easily change the reading side to separately
quote the key/value in this case:

  'foo.subsection=with=equals.bar'='value=with=equals'

And then doing strrchr() would make sense, with the explicitly
documented rule that the environment variable name cannot contain an
equals sign. (Doing a raw "git -c" wouldn't work unless we introduce
another option that lets you specify the key and value separately; that
might be worthwhile, too).

> But we'd also have to handle shell quoting for the user, don't we?

I'm not sure exactly what you mean here. We wouldn't typically see any
shell quoting from the user, since the shell would dequote it and give
us a NUL-terminated argv. Or if you meant we'd have to adjust the shell
quoting in $GIT_CONFIG_PARAMETERS, then see above.

-Peff
