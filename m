Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D68111FF40
	for <e@80x24.org>; Sat, 17 Dec 2016 01:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762177AbcLQBAw (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 20:00:52 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34429 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755396AbcLQBAu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 20:00:50 -0500
Received: by mail-pg0-f65.google.com with SMTP id b1so1219013pgc.1
        for <git@vger.kernel.org>; Fri, 16 Dec 2016 17:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gp1xYiRvwAlysDcCp7pBI7J3f6MDHsO5rh80Jq2io8Y=;
        b=BGpWdDQqsyk5GpFUzdpBDbZGc1eURz8t+NgUVlPUDFsQOmHJF23+TI2gjSTKhjyjWk
         1voeuh9sAIiNgpK3RRAMHR8++aLOIgQLunCOG6XspBiSpp5M5+E0ZkiR5Gzm5VlJmzZn
         93Az6XXjc2Pc9710w9G12bpxLGhaHTtbugpUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gp1xYiRvwAlysDcCp7pBI7J3f6MDHsO5rh80Jq2io8Y=;
        b=aiKJBr5IybfpnRuwB4IEtzUWAR1Fw9ZZEnZvJwNj8XyAgIKqX31gSQj/zwzqWpeDZ1
         suSA/jPs3W4P7eE4RX63gPaKeiSxFE1QALLo1q1HNrkRpKAouE7t0S/nsmnf+CA+1MJj
         p1rGbiRlAxxBQSxzjFFv88lu/NWQ1ntcUVkGABzKsxyTE/dIZanNPpx5aw4v7RM7e1jF
         CrseZspUsoh9gxBzNH4IIQjeXbhPPxqxlIA8aoXMPTKnjxOFaJa23NLU+AJ1Gz2VsrBf
         JDz2nXrTKhJes2bmKCUmV4sRSqx/m9ZNy4h8kea5ftF5sKOmc6BbWvSFv7xC7/eDAD5o
         nBUw==
X-Gm-Message-State: AKaTC033BXusQm8TyVIFpB5Y5CsvosiTQlktHm1ZZNTyshz3vjo/nwa9sp5XRp6LPI9g0g==
X-Received: by 10.84.209.227 with SMTP id y90mr12644539plh.111.1481936449778;
        Fri, 16 Dec 2016 17:00:49 -0800 (PST)
Received: from ethel.corp.roku (cpc108967-cmbg20-2-0-cust367.5-4.cable.virginm.net. [81.101.7.112])
        by smtp.gmail.com with ESMTPSA id h185sm14341306pfg.90.2016.12.16.17.00.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 16 Dec 2016 17:00:48 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        viniciusalexandre@gmail.com, aoakley@roku.com,
        Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv2] git-p4: handle symlinked directories
Date:   Sat, 17 Dec 2016 01:00:39 +0000
Message-Id: <20161217010040.1399-1-luke@diamand.org>
X-Mailer: git-send-email 2.8.2.703.g78b384c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an updated version of my earlier git-p4 symlink fix.

This one now treats addition of all symlinks in the same way,
rather than displaying the target file if linking to a file,
or just the link target name if it's a directory.

That makes the git-p4 summary behave more like normal git
commands (which also treat symlinks uniformaly).

This is a very slight change in behaviour, but I don't think
it can break anything since it is only when generating
the summary that goes after the P4 change template.

Luke Diamand (1):
  git-p4: avoid crash adding symlinked directory

 git-p4.py                     | 26 ++++++++++++++++++++------
 t/t9830-git-p4-symlink-dir.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 6 deletions(-)
 create mode 100755 t/t9830-git-p4-symlink-dir.sh

-- 
2.8.2.703.g78b384c.dirty

