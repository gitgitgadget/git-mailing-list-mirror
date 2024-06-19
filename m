Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1CC158DCF
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718828089; cv=none; b=aZAV3EVbsggymce6/EaDJzT6/h9JkqaVQibIxGSyERFImMcM9vyQYk5Fc213sc72moxCrvy/0uSWMSCKAXTJ7hvoAQ4pq0YZFI0YGaQ5l0/abNekL8I/+0+WNmOHILeF6nvU/92b73fH75GH/LwUt+oqGqA46QPG08VYSFJeLk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718828089; c=relaxed/simple;
	bh=WGk9obBtGVHq4NCemdPO+T6WONAqQn5S6Z6DuiJUhHA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Eikh9WgaQZ2ABKOxc4Cf/yVl6A40WiLMMSCfDqzt11l6fp+oNcaXnkKtUp48440xAORqsZ9XbAWNfMbi1Tra507Tys1GnRnRFgS6lGAshVhtkgt8D3zBJF+hJanL4lcUQAydOGwOzLmdOGh43Bcudz+ykTYn5ZNuKEnNheJE8ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3418120-ipxg00d01tokaisakaetozai.aichi.ocn.ne.jp ([114.171.163.120] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1sK1Mt-00CN3m-2Y
	for git@vger.kernel.org;
	Wed, 19 Jun 2024 19:53:20 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1sK1Ml-003Cy8-2s
	for git@vger.kernel.org;
	Thu, 20 Jun 2024 04:53:11 +0900
Date: Thu, 20 Jun 2024 04:53:11 +0900
From: Mike Hommey <mh@glandium.org>
To: git@vger.kernel.org
Subject: Ownership handling of the "remote name" buffer given to `remote_get`
 is inconsistent
Message-ID: <20240619195311.yhmbv5ruixa433rn@glandium.org>
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

I actually found this a few years ago, but didn't worry too much about
it, forgot about it, then rediscovered it yesterday. I tried to untangle
the situation, but it looks like it would take me more time than I can
allocate, so I'm sending this report.

When you call `remote_get(name)`, you may end up giving ownership of
`name` to the remote, such that if you `free(name)`, using the remote
after that may lead to use-after-free. Of course, this is a
use-libgit-as-a-library situation; I don't think it happens in actual
git code.

Here's how it goes: if your `name` is actually a URL, you end up in this
case in remotes_remote_get_1:

        if (name_given && !valid_remote(ret))
                add_url_alias(remote_state, ret, name);

`add_url_alias` will eventually set `ret->url` to contain `name` as-is,
taking ownership. Later `release_clear` will free it, which will lead to
double-free if the caller frees it.

It's further complicated by `add_url_alias` also sometimes *not* taking
ownership, in the face of URL rewrites (in `alias_url`). Meaning, the
fix is not as straightforward as changing the above to

                add_url_alias(remote_state, ret, xstrdup(name));

This is as far as I went before my time was up on this issue.

Mike
