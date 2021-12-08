Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEADBC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 19:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbhLHT3y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 14:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbhLHT3x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 14:29:53 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C601BC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 11:26:21 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id t8so3162473ilu.8
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 11:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=F+rGjJfQjxc0pEVHFz2drfISI8ELeJiL88XNFOvV7ro=;
        b=WSrVF1DXgBEsdd8pqJcEnTIzR3lsDu/T6uryfELlluFdL+CyxNPTvaD7kyLpc/B3jN
         iHlqg0V6P/Zbkrg4WHAn6V2vH3+HsD9Xx242stydaF+5nzGKVKwno4Fqzhxg3H3uRT2G
         QtJzmtno4/rBejJjQhEj6nEBFUGDRswzsfSZ13LRvRWKNaeoghKrvfEEU5XSkLVUfaUT
         O0AFkUNg96YMUhGZPb9WuvC16Bzm+38FgGQnWzcfIaJFOH4RfLqqPg6heGQHxeFaPvIz
         kln3ISIpsoPL3qA6mkdzB4zPzcJpryr2u4851s5Vos8Fl3pf1s6Rl7pr/GqDGntpfD6i
         5iJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=F+rGjJfQjxc0pEVHFz2drfISI8ELeJiL88XNFOvV7ro=;
        b=hPMFtOcIlCY6kcsnAVxSfwfiEFNEBIahVV6roKqzg26y5INSiC+R+loGrQLhEXwA6C
         O+1zKV/yQy79yivVImJ0Y7SexgHon8RKLUZD+WYZM8+VuWBqWt64s4u2p4JjZ5Y8Ub+K
         M185XvINZuyieIC0QBEnWoqcnLeC3IP28DbBrcDgJnjMlk9xQ3glPiUkCwNrMEGUt6NG
         CvxIEAUm5BMo2GHAnpTXnb+kU0pE7cqMA8o75NJHawkqT57uaK4Q7Rg7/gdkktLXvxwe
         2tJwEc2GTBo9sPFk1VQgUh657MulCa9VBC69W4tvZ6SWV9NyEZycqNmCcEuV1PYaO4LQ
         1t0w==
X-Gm-Message-State: AOAM531bRh3EUVlhmmjCsfIVKWfO11mvriV+WbmLR+ueJPVtHZCwOtzx
        IH5TvD+oY94n2jIdJXbZMVgnYdHSASUPaMSw
X-Google-Smtp-Source: ABdhPJyNidjruLtYLl2yX4nnAyy3KUc+L1nPT11MIe3DBtB8d01QG5YiHuw59VUKoRoUaU2bDxuRkA==
X-Received: by 2002:a92:db04:: with SMTP id b4mr9806130iln.276.1638991581103;
        Wed, 08 Dec 2021 11:26:21 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m2sm2351738iob.21.2021.12.08.11.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 11:26:20 -0800 (PST)
Date:   Wed, 8 Dec 2021 14:26:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, stolee@gmail.com
Subject: [PATCH 0/2] midx: prevent bitmap corruption when permuting pack order
Message-ID: <cover.1638991570.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series demonstrates and fixes a problem (which has existed since the
inception of MIDX bitmaps) which made it possible to reliably introduce bitmap
corruption into a repository.

The recipe (which is explained in detail in the first patch) roughly looks like
creating a MIDX with some packs. Then re-generating the MIDX and its bitmap but
under a different object order (e.g., by changing the `--preferred-pack`).

Because we used to link the new .rev file into place, and because the object
order is not encoded into the MIDX itself, we would inadvertently generate a
.rev file with the same name as the existing one that contains different
contents, and then fail to move it into place. That causes us to read the
.bitmap under the old object order, producing incorrect results.

This series applies a minimal fix (in the second patch), which is to include the
pack ordering in the MIDX itself. Some small thoughts here:

  - We could alternatively have included the entire .rev file's contents in the
    MIDX. But this ends up being kind of awkward (and is also discussed in the
    second patch).

  - We could cache the identity of the preferred pack (which we currently
    discover by looking up the pack for the object in the 0th position of the
    MIDX's pseudo-pack order) by just reading the first value of the new
    optional chunk.

I'm certainly interested in pursuing the latter, but in a different series,
since I'd like to keep this fix as minimal as possible.

Taylor Blau (2):
  t5326: demonstrate bitmap corruption after permutation
  midx.c: make changing the preferred pack safe

 Documentation/technical/multi-pack-index.txt |  1 +
 Documentation/technical/pack-format.txt      |  4 +++
 midx.c                                       | 25 +++++++++++++---
 t/t5326-multi-pack-bitmaps.sh                | 31 ++++++++++++++++++++
 4 files changed, 57 insertions(+), 4 deletions(-)

-- 
2.34.1.25.gb3157a20e6
