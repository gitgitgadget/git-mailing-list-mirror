Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EED7C433E4
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 21:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A2F822B42
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 21:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="Aq69KNb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgHDVWW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgHDVWR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 17:22:17 -0400
X-Greylist: delayed 17313 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Aug 2020 14:22:17 PDT
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E8DC06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 14:22:17 -0700 (PDT)
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1596576135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=rdJ0FAxDxbo6YkIPt61a6ZRYR+Xdbq4ghIr3YXZUhRM=;
        b=Aq69KNb4UI9PPli+zG9n4tAVLsBsNwZp6qwN57UX4/dIRWpoX2tOb3CH6qKOizJFiI9jRJ
        UJr9YA5HlzmIN4wxyn9NrSJx0V4swxE2Zc7RG5G8ERyoIM2SxcWB1aCww2TmNH/zl+Ybm2
        U/mgMG8g3jofsRzQNol/xmN39XIbZl4=
Content-Type: text/plain; charset=UTF-8
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH] apply: Allow "new file" patches on i-t-a entries
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     "Junio C Hamano" <gitster@pobox.com>
Date:   Tue, 04 Aug 2020 16:59:03 -0400
Message-Id: <C4OIIFOZ357K.38YZE7TJFUCV8@ziyou.local>
In-Reply-To: <xmqqlfiuryym.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue Aug 4, 2020 at 3:30 PM EDT, Junio C Hamano wrote:
> How often do we pass ok_if_exists, I have to wonder. If it is often
> enough, then we can check that first way before we even check to see
> if a cache entry for the path even exists or what its i-t-a flag
> says. Something along the lines of this untested code:
>
> if (state->check_index && !ok_if_exists) {
> int pos =3D index_name_pos(state->repo->index, new_name,
> strlen(new_name));
> if (pos >=3D 0 &&
> !(state->repo->index->cache[pos]->ce_flags & CE_INTENT_TO_ADD))
> return EXISTS_IN_INDEX;
> }
>
> That is, only if we are told to make sure the path does not already
> exist,
> we see if the path is in the index, and if the cache entry for the
> path in the index is a real entry (as opposed to i-t-a aka "not
> added yet"), we complain. Otherwise we'd happily take the patch.
>
> Whether ok_if_exists is frequently used or not, the resulting code
> may be easier to understand, but I am of course biased, as I just
> wrote it ;-)

ok_if_exists gets passed in cases where a real entry does exist but
we're okay with a new file diff anyway due to other patches in the set
being applied making it valid (type-change diffs and rename diffs) - for
this reason, I didn't pass ok_if_exists, but instead checked here. I
think we're in agreement on this and your logic makes sense in that
light. I'll send an updated patch.
