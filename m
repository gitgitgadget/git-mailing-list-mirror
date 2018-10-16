Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C42C1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 07:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeJPP2i (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 11:28:38 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45894 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeJPP2i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 11:28:38 -0400
Received: by mail-ed1-f68.google.com with SMTP id v18-v6so20288117edq.12
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 00:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=feXTQmwfOTDLLHjYRdDGbu7om2SNNlXBQfi17DZwexY=;
        b=WIOhhV9FaWWubN9uvPGgv1q4Z8h1PKBawx0IN9qG1G3G5PPooj7wTPLKX85eyc766o
         4IA12GX3WWsSz5vXXwY4BNRm8b1mgD09dA0OxiJYGZI5uYwOvTD0nAH14bdwf7ZNrW+q
         Ca704nTOXm1nV4X9oLJgEAi7TXQYUhUv7PbSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=feXTQmwfOTDLLHjYRdDGbu7om2SNNlXBQfi17DZwexY=;
        b=Z15rbfwW2FFEBU0y1NCinFGFJacDR7VFxru7OwNNOePTiIEuhm3dfK1QpcXFsJ2qud
         u4FcKyVfe6gCPtbL5pWmDJfc8ZUaHyQEhnDVisE1Eee/J6vEoR5oIj/j4GAcL8/URNVc
         1yuDfF6/IKeW3FZbKa7p9fsitcpL0M4cZ73g7S6KmmbaHfOLW5iILVn2/XxMXVlcSWRb
         2WnIBJzXGN2lOiktDVPLHlzyd/yvK050DMdofY+l8hRewH801MIqM0rTAnlcyRznCGRl
         d4AL7trzKGq91Dh2ypEC/S06+BatNMO29uiyIoZliVY2HnOgBcnXw9jUoBIW7IXRvrG4
         IPjw==
X-Gm-Message-State: ABuFfogUxRRoRj2Nvugkc+mWRexfFHQb/GUU+JkWloXiMF+746JtAVRQ
        79eDtKJNcT5WYC561O/76SNSV0G08fA=
X-Google-Smtp-Source: ACcGV61iiUZpcTfBrW+kKHFAREKnjfAhF53/YdCsItPXAMBmIoKn8PGpEUGmFNnrpYxFDvSG5phxlQ==
X-Received: by 2002:a17:906:64c:: with SMTP id t12-v6mr22439145ejb.113.1539675569537;
        Tue, 16 Oct 2018 00:39:29 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id q18-v6sm2774661ejr.8.2018.10.16.00.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Oct 2018 00:39:28 -0700 (PDT)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v2 0/3] send-email: Also pick up cc addresses from -by trailers
Date:   Tue, 16 Oct 2018 09:39:20 +0200
Message-Id: <20181016073923.28134-1-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181010111351.5045-1-rv@rasmusvillemoes.dk>
References: <20181010111351.5045-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series extends the logic in git-send-email so that addresses
appearing in various *-by: trailers (e.g. Reviewed-by, Acked-by,
Tested-by) are picked up and added to the Cc list, in addition to the
current logic that picks up Cc: and Signed-off-by: lines.

This deliberately only picks up -by trailers (as opposed to any
trailer), based on the heuristic that the -by suffix strongly suggests
there's a (name +) email address after the colon. This avoids having
to deal with BugID:, Link:, or other such tags. Still, widening to any
-by trailer does increase the risk that we will pick up stuff that is
not an email address, such as

  Reported-by: Coverity
  Patch-generated-by: Coccinelle

where send-email then ends up cc'ing the local 'coverity' user. Patch
2 tries to weed out the obvious no-email-address-here cases, which
should also help avoid cc'ing garbage (local) addresses for malformed
cc and signed-off-by lines. Patch 3 is then mostly mechanical,
introducing the misc-by suppression category and changing the regexp
for matching trailer lines to include .*-by.

Changes in v2: Rework logic in patch 3 as suggested by Junio.

v1 cover letter:

This has been attempted multiple times before, but I hope that this
can make it in this time around. That *-by addresses are not
automatically Cc'ed certainly still surprises people from time to
time.

I hope that this addresses all the concerns Junio had in
https://lkml.org/lkml/2016/8/31/768 .

For the name, I chose 'misc-by', since that has -by in its name. I am
fine with absolutely any other name (bodyby, body-by, by-trailers,
...). I doubt we can find a short token that is completely
self-explanatory, and note that one has to look in the man page anyway
to know what 'sob' means in this line from 'git send-email -h':

    --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, all.


Rasmus Villemoes (3):
  Documentation/git-send-email.txt: style fixes
  send-email: only consider lines containing @ or <> for automatic
    Cc'ing
  send-email: also pick up cc addresses from -by trailers

 Documentation/git-send-email.txt | 11 +++++++----
 git-send-email.perl              | 24 +++++++++++++++++-------
 2 files changed, 24 insertions(+), 11 deletions(-)

-- 
2.19.1.6.gbde171bbf5

