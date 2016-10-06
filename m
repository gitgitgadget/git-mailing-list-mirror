Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A0F6207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 19:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934725AbcJFThf (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 15:37:35 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36381 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934676AbcJFThd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 15:37:33 -0400
Received: by mail-pf0-f179.google.com with SMTP id i85so13496362pfa.3
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 12:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rkaXBVrDSyOMtkVnHZKg1CB7drmViiMA5BzWpqnHUKc=;
        b=cmQAFo6TMYVc3ucok7buKb7abt7FIYsk/hBaQ+DDfWvOo7HqFuVUAgxJtHA8ovuxcO
         FSRA9AnRx3Y/H3eu0ycOapjTCaGmpd6QefkrYamJ63vTKCWXDp9bLEoAnkyCBWH3ssiE
         FBuk3HRJu+TIiFLdPbhJOq63vOLlYz3Yi/xPQXXJekd6LwTptj/zOhivxf5XSczf+1h9
         Bs+q0a3aOURp4ypuWOh97oUxiRGxtbyWHl6C8DjAYK9sA9+wv7uYaB0H9jEiN4ZUJiPP
         zdW4DD1M2xwqX234OzXGASXluyhXVTiq4jS/yWgmcWdF5Ti4weC7GrKQFBRAQGXsX7Fh
         ujOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rkaXBVrDSyOMtkVnHZKg1CB7drmViiMA5BzWpqnHUKc=;
        b=G2A9D9rKg5Lki4o0Sm8pmNBmseUj54evA9h9x/vet60v/4VbnUKrb5em4ltmLhDTXW
         MBGdTH3wAG6Lxs97H5x7A0gbPuBDMQwT/22QMoZHTr3lUosO7WXoxJvdw0QTBfDW7hPI
         xLXSb+h8GBIE2pWvsWv00OsSP3/fDMNgmMQsBwPhi9hcSM5Pu3q2skLB3aOZxlTUA8/K
         tnRiTvuvT0kTMUJCAfF7Qu9lM13zHfHyMhYBrOQWjBNY8h8/2bdjJxFw0WCI5nsZabmi
         e5SbZL8V4fxKn1/Gl0FeP7sjd6AmqiVgEBPfmQJhGpZOJPAkrm48jECaSEVUqqUnzvl8
         18Jw==
X-Gm-Message-State: AA6/9RlhhxslFPKT2Zog7NJg8MVbXwHB2/yePEAI4FjrTfPywRDL6pxusmxzBI29QwK96b1P
X-Received: by 10.98.144.69 with SMTP id a66mr19983640pfe.181.1475782653066;
        Thu, 06 Oct 2016 12:37:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9975:37b1:c0d3:285b])
        by smtp.gmail.com with ESMTPSA id b123sm7745507pfa.96.2016.10.06.12.37.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 06 Oct 2016 12:37:32 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, hvoigt@hvoigt.net,
        torvalds@linux-foundation.org, peff@peff.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] submodule pushes be extra careful
Date:   Thu,  6 Oct 2016 12:37:23 -0700
Message-Id: <20161006193725.31553-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.353.g1629400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a reroll of
http://public-inbox.org/git/20161004210359.15266-1-sbeller@google.com/
([PATCHv3 1/2] push: change submodule default to check when submodules exist)
but with a test.

As we only have a heuristic, the test failed initially as these tests don't
have any configuration at all nor do they have the submodule repos in the
superprojects git dir. So I was looking for a cheap way to add a config.

I could have written the config myself via git config, I think it is more
idiomatic to use a submodule command for that. However just getting the
configuration added is not possible with a submodule command, so I made one
in the first patch.

Thanks,
Stefan

Stefan Beller (2):
  submodule add: extend force flag to add existing repos
  push: change submodule default to check when submodules exist

 builtin/push.c                 | 15 ++++++++++++++-
 git-submodule.sh               | 10 ++++++++--
 t/t5531-deep-submodule-push.sh |  6 +++++-
 t/t7400-submodule-basic.sh     | 14 ++++++++++++++
 4 files changed, 41 insertions(+), 4 deletions(-)

-- 
2.10.1.353.g1629400

