Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15D7D1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 20:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeC0Ulq (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 16:41:46 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:42930 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbeC0Ulp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 16:41:45 -0400
Received: by mail-pg0-f54.google.com with SMTP id f10so82182pgs.9
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 13:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NDilgldexp2FK7PA2BMskLCG5A2oQqm+Y+YMlJibLiQ=;
        b=VgyYfK/J5zMs0zv2ZposvY4lo25GGJLZZwKqiMnWhvlhCnt8Wh0gXDheMxTcdJlpUg
         2wIkPHoQPCVdXMCQho0yPwco1hlQmycQmrUqoc00SdUSWZgA7fte/FZ70SomiO/q8F/U
         kcB/qWcrAfZ4t6+pt2FEuL0Rw6j5vaCSFMfkI5oRXMLyIIEIK+TWsqasNBUwpl+x/50p
         egxbuo1LQEVHyM/ixqthROGWr/b5L70UeNuaw4Oa/tT8y+eXC2koSds6nPnIU0VjJGhK
         VxI6tgVxjPKbkm5IwYjBFmLTzyvuyfABvjZ3obIb2fHymgdjwikWsZmat7CnKg+7E8iO
         77KA==
X-Gm-Message-State: AElRT7F6aiOslfUqhpt6BxVSNzweM5iAlrx0XBVSouAj4rKy+aKdTXqC
        ZtUWgoPLhcxBXC3ydqDpNxVqDBjddhZuvN5GhmRwe254
X-Google-Smtp-Source: AIpwx4/pnMSf9b1tqV5F8d511pDTQu4nkpJXj/F4jDh9fs4eRnK9LzgonWW7hBI1l3pjxbEqnYlN4Y2ezM4Z7hcPg50=
X-Received: by 10.98.244.6 with SMTP id r6mr622777pff.242.1522183305033; Tue,
 27 Mar 2018 13:41:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.177.141 with HTTP; Tue, 27 Mar 2018 13:41:24 -0700 (PDT)
From:   Jason Frey <jfrey@redhat.com>
Date:   Tue, 27 Mar 2018 16:41:24 -0400
Message-ID: <CAP6Vx84GRRxgMZF5P6tb6F4rJ8ozxx-d0o_LsNe=kEYVRkBTKQ@mail.gmail.com>
Subject: Bug: duplicate sections in .git/config after remote removal
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While the impact of this bug is minimal, and git itself is not
affected, it can affect external tools that want to read the
.git/config file, expecting unique section names.

To reproduce:

Given the following example .git/config file (I am leaving out the
[core] section for brevity):

    [remote "origin"]
        url = git@github.com:Fryguy/example.git
        fetch = +refs/heads/*:refs/remotes/origin/*
    [branch "master"]
        remote = origin
        merge = refs/heads/master

Running `git remote rm origin` will result in the following contents:

    [branch "master"]

Running `git remote add origin git@github.com:Fryguy/example.git` will
result in the following contents:

    [branch "master"]
    [remote "origin"]
        url = git@github.com:Fryguy/example.git
        fetch = +refs/heads/*:refs/remotes/origin/*

And finally, running `git fetch origin; git branch -u origin/master`
will result in the following contents:

    [branch "master"]
    [remote "origin"]
        url = git@github.com:Fryguy/example.git
        fetch = +refs/heads/*:refs/remotes/origin/*
    [branch "master"]
        remote = origin
        merge = refs/heads/master

at which point you can see the duplicate sections (even though one is
empty).  Also note that if you do the steps again, you will be left
with 3 sections, 2 of which are empty.  This process can be repeated
over and over.

Thanks,
Jason
