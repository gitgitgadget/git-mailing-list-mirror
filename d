Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.4 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MISSING_SUBJECT,PI_EMPTY_SUBJ,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7322B1F600
	for <e@80x24.org>; Fri, 21 Jul 2017 03:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030228AbdGUDuR (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 23:50:17 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35162 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030222AbdGUDuR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 23:50:17 -0400
Received: by mail-wr0-f195.google.com with SMTP id c24so7889461wra.2
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 20:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:mime-version:content-transfer-encoding;
        bh=FHYYpDaOEbSY3nwavfeNYwsvORvCc5HJeWzvPyh5k8I=;
        b=XlVuwIWKv59heZnRk6A0BlqpUBarO522g82suAuYygHW5EF65rzwNjFZGeRx9qD3eO
         LDzcb9WkFTRoTXG3GcBTTXhUsQXqhGP3rWHl9lfoS25gjbzvpG0PqRSKzzmd/yrkaWnB
         X2wl3cPwjD9HTnL4eCC6TG9Ndrhm3G3SwZlztmd1VMmxtgYfvhzSbAbVGRaPyGYQ3jli
         kyAl2LnKPxDq7OlemRzs2zJwypHOuv4Evh3Yr7AhOjhCYGjPVAonapq2WFfmj9awG/H1
         1CVs3696DezgidtkoqmDigOius8vc6rUQoY/ov4Ch2B19GmM5v4uWiRUTbiZ4Wpz4D8j
         KdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:mime-version
         :content-transfer-encoding;
        bh=FHYYpDaOEbSY3nwavfeNYwsvORvCc5HJeWzvPyh5k8I=;
        b=iat9P02rMoGi6xCBqy/hp8YMJrkNbm8F33tqKkx0wLRGt+H+M/TTkB3B/zR0dQb18Z
         HSLM9zGgm2YrzYbFQVWZS3oWR1TIquaD98cZNYB78StaP0FLiC11zr83xO+2ypst8wKw
         7TAE3kqqD4X8Wwe49IGRY9Sn9YCtA5sEYcwjTlpbLyr29CpgTEmH9km6qLQ2Ju31lXL9
         LJLMzjk0bEEvskRuRz5vAbjpF3YYgk0dWjjpXwTB2GyVi+1X3g5j05jiJAbl1PM1R0PF
         8loPXnb/tsB60py9On0VIyXZ3vngEIViSbLAyz1hOdFt9PabhGedHw9HNfTYoX8Gwicf
         ybdw==
X-Gm-Message-State: AIVw113yGQAGANzQHEglEY7HWTNMp8uOmFN4hsE/EZnhkVA7LuAI3W/B
        cWZwgkB84KV97L+G
X-Received: by 10.223.150.148 with SMTP id u20mr8572069wrb.195.1500609015845;
        Thu, 20 Jul 2017 20:50:15 -0700 (PDT)
Received: from [192.168.1.183] ([5.127.215.185])
        by smtp.gmail.com with ESMTPSA id q10sm6018459wrb.3.2017.07.20.20.50.13
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2017 20:50:15 -0700 (PDT)
Date:   Fri, 21 Jul 2017 08:20:13 +0430
X-Priority: 3
Message-ID: <99oejev8qnqfqfyjqn5txuwm.1500609015659@email.android.com>
From:   "nima.alavirad@gmail.com" <nima.alavirad@gmail.com>
To:     git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

CgrYp9ix2LPYp9mEINin2LIg2KrZhNmB2YYg2YfZhdix2KfZhyBIdWF3ZWkg2YXZhg==

