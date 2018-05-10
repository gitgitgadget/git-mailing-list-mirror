Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B90C31F406
	for <e@80x24.org>; Thu, 10 May 2018 19:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751010AbeEJT64 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 15:58:56 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36421 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbeEJT6z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 15:58:55 -0400
Received: by mail-pg0-f68.google.com with SMTP id z70-v6so1415115pgz.3
        for <git@vger.kernel.org>; Thu, 10 May 2018 12:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=D5qRzL3JrhviS9My5hEMbvAEekEqriwt4iWMH/z8MGc=;
        b=A7nZ6hzGzYdoA/6Cf669btf424/r3ik9IlUNdgpoF4hhxI7ce8bBNl7baa2J3DOIIq
         QVXXrWs6qP1AxqYvr6udINUmt8szdt9PRUICFKzoRmleQIzP++UsRz3H0rLDm4KWlUxN
         jOiatqgubAmgo/vzDbqhwZWDg8zYT6z9UFY/LKHre5Py9odRMaR7hfvr222jx5Ld1xJW
         ktK6cin9SmjCONX2k9hdZiHxKUmOVUqP4pxHzYPTD46hgXm5BzQ4TwyCMp4bg4rQlqYI
         Rj2mpUm4hhlu7R1O5UjSDPWohdEd8sUrAwax4frku6dhX2J0ntPZ17PAC7I1B87NRYNC
         sKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D5qRzL3JrhviS9My5hEMbvAEekEqriwt4iWMH/z8MGc=;
        b=sKrzZ9M4Z1p3DPIvU2lYVXjFiynl1ZrxFH2AY9EVetaMBR/0KJxphTn/HirDhotrUC
         H/qgmwb63ZgQtaoBZ0sdhGC7VxrEcuoslYq/ZXVaDsJDExiOsxDNRp3EJOVztKkd+348
         XnBXPmSRuQgajVmZbJun+DJlpggzyipjqhcF6/50oMCxqM1IiF6DRu+lakMFNK3mV5eA
         M5NixkYAiK6ka50WMGyZKHvr3n0jAOMHgAPDH5+nDUzVpRw+aP87OTdE8g3YfNCkFXfj
         Jpat6yW08w7sCm7wLw+y0PODiXbS/N26axewzNS8kSnxy7RPHrDc5IIhU2u5wR87Xzbr
         X09A==
X-Gm-Message-State: ALKqPwekylv2LvZIuZyh86HEXWoMSg7QunDpKvc1/AsOOxidJnO4JIMv
        tBJex/LO0MXoilefce2CDtV4YQ==
X-Google-Smtp-Source: AB8JxZq48EqhsN9Ud3Ha6c0USu5YP1CTm1D5Xg/UUBMBxSa67x0SFwgCd2WVmMxMc8L/orxW5ba+9w==
X-Received: by 2002:a63:2b46:: with SMTP id r67-v6mr2108784pgr.89.1525982334658;
        Thu, 10 May 2018 12:58:54 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id o5-v6sm2397382pgv.47.2018.05.10.12.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 12:58:53 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 0/4] Fix mem leaks of recent object store conversions.
Date:   Thu, 10 May 2018 12:58:45 -0700
Message-Id: <20180510195849.28023-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series replaces the two commits that were queued on sb/object-store-replace,
fixing memory leaks that were recently introduced.

Compared to v1, I merged the two independent series from yesterday,
rewrote the commit message to clear up Junios confusion and addresses Peffs
comments for the packfiles as well.
Also added another free to free the oidmap for the replaces themselves.

Thanks,
Stefan

Stefan Beller (4):
  packfile: close and free packs upon releasing an object store
  packfile.h: remove all extern keywords
  object.c: free replace map in raw_object_store_clear
  replace-object.c: remove the_repository from prepare_replace_object

 object.c         |  7 +++--
 packfile.c       | 13 ++++++++
 packfile.h       | 79 ++++++++++++++++++++++++------------------------
 replace-object.c |  2 +-
 4 files changed, 58 insertions(+), 43 deletions(-)

-- 
2.17.0.255.g8bfb7c0704

