Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DEB620193
	for <e@80x24.org>; Thu,  4 Aug 2016 19:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758994AbcHDTwI (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 15:52:08 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33895 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758977AbcHDTwG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 15:52:06 -0400
Received: by mail-pf0-f178.google.com with SMTP id p64so89616171pfb.1
        for <git@vger.kernel.org>; Thu, 04 Aug 2016 12:52:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4MKeS1wRX6DU49f9NOSfJFb23fh7eoooSnBdXCKAs5Y=;
        b=hLy3Ihd7jDWTa/lYDiF6li7hczc7NvwyVEqf6Z0ArkhOewd2eC6wwsygmHOWkN6qsE
         ADYpFDNOjn28S1DcO7vELTOTud+cnYDkNONwgUOil1kwQUdkDPYwIjgGN5tHAbjysuIM
         xgOSj6TpQY8SC6lMtaFM2+yjMbB0aNAyWUxNhHHJCyMwa69hfYx177Z3DtINJmRQeKhq
         Kj2BChVosEN86xwAjphMgEJ2ZRrsLdQrFj6ImBcDwctfgf1xmar+is5UFqs6MaqRbnOV
         DwqgKb9eunvQuQ0cC/8GmBeuko8M3UDyM1qzBP0kQCuPBro2/t8MEZbI92VMY/I4r2kW
         nS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4MKeS1wRX6DU49f9NOSfJFb23fh7eoooSnBdXCKAs5Y=;
        b=iukbNWkVPxZa2BCf+omPKwFlONMLeMxQqSiw2NaT95RNnA5qRZM7nTRnprq3soV6bA
         236rJgbvbY9AR0LFG/A//GFAmaGUTVZQm4/TjiPZdjF21yr1So633xh5RKCSYFTm0IeO
         z3FrSMb3FLpQfYVXbZOCStjh68/iqGreeN4045T1dQnTGcWjsswX+FxocLRwtKKzGJM7
         74focqeN8ISu51ArQeGbPGHZWyOtQuwjLmjxHflH6pG4+ElOvSLA0GzXiHDc4KJ+4yyz
         VqvuKE+P5m60h4pA1fdrgM6xZK1wcUIu94LQCPjssDnqJTMvs6C56cnLGLzeSro+z4U7
         fQDw==
X-Gm-Message-State: AEkooutp8Ndjvs4DCLzi0+7dATkds4GnMsIITX8Ceky2zZ9+9O4jvG8VQxzJMoqIcvxDej4V
X-Received: by 10.98.102.79 with SMTP id a76mr128955564pfc.75.1470340325250;
        Thu, 04 Aug 2016 12:52:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b86b:a022:8342:c00c])
        by smtp.gmail.com with ESMTPSA id os8sm7063063pab.6.2016.08.04.12.52.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 04 Aug 2016 12:52:04 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, mst@redhat.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/6] git clone: Marry --recursive and --reference
Date:	Thu,  4 Aug 2016 12:51:53 -0700
Message-Id: <20160804195159.7788-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.572.g9d9644e.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

 Currently when cloning a superproject with --recursive and --reference
 only the superproject learns about its alternates. The submodules are
 cloned independently, which may incur lots of network costs.
 
 Assume that the reference repository has the submodules at the same
 paths as the to-be-cloned submodule and try to setup alternates from
 there.
 
 Some submodules in the referenced superproject may not be there, 
 (they are just not initialized/cloned/checked out), which yields
 an error for now. In future work we may want to soften the alternate
 check and not die in the clone when one of the given alternates doesn't
 exist.
 
 patch 1,2 are modernizing style of t7408, 
 patches 3,4 are not strictly necessary, but I think it is a good thing
 to not leave the submodule related C code in a crippled state (i.e.
 allowing only one reference). The shell code would also need this update,
 but it looked ugly to me, so I postpone it until more of the submodule code
 is written in C. 
 
 Thanks,
 Stefan 

Stefan Beller (6):
  t7408: modernize style
  t7408: merge short tests, factor out testing method
  submodule--helper module-clone: allow multiple references
  submodule--helper update-clone: allow multiple references
  submodule update: add super-reference flag
  clone: reference flag is used for submodules as well

 builtin/clone.c                |  22 ++++--
 builtin/submodule--helper.c    |  45 ++++++++----
 git-submodule.sh               |  12 +++-
 t/t7408-submodule-reference.sh | 153 +++++++++++++++++++++++------------------
 4 files changed, 147 insertions(+), 85 deletions(-)

-- 
2.9.2.572.g9d9644e.dirty

