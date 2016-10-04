Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,EMPTY_MESSAGE,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85FDA207EC
	for <e@80x24.org>; Tue,  4 Oct 2016 05:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbcJDFVk (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 01:21:40 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33021 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbcJDFVj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 01:21:39 -0400
Received: by mail-vk0-f68.google.com with SMTP id z126so7008219vkd.0
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 22:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=d3uI1jBiW5RMHjtB/Kf/dFT168SY9jkJZ+u0MWkKmMaiXiiW9MhV2nrDxrFs9d9iun
         t850WX7l+JD5h7Z4++gCyAAe5VcfvWh6K2+2tx/JMBBJJaPemdxMXE1CVBTU7rMhcoQ9
         jJlxmncu9CXWsccuiLKMPrm53MIgJnuJRzR3kDQ72/nwcvvj6xkXdx7ZKZpyFPoDb9Mw
         vhqtsotfqw5jXrnYUBhJnkU9/Vqvoivzmjp2Og2P8ZPSlmuv2NwOmAkIuuMVQ6b8J4rC
         MVU6IG/Bc11wDUu+b6oDqg6QDCuOo95DJFh3wJf1qE/1/RiNAvdV4hGgGMnNrlkWLZjT
         /lGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=BepDej/YP2Oa2V7l6y6ljl+xoM+N/ihW0HSvDM/lR4RIfWiNIBG4Cz2IdQzKgiDTEG
         N/DH+YWG11iis8mO++h2Pjnf7r76z5nsc/aN/bebKCpnIw24GksDifn4Udks/QlkaaZH
         BLN3kLCMupBfgAH2tL6Dvg1g9Vv/8KMmF4YtXSJIN+TQ6RRfvcZHJr5wHeookCEjSMC3
         6CTZd/O/tdmp5+k/4Zs/yZcUVKiRNUA7j+286qkVQbFUrfsF7gPAqxHBLtamlG2x7eKQ
         ErXDOGwa+w7JoAbh3hY7iRsub9cF3F6eYvq4qtRoLtoQu1ShmAuicidvydgq0X0bhkpN
         zHow==
X-Gm-Message-State: AA6/9RlcZIWaI1r8jivaX/BK2//2+o0f0rW/aNC6uVi9ZUL2zmGkpDaIhu/F/XUQmuRvaw==
X-Received: by 10.31.137.140 with SMTP id l134mr1030013vkd.90.1475558498930;
        Mon, 03 Oct 2016 22:21:38 -0700 (PDT)
Received: from [192.168.1.14] ([204.195.149.173])
        by smtp.gmail.com with ESMTPSA id u48sm463854uau.5.2016.10.03.22.21.38
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Oct 2016 22:21:38 -0700 (PDT)
From:   Otavio Carvalho <elotta1223@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Subject: 
Message-Id: <A094B4E3-A75F-497B-8C13-76FB1F3A5CE9@gmail.com>
Date:   Mon, 3 Oct 2016 22:20:44 -0700
To:     git@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
X-Mailer: Apple Mail (2.2104)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

