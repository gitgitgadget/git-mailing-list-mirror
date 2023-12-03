Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ANGn/oKn"
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFE0A1
	for <git@vger.kernel.org>; Sun,  3 Dec 2023 05:39:24 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-35d597d333aso7805295ab.1
        for <git@vger.kernel.org>; Sun, 03 Dec 2023 05:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701610763; x=1702215563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4+u8OZ+fXNuzeMzznST9AzVVYucdbO4kgNjNT1vncdw=;
        b=ANGn/oKn7qhzc+8GqISj82NoYmLAwdWa9hjX3O2DfTBgIslbeXiezHv930OXmxuE4V
         wv3MVFbRcby4Usyot6YHjh2GFFB7bfeJO8COHWlC2mECVqurYEhj27oB8aC8WcAzieoC
         pA8CpMlRD9jZ7rO0TD/g4W6bNMEew7siA1qHNw+2ZiPQmC+9tzJPtfJkEKcxbxQ5aETQ
         ZZLD+WM0aU3p5R9qsQtUc1hHO69rDmg++oO6zqD25uNmE16QRNUXm6Sy5uAjQJdoasz+
         1opUGnmgpTk+zoE3lzy4eJ4JrNFecvFd1NWaiZH4yv+S5vrVk/ie03v917vPHjwJKher
         ePQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701610763; x=1702215563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+u8OZ+fXNuzeMzznST9AzVVYucdbO4kgNjNT1vncdw=;
        b=FIEh0zVdKIdVU8K1M7R71BL1ayDxkj+zDFgQV7FJ2Fe+AJo8qcoHoLXTLhXthXsN3f
         0j/61PZ3hRGTLlLjD021Oc0XpkDJXnzj2fghd72/HSbH1ScwmkYai7WnLmLimDNSSRof
         eYdE8X2LxMxTJjQf186qb3SY0lITrlIOQeQLF00Op16TYwu1GEKWteDh0oFWtuGnux49
         RNKDs8aXTpeB718czmVtq+5JgElqnJXmjZC74OGzu44fOVOfZJdEeP4ohII40S6t/0++
         8IkHQrcupAPwcxPn2MF/lr/m1MhGVuWQYFKpR58lRx/joYmlQY+wJypjFPqCWdhISCxr
         zu4A==
X-Gm-Message-State: AOJu0YyyAbNdAMz0j5Qe84lJrFHbDBT9cNmQVOqSiGt9Xmw8cvboeP6j
	gQmzE+QpM+43B03/5RTjjzpbXMZh6MaAwZF58II=
X-Google-Smtp-Source: AGHT+IH/ViiGvoiZVSRNAthY5OqV9iEqndwRnFWI5GuRelGUDxn1ALvtnIWhHHQpnGhyVlwF+wUcXA==
X-Received: by 2002:a92:cb43:0:b0:35d:52af:bce9 with SMTP id f3-20020a92cb43000000b0035d52afbce9mr3953552ilq.1.1701610763321;
        Sun, 03 Dec 2023 05:39:23 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id s4-20020a637704000000b005c65e82a0cbsm2515110pgc.17.2023.12.03.05.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 05:39:23 -0800 (PST)
From: Han Young <hanyang.tony@bytedance.com>
X-Google-Original-From: Han Young <hanyoung@protonmail.com>
To: git@vger.kernel.org
Cc: Han Young <hanyoung@protonmail.com>
Subject: [RFC PATCH 0/4] add parallel unlink
Date: Sun,  3 Dec 2023 21:39:07 +0800
Message-ID: <20231203133911.41594-1-hanyoung@protonmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have had parallel_checkout option since 04155bdad, but the unlink is still performed single threaded.
With a very large repository, directory rename or reorganization can lead to a large amount of unlinked entries.
In some instance, the unlink process can be slower than the parallel checkout.

This series of patches introduces basic support for parallel unlink. The removal of individual files
can be easily multithreaded, but removing empty directories is a little tricky.
If one thread decides to remove the directory, it may still have files that need to be deleted by
another thread. I had to use a mutex-guarded hashset to collect these 'race' directories,
and remove them after all threads have been joined. Maybe there are ways to do this
without mutex and hashmap?

The speed of unlinking files seems to vary from system to system. I did some tests with a private repo.
When I checkout a commit with 15000 moved files on a Linux machine with btrfs, parallel_unlink yields
10% speed up. But on a Intel MacBook Pro with APFS, the speed up is over 100%. I find it difficult to
choose the default threshold of parallel_unlink.

This series is by no means complete. Many functions contains duplicated code, and there are some
memory leaks. I want to know the community opinion before proceed, if it's worth doing or a waste of time.

Han Young (4):
  symlinks: add and export threaded rmdir variants
  entry: add threaded_unlink_entry function
  parallel-checkout: add parallel_unlink
  unpack-trees: introduce parallel_unlink

 entry.c             |  16 ++++++
 entry.h             |   3 ++
 parallel-checkout.c |  80 +++++++++++++++++++++++++++++
 parallel-checkout.h |  25 +++++++++
 symlinks.c          | 120 ++++++++++++++++++++++++++++++++++++++++++--
 symlinks.h          |   6 +++
 unpack-trees.c      |  15 +-----
 7 files changed, 249 insertions(+), 16 deletions(-)

-- 
2.43.0

