Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502C818644
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 15:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ue8waQ6G"
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C181107
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 07:54:15 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b2f2b9a176so2981902b6e.0
        for <git@vger.kernel.org>; Mon, 06 Nov 2023 07:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699286054; x=1699890854; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vaS7G4ot0i6NI34nqW8Mm4Ve89rncnfeOlAH76I2j6c=;
        b=ue8waQ6GURGIdnoaZrLcqTJvtkzm+BJBvpGu4aYKVGuzVrx9fi7PEKq5dOcibVf118
         eQNHk9nBsIQIoWKh29MNwW7aI0gY2n5sptok3vP9bqpjEjIjcSHbt1QPIvjlbmPHL97U
         A+zHpTMcwysed00wmhTDE8Taw6osOCTE+moOpQcnY1DjFQWcwsmsPrYRwABaDDmEsBa9
         cmBzHUPUGCdYeCkE42QZPzz4HgEw+hLiavgCGs5XPHq54X+GJRGdcehfdUWLsAMYyhzZ
         faqDprxl8c596FhUFSN4F/6C5YyLFHarbSt2Oy0kpuQoJs8fJ7emkgXzB1RQk67EgNQz
         rKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699286054; x=1699890854;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vaS7G4ot0i6NI34nqW8Mm4Ve89rncnfeOlAH76I2j6c=;
        b=uKROrl21N1N3Ix0f9LcaVDOUxHTLNXA2tVdohfyAF+AfpfcpRHN2QJkEDMmGxGRlCA
         LX5anfT5Xz10ENrqLhhcuKpo/32MLabeQKjvO4CnUAplVSg6/VmVh7l+3c2sVfG9Tkxy
         gJNxMVUf3X65fYlAp9WT/5mRnCAL7AsNGlKPgUokVtjpcCDEnSLHkU3+3VeOgdhAamqr
         KO1WxX3OwQZA/vc1UruSupTM6pM0r+GxpxF+OimRTy1z55tLogTgUkK1gmjN6eWqYnHI
         9QAVPwZ1WY19PmdMbT/uXszKgHZ2tm/+CJHjlQjcCa2kHnL+bH/SA7oFAU8AVFhftuU4
         ApzA==
X-Gm-Message-State: AOJu0YyDvn0R8bmPePmz0aDDXuoLsnk/F+3L6RkDL6Rul44uJcRgYkah
	XAGr0MsbDQZU4q6pAFUrdTnjGcgagxNyWrb7r+PCS2of49J1bVE9kf39t/yr
X-Google-Smtp-Source: AGHT+IGUxKbO9iFVjmATBaejiEIGljoQrqUhbWeVggc6oE03vq35UjZWzKsUxaPvZZOhmtLQsncsc0YJiD2rf6p0KzU=
X-Received: by 2002:a05:6871:aa11:b0:1db:70ee:efed with SMTP id
 wq17-20020a056871aa1100b001db70eeefedmr107536oab.18.1699286054533; Mon, 06
 Nov 2023 07:54:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Joanna Wang <jojwang@google.com>
Date: Mon, 6 Nov 2023 10:54:03 -0500
Message-ID: <CAMmZTi-JJ6=Uw_+r50hKMYf34D0NtqXhaA=f+11+wAQBjqA7_g@mail.gmail.com>
Subject: Bug: magic-less pathspecs that start with ":" not processed as expected.
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)

What did you expect to happen? (Expected behavior)
`git stash push -- :file` where `:` is part of the filename, should search
for files named ":file"

What happened instead? (Actual behavior)
The match string used to find files is "file" without the ":".

What's different between what you expected and what actually happened?
file named ":file" is not found.

Anything else you want to add:
I believe this is due to parse_short_magic() not handling the case where
":" is part of the file name rather than a prefix for pathspec magic.

I could not find any documentation that says ":" is a reserved
character to indicate pathspec magic symbols MUST follow or that
":file" is not a valid file name.

[System Info]
git version 2.42.0
cpu: x86_64
no commit associated with this build
shell-path: /bin/sh

[Enabled Hooks]
not run from a git repository - no hooks to show
