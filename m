Received: from mail-24425.protonmail.ch (mail-24425.protonmail.ch [109.224.244.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B499187346
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 11:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767524707; cv=none; b=SaIrHjGfLyKERUhukYpkdri2TAUczH0w5ovG5DBbp1GSHD7RVdkTDts3NIAHSIyLfkXTTwiEMqdWdCXsBPsDmF6rqAHpCR4MVrmfJw8sntCKUr6AHsbuDCkA0QQIQO8AFrIMObkVEDUQKZWHrhUTkwuxgTsQM/uxWNs/XULz1IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767524707; c=relaxed/simple;
	bh=9gMUGfXwnn5UbYNR8dRFgJFvSHPhVXMc4JYb6X92Y60=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=sysTIPHrIgCnhEK1wCBniNptPyPOv8/FvTbsZx5jeKrO7Li+oZb2UfvrHljg8U+/KVolLxbbxRVdMhY5vgvQwNys5iOs0zpiO5NrK+5VkoJoh8/QEYeM6JwRsdPU69nCcyK3QrznQa8xPCIXFy79AFzNuzH2v9Dm5mmtIjaqcpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=tE0wiJle; arc=none smtp.client-ip=109.224.244.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="tE0wiJle"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1767524703; x=1767783903;
	bh=VMNM8VUBqDgiPirMjRmim+YzJ/0RoGyLX2h213CvOWQ=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=tE0wiJleUHSec7Y9haG4Zl/JT29xC9Ru53Y64pvlaY5IDlh53fy8TDtsQzBOUUTg+
	 8P2+lXd5Q9aJibvUub8Ig66/rZC6ARR+LJBPhXGhVpE5bWDOrLOHZmKZWi22eTluY0
	 5YKimCcGYVZeOky3Yj8T8UVXBj1hxj2aJ50PHDO1qSIipAW3qIpaV0ulpNi/4uxbtD
	 uFO3JQ/3ns1EOqqCc8SDAoKAlZv2vfqFG3faV0W/dG2MU19NL8G23yO90SoLu6j4Cu
	 nf/40ofQN7fwAnWZuROlXfcPbrpYs8VIuTjtNs4Lq8k6mcAfCPx0jAFjprN+HRVftH
	 ZnYGn0UTyIYMQ==
Date: Sun, 04 Jan 2026 11:05:01 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Tsahi Elkayam <Tsahi.Elkayam@protonmail.com>
Subject: [RFC] builtin/stash: data loss from reset --hard
Message-ID: <-98ze4v1cX5P2d_tlWY6nBZuQhY3J7OJLJX51VS53bVhirt-Gm9zA6E_Y-pNMMYhtcLN2MM_miuPfR_Nrq5JCUWDgI_BwG9rUxtuBoqf8h0=@protonmail.com>
Feedback-ID: 35521663:user:proton
X-Pm-Message-ID: 667219d03230984e137b64f4bf3e4ca583ae1fb5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I am a beginner C developer exploring the Git codebase and came across
something I would like to understand better.

In builtin/stash.c line 1747, there is a comment:

    /* BUG: this nukes untracked files in the way */
    strvec_pushl(&cp.args, "reset", "--hard", "-q",
                 "--no-recurse-submodules", NULL);

Steps to reproduce:

    $ git init test && cd test
    $ echo "tracked" > foo && git add foo && git commit -m "init"
    $ git rm foo
    $ mkdir foo && echo "precious" > foo/file
    $ git stash
    $ cat foo/file
    cat: foo/file: Not a directory   # precious data is lost

The reset --hard restores the original tracked file "foo" from HEAD,
destroying the untracked directory "foo/" and its contents.

There is also a test_expect_failure test in t/t2500-untracked-overwriting.s=
h
that documents this behavior.

I am not sure if this is considered a bug to be fixed, or intentional
behavior that is simply documented.

If it is a bug, would this fix be reasonable:

-       /* BUG: this nukes untracked files in the way */
-       strvec_pushl(&cp.args, "reset", "--hard", "-q",
+       strvec_pushl(&cp.args, "reset", "--merge", "-q",
                     "--no-recurse-submodules", NULL);

I understand --merge would fail instead of silently overwriting,
which seems safer.

I would appreciate any feedback or guidance.

Thanks,
Tsahi



Sent with Proton Mail secure email.
