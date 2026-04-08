Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAD539DBD8
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775665557; cv=none; b=V9acM6TcA0SUVOPlE248TSEagGw8Rk83jhokSQgG4fnZLe2L+vG0J6RJW0GAPG90m/CptbdyzqMWs3MoBzlhXu3pt4+QejpojtL51/IcMcAYzlV978ZqC0UeVn+ahiXgPxYM24ZO9DergjsEpZMXOqjZQEwfwJqIcsjGwFr1htk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775665557; c=relaxed/simple;
	bh=qayxorjR8xKFn4Ltyfgy5aFhZEEvE9SOLl09N34nxQ0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pq0mKianHtZDDBAttElrBf5cVuIvhpTVP/vyg2yFHn0x/j2LQsKzzD35tgB8TvrbE/tP3YiYK484wAjt0g+aEt1fId211BLABAilK2qM3ohVD3xONF/7em0kwMCJxF1SiIm6al1A1O5kDoZ4zJQpLne5yJ4CBAn7Ckwr807R1Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 638GPqxD3311538
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Apr 2026 16:25:53 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <rsbecker@nexbridge.com>, "'Jeff King'" <peff@peff.net>
Cc: <git@vger.kernel.org>
References: <00f401dcc6e6$7183c0f0$548b42d0$@nexbridge.com> <20260408041716.GA1324339@coredump.intra.peff.net> <011701dcc767$8c2ab400$a4801c00$@nexbridge.com>
In-Reply-To: <011701dcc767$8c2ab400$a4801c00$@nexbridge.com>
Subject: RE: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
Date: Wed, 8 Apr 2026 12:25:47 -0400
Organization: Nexbridge Inc.
Message-ID: <013301dcc774$5e9fffb0$1bdfff10$@nexbridge.com>
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
Thread-Index: AQIImllt8JGdGqh7Bu9hfV8wd5a54AFtvwh7AomCUMu1XfehMA==
X-Antivirus: Norton (VPS 260408-0, 4/7/2026), Outbound message
X-Antivirus-Status: Clean

On April 8, 2026 10:54 AM, I wrote:
>To: 'Jeff King' <peff@peff.net>
>Cc: git@vger.kernel.org
>Subject: RE: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
>
>On April 8, 2026 12:17 AM, Jeff King wrote:
>>On Tue, Apr 07, 2026 at 07:29:50PM -0400, rsbecker@nexbridge.com =
wrote:
>>
>>> I can getting numerous issues in t5310, t5326, t2527 relating to the
>>> following use of --git-dir:
>>>
>>> In t5310:
>>> fatal: not a git repository: 'clone.git'
>>> not ok 55 - fetch (full bitmap)
>>> #
>>> #                       git --git-dir=3Dclone.git fetch origin =
second:second
>>> &&
>>> #                       git rev-parse HEAD >expect &&
>>> #                       git --git-dir=3Dclone.git rev-parse HEAD =
>actual &&
>>> #                       test_cmp expect actual
>>> #
>>
>>This test hasn't changed recently. The clone.git directory should have =
been created
>>by an earlier test. Can you try running with "-i" and make sure that =
this is the first
>>failing test, and we didn't fail earlier?
>>
>>Especially because...
>>
>>> In t5326 and t5327:
>>> fatal: writev error: Invalid function argument
>>> fetch-pack: unexpected disconnect while reading sideband packet
>>> fatal: early EOF
>>> fatal: fetch-pack: invalid index-pack output not ok 24 - clone from
>>> bitmapped repository #
>>> #                       rm -fr clone.git &&
>>> #                       git clone --no-local --bare . clone.git &&
>>> #                       git rev-parse HEAD >expect &&
>>> #                       git --git-dir=3Dclone.git rev-parse HEAD =
>actual &&
>>> #                       test_cmp expect actual
>>> #
>>
>>...it looks less like --git-dir is a problem here, and more like the =
introduction of
>>writev() is. It is now used in sideband_send(), so it seems plausible =
that a similar
>>failure might have broken the git-clone operation that the other test =
was using to
>>create clone.git.
>>
>>As for why writev() is failing, I don't know. If it were totally =
broken on your system
>>I'd expect almost everything to be failing. But maybe try building =
with "make
>>NO_WRITEV=3DNope" and see if that makes the problems go away? The =
compat
>>implementation just does a series of write() calls, which is what =
send_sideband()
>>was doing before.
>
>First fail is as follows in subtest 25:
>
>expecting success of 5310.25 'clone from bitmapped repository':
>                rm -fr clone.git &&
>                git clone --no-local --bare . clone.git &&
>                git rev-parse HEAD >expect &&
>                git --git-dir=3Dclone.git rev-parse HEAD >actual &&
>                test_cmp expect actual
>
>Cloning into bare repository 'clone.git'...
>remote: Enumerating objects: 629, done.
>fatal: writev error: Invalid function argument
>fetch-pack: unexpected disconnect while reading sideband packet
>fatal: early EOF
>fatal: fetch-pack: invalid index-pack output
>not ok 25 - clone from bitmapped repository
>
>I think the invalid function argument maybe an ioctl or socketioctl not =
supported for
>the file type.

This is also impacting t5608 and t7700. Anywhere where writev() is used, =
seemingly. We went through
MAX_IO_SIZE issues years ago, instead of using ssize_t as a basis of how =
big communication is. I think
writev() is not valid. It worked on Lunix, but had issues elsewhere. =
This broke the compat layer.

