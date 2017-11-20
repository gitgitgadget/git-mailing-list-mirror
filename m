Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E98AE202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 17:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbdKTREq (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 12:04:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:34726 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751601AbdKTREq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 12:04:46 -0500
Received: (qmail 28810 invoked by uid 109); 20 Nov 2017 17:04:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 Nov 2017 17:04:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13384 invoked by uid 111); 20 Nov 2017 17:05:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 20 Nov 2017 12:05:01 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Nov 2017 12:04:43 -0500
Date:   Mon, 20 Nov 2017 12:04:43 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, hsed@unimetic.com,
        git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH V4] config: add --expiry-date
Message-ID: <20171120170443.awpvcuubsi5o6zmp@sigill.intra.peff.net>
References: <xmqqlgj7xcuf.fsf@gitster.mtv.corp.google.com>
 <20171118022727.30179-1-hsed@unimetic.com>
 <xmqq8tf4qmu8.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8tf4qmu8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 18, 2017 at 12:37:03PM +0900, Junio C Hamano wrote:

> > +int git_config_expiry_date(timestamp_t *timestamp, const char *var, const char *value)
> > +{
> > +	if (!value)
> > +		return config_error_nonbool(var);
> > +	if (parse_expiry_date(value, timestamp))
> > +		return error(_("'%s' for '%s' is not a valid timestamp"),
> > +			     value, var);
> > +	return 0;
> > +}
> > +
> 
> I think this is more correct even within the context of this
> function than dying, which suggests the need for a slightly related
> (which is not within the scope of this change) clean-up within this
> file as a #leftoverbits task.  I think dying in these value parsers
> goes against the point of having die_on_error bit in the
> config-source structure; Heiko and Peff CC'ed for b2dc0945 ("do not
> die when error in config parsing of buf occurs", 2013-07-12).

Yes, I agree that ideally the value parsers should avoid dying.
Unfortunately I think it will involve some heavy refactoring, since
git_config_bool(), for instance, does not even have a spot in its
interface to return an error.

Of course we can leave those other helpers in place and add a "gently"
form for each. It is really only submodule-config.c that wants to be
careful in its callback, so we could just port that. Skimming it over,
it looks like there are a few git_config_bool() and straight-up die()
calls that could be more forgiving.

+cc Stefan, who added the die(). It may be that we don't care that much
these days about recovering from broken .gitmodules files.

> Thanks; will queue.

Thanks for reviewing. This was from the hackathon last weekend, but I
missed the later re-rolls amidst my return travel.

(And thank you, Haaris, for seeing it through!)

-Peff
