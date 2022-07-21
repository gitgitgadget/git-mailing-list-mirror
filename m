Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D9FC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 15:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiGUPTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiGUPTl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 11:19:41 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77B33FA23
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 08:19:40 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id y9so1483920qtv.5
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 08:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=IsmYRizNfHodRnXJ9iJHQ/QoaXs+FD+1s46+dZpU9x8=;
        b=DjppkqUr90al/vnMreiwPSV+jrlI+5onZCTrnoZaqeIPLVTLoTM26SB0YDONB4Qg4k
         TmlQgdyNxhtRsDx7IhHoHlimiuOyrsQR1nJHGRaYWbQCMAcXGZkmElbntfu0nzJmFbeQ
         GUddEs6+8nqqmnHXyRF9omRrmLa5sIHKdOKMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=IsmYRizNfHodRnXJ9iJHQ/QoaXs+FD+1s46+dZpU9x8=;
        b=odrDRY4kojKQCsw3B+1Q3CNxiOfM9BhejY+9KMiBxHagPXB7VfRx2mGkOX9opyYTKM
         vSeK7M6QF+yGke5xTub1DI9b3BZNto6WmEWkGLInhAt+v9Ud+CElGl2b5swS1g9j4Nkg
         s0ZxpN7K1k+tOOGprWGEJmY/JlufZezkgnlYZ8st3LKG1JaFfPtx9uRxYdtCZC/8qyOU
         EWnlbJ8ixLv2WC3++UY0+8/eSGXyKqcatJsNCYE0LuEI63W1Y34LGhapJviklkK+T7Fc
         S2oz+P0OKQsjLa/uD4atukcKGRpwnAc17O6TdyUHa6Io5K1gn/JsfJ1oU3wh6DsVsrck
         Ug4Q==
X-Gm-Message-State: AJIora9PAMmJvMVY8U/rvIZqiaklFTAN1i6RWXE2MHdXDJCOfCQFzlSc
        s15hnC8B9Q+UF6kGqTCL//AKmVuPJlcQ8Q==
X-Google-Smtp-Source: AGRyM1sC3ITQtB/CCa2O8FGnrGdvEEZqJDDy9n0QZ4Ft+aHubVD66mWv85Uo+dYhLBBj1KfEqTSbjw==
X-Received: by 2002:ac8:5c86:0:b0:31f:1702:2d59 with SMTP id r6-20020ac85c86000000b0031f17022d59mr1944570qta.531.1658416779646;
        Thu, 21 Jul 2022 08:19:39 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-245.dsl.bell.ca. [209.226.106.245])
        by smtp.gmail.com with ESMTPSA id o64-20020a37be43000000b006b59cf38b12sm1457834qkf.126.2022.07.21.08.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 08:19:39 -0700 (PDT)
Date:   Thu, 21 Jul 2022 11:19:37 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Cc:     newren@gmail.com
Subject: [filter-repo] How to reorder commits
Message-ID: <20220721151937.adgufwkj3uxkk3yb@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah:

It seems filter-repo can be used to easily reorder commits, but I'm not able
to quite figure out how to do it with callbacks. My goal is:

- keep the cover letter at the start of the series in order to cleanly
  delineate where their work starts (and thus avoid potential problems with
  rebases and finding fork-points with base branches, which tends to give
  newbies trouble)
- when the author is ready to submit their work, move the cover letter to the
  tip of the branch and tag it as "foo-bar-v1"
- when the author is ready to work on their changes, they run --reroll and we
  move the cover letter back to the start of the series, adding any necessary
  template "changes in vX" entries to it

(or maybe it will go completely differently -- it's all very fluid right now)

Basically, is git-filter-repo the right tool to reorder commits, or is it best
to go directly with fast-export/fast-import?

Thanks in advance,
Konstantin
