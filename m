Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0235F168B9
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KS6UDatw"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e0a89b98e4so381276a34.1
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 13:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705094388; x=1705699188; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8/Way7SA5PZiXtXIWNiUdPFch4kt7FbKsPsiDLCHaoY=;
        b=KS6UDatwCRpUtZBC2xZ1R57CsrO23bF6Iu4h0vQktBkS9/htpMVGAdC0Kj5TjO5OET
         VfmzBTpW+iFs8erGdKKmfaSHf6VHTjeZ+Emjzso6KsDVG8m1lV3CwoZrs5KXWjWL0O/J
         4UOBLU1/0Vnj6lSM5eDe/QFk2UXg9IjJSRbcFVRcU6TRxRW/QlcgIqkw+gh2JmLPODvJ
         V42yYy59O5yGEeEEuty0hKs94hglKbtrl5mshvyUIct609mrZjsIDUqqzvs031kCDFs5
         mqH/i7g3fsoWM+cgVDNmlCnEWI0tuqnpQiHKk24BF8kcqhEhICD3d7ehJp/D4ubSGMDn
         IZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705094388; x=1705699188;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8/Way7SA5PZiXtXIWNiUdPFch4kt7FbKsPsiDLCHaoY=;
        b=g4eMTvKvRwNKkqqhrYqwtU/VUHyLHB0WKKxEHsmNABLRl7T3TizYlrzLLvd10T5/VC
         AsqVEY3zKo+jy0N6dT9Vrenx2VFveehHASQ1LJhBlR5dKqsnkguW4lHgKi1q7kp/T+r5
         JnyauvTbvJ6tN9NovEcp6Q+k7i4C+9w0cU1KyK3Ddkpio55aW0EE3HzaDo/e/ZP3j6iu
         MpxetIDw8StNw7Y4fOq6pUHzwRrSvsmQ7wqmGE84iVpmZ0X9SvIbsYqDTLL5lIuuOjtc
         R8R7J3/j8LZV2eW07/UDeC8OkdU1vEcqwHZ6dNFNEA98SnVTKw+92/wur8m2Pwdpigfb
         YB7g==
X-Gm-Message-State: AOJu0YxOtyZa9sbYQ2WuQ+L86Uq4iFe15yku1b4GIjtnqxViytWX5555
	wrSkTchueWYTbZ+mh28hJZPdFKoKMKHELgL+P528nQoB0DEBgr1JbNcga87BV54w
X-Google-Smtp-Source: AGHT+IE3/UCHtfaUq1K/vq5/lk1FcHQz+kUZhwPH6IoBtgZQdemKUFFi+wFTyNgiWze21B4LwP07BykUuNfKc5Xbtrs=
X-Received: by 2002:a05:6830:32a8:b0:6dd:e845:c6e3 with SMTP id
 m40-20020a05683032a800b006dde845c6e3mr1879128ott.26.1705094387767; Fri, 12
 Jan 2024 13:19:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Raul Rangel <rrangel@google.com>
Date: Fri, 12 Jan 2024 14:19:34 -0700
Message-ID: <CAHQZ30Ad6+YM9qnCOeNNy8e2k-AbYR_bBXTups-7z6=ioyqS5Q@mail.gmail.com>
Subject: Make git ls-files omit deleted files
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
I'm trying to copy my current git worktree to a new directory, while
including all modified and untracked files, but excluding any ignored
files. I essentially want a copy of the tree assuming someone ran `git
add --all && git commit` and cloned that commit into a different
directory.

I got pretty close with the following command:

    $ git ls-files --cached --modified --others --exclude-standard
--deduplicate | xargs cp --parents --no-dereference
--target-directory=/tmp/clone/

The problem is that if I have an unstaged delete, `ls-files` will
print it out as a modification and `cp` will print an error saying
that it failed to copy the non-existing file.

The man page states this behavior:

> --modified: Show files with an unstaged modification (note that an unstaged deletion also counts as an unstaged modification)

Is there another way to achieve what I'm doing that's not too
expensive? If not, could a `--no-deleted-as-modified` flag be added?

Thanks,
Raul
