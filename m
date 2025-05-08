Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21001946A0
	for <git@vger.kernel.org>; Thu,  8 May 2025 20:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746734792; cv=none; b=uZlKOJjZbFTT4ZTjHq+5DuJu8q+l9XZpsCVWQbs4ZKO6NIgSAFIVzXBspAHUjztv0PnW8BLQMrQ8afoJP9/veh3WGU/n/AOagvmr0bDP1weAOXH8ueoeRbuTKVArUSIjniDuzjJpdn6CG7hRvGId3N05e/StEK+hUZhiTGEc9Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746734792; c=relaxed/simple;
	bh=qOB+KQriSYVR07xfz6GZXrKXBkCpiI7PqbhzBrLOo7Q=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=WmLg3+rdohQBP9Cj6Jj2dTMUdazG7k9APjnKIw2SpBKYFRoz9SomJ5UEbtppHccftwpa3UOy3qioeYxbscaYrP06QsmpGSCmZDXVJu82yXGSSv2WcBeHglDtxc0gDapMxhJ4HVAOZoAYugjshLVgpZTsxc6EhGT5+xBCrzfVRpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 548K6C2r2194421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 May 2025 20:06:13 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Jeff King'" <peff@peff.net>,
        "=?UTF-8?Q?'Michal_Such=C3=A1nek'?=" <msuchanek@suse.de>
Cc: "'Akash S'" <akashs@commvault.com>, <git@vger.kernel.org>,
        "'Adithya Urugudige'" <aurugudige@commvault.com>,
        "'Abhishek Dalmia'" <adalmia@commvault.com>
References: <PH7PR19MB70252D42F5D04FFC0331AB63C08E2@PH7PR19MB7025.namprd19.prod.outlook.com> <aBz8U35YX7UH-PTW@kitsune.suse.cz> <20250508194731.GA13108@coredump.intra.peff.net>
In-Reply-To: <20250508194731.GA13108@coredump.intra.peff.net>
Subject: RE: Incremental Backup of repositories using Git
Date: Thu, 8 May 2025 16:06:08 -0400
Organization: Nexbridge Inc.
Message-ID: <029701dbc054$a6e9af00$f4bd0d00$@nexbridge.com>
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
Thread-Index: AQIZtOnO1cTS/ZYCBMta1QTCdasffQLodvEPAd5aFA6zJwhZUA==
Content-Language: en-ca
X-Antivirus: Norton (VPS 250508-4, 5/8/2025), Outbound message
X-Antivirus-Status: Clean

On May 8, 2025 3:48 PM, Jeff King wrote:
>On Thu, May 08, 2025 at 08:47:47PM +0200, Michal Such=C3=A1nek wrote:
>
>> If you have one of those filesystems that support deduplication on
>> filesystem level you could make each snapshot as a full repository
>> with all objects unpacked, and the filesystem would deduplicate the
>> objects for you.
>>
>> The downside is that you have no way to do multiple full backups this
>> way, and you would have to use something else for that (such as those
>> bundles, or plain archiving the repository as files in a tar archive
>> or such.
>
>This is tempting, but I suspect that storing the objects unpacked will =
become
>unfeasibly large, because you are missing out on delta compression in =
the packfiles.
>You can compare the on-disk and uncompressed sizes of objects in a repo =
like this:
>
>  git cat-file --batch-all-objects --unordered \
>               --batch-check=3D'%(objectsize:disk) %(objectsize)' |
>  perl -alne '
>    $disk +=3D $F[0];
>    $true +=3D $F[1];
>    END {
>      print "$true / $disk =3D ", int($true / $disk);
>    }
>  '
>
>It's not entirely fair because the "true" size is missing out on zlib =
compression that
>loose objects would get. But that's at best going to be about 4:1 (and =
in practice
>worse, since trees are full of sha1 hashes that don't compress very =
well).
>
>In my copy of linux.git, that yields ~135G versus ~2.4G, for a factor =
of 56. Even if we
>grant 4:1 compression from zlib, that's still inflating your on-disk =
repository by a
>factor of 14.
>
>If you have the patience, you can run:
>
>  git cat-file --batch-all-objects --unordered --batch | gzip | wc -c
>
>to get a better sense of what it looks like with the extra deflate =
(this is cheating a bit,
>because it will find cross-object compression opportunities which would =
not be
>there in loose objects storage, but should get you in the right =
ballpark).
>
>You're probably also paying some inode costs with loose objects (1K =
trees at the
>root of linux.git all pay 4K or whatever as individual loose objects).
>
>So you're probably much better off with some strategy .keep files. =
I.e., make a good
>big pack and mark it with .keep, so that it is retained forever.

As a possible alternative, would some kind of information presented via =
the proposed
git blame-tree series (or call it git annotate-tree perhaps) be useful =
for this enhancement?
I am not sure what the results will look like, but it might be useful =
and then cached by
the backup strategy. I'm grasping at straws, though.

--Randall

