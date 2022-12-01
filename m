Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1D0C47088
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 19:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiLATGw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 14:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiLATGu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 14:06:50 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29529B5DAB
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 11:06:50 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id z10-20020a170902ccca00b001898329db72so3285354ple.21
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 11:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZcvlfgxpXYfzhoGAJYn2Qq5gTZwilWRAsn2FWpPCztk=;
        b=qSBb5s+bVtePKz8tDyXRLUPPpwF4N1HHd3I0njmCvGOyEUMiestMqu7aQ2aoo96Wd2
         zF9PX89qknmzDy8Y3ca1j0UzEm3vWC08rRAZu755GaHqVjh3LP8CfyKwWQVjtiq4nZZf
         NzgqNGfN06uIEx1WPkdmbR9v1pc4iBxqFD0K23VvUQrRV6QBCLUzG/sH4TBCDpfPn1XB
         fJ3PMQcYlmxErpe9e9svY11gLbFjLZE269QStkC1/4XzuAVwMz7QGW9L5YI7rNUDuOGJ
         yrulZyJMouPLCMvPir6MRhozZsM++vhtvdwoXnR18t8gquYBlSLho5khCxrlnXnUE0Gn
         m81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcvlfgxpXYfzhoGAJYn2Qq5gTZwilWRAsn2FWpPCztk=;
        b=aMkaLl0DItanUiavt8k1AJc+Gpq9mKcy9opQL+6CSam5iT/EjQ0vsOtPzPBfNkW7pE
         YTc/htiBB43HLnWdB27caVxWXIyL9e+BnrOQr9EUqCowm2HJ3x87YDgYR3aEJzp9RCgA
         qltk96DGRLBw6wQ47ZIqyKW+wkIvh0Xpxp+mPcAUWd/lalonX2Bdo3yRKdqYWsUXQdXc
         U325Lf52Z0UVJorFzJx0xrdCBWnShOUL/HIYSzXiUX2ZSdlhdoV73lXM/tPE4WfdeZQU
         Bym8MIAzVAfQPPKY2vi0vkv4TEzR5iJvFFxGmm1XZ0RYZNlEVi70xDv8oARbkTaxn7BR
         vNZg==
X-Gm-Message-State: ANoB5pldR02BXQ3kSK02vx7bEHiUmxadP4CylpTRT2lsrGAHT5Q6TuL8
        y4liuqh35BGnDLkKNg1/1TfffJIsdM1DzqxtkcS+
X-Google-Smtp-Source: AA0mqf78n2r7ub25EVhZbR5OR5OznOfloUZVWsA+RFhom7+w5H3cQngtNLaZ3tTlxNUjy9XpCYTmHRRUXZpi3jHVLHPe
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:43a4:b0:219:1d0a:34a6 with
 SMTP id r33-20020a17090a43a400b002191d0a34a6mr2933704pjg.1.1669921609176;
 Thu, 01 Dec 2022 11:06:49 -0800 (PST)
Date:   Thu,  1 Dec 2022 11:06:43 -0800
In-Reply-To: <xmqqa648uhz2.fsf@gitster.g>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221201190644.3604867-1-jonathantanmy@google.com>
Subject: Re: [PATCH 2/4] object-file: refactor corrupt object diagnosis
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Jeff King <peff@peff.net> writes:
> 
> > So maybe:
> >
> >   if (!oideq(real_oid, oid))
> >
> > instead? It's a little slower, but the point of this is to diagnose and
> > die, so it's not exactly a hot path. :)
> 
> Very true, including the part that the original is fine because it
> is localized and fairly obvious.  For a public function, we cannot
> assume any additional constraints between oid and real_oid (other
> than they are of the same "struct object_id *" type) like the two
> pointers prepared locally in the original had, and use of oideq()
> would be more appropriate here.
> 
> Thanks.

Makes sense. I'll make the change.
