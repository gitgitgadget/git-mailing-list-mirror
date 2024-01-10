Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4679F4CDE0
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiAT45RA"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-336788cb261so3852421f8f.3
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 10:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704912751; x=1705517551; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DnJieZDeBkyQhnE/TYHW69Q9cORVHwx8j0wdDFWhkDQ=;
        b=fiAT45RAmcg23SCsmfbyG2fizjSVSplQ5ozU0DcHSFWQir23VeGkSvIuJvNfHM4ouC
         8XLV2YioTBGsKH0uCIVRX33o9isU7G7Yw04u0DzEg6VPexffo6ZlZpE7zncx9MqF3n2e
         6vlUw4fmygOYbMdPrvvHcv6PSrKVaeFUgMqbh0Blm8AvFz0OB1sqt9oTo1Yrk5tuk2ke
         1OXjZQ38VWt4sivYdyPGAMgaUZYPgt/uiQ/PXOPthFl5yibHncjcCkvmLKxLknbef+Vn
         emi77kKYc6v/bwc4z0/OccelO1AsUmhNHLQhIn5ajslhNo6y2qTWNv0fhJOJkyRqTMjy
         0ZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704912751; x=1705517551;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DnJieZDeBkyQhnE/TYHW69Q9cORVHwx8j0wdDFWhkDQ=;
        b=Kf/U/CjrX9XLf+HZARQGggBxpcK5mJMIXLVwFLlUu9jhIIKUwDiDBs65q5/tT/EB4b
         PvlyIz+rXzk+Y6cHo5M7pewy9NjCn/rEMDlrpvrcbA2GLqzMa+WnZYh6yAMqiSDbyaIh
         etf/fQYP8KUEml1hAldfC++BMZDAV+7+nCqBGW3nWpyjvRbHG74KYRZ1mYHq+d1BC0t4
         I6iU4PMNFvm9VATOuy2v6x9WHs1DixNqHDnOoCvRMop4/p5CMbUyXej3KZkLXRq3FDvs
         TwTkWVLglTynpR9hY6HocAFij6CLcSsMhiB+EZJVMX5l4obLH7Fno7Yz3dQ7NgsaT0By
         NJyQ==
X-Gm-Message-State: AOJu0Yy0FVH0HyzKxd6e+0H+jaUxjAOkqRgrmzAHAtnlqaSI6VxjTHVF
	7vAHJ8lqfk1lRfwkr5v/ECpO4xjk4Do=
X-Google-Smtp-Source: AGHT+IHMW489MBOeiGpCEmqUjvXYPlxVSTGLOwamuwwBLbrpCXZfbKIdZAwWyrAhO5JdX4J0H+VKCw==
X-Received: by 2002:a5d:6647:0:b0:337:4c69:3ec3 with SMTP id f7-20020a5d6647000000b003374c693ec3mr971453wrw.32.1704912751117;
        Wed, 10 Jan 2024 10:52:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k16-20020a5d5190000000b00336c43b366fsm5509218wrv.12.2024.01.10.10.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 10:52:30 -0800 (PST)
Message-ID: <pull.1634.git.1704912750.gitgitgadget@gmail.com>
From: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 10 Jan 2024 18:52:28 +0000
Subject: [PATCH 0/2] Generalize reference locking in tests
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
Cc: Justin Tobler <jltobler@gmail.com>

There are two tests in t1401 and t5541 that rely on writing a reference lock
file directly. While this works for the files reference backend, reftable
reference locks operate differently and are incompatible with this approach.
To be reference backend agnostic, this patch series refactors the two tests
to use git-update-ref(1) to lock refs instead.

This approach is more verbose and may warrant consideration of implementing
an abstraction to further simplify this operation. There appears to be one
other existing test in t1400 that also follows this pattern. Being that
there is only a handful of affected tests the implemented approach may be
sufficient as is.

Justin Tobler (2):
  t1401: generalize reference locking
  t5541: generalize reference locking

 t/t1401-symbolic-ref.sh    | 28 ++++++++++++++++++++++++----
 t/t5541-http-push-smart.sh | 25 +++++++++++++++++++++++--
 2 files changed, 47 insertions(+), 6 deletions(-)


base-commit: 624eb90fa8f65a79396615f3c2842ac5a3743350
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1634%2Fjltobler%2Fjt%2Fbackend-generic-ref-lock-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1634/jltobler/jt/backend-generic-ref-lock-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1634
-- 
gitgitgadget
