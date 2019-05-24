Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 980D11F462
	for <e@80x24.org>; Fri, 24 May 2019 17:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391279AbfEXRsj (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 13:48:39 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:44385 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391230AbfEXRsj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 13:48:39 -0400
Received: by mail-pl1-f173.google.com with SMTP id c5so4445923pll.11
        for <git@vger.kernel.org>; Fri, 24 May 2019 10:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=9pKvcBzDHI35DTCDtqwlbs+DopubFAJ3ZjD+xkB829M=;
        b=ZGoUXAWBJldDGeCkyokpFBcwiSN39gkxPVumlzu0XTzOvAJn+h67W5GX6Af7dQeXdq
         7jlObyalhbdFcJDbV5kbrHpEU5Et0wTAmGuvGiXvKSOigtVWs4MMpL26hUN3ETWE3nRD
         GIerk9ohxv20+CPn1zTGUADbdaUulYprI1x0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=9pKvcBzDHI35DTCDtqwlbs+DopubFAJ3ZjD+xkB829M=;
        b=qHPUH2Ax2t74mpwOvcjV6XIaFOOS2Q+ZWK8LvgDR7JMSwoCtvia/7U2etNuUO8Fd9j
         X/PLPv7q3DSYOchhdVhTMGPbKtg6C4gJbLAhUKu1rvh4mZLlCdDHrLzXDaYEC/H6y+jc
         k4M7KfO7C3kpxbrZTnr6vNLFrc8WHO5vdSFvlPIK0/NwXhOUyiBEOMLHRthPVoyzSCPu
         KVCKb1RB+gFHoRvOGhStI/FRMbhM4lJrd5RuTeTa0HeT0OSYNPL3ng8trh56BTrGPZl9
         +1Uu8o7dSlyHvTntA7z504molhR4dYtL3KJkM38+Pbshi02jtquLtnCQLMK9gFjDFjCE
         eQqg==
X-Gm-Message-State: APjAAAUXjJtZHXQr10GAP2y7z0Nwhobe915mohTeBIoV+TtxB0keeY6G
        QlDrfiO/K8zIzTm3hcSyx8cRJDNzrCPFYQ==
X-Google-Smtp-Source: APXvYqy3LLAJnXUG8CbnFTEIuW2GK25rktHKCqDudD4ZGxWKxmqcdN6qW6V3+888ysuFTPY8zYp02w==
X-Received: by 2002:a17:902:b695:: with SMTP id c21mr107662419pls.160.1558720118608;
        Fri, 24 May 2019 10:48:38 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id e6sm5116034pfl.115.2019.05.24.10.48.37
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 24 May 2019 10:48:38 -0700 (PDT)
Date:   Fri, 24 May 2019 13:48:35 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Subject: git bundle verify segfaults
Message-ID: <20190524174835.GA2068@chatter.i7.local>
Mail-Followup-To: git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello:

I seem to be getting a segfault trying to verify bundles created from 
linux.git. It's easy to reproduce:

$ cd linux
$ git show-ref master
c50bbf615f2f0028ad1771506ef8807130ccc2ce refs/heads/master
$ git bundle create /tmp/linux.bundle master
Enumerating objects: 6705678, done.
Counting objects: 100% (6705678/6705678), done.
Delta compression using up to 8 threads
Compressing objects: 100% (1037089/1037089), done.
Writing objects: 100% (6705678/6705678), 1.19 GiB | 97.81 MiB/s, done.
Total 6705678 (delta 5657955), reused 6664576 (delta 5622679)
$ cd /tmp
$ git bundle verify linux.bundle
BUG: refs.c:1750: attempting to get main_ref_store outside of repository
Aborted (core dumped)
$ git --version
git version 2.21.0

Best,
-K
