Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0AEB1F461
	for <e@80x24.org>; Tue, 14 May 2019 09:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfENJlu (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 05:41:50 -0400
Received: from mail-it1-f175.google.com ([209.85.166.175]:51292 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENJlu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 05:41:50 -0400
Received: by mail-it1-f175.google.com with SMTP id s3so3887938itk.1
        for <git@vger.kernel.org>; Tue, 14 May 2019 02:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BLkzUw60uRBk0QUyi6sUn0YB3UhJq5F5jkzNlQ8vPBQ=;
        b=XM+4R6jpyM7pIR8/27A9L1Zb5z6Hps0Rrc/x7OecLAtXaC9JnUBj2fvqzRSev1WLo1
         jln3Qv+H5zSMP4F+rwD38b2cDL9923J3dG+tmLj72fDwEkjE89Ey28l/mUed3/q2nMQw
         gB+VGyMsTlaA6kpX9fO0YOuZbzK+ih2AHCk1JR7MCCr/BdpdATFkHnS9vdrVt0SSneZQ
         81B+ffzsEx6uaTKzePrx6iiw1x1l7mqg+CvmhWJEnlUIYSl6h6rZyOU0uQVuPESc4D/O
         YeD4qghs0i2wKCtq6QZp/TV8BAsOthEZszxUDbxXPqH4QRTzuJw1VkvJsQ3OUyMqpq4a
         xwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BLkzUw60uRBk0QUyi6sUn0YB3UhJq5F5jkzNlQ8vPBQ=;
        b=PE0cnJTpKK13PLL1GVVFKWtGlnV5ShKDzt07FP6nYVrnsW8rx5k3otfWtyK+ZGH6JK
         QNG8IcF6Mgx4SSWB1QUBlWv0XTm+k8PLFYtJYrUto0qDWO4111xjl3ujG3Cf62sB9rs/
         kp/TynX2Nqvs4mJckc9svGN+MHCdWfASsNNE+xlfdUVhFTAmgbnFhzI1eXSUfs7+hn+n
         ZMebG1D7pNn8s0cl1m9Tm8bTT8jI9oQseHxPBzIUzqQLxwnb9TbM/OXIl6XikgCXilWX
         zD7n7qSc53bAV0OceUznxwvLr83Us3mucuOqFv9SE+YpYDS1p4JmFfeO5H4oWGqn5hG7
         +Pbg==
X-Gm-Message-State: APjAAAXLBy7FUFCNtBiKH8aHhKImf9jWPLSHsQS0ha7ho9fubmOrsfvA
        sEpMJbJm4p8H9AsfADtYsSmtq/TQIq50AHcUC6TKu7bM
X-Google-Smtp-Source: APXvYqyj4R2waccc5xhnvGNnFWsp/GKjtFLIwWW1IhJ6ZxGyEiU+bjGZRRh2dIx5c9KWg+j1q3OAUfnL/sT/CqqvUN0=
X-Received: by 2002:a02:ba85:: with SMTP id g5mr21802916jao.92.1557826909267;
 Tue, 14 May 2019 02:41:49 -0700 (PDT)
MIME-Version: 1.0
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 14 May 2019 16:41:23 +0700
Message-ID: <CACsJy8Bew3i6AL_XWfhLhCvdSFYVCGoEQepi9KLmSDPVmDu5Zg@mail.gmail.com>
Subject: Is git-checkout's restoring d/f conflict really sane?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$ echo data > one
$ git add one
$ rm one
$ mkdir one
$ echo two > one/two
$ echo three > one/three
$ git checkout one
$ ls -l one
-rw-r--r-- 1 pclouds pclouds 5 May 14 16:36 one

Replacing a file is one thing. In this case we're deleting a directory
and unknown number of files inside (in this case 'two' and 'three').
Is this really a good thing to do?

If it's not but too late to do anything about git-checkout, could
git-restore do something better (and exactly what)?
-- 
Duy
