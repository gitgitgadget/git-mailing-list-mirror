Received: from kitenet.net (kitenet.net [66.228.36.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302AB8174E
	for <git@vger.kernel.org>; Wed, 22 May 2024 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.228.36.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716373937; cv=none; b=k3oQUueRCWnxLRQrEC3YcHhNO2TdZAhJ5qoaz8kWfteGcmx8FPUv6bLn6S9RE+TGVzPkAJoUdwn+S1Hj+3zkJ8eFo+LaSoKXm1/+0VigqF18+NS+ujgDEyOUs4VI2JoVA1t9N1peHWgqnuMO28Pk7oIaj/WfRsVexjgHNNcleRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716373937; c=relaxed/simple;
	bh=X6hhseWSM1rNQ6PPeiHtzRU8WaIUCmKn93grukTEc8Q=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szKiv30MTgxTo5EtQQABJvhGq06N7rAKURx34Jm+SEtCeQh7YfhLhplnwUWvl70j8RTfFuojURW10qaUF0g1hKViCn2IW59RHyE7f9RpztdopVwD80GXZ2CxoHbjWgNOzZaaFsyfIrN82fcY/j6dy0ib1FJeWzCBV2U5RL4qehI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joeyh.name; spf=pass smtp.mailfrom=kitenet.net; dkim=pass (1024-bit key) header.d=joeyh.name header.i=@joeyh.name header.b=cjBTdL0E; arc=none smtp.client-ip=66.228.36.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joeyh.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kitenet.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joeyh.name header.i=@joeyh.name header.b="cjBTdL0E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=joeyh.name; s=mail;
	t=1716371352; bh=X6hhseWSM1rNQ6PPeiHtzRU8WaIUCmKn93grukTEc8Q=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=cjBTdL0ERuQtWQtQcUg2aTloUpp8MqjB2/k4+GwEfkl4ib12TPowDnM84Tc9Vnj3a
	 tX7VpnLPcHzZpHa3KBfLDf0cEkBH5l/I0B/yEPR9NYrMPuzDdyCdtDg5RwwxTptI+T
	 R4ojJYgcfFfqqu5WE3cUMWoLa0E9Cl/RSt/7VVr8=
X-Question: 42
Date: Wed, 22 May 2024 05:49:12 -0400
From: Joey Hess <id@joeyh.name>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Revert defense-in-depth patches breaking Git LFS
Message-ID: <Zk2_mJpE7tJgqxSp@kitenet.net>
References: <20240514181641.150112-1-sandals@crustytoothpaste.net>
 <0f7597aa-6697-9a70-0405-3dcbb9649d68@gmx.de>
 <ZkO-b6Nswrn9H7Ed@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZkO-b6Nswrn9H7Ed@tapette.crustytoothpaste.net>

brian m. carlson wrote:
> If these protections hadn't broken things, I'd agree that we should keep
> them.  However, they have broken things and they've introduced a
> serious regression breaking a major project, and we should revert them.

More than one major project; they also broke git-annex in the case where
a git-annex repository, which contains symlinks into
=2Egit/annex/objects/, is pushed to a bare repository with
receive.fsckObjects set. (Gitlab is currently affected[1].)


BTW, do I understand correctly that the defence in depth patch set was
developed under embargo and has never been publically reviewed?

Looking at commit a33fea0886cfa016d313d2bd66bdd08615bffbc9, I noticed
that its PATH_MAX check is also dodgy due to that having values ranging
=66rom 260 (Windows) to 1024 (Freebsd) to 4096 (Linux), which means git
repositories containing legitimate, working symlinks can now fail to be
pushed depending on what OS happens to host a reciving bare repository.

+                               if (is_ntfs_dotgit(p))

This means that symlinks to eg "git~1" are also warned about,
which seems strange behavior on eg Linux.

+                               backslash =3D memchr(p, '\\', slash - p);

This and other backslash handling code for some reason is also run on
linux, so a symlink to eg "ummmm\\git~1" is also warned about.

+               if (!buf || size > PATH_MAX) {

I suspect, but have not confirmed, that this is allows a symlink
target 1 byte longer than the OS supports, because PATH_MAX includes
a trailing NUL.


All in all, this seems to need more review and a more careful
consideration of breakage now that the security holes are not under
embargo.

--=20
see shy jo

[1] https://forum.gitlab.com/t/recent-git-v2-45-1-breaks-git-annex-compatib=
ility-because-of-apparent-fsck-symlinkpointstogitdir-error-on-gitlab/104909
