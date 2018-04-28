Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B37701F404
	for <e@80x24.org>; Sat, 28 Apr 2018 09:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759729AbeD1JrI (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 05:47:08 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37798 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759686AbeD1JrH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 05:47:07 -0400
Received: by mail-lf0-f66.google.com with SMTP id b23-v6so6028767lfg.4
        for <git@vger.kernel.org>; Sat, 28 Apr 2018 02:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=IZUJiXRWvioVTeMy0JKDDRyKY/O9zobKjiihKbG1XLHvF9gUrqUqgh0O3Rv1LRP8MO
         2Z52glP/jxE0yn9fA+6wLVZg3AnKbIWmRHhVAk2WeQJmnNeLtkuN5BobThz0JlT5RNRa
         QJJxz6pcP/H67Bidk0lm1XthqLCjSknDuQZYfh0F8u9l4NRTDvZxjtTBbaPejcelAuNM
         KVdtzm6ojNXfokgnloRf+tMeTZQsiY7lvxGHHijEgxwcU+fAUSgjYmP9+R6MH6Pc9XE7
         k/cZ3UB08r9FQeoCk1klKvMYKXwsp5oZ6TMyKbwFotisnx1WjiEjeD8mBU+7CFfn/p30
         3QKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=rytjxYy+VFzcvPoF87bCNorEYSAj4zlFfacLtH0rYS59zQfwSucV8eEWezNwYmsv2b
         1e3uebH/PPeHe547zam9zFcbGw5CKGZ8LMEC2GUEI0RaMt93lSt4TofVZBgo2kym7fbu
         6cW8Fwpt7KJrFIBxNz8h3q06pfFOTs0JyiUs303hxF/38fxgnpf0RxKpV62eLMR/SOqC
         ist7KeqPb7nd8gX/r+HxMD5kGCbbKphXoInqU5IHI1Ek4JE64nlfM7JP38cE8t2QTlBU
         mcbo58C7z1Dyy/ZhE8hTv4C5aC+sRQ7m4aPGaYeBcjJSinKuUWquiJOgXsKMHjnJ/gWE
         DHrg==
X-Gm-Message-State: ALQs6tCQzZVqm+GmZl1hj1X8BT5CyBa56sE5ie7GSeC6ypTi7QE04fQW
        lfXL8ZIIEWlmjHnIR5vZMdI6uS4c06w4n26x6yl9dQ==
X-Google-Smtp-Source: AB8JxZpnSQc4oRS+4cAt3pmVHKDuzjMneCsxXuf+qgPVFvXF3IcTjqtST50MZP6ouYNcjL8SfpCCiTUUAppJl6yA8v8=
X-Received: by 2002:a19:6b15:: with SMTP id d21-v6mr3213921lfa.123.1524908825866;
 Sat, 28 Apr 2018 02:47:05 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?2KfYqNmIINiz2YrZgSBBbHJhc2hkaSBVQUU=?= 
        <sd1222022@gmail.com>
Date:   Sat, 28 Apr 2018 09:46:55 +0000
Message-ID: <CAB9E7Bty2T2Nv_tVvU54csa+h7Mx3rLOFwknbThRyBU-T9V5qg@mail.gmail.com>
Subject: =?UTF-8?B?2KrZhdmD2YrZhiDYs9mI2YIg2KfYqNmE?=
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


