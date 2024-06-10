Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E853BB48
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718063740; cv=none; b=mEPICHmM4/TGs4oPIAxzfamWbX2nd/aEGVaueYA/UexYwylu1L71bsRcSFcculm7H/cX2gqU/lbNx2I/69cEVDM9GCrPihqAsgqCbOFAsv5eRTdwMCpWpAQZtdRFX+wmR5ZsNCVJi070rlBX5+SWPgXdyQ7GLWbeZU1f18nVkVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718063740; c=relaxed/simple;
	bh=b4kcy5D+7dIkjR5KQbEQH0kDGGtqRcmkRlWO81XHHLg=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Iew4kD3m4mbv8tPQJmPnK3/JYPXu9QiUF1Mu0OKlFaIb479BLjSGSFVrFeEov69trR/gx58xS1VJCjk+KUYk1xRMlTD/ZeZ4vK5ybiAx2PD9f4nhx3SIEZwx82MB/49m382V0RAq7eXQqjSbJNXLAm889LDf2ZpplQvF/uZgf3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 45ANtPcd1825388
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 23:55:25 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Yuri'" <yuri@rawbw.com>, "'Junio C Hamano'" <gitster@pobox.com>
Cc: "'Git Mailing List'" <git@vger.kernel.org>
References: <ae862adb-1475-48e9-bd50-0c07dc42a520@rawbw.com> <xmqqwmmw1sev.fsf@gitster.g> <4ed426e4-beb6-45ed-b493-1e19c7c0511b@rawbw.com> <xmqqikygzdgk.fsf@gitster.g> <e8feffd0-ba6d-4aae-8c80-3d6482896b08@rawbw.com>
In-Reply-To: <e8feffd0-ba6d-4aae-8c80-3d6482896b08@rawbw.com>
Subject: RE: [BUG] "git clean -df ." silently doesn't delete folders with stale .nfs* files
Date: Mon, 10 Jun 2024 19:55:20 -0400
Organization: Nexbridge Inc.
Message-ID: <0ee501dabb91$aa2340a0$fe69c1e0$@nexbridge.com>
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
Thread-Index: AQETpLHCLpFQr2QiGEI4aCI0uZSumAGFDyW3ASm+LNUCETu8/AHXUzFksxsaZWA=
Content-Language: en-ca

On Monday, June 10, 2024 7:28 PM, Yuri wrote:
>On 6/10/24 14:37, Junio C Hamano wrote:
>> But .nfs* files are not something you as an application are not
>> supposed to touch, so a directory that still contains one cannot be
>> removed, either. It's a limitation (I wouldn't call it a "bug") of
>> NFS. You can kill the process (or wait until they exit) holding the
>> file open and then run "clean -df" again, perhaps.
>
>
>With the '-f' the user tells git to remove all, and if this doesn't =
work git should tell
>the user that this didn't work for the .nfsNNNNNNN file and for the =
directory as
>well.
>
>
>Why is git quiet about leaving the files. It should complain.
>
>Or maybe there should be a verbosity option, like -v 10, that would =
make git
>complain about such things.

I have tried to reproduce your situation using git 2.43.0 without =
success.

$ mkdir test
$ cd test
$ touch .nfs12309
$ git clean -df .
Removing .nfs12309

I have tried this with and without existing commits and files, but =
outside of an NFS context. Do you have a reproducible set of commands =
that I can try? What is in your .gitignore file? I saw a very old NFS =
situation where . prefix files did not get reported on some operating =
systems - I do not think this is what is happening, however. What do the =
commands ls -a and ls and find . -exec {} ";" report at the root of your =
repository? In NFSv4.1, there is a known situation where .nfsXXXXXX and =
.smbXXXXXX files are retained by NFS until the server is notified (or =
NFS determines) that the files have been closed by all clients. These =
files (with those names) may be automatically created by NFS (at its =
whim) and are managed by that subsystem - As I understand it, NFS =
manages removal of those files independently of the client or programs =
running on the client, so git may think the file is actually removed but =
the file may not actually be removed because the unlink() can be =
deferred by NFS. My suspicion is that this NFS itself might be =
contributing to the situation.

Can you try creating your repository, then restarting your server and =
client to isolate the "is open" tests that NFS could be doing, and see =
whether git clean continues to experience this?

--Randall

