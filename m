Received: from kitenet.net (kitenet.net [66.228.36.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3F21FC7C6
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.228.36.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733252354; cv=none; b=fYHmMi7X/fUCQjfOM+fhHEBV78EKJz1RiL/QahfVh1vNBVwFsd0S3b1SW3R3+sWXmX8a2VkSMmtgLUsR0b3cOPbDSxq+SsESMbvscsfL0wc7eibNVAXBv1hz4c3nxBnRbm/ql3Jqt0Jy1Of9OZ+g78ClPVWxq+PVeesK7Kr6BDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733252354; c=relaxed/simple;
	bh=PJTHqF5PQKY1zmkzMeXReuNssoiSGDc6y2TxvonH0EA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rnlelWBwaRugbmDS3ZGtFHAQXQpVR/VggJLUKxXPNfxAZUovqJfRgJl1XHcqYHqv82DD3PP3PfIz24S+bBy2ZM3caUyOqMzgmkIiTRuz4YOhkB5pn0M3qJXz7tEsapy3ZUrlURn/SwXGSZtDlyc8iCAY4WSEun1MrBKj+/c22JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joeyh.name; spf=pass smtp.mailfrom=kitenet.net; dkim=pass (1024-bit key) header.d=joeyh.name header.i=@joeyh.name header.b=Eb9wLUkZ; arc=none smtp.client-ip=66.228.36.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joeyh.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kitenet.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joeyh.name header.i=@joeyh.name header.b="Eb9wLUkZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=joeyh.name; s=mail;
	t=1733161267; bh=PJTHqF5PQKY1zmkzMeXReuNssoiSGDc6y2TxvonH0EA=;
	h=Date:From:To:Subject:From;
	b=Eb9wLUkZyQpzKnJ2lO/RviSyH3EEFHPYUGpxqCH49Tg/EZ3FwL1760P2gIJcVetXN
	 DDvM8frh6Og+qBxX27Ven/DWcgTkrGA5UCn26IfZnjekS3R7aEVPa+wfF4i+duXiXN
	 DTPVlk/DHCq8UgkTMkFgBP1qOUJKxTJYWOv04iLY=
X-Question: 42
Date: Mon, 2 Dec 2024 13:41:07 -0400
From: Joey Hess <id@joeyh.name>
To: git@vger.kernel.org
Subject: infelicities in git hash-object --stdin-paths with special characters
Message-ID: <Z03xM9AvbUpqXpkI@kitenet.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Apparently "Icon\r" is a common filename on OSX, anyway it's a legal
unix filename. It seems that sending a line containing that filename to
git hash-object --stdin-paths triggers some DOS-style CRLF handling.
Here I am running git version 2.45.2 on Linux.

$ touch Icon^M
$ printf 'Icon\r\n' | git hash-object --stdin-paths
fatal: could not open 'Icon' for reading: No such file or directory

$ echo 'wrong file!' > Icon
$ printf 'Icon\r\n' | git hash-object --stdin-paths
1c43b74a7787621318ee7442eb5a36e32476f326

While looking at builtin/hash-object.c to see why it might do this, I quickly
noticed another odd behavior:

$ touch '"foo"'
$ printf '"foo"\n' | git hash-object --stdin-paths
fatal: could not open 'foo' for reading: No such file or directory

$ touch '"foo'
$ printf '"foo\n' | git hash-object --stdin-paths
fatal: line is badly quoted

The documentation does not seem to mention that quoted lines in
--stdin-paths are at all special. Of course, quoting would be one way to
work around the CRLF problem, if it were documented.

It seems that some parts of git that read filenames from stdin use
strbuf_getline_lf and others use strbuf_getdelim_strip_crlf. There does
not seem to be any consistency, and my impression is any user is best
off using -z, when the command supports it, to avoid the mess.

Given all that, maybe adding -z to hash-object would be a good "fix".

-- 
see shy jo
