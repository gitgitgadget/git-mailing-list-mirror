Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA334CB50
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707486724; cv=none; b=qpXELrRIlDAcI5MfRAecX8c8/KtCguK8z6P5BDYgTQWK8aKaFJKojcvSueZYOmc7zhac/b9g30/iRlyw36R/EpCtE1VDKzMRBKmU3bGsmtg5ejNSSre+jX2ZdhhMQ5esql2lz41Qmc7A3VsaYTXsRM6xbEb40EImJWYcpBdoXCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707486724; c=relaxed/simple;
	bh=NooesN/N8tToTtICakbAtZB46rWMzc4HXVqECDQ1YMk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GBPTr0ID1XC48YtKtGfswoyQz8tXwgsbZt/gMud8ABSGI6Gio3++dJ9IOsfiUN//08TnfjkmvpH88LhIniiKc393Fwv3J9OUygxMuo9J+K0uUHm7r4c2Fbsuf3V8yRWtSneN439Pb3SW8tUeXPmgQRz9JiL62ObdDDg0abJkUPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=YGVZcAeJ; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="YGVZcAeJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1707486717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=xAslB4lnOkjlgSW3j6U+cMxp45ZMY/PxZJOEeL/Dfn0=;
	b=YGVZcAeJ+yNttkeFTbZYbzvIMUw9NZr1nCQ+3jrUZziqe8/rK0j8v4bBWNG1GfhVsbh3vP
	aX33wlfg7igWOP83ZreobFeeK8aSli/MT3aK+W2zwZBOZI5hskMj9SEagklLLR9J3zS1C0
	XGqMKuURKxvrQtjBqSbDEIdMDvo4FJc=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Subject: Race condition in git-bundle(1) create when ref is updated while
 running
Date: Fri, 09 Feb 2024 14:40:30 +0100
Message-ID: <87eddlpx5k.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Hi y'all,

I discovered a bug in git-bundle(1) create. There is a race condition
happening when a ref gets updated while the bundle creation process is
running.

To reproduce, I've been running git-bundle(1) with
`create my.bndl --all --ignore-missing` in a debugger. I've set a
breakpoint at bundle.c:515[1] where setup_revisions() is called. After
stepping over this line I see in the debugger `revs.pending` is
populated.

    (gdb) p *revs.pending.objects
    $6 = {item = 0x7a2fb0, name = 0x78d7e0 "refs/heads/master", path = 0x0, mode = 12288}
    (gdb) p *revs.pending.objects.item
    $7 = {parsed = 1, type = 1, flags = 0, oid = {hash = "R\026\370\365\304\b\236\302\234\344\232\372\024t4\302>\017\001c\000\000\000\000sS\344\367\377\177\000", algo = 1}}

The hash value is the binary representation of
`5216f8f5c4089ec29ce49afa147434c23e0f0163`, the current HEAD of
`master`. At this point I've updated `master` in another terminal
window:

    git commit --allow-empty -m"dummy"

Then in the debugger I continue the process to create the bundle. The
resulting bundle seems to be missing `refs/heads/master`.

I'm surprised this ref is completely omitted from the bundle. Even
though the ref is outdated, I would expect git-bundle(1) to just take
the old commit ID.

[1]: https://github.com/git/git/blob/5216f8f5c4089ec29ce49afa147434c23e0f0163/bundle.c#L515

--
Toon
