Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF212BAE5
	for <git@vger.kernel.org>; Sat, 27 Jul 2024 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722109816; cv=none; b=aeg4WAiQCzwUWkF4G1NhoV62I1ew1HRWGLh3o8Hri/d+K7MUwxVaRysYrevmBPg81uO1A/IcBH+nmsnktwI2u8fREMHQqUBegesHBEHmKyzXStX9Jg/79nVi/OXNrXGJpOElTMGQ4Itb0HMjknZU8RCy7uKV03iiRPy6aa+9SmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722109816; c=relaxed/simple;
	bh=8AoJA/GWi/YlWUi2PulJXlM8YXIGf5YYEObpDzZ81MA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PNB2OIxrgtJDCufDN3uV94oBDbHNOZwUiy4JB+9CpDHxcUwPESc7pjsC0YY+LYp9W4Wtded+YobhOLGH80D3Rp6seI0oy+uQNTPeJ9S2TqpPzvszrWAihPG6t4pHJSaUOnB4i69DLAm5vy72uGDSIz1s3Hx5PDK3DHUVPkSPO+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3332141-ipxg00c01tokaisakaetozai.aichi.ocn.ne.jp ([180.44.173.141] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1sXmwu-00AkCa-2L
	for git@vger.kernel.org;
	Sat, 27 Jul 2024 19:19:24 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1sXmwn-0002ZZ-1w
	for git@vger.kernel.org;
	Sun, 28 Jul 2024 04:19:17 +0900
Date: Sun, 28 Jul 2024 04:19:17 +0900
From: Mike Hommey <mh@glandium.org>
To: git@vger.kernel.org
Subject: [2.46 regression] git ls-remote crash with import remote-helper
Message-ID: <20240727191917.p64ul4jybpm2a7hm@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Running `git ls-remote $helper::$url` crashes when run outside a git
repo and the helper uses the import feature.

Here is a minimal reproducer:
```
$ cat > git-remote-foo <<EOF
#!/bin/sh
echo import
echo refspec '*:*'
EOF
$ chmod +x git-remote-foo
$ PATH=$PWD:$PATH git ls-remote foo::bar
```

The crash happens in parse_refspec in refspec.c, on a deref of the_hash_algo,
because the_hash_also is not set anymore at that point since c8aed5e8da.

Mike
