Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6AF5FDCC
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709932844; cv=none; b=ThQYCBSYdYpfMDZsNiGHmL+DfF3mrj+CNXeC4CK1ySuWy6bgwL+Bm5Voj52oqZrzoPOwgyXBf7bonxKVGcPT8AGKPLncTeSH51pQ/67chy+APLKGtfFMWk0uTLK75ZD2KDpDUnbOXy14brGT34AlmPsfzoHfYITF0RrGCoDHMt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709932844; c=relaxed/simple;
	bh=5P6ICMeaAbri39zqZg87ua5pOXsaWCkrnwV3q87B/jg=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ipTltd5aclY/quIUHNkbWnRI+w3DU7VOp8TCB0CEBZcJSVmccaSd1zy2oicQ9U0C/+wPsPMVLVLjyCQlB2goK/mq9qO1JobKHWUwI0IqnHjTlK79FIyNKSgKSXQkacx3mid3duY1Id+45/G2bTxHtRElLtKdzvD+mPtNqUU4/PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 428LKJ5B555498
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Mar 2024 21:20:20 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Angelo Dureghello'" <angelo@kernel-space.org>
Cc: <git@vger.kernel.org>, "'Patrick Steinhardt'" <ps@pks.im>
References: <72771da0-a0ef-4fd9-8071-6467cd7b6a6b@kernel-space.org> <Zetw0I0NHgABR_PX@tapette.crustytoothpaste.net>
In-Reply-To: <Zetw0I0NHgABR_PX@tapette.crustytoothpaste.net>
Subject: RE: [BUG] cannot git clone with includeif onbranch
Date: Fri, 8 Mar 2024 16:20:14 -0500
Organization: Nexbridge Inc.
Message-ID: <0a9601da719e$6cc85250$4658f6f0$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQHH0Ksfq+HtFGOeMOMj96aDSmNkZwIl39lLsUJro1A=

On Friday, March 8, 2024 3:11 PM, brian m. carlson wrote:
>On 2024-03-08 at 19:25:52, Angelo Dureghello wrote:
>> Hi,
>>
>> below the bug report, not totally sure this is a bug btw.
>>
>> ---
>>
>> Thank you for filling out a Git bug report!
>> Please answer the following questions to help us understand your =
issue.
>>
>> What did you do before the bug happened? (Steps to reproduce your
>> issue)
>>
>> Perform a git clone https with includeif onbranch in the .gitconfig
>>
>> Create a .gitconfig
>> with
>> [includeIf "onbranch:wip/pippo/**"]
>>         path =3D ~/.gitconfig.pippo.inc
>>
>> git clone https://github.com/analogdevicesinc/no-OS.git
>>
>> Cloning into 'no-OS'...
>> BUG: refs.c:2083: reference backend is unknown
>> error: git-remote-https died of signal 6
>
>Thanks for the report.
>
>I can definitely confirm this with a local Git 2.44.0 built out of my =
working tree.  It seems to trigger as long as there's a `path` entry
>whether the path exists or not.  It _doesn't_ seem to trigger with a =
`gitdir` check, but does trigger for `onbranch`.  v2.43.0 is not
>affected.
>
>I do definitely think this is a bug.  First of all, we should not =
trigger BUG conditions, even if the user has done something naughty, so =
we
>should fix it for that reason.  Second of all, this seems like a =
completely reasonable thing to want to do, and considering it triggers =
for
>existing files, and that it worked just fine in v2.43.0, I don't see a =
reason we shouldn't have this work.
>
>A bisection[0] leads us to 0fcc285c5e ("refs: refactor logic to look up =
storage backends", 2023-12-29).  I've CCed the author of that
>commit, who hopefully can provide some more helpful context.
>
>I have some guesses about what's going on here, but I haven't poked =
further into the situation, so I'll refrain from speculating for now.
>
>[0] git bisect run sh -c 'make -j12 && cd $TMPDIR && rm -fr no-OS && =
PATH=3D"$HOME/checkouts/git/bin-wrappers:$PATH" git clone
>https://github.com/analogdevicesinc/no-OS.git; RET=3D$?; [ "$RET" -eq =
128 ] && RET=3D1; exit $RET'

I was wondering whether this should only work on a clone with -b =
wip/pippo/... argument, although it should not fail the clone, just not =
apply the path. I can see how it would be somewhat confusing if the =
global config defaults to master and remote only serves up main - or =
vise-versa.

--Randall

