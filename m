Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5003B796
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsGldcDG"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e4f692d06so5832885e9.1
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 09:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704822819; x=1705427619; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lO4nWx8jETPL1hO+aEJNigdb+1CCJE1SbH2rEl6ze4Y=;
        b=UsGldcDGqFJ4pCM4Z/W1WCCT4AuC341+HHKZOlVXN/YN4iRFbGa/GnY/NEtChKzIlJ
         Ur0Nk3OvoX5/UHiAI/P1Ogk/P/Twx9PJtPBwZrC8p3nc84A3v7eOY3kmhrGphiKjQ867
         C1zY0ndJZwbgGVBQgq4Yf2oeHjnlCZ2QZ/iLOQVwvjv4PM5kDGHJPWFdrmXqmT2OtK8K
         wBENX9bSzASS1xDDvEvTFh8rX7GvYdArDZxK/ykotoF8UxhXf3gO+tuAW9VkGoObwECd
         PbZSHQTv3dkWpHlot6eV5dG6roLRwBotcr/i32xu8NSjwkInBYMHvOrPR139WfgTS+Tk
         N72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704822819; x=1705427619;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lO4nWx8jETPL1hO+aEJNigdb+1CCJE1SbH2rEl6ze4Y=;
        b=KgXH81E37urZAgcmGCjUJYYbkpShKOG6uimrjtkfCpgLIymSU2JUtqJMQcSqgcwXoJ
         9PNnGhlL/u9khPP9M5NN6Hv560YL4TDaeUEHvuD2TI4Y14TJTeet7J0gMwWUl+rIY95S
         6lofQtep4DZlcNm4y+QNkFqGi+fUua9rdgZcEdPJVn2Fke2q6KsVsXbcbzFeUn22PWqQ
         ZsL9CrFaLi17zUwnGMUQWOoh0b8G2zE/6nvaj5xC/q0R4fDyxff9I2TNyEhbMDJs1ZDj
         y5fCPIbfokh+LRc3j2MJE0F+OjZ7jwM0xTu9iluWbFniGHRNlldlHXKG+wl7R0eaYhyq
         MTOA==
X-Gm-Message-State: AOJu0YwlQXbiPyksr1von61JiQ4s5AKHTpk1Mw9SxWDNhmaG6xIml6Ve
	dxwoRbHaGFwEAtb4AR4/W8F1Mah66Rc=
X-Google-Smtp-Source: AGHT+IEQkEdtZ/2le5mS/SuxcjbAQKQBJLOy1YY30Ez33uwN6VmFJb7WLq7b+Zem+63YsX4UobT8YQ==
X-Received: by 2002:a05:600c:4e8e:b0:40d:8dc7:acbf with SMTP id f14-20020a05600c4e8e00b0040d8dc7acbfmr713871wmq.43.1704822818566;
        Tue, 09 Jan 2024 09:53:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az3-20020a05600c600300b0040d5f466deesm4442603wmb.38.2024.01.09.09.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 09:53:38 -0800 (PST)
Message-ID: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Jan 2024 17:53:34 +0000
Subject: [PATCH 0/3] Strengthen fsck checks for submodule URLs
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
Cc: Victoria Dye <vdye@github.com>

While testing 'git fsck' checks on .gitmodules URLs, I noticed that some
invalid URLs were passing the checks. Digging into it a bit more, the issue
turned out to be that 'credential_from_url_gently()' parses certain URLs
(like "http://example.com:something/deeper/path") incorrectly, in a way that
appeared to return a valid result.

Fortunately, these URLs are rejected in fetches/clones/pushes anyway because
'url_normalize()' (called in 'validate_remote_url()') correctly identifies
them as invalid. So, to bring 'git fsck' in line with other (stronger)
validation done on remote URLs, this series replaces the
'credential_from_url_gently()' check with one that uses 'url_normalize()'.

 * Patch 1 moves 'check_submodule_url()' to a public location so that it can
   be used outside of 'fsck.c'.
 * Patch 2 adds a 'check-url' mode to 'test-tool submodule', calling the
   now-public 'check_submodule_url()' method on a given URL, and adds a new
   test checking a list of valid and invalid submodule URLs.
 * Patch 3 replaces the 'credential_from_url_gently()' check with
   'url_normalize()' followed by 'url_decode()' and an explicit check for
   newlines (to preserve the newline handling added in 07259e74ec1 (fsck:
   detect gitmodules URLs with embedded newlines, 2020-03-11)).

Thanks!

 * Victoria

Victoria Dye (3):
  submodule-config.h: move check_submodule_url
  t7450: test submodule urls
  submodule-config.c: strengthen URL fsck check

 fsck.c                      | 133 ----------------------------------
 submodule-config.c          | 140 ++++++++++++++++++++++++++++++++++++
 submodule-config.h          |   3 +
 t/helper/test-submodule.c   |  31 ++++++--
 t/t7450-bad-git-dotfiles.sh |  26 +++++++
 5 files changed, 196 insertions(+), 137 deletions(-)


base-commit: a54a84b333adbecf7bc4483c0e36ed5878cac17b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1635%2Fvdye%2Fvdye%2Fstrengthen-fsck-url-checks-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1635/vdye/vdye/strengthen-fsck-url-checks-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1635
-- 
gitgitgadget
