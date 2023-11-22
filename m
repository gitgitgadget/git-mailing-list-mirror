Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6Z7ST3A"
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D914493
	for <git@vger.kernel.org>; Wed, 22 Nov 2023 11:18:40 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507adc3381cso57335e87.3
        for <git@vger.kernel.org>; Wed, 22 Nov 2023 11:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700680718; x=1701285518; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RR/VkewwMgiA/HU/bS6j1yFsVelIjFnS9l3l5s2tmNc=;
        b=U6Z7ST3An0zlnqXpJ4ewzq2Q3/Xkil/3Lkj8PhxsllVcfpLqz3ljYYEBmz+HyPJVI0
         PCdOy9aLtiaquICIkCx7240qoNmlejW5xDTSg0cdtcESLSoOM0Xd/EVzgEDZvNrUvNI8
         p2SbPTT/na2JlMuFbSb8hdhMxtX7ZOJG9nfv3hZS8P0gBtIVti5cJrTsOr+EvhpiLwFo
         sJL2QoqM5WnkgNb+SC1Fr+bR8p3+2MacwilEgaqn8bjcOfs6Xb+ZAreHLx7AdykA04yS
         ue6AEziqxHl0/M6GU9sj8TuDKy/B3u2dkndzewJxc4ifF5vEESz0dEC/xwUp1QqUgT3E
         kq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700680718; x=1701285518;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RR/VkewwMgiA/HU/bS6j1yFsVelIjFnS9l3l5s2tmNc=;
        b=tR6+GAOd46Ah/vmOv+dpCXdEtPMWT0hq+mv5q0/bXhpDCR8Pt/YFtBo6x/nf5y8eEY
         t9FtkjdSDpE8ORrLZB22S9Ryoh3hOqQr9y6Vl4WAlFgoPW8llHkA6TwTaZ5iR2/tcA6K
         0wY2M0TSCiJ9p+a9iBtRxNisJluEJH0J9IwXjXWC7YaR9nrhnFKa4vAmsEVe5niiC3ux
         cuijtmQWZT2jWTv6wCEUpgKGXwlLT97Ggg0R4NRpqd8mlFdAiQ3MEv9drPcUpig5PhhJ
         IiQIJ+1Zft3dVPeS3eLele7+76/gjvJuyaJWnzZtO8/jX4TWmnY6A39AS3cYuNYSLa2g
         KNkA==
X-Gm-Message-State: AOJu0YwL3qOCUorbICc1OhHt8ZBQzMRvQwt76V5PfmnVB93wZEf3Pi5W
	6VMVV52ZVUQfNQUdi+JmArv1q3k+HJU=
X-Google-Smtp-Source: AGHT+IFCioqjSxo05GJq0hs2OpnT4lcRSmYk6RxwXK2feak09tP/0vENzv6z/TafVD78szQZvUncLA==
X-Received: by 2002:a19:e00e:0:b0:50a:a33a:942f with SMTP id x14-20020a19e00e000000b0050aa33a942fmr2047802lfg.65.1700680718238;
        Wed, 22 Nov 2023 11:18:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15-20020a5d58cf000000b0032d9337e7d1sm154271wrf.11.2023.11.22.11.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 11:18:38 -0800 (PST)
Message-ID: <pull.1616.git.1700680717.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Nov 2023 19:18:33 +0000
Subject: [PATCH 0/4] Redact unsafe URLs in the Trace2 output
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

The Trace2 output can contain secrets when a user issues a Git command with
sensitive information in the command-line. A typical (if highly discouraged)
example is: git clone https://user:password@host.com/.

With this PR, the Trace2 output redacts passwords in such URLs by default.

This series also includes a commit to temporarily disable leak checking on
t0210,t0211 because the tests uncover other unrelated bugs in Git.

These patches were integrated into Microsoft's fork of Git, as
https://github.com/microsoft/git/pull/616, and have been cooking there ever
since.

Jeff Hostetler (3):
  trace2: fix signature of trace2_def_param() macro
  t0211: test URL redacting in PERF format
  t0212: test URL redacting in EVENT format

Johannes Schindelin (1):
  trace2: redact passwords from https:// URLs by default

 t/helper/test-trace2.c   |  55 ++++++++++++++++++
 t/t0210-trace2-normal.sh |  20 ++++++-
 t/t0211-trace2-perf.sh   |  21 ++++++-
 t/t0212-trace2-event.sh  |  40 +++++++++++++
 trace2.c                 | 120 ++++++++++++++++++++++++++++++++++++++-
 trace2.h                 |   4 +-
 6 files changed, 253 insertions(+), 7 deletions(-)


base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1616%2Fdscho%2Ftrace2-redact-credentials-in-https-urls-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1616/dscho/trace2-redact-credentials-in-https-urls-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1616
-- 
gitgitgadget
