Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F8BE202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 22:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753512AbdCOWWa (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 18:22:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:44889 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753474AbdCOWWa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 18:22:30 -0400
Received: (qmail 8017 invoked by uid 109); 15 Mar 2017 22:22:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 22:22:26 +0000
Received: (qmail 15057 invoked by uid 111); 15 Mar 2017 22:22:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 18:22:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Mar 2017 18:22:23 -0400
Date:   Wed, 15 Mar 2017 18:22:23 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/6] index-pack: factor out pack/idx finalization
Message-ID: <20170315222223.qyrxb6ey3rz3omt4@sigill.intra.peff.net>
References: <20170315212617.6x57bvltinuozv4q@sigill.intra.peff.net>
 <20170315212733.73cw22dm36oc5im4@sigill.intra.peff.net>
 <f42ba0f5-a879-f63f-1cbd-de268da05966@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f42ba0f5-a879-f63f-1cbd-de268da05966@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2017 at 10:03:56PM +0000, Ramsay Jones wrote:

> > -	if (final_pack_name != curr_pack_name) {
> > -		if (!final_pack_name) {
> > -			snprintf(name, sizeof(name), "%s/pack/pack-%s.pack",
> > -				 get_object_directory(), sha1_to_hex(sha1));
> > -			final_pack_name = name;
> > -		}
> > -		if (finalize_object_file(curr_pack_name, final_pack_name))
> > -			die(_("cannot store pack file"));
> > -	} else if (from_stdin)
> > -		chmod(final_pack_name, 0444);
> > -
> > -	if (final_index_name != curr_index_name) {
> > -		if (!final_index_name) {
> > -			snprintf(name, sizeof(name), "%s/pack/pack-%s.idx",
> > -				 get_object_directory(), sha1_to_hex(sha1));
> > -			final_index_name = name;
> > -		}
> > -		if (finalize_object_file(curr_index_name, final_index_name))
> > -			die(_("cannot store index file"));
> > -	} else
> > -		chmod(final_index_name, 0444);
> 
> Is from_stdin always true if final_index_name == curr_index_name?
> Was the original asymmetry deliberate?

Hrm, good question.

I think the logic on the pack side is that:

  git index-pack --stdin

will write a new pack, and we should chmod it as appropriate. But it
would be wrong to do so when generating an index for an existing pack:

  git index-pack foo.pack

Whatever wrote foo.pack is responsible for the chmod then.

So the flip side (and what your question is asking) is whether it is
safe to skip the .idx chmod in the non-stdin case.

Usually when we don't have an existing .idx file, we write to a new
tempfile.  We obviously want to chmod there, but it would fall under the
"final_index_name != curr_index_name" case.

But it looks like you can give "-o", or we can derive the name from the
.pack name. So if we do:

  git pack-objects --all --stdout >foo.pack
  git index-pack foo.pack

Then we'd expect the newly-created .idx to have mode 0444, but it
doesn't. So yeah, I think the distinction does matter.

I'm not sure if the best path is to include that flag in the
finalize_file() helper, or just ditch the helper.  Its main purpose was
cleanup so that the odb_pack_name() refactor didn't have to happen
twice. But after that refactor, the amount of shared code is relatively
small.

-Peff
