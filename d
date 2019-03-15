Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4289C20248
	for <e@80x24.org>; Fri, 15 Mar 2019 11:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfCOLWS (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 07:22:18 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:37045 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbfCOLWR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 07:22:17 -0400
Received: by mail-pg1-f174.google.com with SMTP id q206so6262578pgq.4
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 04:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:subject:message-id:from:to:mime-version
         :content-transfer-encoding;
        bh=1nJgFz1Ngw2M2DYE05UhMN5IlThqsUJd9BsvdVQk4FQ=;
        b=vMm/GHotTTbxbFL/ac2WtmMs4Bsl3VvVXKbeJ4q3P68HfJIF4upXdtuaz5xcBniQ6H
         PQvKF8As8ybG5XOBP4V5QH8Ah2XXmoNSWvX4D/wksK4IlJ2Q6J8oKwNs1kn1P2X5mpd5
         3+y6iW9mZlYvbRk1aHHCpLn2jXx47ynLdnPYX08+Q3zY4DCvhZUZppxT7l4ZjLmOmO/m
         wbxwguV4mg8Gu891XleINLvTRuna7K71xruh2gt7NYbHCtMISEBZmFMj8T7/2rVcIcAx
         R+OEf72jyv/s0oI86ky7wZznva4c0qeTjqI3QNaI5otqiMwbW/eyVSZrmo9zaqQzsz2v
         9BVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:message-id:from:to:mime-version
         :content-transfer-encoding;
        bh=1nJgFz1Ngw2M2DYE05UhMN5IlThqsUJd9BsvdVQk4FQ=;
        b=KSqEuGjP9ea7wBh+NmhseJ16rZq+1FBAch6NeuZDG1rHcoqVHcH2PeBsBEvIjyNsVU
         UUUaIZfgNWWexqhCO7T4vLMRex3MImgXIBcnXN6+GVzCj29aJ+CYdK5S9dWAqJ+Hzo5y
         5ckaxHw+UDUIP0Ou4Se7lbWAy1E2Zs5hlDIlyFfe60pU6VWrE1ltNNj+NX63qmBVW/dW
         itqM5oNlFBYzer0Bb9S5NG57qGC8N322T0fc1NSqZujGulMJra630YK6/s+3mdjEgC5/
         a8LDf+tw83YjeXPoZXl3GoeMyk4oeBfl31PmLDkG53W+g3yV5DX6jhfHCmbcOvov9nNH
         3WaA==
X-Gm-Message-State: APjAAAVJcvf0Y/Dm1VFoZJ7K/9DjuZQ7uO0tFWe2CcVJZwDFjasW/Ua2
        zQrm1s2Kd+jmvbbToh97kjq2QjEk
X-Google-Smtp-Source: APXvYqzWAsI3veVHS08u3UFrqF3lK69GkVa+gfqwCuIKx1+hBgcN1Q5/BTftcg8mcaBNjc4ktEd2Tg==
X-Received: by 2002:a17:902:204:: with SMTP id 4mr3766525plc.180.1552648936941;
        Fri, 15 Mar 2019 04:22:16 -0700 (PDT)
Received: from [192.168.1.101] ([27.76.23.159])
        by smtp.gmail.com with ESMTPSA id b138sm3747733pfb.48.2019.03.15.04.22.15
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 04:22:16 -0700 (PDT)
Date:   Fri, 15 Mar 2019 18:22:12 +0700
Subject: Ok
X-Priority: 3
Message-ID: <-ec03f2-1kq1rmyhaeoc-m9xehy23bjjv-5z9hqwrg2923z1dy45-jvkeuffeupmn-8w16gkqipdnm-s421ucb8e90s-hlne1o8a0pwct3zq3h-5n5qg2r7a4uri1xdbd-rxuujroa6pay-2i6pgm-kgdizo.1552648932398@email.android.com>
From:   Tuan Nguyenthanh <cautoncp83vn@gmail.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

CgrEkMaw4bujYyBn4butaSB04burIHRoaeG6v3QgYuG7iyBkaSDEkeG7mW5nIEh1YXdlaQ==

