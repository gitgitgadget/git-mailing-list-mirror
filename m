Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3085A18EB8
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 23:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721690063; cv=none; b=AtJMCd23LAWXs8OsLzsZAxUYW/IWsXOR79uc/Yt3y+Nf9n0iV4P8xo5Ms/ah9IWbdCY8yGluMghtJ/lYHk8iUd9PfAN4UyPDLFiZyFvAH7Cw8NJ2G/04qB0k39jOtY3zXWq0F3/RmVi4nUWDyc13pwUoQG8wDmbart3YYDOr9dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721690063; c=relaxed/simple;
	bh=Gi0aqYILqOf36G06pK5mTqfUycyAd+udR5DF0U8QnUc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=COJ6N/vTyMFhaLJpz5ieD04aaQ+MxGfKyy9QfVG2bcU6WcESTn6aCN6zJSCS+k/eVEmJnv/sVd/48vnU+FZkY1pzs1OEPtOKiXBx/p8+ExQuM9gwL3gnVWLpZ/qqVVEmW+ceNutZaKTL1EZshRbTAsaOxUL9WyEwrUcDJjeMWiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46MNE8BV1743390
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 23:14:08 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Thaina Yu'" <thainayu@gmail.com>
Cc: <git@vger.kernel.org>
References: <CADeMgjBeyWkE3mp+-x57NSsyNLQf3cTta+Xm5uyVOQE-rpT6yg@mail.gmail.com> <Zp7Pg7ZOlBZcfJei@tapette.crustytoothpaste.net>
In-Reply-To: <Zp7Pg7ZOlBZcfJei@tapette.crustytoothpaste.net>
Subject: RE: [feature request] Is it possible to have git tag can be sorted and filtered by semver?
Date: Mon, 22 Jul 2024 19:14:03 -0400
Organization: Nexbridge Inc.
Message-ID: <031701dadc8c$db6d3370$92479a50$@nexbridge.com>
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
Thread-Index: AQNZQgdb9BumMJee//uPORLU/o8YkQIdnAccrvWl/zA=
Content-Language: en-ca

On Monday, July 22, 2024 5:31 PM, brian m. carlson wrote:
>On 2024-07-22 at 16:58:11, Thaina Yu wrote:
>> Currently there is `ls-remote` and `tag` that has option to
>> --sort=3Dversion:refname which is really useful when we have tag as
>> version format and let it sort as numeric version
>>
>> But it could be better if we can also sort and filter the version in
>> the range of semver format. So we can use git system as dependency
>> management system natively
>>
>> So I would like to propose a new sort option semver:refname
>>
>> `git ls-remote --sort=3Dsemver:refname myRepoUrl refs/tags/v{^0.*.*}`
>> where brace {} can be used to define semver versioning ranges for the
>> patterns in addition to glob filter
>
>Assuming we add such a feature, how does sorting by SemVer differ from =
the
>current version sorting?  That is, where is the current version sorting =
deficient for
>SemVer?  Also, what do you want to happen when a tag doesn't meet =
SemVer
>requirements (note that the "v" prefix is not allowed in SemVer, =
although it's
>customary in tags)?

Currently, tags would be sorted as follows (simple example):
1.10.0
1.2.0
1.9.1

With semver, the tags would be:
1.2.0
1.9.1
1.10.0

My take is that this, if implemented, would need to be more general, and =
include prefix and suffix handling, so:
v1.2.0
v1.9.0
v1.10.0

should sort as appropriate. We might need something like v({semver}), or =
a more general regex-like (prefix){0,1}(semver){1}(suffix){0,1}.

While at it, having a reverse sort would also be useful. For platforms =
that have semver-util, this can be trivially scripted. For exotics, no =
such luck, as semver-util is not especially portable, not for lack of =
trying.

>As for the special range syntax, I think the typical suggestion is to =
filter the output of
>ls-remote or for-each-ref by piping it to a suitable program.  Perl or =
Ruby are
>common choices here, and both could easily parse SemVer tags.  For =
example:
>
>  git for-each-ref --sort=3Dv:refname refs/tags/ |
>  ruby -ne 'if %r[\trefs/tags/v(\d+)\.(\d+)\.(\d+)$]; ver =3D
>Regexp.last_match[1..3].map(&:to_i); puts $_ if [[2, 6, 3], ver, [2, =
15, 2]].sort[1] =3D=3D
>ver; end'
>
>Git is intentionally designed to support this kind of shell scripting.

I think implementing both wrapped semver and reverse sort in git tag =
might be useful for large projects, like git and OpenSSL where the =
number of tags is large. It would make finding time-ordered releases =
somewhat easier.

--Randall

