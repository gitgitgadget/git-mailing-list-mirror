Received: from mailproxy07.manitu.net (mailproxy07.manitu.net [217.11.48.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEE34D9FA
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.11.48.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713177738; cv=none; b=qipfLT8uaXqsStz3PEVxFPcSnAOBsI72PDIjSkYv4/FnJot0s9Z8IqG1JXm73/M0YYaegXMjk22XftRB72DcpP81IOFRxYYcDDx8XOECr8d9PCqlyZ065agGJskx9hIpOCcVhiIdr9ltkn2DztnkYgoxOq1McReQZpN4iQj0h+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713177738; c=relaxed/simple;
	bh=fFXzW91smETE9FP0rTuYcjYNrMeKDBK5V1c+g0p6vQ0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JN2u49U+9YRbOQ8z3FzTEcF/uAc7h+1C92PskNZyt2mkmU3XKVmfLO7gN3qCfp9qgfe4CpoEs7CceIDBdjRtdgOqLEBSfmhOcYbFuGHCxLo9bn10Anw1OOxvPh4QedxqMFSYOlzaisWQW1qNhqBPXstKai5iyg30q0DagsEDv7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grubix.eu; spf=pass smtp.mailfrom=grubix.eu; arc=none smtp.client-ip=217.11.48.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grubix.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grubix.eu
X-Gm-Message-State: AOJu0YwHJlbayYBTvj7SUSl3/w7/V7T0wnJAv3jJ3u03IfWQDzzrY0Nb
	SXKDZeUFXRVQpvjGmh653DeKMqCozbztsMMb+Ii7PhQINuDt4X5vMgHYb0luVyLM/tUpxC1eUqe
	pvqg0ZzQuUpp8d1xJL5JRLUz9Pgk=
X-Google-Smtp-Source: AGHT+IGAnUTPABgRRUMVa9QuFFa/Y1QBaaTuX3MFQGmb9PGRVwVIK3s3QDnPAzgSCddibv384kXXi4+Z6VfprW1c4Go=
X-Received: by 2002:a17:907:6ea6:b0:a52:3d1:6715 with SMTP id
 sh38-20020a1709076ea600b00a5203d16715mr7086941ejc.68.1713177379718; Mon, 15
 Apr 2024 03:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael J Gruber <git@grubix.eu>
Date: Mon, 15 Apr 2024 12:36:08 +0200
X-Gmail-Original-Message-ID: <CAA19uiQip=EsbT8uQCs+98brYSTbOqyHX1ZBhssi4df3dZmZ6Q@mail.gmail.com>
Message-ID: <CAA19uiQip=EsbT8uQCs+98brYSTbOqyHX1ZBhssi4df3dZmZ6Q@mail.gmail.com>
Subject: prepare-commit-msg hook during rebase
To: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi there

For a while now, I thought I was using prepare-commit-msg hook wrong
but finally took the time to analyse this further. Per the doc, the
hook receives the source of the commit message as $2
(message/template/merge/squash/commit or empty).

I notice the following with `rebase -i`:
- When rb applies a patch to be edited/reworded, the hook is called
with `commit` as the message source.
- When rb applies a patch merely to be picked, the hook is called with
`message` as the message source.

The latter also happens when non-interactive rebase applies commits.

I find this confusing for two reasons:
- Whether edit/reword or pick, there is always a commit being applied,
and it's the source of the message. So why not `commit` in both cases?
- The doc says that `message` is for inputs from `-m` or `-F`. So,
certainly this should not apply when the message comes from a picked
commit.

Also, I'm not sure whether the claim about `-m` is true, but that's
another issue; we even might want to distinguish between `-m` and `-F`
here.

Does the source `message` during rb pick occur due to an
implementation detail, maybe since the rewrite to sequencer?

Cheers
Michael
