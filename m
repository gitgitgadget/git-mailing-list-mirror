Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F1DE20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 20:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754646AbdASU0z (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 15:26:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57902 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754611AbdASU0y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 15:26:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB64E60D60;
        Thu, 19 Jan 2017 15:12:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hcCx6etaIw/7VCDuQrN3UUH7AS4=; b=oota1N
        b+YDo9sUQ8ceXNjABV6KUOamqNi2IV3EdEfFhzmmfsQpc0YMe5fY+94jTFvk9ebp
        If3YB29poXkXM4nXbnpTIfUom2Pcu8wDRUXWDZhH0PE+H5XR/xkC0uEBYKdGqUTk
        2RgGsCbs2YQsb3ggbhWdzvyI9VXELV/bG2GxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Kc1/943jSh+w2vPKM1OXo+d+BzFNowym
        +X+/33YW7T3/SJK1APBeqPxvI+oJRY9a455R8nYeJtOJcICfvYSfpm1Sll9+BVBR
        8PDupO26ZRQmLCcoGKbUtgGsv3UgLJF/hBHLZQl4H7MzrkU/WLJUXKDrrBOfovqa
        CAwNeNZw+LY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E34F360D5F;
        Thu, 19 Jan 2017 15:12:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5FF6C60D5D;
        Thu, 19 Jan 2017 15:12:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        Andrew Arnott <Andrew.Arnott@microsoft.com>
Subject: Re: [PATCH 2/2] Be more careful when determining whether a remote was configured
References: <cover.1484687919.git.johannes.schindelin@gmx.de>
        <41c347f22c80e96c54db34baa739b6e37e268b61.1484687919.git.johannes.schindelin@gmx.de>
        <20170117214723.p5rni6wwggei366j@sigill.intra.peff.net>
        <alpine.DEB.2.20.1701181334040.3469@virtualbox>
        <20170118125422.gi3ppqiqhyykk7iy@sigill.intra.peff.net>
        <alpine.DEB.2.20.1701181700020.3469@virtualbox>
        <20170119182721.7y2zzrbaalfqjjn6@sigill.intra.peff.net>
Date:   Thu, 19 Jan 2017 12:12:47 -0800
In-Reply-To: <20170119182721.7y2zzrbaalfqjjn6@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 19 Jan 2017 13:27:21 -0500")
Message-ID: <xmqq4m0u24hs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5BDA322-DE83-11E6-97B0-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jan 18, 2017 at 05:22:40PM +0100, Johannes Schindelin wrote:
>
>> > > I want to err on the side of caution. That's why.
>> > 
>> > I guess I just don't see why changing the behavior with respect to
>> > "prune" or "proxy" is any less conservative than changing the one for
>> > "refspec".
>> 
> I think _this_ is a much better way of framing the problem. It is not
> about which keys are set, but about _where_ they are set. IOW, a
> reasonable rule would be: if there is any remote.*.X in the repo config,
> then git-remote should consider it a configured repo. And otherwise, no
> matter what is in ~/.gitconfig or elsewhere, git-remote should proceed
> as if it doesn't exist (and repo-level config can take precedence over
> config defined elsewhere).
>
> I.e., something like this:
>
> diff --git a/remote.c b/remote.c
> index 298f2f93f..720d616be 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -373,6 +373,8 @@ static int handle_config(const char *key, const char *value, void *cb)
>  	}
>  	remote = make_remote(name, namelen);
>  	remote->origin = REMOTE_CONFIG;
> +	if (current_config_scope() == CONFIG_SCOPE_REPO)
> +		remote->configured = 1;
>  	if (!strcmp(subkey, "mirror"))
>  		remote->mirror = git_config_bool(key, value);
>  	else if (!strcmp(subkey, "skipdefaultupdate"))
>
> That doesn't make your test pass, but I think that is only because your
> test is not covering the interesting case (it puts the new config in the
> repo config, not in ~/.gitconfig).
>
> What do you think?
>
>> Originally, I would even have put the "vcs" into that set, as I could see
>> a legitimate use case for users to configure "remote.svn.vcs = vcs" in
>> ~/.gitconfig. But the regression test suite specifically tests for that
>> case, and I trust that there was a good reason, even if Thomas did not
>> describe that good reason in the commit message nor in any reply to this
>> patch pair.
>
> The config-scope thing above would allow "remote.svn.vcs" in
> ~/.gitconfig. But I don't think the test script actually checks that; it
> checks for the repo-level config. And we would continue to do the right
> thing there.

I am not "you" you are addressing to, but I think tying it to where
the variable came from makes quite sense.  

Because it makes it no longer possible to just inspect the
configured result to answer "is the remote configured?",
introduction of the configured field also needs to be preserved from
the original by Dscho, so does reading from historical non-config
sources like $GIT_DIR/remotes/*, which are by definition
per-repository thing.

IOW, with this tweak (and not setting ->configured based on what
keys are set), I think Dscho's patch makes sense.

