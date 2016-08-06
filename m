Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F115B1F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbcHFUSy (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:18:54 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33804 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbcHFUSx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:18:53 -0400
Received: by mail-pf0-f181.google.com with SMTP id p64so107157884pfb.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2016 13:18:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=8xlVIOZH2wHQuvFwtKjipB4zv01As+XJvK+C2SuTPew=;
        b=XqJR6gL/rZ2sBspGu5YoGfJhACCEFdSLLQ84e6Mb1i9uH9mIzAOCLvlmvjW8BEIf0J
         PjpyxgaLll3heykhEMxzlNuyaQRsr4eXrkne21+W+hR2z1CWDvQoFJc5NbTZ1CiX662J
         7nuQ+6UuxHn8nHXsKYj259FmVdp0soD9jedspIUDnFBCLGJRDIpmP68mhTufHbyB3Ymm
         HozM1nqtDzCK9dba+q8GiutDGXvDA0+GC1Jv7YPep6HryPxeyNndodsPQ++PSIn8BuWF
         yIde3E6pGrcfNt0sBtmrSITEJUs+IQGxjQYAdD88A/k6l4QexKPWVsn7jIN4BCed/Aq4
         ELwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8xlVIOZH2wHQuvFwtKjipB4zv01As+XJvK+C2SuTPew=;
        b=HnoYzf8lGesjE7DzFX/stuy0GvM+NpENduIdRjIrB4RMkNWbH6uTU+wXA5oTBRYBQR
         kBzDB2FLaRxRF0ZMFl8E0aYE24W1aY3yTqd1EZ01V1+U/NGZQBV9e4mWUxrOsT8ldZvT
         294smcXZiqGlYcOlUO573ctxJ5Gs3rNq4Y2+ajxxPldL+q5zZ0Vt5KUVCt2tT9Y91qEQ
         +0ll5ZYhomsjj6dmOm1GKeZkrNc0ztmprJwNoipMHytTZqK0BubyvpeoLQ+WWzz0lkUr
         hxAlyVq63P/OEWY1/aQXzKMa8aMSuf81t9JxvS0bld7AAfTZ1xo4CQ/KdI8Op/inxdlC
         anxQ==
X-Gm-Message-State: AEkoouvud4mYGMZqOdV3aONJObHjGETu47k6mKPygTNnA7z/WYRTq3yUN8TYJZjOqmsY9mXn
X-Received: by 10.98.157.12 with SMTP id i12mr140704757pfd.164.1470446611730;
        Fri, 05 Aug 2016 18:23:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c0da:b815:bea9:a8ab])
        by smtp.gmail.com with ESMTPSA id e187sm30647254pfg.43.2016.08.05.18.23.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 Aug 2016 18:23:30 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com, Jens.Lehmann@web.de
Cc:	git@vger.kernel.org, mst@redhat.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/6] git clone: Marry --recursive and --reference
Date:	Fri,  5 Aug 2016 18:23:12 -0700
Message-Id: <20160806012318.17968-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.572.g9d9644e.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

v2:
 * fixed the p1,2 cleanups
 * added documentation to patches 5,6
 * improved commit message in v4
 
 Thanks,
 Stefan
 
v1:
 
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

