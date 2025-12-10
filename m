Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4790E16CD33
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 17:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765388962; cv=none; b=LeDmGvczWVNzTkr4m0pJi0jqtrARA0q39TXrrJHZYpT8D4IwVOra9sfYBJIUjEHnEViWD8GwKRKyB/D3/v0IZozvdATI2ptKilBx0CFF1JDkLnkwEO0rbH4jd7DAMQcWsRqSONqdiQSpMpmpDhVNPpnDhwbPnaxX3qwzUUfaQ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765388962; c=relaxed/simple;
	bh=TYWWbIwpujZAt++wr5gv1lq/3aNZZ09DgwJTLaS1Lrg=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=XiSIYzRpUS16mJwqd40i3SqzCz6is01ASbrRruwp3O8SF9vF45utaJk533gVCd6psccISQAZ/KYLowtQExafainAX3oJ++i+rV3avk1M889etQTdDcK24o9r3gWyBi+DWMVtHo6184o1oWrMrkwhWzZ7Lswj2mRRm9I5TqPZ/ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 5BAHn2Ag1705482
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 17:49:03 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Ashlesh Gawande'" <git@ashlesh.me>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>, "'Patrick Steinhardt'" <ps@pks.im>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" <avarab@gmail.com>
References: <20251014144354.1457818-2-git@ashlesh.me> <aO7Aqooz-0ppbcMP@fruit.crustytoothpaste.net> <30639771-4999-45f4-a8d7-1ed4774ffd8e@ashlesh.me> <aPAg3gYwzA9fHCC3@fruit.crustytoothpaste.net> <79d2226c-b568-4385-a618-f0d3c06cd0a8@ashlesh.me> <aTjVenutFBprwrrz@fruit.crustytoothpaste.net> <37c3b31e-900e-4df0-ac30-284e71660487@ashlesh.me>
In-Reply-To: <37c3b31e-900e-4df0-ac30-284e71660487@ashlesh.me>
Subject: RE: [PATCH] http.c: prompt for username on 403
Date: Wed, 10 Dec 2025 12:48:57 -0500
Organization: Nexbridge Inc.
Message-ID: <03ed01dc69fd$45f32fc0$d1d98f40$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHioOeLoZVui41eL+OBn9RlIUxTqwHK+PM8AcbRbpABpCb2JQHevazTAfC+WdgBcl1UNbS6+Vlg
X-Antivirus: Norton (VPS 251210-4, 12/10/2025), Outbound message
X-Antivirus-Status: Clean

On December 10, 2025 7:30 AM, Ashlesh Gawande wrote:
>On 12/10/25 07:35, brian m. carlson wrote:
>> On 2025-12-09 at 08:22:49, Ashlesh Gawande wrote:
>>> I was working on separating the tests and thought about the original
>>> proposal a bit more.
>>> To stop the credentials from being erased on 403 could something =
like
>>> the following be acceptable?
>>>
>>>          else if (results->http_code =3D=3D 401 || =
results->http_code =3D=3D
>>> 403) {
>>>                  if ((http_auth.username && http_auth.password) ||\
>>>                      (http_auth.authtype && http_auth.credential)) {
>>> +                       // Do not override existing credentials on
>>> +403
>>> +                       if (results->http_code =3D=3D 403) {
>>> +                               return HTTP_ERROR;
>>> +                       }
>>> +
>>>                          if (http_auth.multistage) {
>>>
>>> So then we would prompt on 403 only if credentials are not =
configured.
>> Can you tell me what file you see this in?  I don't actually see any
>> place in the code that has "http_code =3D=3D 403" in the latest =
version of
>> the main branch.
>>
>> I wonder if your issue may already be fixed in a newer version than
>> you have.
>Oh, that http_code =3D=3D 403 is my original proposal to prompt for
>username/password on 403 (I did the diff on top of that instead of =
base).
>But you pointed out that it would wipe out existing credentials. This =
is an attempt to
>fix that by not prompting on 403 if git credentials are set.
>So when credentials are provided through default netrc file (such that
>http_auth.* are not set; git credential helper is not set) then we can =
still get the
>prompt on 403.

Please make sure that any existing git credential helpers, including =
custom helpers
are not impacted by this change. This would have serious negative =
consequences
and would be a blocker for many in my community who use both the =
standard
git credential helpers and custom ones. If you are going to force a =
credential wipe
this should cause an update to the credential protocol to inform the =
helper that a
wipe has occurred or is requested. The .netrc approach is most limited =
to Linux
implementations and is not available on or applicable to some other =
platforms.

Thank you for your attention.
Randall


