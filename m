Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B5EC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 14:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C6F3206D9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 14:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgEDOoi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 10:44:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:35762 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728452AbgEDOoi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 10:44:38 -0400
Received: (qmail 31020 invoked by uid 109); 4 May 2020 14:44:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 May 2020 14:44:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17411 invoked by uid 111); 4 May 2020 14:44:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 May 2020 10:44:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 May 2020 10:44:36 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [RFC PATCH] credential: minor documentation fixes
Message-ID: <20200504144436.GA9893@coredump.intra.peff.net>
References: <20200503063423.83152-1-carenas@gmail.com>
 <20200503065826.GB1829906@coredump.intra.peff.net>
 <20200504074520.GB86805@Carlos-MBP>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200504074520.GB86805@Carlos-MBP>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 12:45:20AM -0700, Carlo Marcelo Arenas Belón wrote:

> On Sun, May 03, 2020 at 02:58:26AM -0400, Jeff King wrote:
> > On Sat, May 02, 2020 at 11:34:23PM -0700, Carlo Marcelo Arenas Belón wrote:
> > 
> > > the order of parameters used in credential_match was inconsistent
> > > between credential.c and credential.h as well, so update both to
> > > match the current implementation.
> > 
> > Yes, looks like this has been wrong since the beginning in 118250728e
> > (credential: apply helper config, 2011-12-10). I checked the callers to
> > make sure none of them had gotten it backwards, but they all look right
> > (and just the declaration is wrong).
> 
> thanks for checking, will include this (and your typo fix) in the
> submission; should I add your "Reviewed-by" then?

Sure, feel free to.

> some things that I think might need clarification (or maybe even code changes
> after agreed on) are :
> 
> * the meaning of "exactly" for matching protocol and hostname in the URL
>   since 06 are both case insensitive per RFC3986 and we have been
>   ambiguous on that, leading to some helpers assuming case or encoding.

Yeah, IIRC we discussed case-sensitivity at the time and went with the
stricter behavior in the name of safety over convenience. And I don't
think anybody has complained since then. So I'm not really _opposed_ to
loosening it to match the URL, but perhaps a maintenance release is not
the best time to do so.

> * the rules for how helper matching are expected to be ordered, specially
>   considering the recent adding of wildcard matching and the revival of
>   partial matching, and the fact that the order is relevant for both
>   discovery of credentials and which helpers are used.

Yes, this could be better documented. I think the current rules are
probably not ideal, especially when you mix credential.*.helper and
credential.helper. So some fixes are possible there, but I think they
might be best added as new feature (e.g., a new config like
credential.*.helperOrder that says whether and how to use
non-url-specific helpers; or something like that).

> * the use of hostname as a key, since the addition of cert:// that has none
>   and uses path instead (had emailed the author privately for clarification,
>   but hadn't heard yet) and the effect that has on which fields are expected
>   and which values are valid.

Yeah, there could be more discussion in gitcredentials(7) there.

> * the role of overrides (ex: the documented example of passing URL and later
>   updating it seems useful, eventhough I am not aware if being used)

I'd be OK to see this feature removed. I have used it for various
debugging or experimenting scenarios, but Git in general would never
pass anything except a broken-down set of fields, and only one of each
field.

> * clarification on which fields can be updated by the helper; currently I
>   don't think we allow overrides for protocol and host and assume all others
>   but the documentation doesn't clarify, and that might be a problem for
>   cert:// where file is more relevant.

I think we do allow a helper to transform a credential in any way:

  echo url=https://example.com/ |
  git \
    -c credential.helper='!sed >&2 s/^/one:/; echo host=other.example.com;:' \
    -c credential.helper='!sed >&2 s/^/two:/;:' \
    credential fill

produces:

  one:protocol=https
  one:host=example.com
  two:protocol=https
  two:host=other.example.com
  Username for 'https://other.example.com': 

So after the first helper runs, subsequent helpers (and the internal
terminal prompt) will consider the modified hostname.

Now whether that's a sane feature or not, I'm not sure.

-Peff
