Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669706FB9
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 01:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718068795; cv=none; b=S4blatKyGbAT+IFg6+JuIkMtTdCP/NIUV74AHgGApnfJUP0Z55uul//xlGwJ4w1Rqr9vOQnuTY+gBL0MEn+XVt+dBhRT0OOxWoatNS9KekOw+kUqRTTAJolPy7HGWhJY78MPs/ILHEjAt/LYNOcfv2UMaUyyLZO+KUBmBdkflG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718068795; c=relaxed/simple;
	bh=iBaS9ZOpvs61+BbSCw965OqokLHLwzvHh4vd/J2Xvas=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=tsGgRq2jGXxB394QpLz91l7XcZC8hQmWzuPltlyy3NOuA5/10ElNwjU42plTl5qO50pZAMG3mLC2SfI4Nxe6A4xAPTRPOS1qOV7HJIka50K2soJ4ScH3r4WPWpeNlz5sr59XkoF+sm12tFmwZ6WOB6nR7VCUNcXymejYi/J4yMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 45B1JgfA1837759
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 01:19:43 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Yuri'" <yuri@rawbw.com>, "'Junio C Hamano'" <gitster@pobox.com>
Cc: "'Git Mailing List'" <git@vger.kernel.org>
References: <ae862adb-1475-48e9-bd50-0c07dc42a520@rawbw.com> <xmqqwmmw1sev.fsf@gitster.g> <4ed426e4-beb6-45ed-b493-1e19c7c0511b@rawbw.com> <xmqqikygzdgk.fsf@gitster.g> <e8feffd0-ba6d-4aae-8c80-3d6482896b08@rawbw.com> <0ee501dabb91$aa2340a0$fe69c1e0$@nexbridge.com> <8fdc76e2-3de2-4312-956c-2662336fa54d@rawbw.com>
In-Reply-To: <8fdc76e2-3de2-4312-956c-2662336fa54d@rawbw.com>
Subject: RE: [BUG] "git clean -df ." silently doesn't delete folders with stale .nfs* files
Date: Mon, 10 Jun 2024 21:19:38 -0400
Organization: Nexbridge Inc.
Message-ID: <0eef01dabb9d$70c99690$525cc3b0$@nexbridge.com>
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
Thread-Index: AQETpLHCLpFQr2QiGEI4aCI0uZSumAGFDyW3ASm+LNUCETu8/AHXUzFkAMoJcpkCHbeU6bMD955Q
Content-Language: en-ca

On Monday, June 10, 2024 9:10 PM, Yuri wrote:
>On 6/10/24 16:55, rsbecker@nexbridge.com wrote:
>> I have tried to reproduce your situation using git 2.43.0 without
>> success. $ mkdir test $ cd test $ touch .nfs12309 $ git clean -df .
>> Removing .nfs12309
>
>
>"touch .nfs12309" isn't enough.
>
>
>Here is a reliable way to reproduce the problem:
>1. Have a git repository on an NFS disk.
>2. mkdir xx
>3. touch xx/x
>4. tail -f xx/x &
>5. rm xx/x
>6. git clean -df .
>
>
>
>
>The last operation reproduces the problem. The xx directory and the =
.nfsNNNN file
>in it stay without warnings.
>The .nfsNNNN file is created by the NFS client when the xx/x file is =
removed.
>
>
>Anybody with an NFS disk should be able to reproduce it.
>
>FYI: Git generally warns about files that it can't remove because of =
permissions and
>special flags reasons.
>But Git doesn't warn users about this situation with an NFS directory =
lock file.

That is what I suspected. I am suspecting that git does not see the =
.nfsNNNN file when it is performing the clean. I think NFS creates the =
file after git does the scan, so as far as git is concerned, there is no =
.nfsNNNN file until after the operation completes. NFS puts the file =
there independent of git, so git does not even know about it. Does a =
second git clean -df . remove the .nfsNNNN file and put a new one, with =
a different name, in place?

