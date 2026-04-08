Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D90A37F747
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775660051; cv=none; b=fDpqjCBPRHSqQH1xoeyab1GU9ly6Q+66/gPy58c/ZctEwhuHQ1a/jfzOLSRku7XH+ByeLu3O78j3918tjslRZc7SUHmLZcvTdJB+YTijmkcohM9YIBescznNKX+XrA5MfhBXVJOA7ql/Eq1TwLfv8fO+FnP2pqamORDR4rusbJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775660051; c=relaxed/simple;
	bh=ec87+iz5UzyAmPCYHm7peShtKRrpbjLILTwGuWixAoQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=SlVtV706mxqt4nzkQh7TDbbnzg4QLkd9aErrZh2DkI61pFt16NAV7UJS9IucW0Bxh/2gsoi226g9m2eLCdruuXuW0Ux0WnlXKbR3/S5/qh1G9K3FGFX0XQHIlMn8/mNSdujWcbpzuCoeyMVi8GwqzAzP6u5Vu/wJTtyiJFRlyAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 638Es5u63291336
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Apr 2026 14:54:06 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Jeff King'" <peff@peff.net>
Cc: <git@vger.kernel.org>
References: <00f401dcc6e6$7183c0f0$548b42d0$@nexbridge.com> <20260408041716.GA1324339@coredump.intra.peff.net>
In-Reply-To: <20260408041716.GA1324339@coredump.intra.peff.net>
Subject: RE: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
Date: Wed, 8 Apr 2026 10:54:00 -0400
Organization: Nexbridge Inc.
Message-ID: <011701dcc767$8c2ab400$a4801c00$@nexbridge.com>
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
Thread-Index: AQIImllt8JGdGqh7Bu9hfV8wd5a54AFtvwh7tXIr8BA=
X-Antivirus: Norton (VPS 260408-0, 4/7/2026), Outbound message
X-Antivirus-Status: Clean

On April 8, 2026 12:17 AM, Jeff King wrote:
>On Tue, Apr 07, 2026 at 07:29:50PM -0400, rsbecker@nexbridge.com wrote:
>
>> I can getting numerous issues in t5310, t5326, t2527 relating to the
>> following use of --git-dir:
>>
>> In t5310:
>> fatal: not a git repository: 'clone.git'
>> not ok 55 - fetch (full bitmap)
>> #
>> #                       git --git-dir=3Dclone.git fetch origin =
second:second
>> &&
>> #                       git rev-parse HEAD >expect &&
>> #                       git --git-dir=3Dclone.git rev-parse HEAD =
>actual &&
>> #                       test_cmp expect actual
>> #
>
>This test hasn't changed recently. The clone.git directory should have =
been created
>by an earlier test. Can you try running with "-i" and make sure that =
this is the first
>failing test, and we didn't fail earlier?
>
>Especially because...
>
>> In t5326 and t5327:
>> fatal: writev error: Invalid function argument
>> fetch-pack: unexpected disconnect while reading sideband packet
>> fatal: early EOF
>> fatal: fetch-pack: invalid index-pack output not ok 24 - clone from
>> bitmapped repository #
>> #                       rm -fr clone.git &&
>> #                       git clone --no-local --bare . clone.git &&
>> #                       git rev-parse HEAD >expect &&
>> #                       git --git-dir=3Dclone.git rev-parse HEAD =
>actual &&
>> #                       test_cmp expect actual
>> #
>
>...it looks less like --git-dir is a problem here, and more like the =
introduction of
>writev() is. It is now used in sideband_send(), so it seems plausible =
that a similar
>failure might have broken the git-clone operation that the other test =
was using to
>create clone.git.
>
>As for why writev() is failing, I don't know. If it were totally broken =
on your system
>I'd expect almost everything to be failing. But maybe try building with =
"make
>NO_WRITEV=3DNope" and see if that makes the problems go away? The =
compat
>implementation just does a series of write() calls, which is what =
send_sideband()
>was doing before.

First fail is as follows in subtest 25:

expecting success of 5310.25 'clone from bitmapped repository':
                rm -fr clone.git &&
                git clone --no-local --bare . clone.git &&
                git rev-parse HEAD >expect &&
                git --git-dir=3Dclone.git rev-parse HEAD >actual &&
                test_cmp expect actual

Cloning into bare repository 'clone.git'...
remote: Enumerating objects: 629, done.
fatal: writev error: Invalid function argument
fetch-pack: unexpected disconnect while reading sideband packet
fatal: early EOF
fatal: fetch-pack: invalid index-pack output
not ok 25 - clone from bitmapped repository

I think the invalid function argument maybe an ioctl or socketioctl not =
supported for the file type.


