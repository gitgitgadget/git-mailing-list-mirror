Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.2 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MISSING_SUBJECT,PI_EMPTY_SUBJ,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0801F1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 23:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbeC0XFs (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 19:05:48 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35005 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752027AbeC0XFr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 19:05:47 -0400
Received: by mail-pf0-f169.google.com with SMTP id u86so228812pfd.2
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 16:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:mime-version:content-transfer-encoding;
        bh=MnW17wGGjnLS37oIhvXxNpUqbTgc4NA9NEPJU9cB7Ro=;
        b=J5Cvfrj0U1eKKTpVS/ZCx6eNfzGPNTs4fGGQ4fcvSnkTuDToXYP8T0siV8iOj2P3Gt
         NeOGpcoNCecDww14RzcQtN0nSvbnz3y4g5x0oOsPvKDKBYxfBvfPNtIQQlBlHLJmm9mT
         eEm4wKlb7NOIdS2tD7SlZaYirHrkzlZE8kHwJLcY4L5vM1Au8QT2rVdPfQIh+ScWpNeS
         siqyHMeEDYiRXZRGp9a9uMfPHJ+FsDT8xwlBwlC2KdKapSpUmReIhUDWsDLexfXt5mKQ
         2C81w7TP+u39Mz8G5aBRvQQ41UK1Kxu3JMAq1WcUwbQE4nY1hWz4mNnzKyDqkj51iu1E
         kk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:mime-version
         :content-transfer-encoding;
        bh=MnW17wGGjnLS37oIhvXxNpUqbTgc4NA9NEPJU9cB7Ro=;
        b=LDJIJRdnGtyjUY5clzLjhVA9HCGLUUdKIP4yemdLy9vptbc4TrKP+TQaq67yBl++Uv
         Buvw+0dNjnAjK89uCTE4Vkhdyr4g02tJQeB0YelXGbHg+hL1iUJoSlB6pGnQe7dnWnKX
         BcGDEAjYkiW7EwRCBW8WpyLUwwCV00GpHVRzT28apNHcrUpJDrPeIuRcpnyBvsXjSTwz
         8PnvKEfcXJ7uAPE5GwH74OzpE940Ui+htVLRQPgtxFWaxpZ7xGPt+U55pqjpFubrZSR7
         nR8hA611LjLLySrnod++0qiORh2OgDC433zvRFugG+M43hi9rT4JdOy8Cyroo4bdw8zK
         OZ9w==
X-Gm-Message-State: AElRT7Eo76t/Gqbz4rh74A69IpFspjcvhFUIAEuq6QWYGlMHc1NFWk05
        DjejAAAdC17oIuVxoVScsfDT9kCa
X-Google-Smtp-Source: AIpwx48jGRozXV4DA3Z3+zZnXuDI4UMziomNvpDfA1DYfwgaAg03SYSS5mP9mtthGym26CoyY/HHtw==
X-Received: by 10.98.103.199 with SMTP id t68mr954323pfj.24.1522191946791;
        Tue, 27 Mar 2018 16:05:46 -0700 (PDT)
Received: from ?IPv6:2402:1980:8180:ca60::1? ([2402:1980:8180:ca60::1])
        by smtp.gmail.com with ESMTPSA id y23sm4083585pgv.4.2018.03.27.16.05.45
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Mar 2018 16:05:46 -0700 (PDT)
Message-ID: <5abace4a.d765650a.d85ca.86cb@mx.google.com>
Date:   Wed, 28 Mar 2018 07:05:40 +0800
From:   Cheah Teng Chye <ctc3315@gmail.com>
To:     git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cgrlj5Hoh6rmiJHnmoTmiYvmnLo=

