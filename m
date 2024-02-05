Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0ED482CD
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 22:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707173555; cv=none; b=aTq/MfWFmH30oSrtQkoR6Q7XFf16Hhv3NIFUI6wHVA4gbRTxGZtH1DC4yAqwSqz8aAJeGFmVJ4uObo3mcyZra+GY8xw+eANTCVu5BscS2hgmRjwqxTHik8MYwhwW0sVmXLctdpRWeq+3AF07mu7sDDV5XuuYM95/l2AExc/K/wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707173555; c=relaxed/simple;
	bh=3J4gueTzzEsszpBFyJ6Z5Y4rUdbaZ7ooRWzjtmvw/yQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=f8pXQzWjSWoNm2pOn5ydTFVjy/jesIuHKLiNSm4sHBQTtxTQfNH4lN/d/1n8ofOuWCIA1nMlGRR/rYHMszCP0a9BLs43HD7BPCJeatnIBs2MPq/r1FguBRlZz30hGPnTm9/dGt1DKEjSQq/Idb3koBbB2AwxZ3zPBd6zsY4+seg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 415MqHe12320916
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 22:52:18 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Quentin Bouget'" <ypsah@devyard.org>
Cc: <git@vger.kernel.org>
References: <20240204185427.39664-1-ypsah@devyard.org> <20240204185427.39664-3-ypsah@devyard.org> <ZcARb4YNCD4NLJku@tapette.crustytoothpaste.net> <CYWT6JWQCTFG.106OCJTV3NQDU@devyard.org> <ZcFeoyFXqLhMXVRh@tapette.crustytoothpaste.net>
In-Reply-To: <ZcFeoyFXqLhMXVRh@tapette.crustytoothpaste.net>
Subject: RE: [PATCH 2/2] http: prevent redirect from dropping credentials during reauth
Date: Mon, 5 Feb 2024 17:52:12 -0500
Organization: Nexbridge Inc.
Message-ID: <024001da5885$f85e1160$e91a3420$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQOLeevKzT3v0wkj8zcvqA/epUr17AK8HKeCAYoxON0B0zcOTQIO8efkrVjS90A=
Content-Language: en-ca

On Monday, February 5, 2024 5:18 PM, brian m. carlson wrote:
>On 2024-02-05 at 03:01:17, Quentin Bouget wrote:
>> Good point, I had not considered the security implications.
>>
>> I can see libcurl only reuses credentials after a redirect if the
>> hostname has not changed: [1]
>>
>> 	By default, libcurl only sends credentials and Authentication
>> 	headers to the initial hostname as given in the original URL, to
>> 	avoid leaking username + password to other sites.
>>
>> Does it sound OK if I use the credentials provided by the redirect
>> when there are any (out of consistency with the current
>> implementation), and only allow reusing the current credentials when
>> the redirect and the original URLs share the same hostname?
>
>I don't think we can actually rely on that functionality because
>`credential.usehttppath` could actually have been set, in which case =
we'd need a
>different credential.  For example, I know some forges issue certain =
types of tokens
>that are tied to a specific URL and wouldn't validate for a redirect, =
even if it were
>actually the same repo.
>
>If there are credentials in the URL provided by the redirect, I think =
it should be safe
>to use them; otherwise, we'd need to rely on filling them with the =
credential
>protocol.
>
>> Apologies, I feel like I may have given the impression I wanted to
>> configure credentials in git's configuration files, which is not the
>> case.
>>
>> My use case is to `git push` a tag from a CI/CD pipeline to trigger a
>> release, similar to how I do it here. [3]
>>
>> Or is this the kind of use case you are trying to discourage?
>
>We're trying to discourage all use of credentials in the URL at the =
command line and
>in remote names/configuration files.  If you want to pass in =
credentials from the
>environment, the Git FAQ explains how to do that[0], and that technique =
can be
>used in such a situation.
>
>[0] https://git-scm.com/docs/gitfaq#http-credentials-environment

A common side-use case (not directly in git) for this situation is to =
attempt to use curl (or libcurl) to create a Pull Request via the GitHub =
(or other enterprise git server) CLI or POST. This is most often done =
via REST rather than supplying via the URL. It does remove the need to =
pass some credentials (a.k.a. the API token) via the URL as the API =
token gets injected into the JSON content - this may have been the =
original motivation as many of the servers do redirects. However, they =
do not reprocess or inject different credentials. I am wonder about the =
specific use case is for this situation and why a redirect injects a =
credential change, which I cannot see is a good thing.

--Randall

