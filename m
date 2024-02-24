Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3683E134AD
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 05:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708753409; cv=none; b=dPY3m9XBdzqnaHpT2XKrM31FMFFjuAjKUgY2/rNMjeuvFC2kON/HL0/dyD8ywZkb3qc9ee4FuasShlShNlnlZ14pZ+gCSycHJVVfno4wYNTKA58awVstNTVYaKVLvn68HqvNVtVcBTRZwkxutN97gBa+F8AfD03U0CUQ9Zh+8EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708753409; c=relaxed/simple;
	bh=Fp8163CLTt7UvWkrMY5VMW3LbvQX3SvhfBjL6WjJWxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAf47dyBYnWPO2n8zTdPTAhn7G0PqLu5BTb2RfUGEqQSYh1T/PmUUuPuOUZapWtamP8mSRhi0pMjX0ZidNstiRCx9yfMEYhh3055L7QZKKWux0tIpsxn7VHhW9TrgZ1Wkvskl2Soa3fmlRFnvgQIYWEhHeEJZUatlIGzWveHbJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3418120-ipxg00d01tokaisakaetozai.aichi.ocn.ne.jp ([114.171.163.120] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1rdkJC-008pKQ-0x;
	Sat, 24 Feb 2024 05:10:50 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1rdkJ6-000lXC-06;
	Sat, 24 Feb 2024 14:10:40 +0900
Date: Sat, 24 Feb 2024 14:10:40 +0900
From: Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, git-packagers@googlegroups.com,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [ANNOUNCE] Git v2.44.0
Message-ID: <20240224051040.ftuo24smozqugbde@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <xmqqbk87w164.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbk87w164.fsf@gitster.g>

Hi,

On Fri, Feb 23, 2024 at 09:17:07AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt (139):
>       builtin/clone: create the refdb with the correct object format

I haven't analyzed how/why exactly yet, but I've bisected a regression
in the behavior of is_git_directory() during a clone to originate from
this change.

Here's a way to reproduce the problem:

```
$ cat > git-remote-foo <<EOF
#!/bin/sh
git config --local -l >&2
exit 1
EOF
$ chmod +x git-remote-foo
$ PATH=$PWD:$PATH git clone foo::bar
```

With versions < 2.44.0, it displays the local configuration, e.g.:
```
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
remote.origin.url=foo::bar
```

but with 2.44.0, it fails with:
```
fatal: --local can only be used inside a git repository
```

Mike
