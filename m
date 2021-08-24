Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEDEC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 07:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2883610A4
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 07:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbhHXH7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 03:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbhHXH7u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 03:59:50 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530E5C061575
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 00:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=etTwgjquFOes4QApCEyxlh9IjUlaQD8p4GvSZlg3ifg=;
        t=1629791946; x=1631001546; b=CxjhiVC/sIeC1lQfzp3WOJKP8/wdtWWsEI/pI/U62vH93AA
        9Xa4eQjeFurXeIsAdcQBbC3dMzt+TrB4RyIRcJQs0sK9UuB/ik7LkjokD6d42246kLtbQNeoa3FBQ
        B6/VoUz8kN/xYgy3r8Gg2kd5z6zrmVKbY0uFOL5rzsvhoXWWlJDGCnjbDa3TgQHpwgsQcq233qKvF
        krBIizpRb6+4W4rTk+wcThYpFUQWDYOmXw1Y4O1xAuFR+aMFIgoThAL41k1d+08IYA0Yw3juDJ9tw
        gIhCltjc20HlXg/v2RPjGux1iXh3bGQq5JBOMDduRw4efukzQbcpr4AqjRnm+tWQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mIRKp-00FCvs-Lh; Tue, 24 Aug 2021 09:59:03 +0200
Message-ID: <f398645c2c946ea0d7cc6d8f603962dde5f7c4e0.camel@sipsolutions.net>
Subject: Re: [PATCH v3] multi-pack-index: fix *.rev cleanups with
 --object-dir
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Date:   Tue, 24 Aug 2021 09:59:02 +0200
In-Reply-To: <xmqqeeajpyrc.fsf@gitster.g>
References: <20210823171011.80588-1-johannes@sipsolutions.net>
         <xmqqeeajpyrc.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2021-08-23 at 15:44 -0700, Junio C Hamano wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
> 
> > If using --object-dir to point into a repo while the current
> > working dir is outside, such as
> > 
> >   git init /repo
> >   git -C /repo ... # add some objects
> >   cd /non-repo
> >   git multi-pack-index --object-dir /repo/.git/objects/ write
> > 
> > the binary will segfault trying to access the object-dir via
> > the repo it found, but that's not fully initialized. Fix it
> 
> OK, so write_midx_internal() was given an object_dir to work in,
> made various changes to that directory, but at the very end of the
> sequence, instead of clearing the revindex in the object_dir we have
> been working in, cleared the odb associated with the repository.

I'm not sure I'd claim "cleared the odb" but it's also not entirely
clear to me what you mean by that.

Specifically, what happened is that it cleared out all the .rev files in
the objects/pack folder associated with the repository. And if there
wasn't actually a repository, it would NULL-ptr-deref instead.

Feel free to rewrite the commit log, or I can if you really want me to.
I was more concerned with the segfault, but I can also understand that
you'd be more concerned with the on-disk correctness issue this causes.

johannes

