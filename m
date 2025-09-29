Received: from mail.lohmann.sh (mail.lohmann.sh [23.88.42.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7202B1373
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 11:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.42.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759144758; cv=none; b=uZKwONderoboGVVShfT4kNTYyrBuAks0cHuh3qQHokuFYqYh6Iuigih1ZPzuwkKQpp+VzG+RDpQcrFRbuE78IyWDON6y46QpPxLI3MUmuBm/qwy6pKVC/5WKUG4LCWdXu2uze6Ewg8FPSgGmpDDEddKSUL5qorRBppRKKDF6gTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759144758; c=relaxed/simple;
	bh=jSR7pfoj8PoLXfpFMPT6ING0yI8UkSTF73rdlxVUCFI=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=ti171AjzRqEnrl7DVx04/EsGldVLbLSqG1k4kp3DCllvk6ZmqzrsQmzdlDQ1lxVbUdNNDvDGpXbb29tX/CvzQwJfAzaeaGLy14LJarle8GJ051kbE3l1/zRambfLVc+b+Iz9wdgcU51Iun5St88a1S8udXetHW1KVPP8QZHgizk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=not-evil.de; spf=pass smtp.mailfrom=not-evil.de; dkim=pass (2048-bit key) header.d=not-evil.de header.i=@not-evil.de header.b=Fbs0DHIE; arc=none smtp.client-ip=23.88.42.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=not-evil.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=not-evil.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=not-evil.de header.i=@not-evil.de header.b="Fbs0DHIE"
From: Michael <gitmlko@not-evil.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=not-evil.de; s=mail3;
	t=1759144316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4tEfAYP4raXy318UZslkR19dEyHIjaT94/nafy3HapQ=;
	b=Fbs0DHIExTteBWg6dChM0nLBY5Od+v7Q84nopDD0k6DkdNagK3Bvc8ZdKV/BMSch3q0KKX
	N51maUX8yLcWuCx6Wk9M26e6tHJGpye/ma/TKCMji/sdhWDevG6zkKZq7cSHqjqzfgvkSy
	ipNcnxaRn4nx64xcpeXcVdWfQitqHlLF/XPNYW5d0ZopMR6tbXxAESq7vZG1koblGl1/5S
	goAOVOE+y3zghh9sXF7xGifBFK08HbX0lBu09XW5KYX1h/8w0qESTz7dvyf89lv3q3NdCL
	uu/OKtR5/j7sAT7NG20eMyHAsOijpBVN+lGCoUN8ZIG0jvMjcUwm6Cn082bKvQ==
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.33\))
Subject: git reflog write does not pick up user.name and user.email from
 config
Message-Id: <519E887F-2028-476E-B26D-85E23F7974A5@not-evil.de>
Date: Mon, 29 Sep 2025 13:11:56 +0200
Cc: ps@pks.im
To: git@vger.kernel.org

Hi there!

I've been playing around with a toy project (an interactive step by step
git tutorial that is just a repo) where I have been creating a reflog
manually so far. I was happy to see the new `reflog write` feature and
wanted to integrate it.

When comparing the results of my hand made reflog with the new
`git reflog write` result I found some differences: It does not seem to
pick up the "user.name" and "user.email" from the local git config.

Example:

```bash
git init example && cd example
git config --local user.name "C O Mitter"
git config --local user.email "committer@example.com"

message=3D"hi"
oid=3D"0000000000000000000000000000000000000000"

# Setting env vars works as expected
GIT_COMMITTER_NAME=3D"$(git config --get user.name)" \
  GIT_COMMITTER_EMAIL=3D"$(git config --get user.email)" \
  git reflog write "refs/test_vars" "$oid" "$oid" "$message"

# Picking up the information from the local config does not work
unset GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL
git reflog write "refs/test_no_vars" "$oid" "$oid" "$message"

# Since setting the env variables to the config value, no diff expected
# but:
diff .git/logs/refs/test_*
# 1c1
# < 0000000000000000000000000000000000000000 =
0000000000000000000000000000000000000000 Michael <michael@mycomp.local> =
1759142076 +0200	hi
# ---
# > 0000000000000000000000000000000000000000 =
0000000000000000000000000000000000000000 C O Mitter =
<committer@example.com> 1759142076 +0200	hi
```

Intuitively I would expect these values to be picked up from the local
config instead of having to specify them in env variables. I didn't
expect it to fall back to some system values, instead of git config. Is
there a reason that this information is not used from the config? And if
yes, could you set some config, so that it gets picked up?

Unfortunately my ability to understand C is too limited to grasp how
`git_committer_info` works=E2=80=A6

Thanks a lot for your work!
Michael

