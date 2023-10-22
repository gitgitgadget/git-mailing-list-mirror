Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4DB36A
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 02:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mcclimon.org header.i=@mcclimon.org header.b="DpNijYGt"
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896ECBF
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 19:28:12 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id 6a1803df08f44-66d36b2a247so13812406d6.1
        for <git@vger.kernel.org>; Sat, 21 Oct 2023 19:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mcclimon.org; s=gw; t=1697941691; x=1698546491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7GNOy0uIQgcf2jO6za71/+nz+4mzmIqjYgOAesmsLSA=;
        b=DpNijYGtOGbfdqjBgLFiV3PmIFOCzuhqVesxsJrqy40Mll9lyTATGhht6sAqSWEA3I
         P/5dQyqr1XXVQNr7Q9eTAmIETFU8s7fITiV3JJRh7WdhFsV3U6/Ej6bQutRDKJDD12TH
         Hdp5iH7BIBB7xycWiEvaeVVumjgIw+sPWUuS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697941691; x=1698546491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7GNOy0uIQgcf2jO6za71/+nz+4mzmIqjYgOAesmsLSA=;
        b=Cp0FJr8m+aKwMo62J/4BQsQpP4d9s/FXyA92ENDP8HBXJQf4cCWEAu2tr5xMGEyiiU
         x/L5BvX5jA/YQv/QRqDbYh1IGPydpyAw6c8ugvlIZmuXTodL05IpdrDzJsuUfKqjKXr3
         gQWH5KPuv/UDEpxTVsZx8PepAszQrXsrxK0BGc935zS9MSG3fKIqr6TkFEiAj8nHafk4
         ebrr1lMIydET5tI8/WSx/9q11vrkGWgHTQH3gZ/I6LDNGOn84c0yYur43tR/hnjzEEFE
         3G1c0X0RDfuGjUEfG0LJdegUIhENwLC+SLE4QZ0Tlu9SK0EMO7p9oSfFKIAnPUpKADvN
         pCww==
X-Gm-Message-State: AOJu0Yw0QWoVBbq1FY0JvkGMsBHmn3Av0Pqgw1zQutPZzCIMslTVmwXC
	44RP17/kIO7kuuhRokD0w8kEG24+2MJ+5ka7KVsyoD/H
X-Google-Smtp-Source: AGHT+IFaQuq9w6sfQT1Eq3ilS6Yl8jnVGHObkaE91jffmCGMnziU8EnC6fyIzImtR5DzD4JHk1K9OQ==
X-Received: by 2002:a05:6214:23cc:b0:65b:2ad1:14f8 with SMTP id hr12-20020a05621423cc00b0065b2ad114f8mr7345519qvb.42.1697941691177;
        Sat, 21 Oct 2023 19:28:11 -0700 (PDT)
Received: from localhost ([2600:4040:7ee9:4100:1908:ac84:cbae:dea2])
        by smtp.gmail.com with ESMTPSA id h7-20020a0ceec7000000b00655ec7bbfd0sm1873849qvs.7.2023.10.21.19.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 19:28:10 -0700 (PDT)
From: Michael McClimon <michael@mcclimon.org>
To: git@vger.kernel.org
Cc: Michael McClimon <michael@mcclimon.org>
Subject: [RFC PATCH 0/2] pretty: add %I formatting for patch-id
Date: Sat, 21 Oct 2023 22:27:58 -0400
Message-ID: <20231022022800.69219-1-michael@mcclimon.org>
X-Mailer: git-send-email 2.42.0.424.gceadf0f3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'll say up front that this patch doesn't actually work, but I am stuck
on it and interested in continuing, and am hopeful someone can point me
in something closer to the right direction. (Also, the proposed log
messages are not good, and I would not actually submit the patch for
merge consideration with these messages.)

I would like to have a single-command way to get the patch id for a
commit: the thing you'd see in a pipeline like
    git diff-tree --patch-with-raw HEAD | git patch-id

My initial thought was to add a --patch-id flag to git diff-tree, but
then I thought that maybe better would be to add a pretty specifier to
do so, so that (for instance) you could generate patch-ids for
everything in a branch by saying something like
    git log --pretty='%I %H' start..

I have taken a pass at doing so here, but it doesn't _work_, and I'm not
sure why. It seemed like the thing to do was to use commit_patch_id from
patch-ids.c, but I think that either I'm not holding it correctly, or
that it's not fit for purpose. It was added (or rather, made public) in
ded2c097 (patch-ids: make commit_patch_id() a public helper function,
2016-04-26), which was in service of fa2ab86d (format-patch: add
'--base' option to record base tree info, 2016-04-26). It seems like at
the very least, it probably won't work as expected on merge commits.

The thing that is perplexing to me is that it _does_ appear to work on
some commits, for example (where 8b3aa36f is a recent-ish commit from
master, chosen at random):

$ ./git --no-pager show -s --format='%I %H' 8b3aa36f5a7a0c923bc4a28ff19caae78644ae08
ec66952bdef82a1fc6d31c1057195af31c86da48 8b3aa36f5a7a0c923bc4a28ff19caae78644ae08

$ git diff-tree --patch-with-raw 8b3aa36f5a7a0c923bc4a28ff19caae78644ae08 | git patch-id
ec66952bdef82a1fc6d31c1057195af31c86da48 8b3aa36f5a7a0c923bc4a28ff19caae78644ae08

But for other commits, like the one in the test here, it does not. I
have done a bit of investigation, but I would not really call myself a C
programmer and I'm not super familiar with the codebase, so I'm a bit
stuck. I thought maybe at first I wasn't initializing the diff_options
correctly, but I suspect the problem is actually more fundamental than
that.

Anyway: I would be happy to hear any response at all, whether that's 
a) a pointer to some other way of implementing a %I pretty format,
b) an easier-to-implement possible solution (maybe diff-tree --patch-id
would actually be better), or c) saying the thing I want isn't feasible
and I should stick with the pipeline. Thanks!


Michael McClimon (2):
  patch-ids: add const modifier to commit
  pretty: add 'I' placeholder for patch-id

 patch-ids.c                   |  4 ++--
 patch-ids.h                   |  2 +-
 pretty.c                      | 11 +++++++++++
 t/t4205-log-pretty-formats.sh |  7 +++++++
 4 files changed, 21 insertions(+), 3 deletions(-)

-- 
2.42.0.424.gceadf0f3

