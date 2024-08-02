Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBFFD272
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 20:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722629064; cv=none; b=o7/jp1z4YSLdJ6VuSTwvwYitH5A81vA/KjunQamd1UvBgj8HkxdymX5xH5PUJNkrSjpjgHcMHI8i4VDtOvuUGLChZgrxNtPfRQYDXXBbAVZi2s0ZdxlAREGSCaHbGzdm6FtcBSlzKnxHj+sEzIb39pwQueChihwXYYN3af0ukEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722629064; c=relaxed/simple;
	bh=sDTQDgMciX5uE0sUO8H7IyJ3dKAz3vi+zl55XhiEQzA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=VnnhtrOmeql9ZLQFAjfg2nDxwiCUITzs4Tdq4ODHrZzaP3tnoqTTGQWeB54xTy/5+zc+vfipC25er5Brv7w4crADExIJTgOabx/cP6hwag1FlcGX9lVcSeVcKBPE6Myy5idAOtgqu6k5xvOjELuRD8qTEkGJZ13+BdfZyqjmhu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 472K49hP3716136
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Aug 2024 20:04:09 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Michael Salman'" <mjsalman@pathcom.com>
Cc: <git@vger.kernel.org>
References: <3db395fe-8d32-4a33-8f16-7df95f3ff194@pathcom.com> <Zq0684YmxLqqsSRk@tapette.crustytoothpaste.net>
In-Reply-To: <Zq0684YmxLqqsSRk@tapette.crustytoothpaste.net>
Subject: RE: Merging problem
Date: Fri, 2 Aug 2024 16:04:03 -0400
Organization: Nexbridge Inc.
Message-ID: <03ed01dae517$22f7bac0$68e73040$@nexbridge.com>
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
Thread-Index: AQHYPOSmlVvo8fvUOkeonsGNOWHXegHm1fJ9sgp9NsA=

On Friday, August 2, 2024 4:01 PM, brian m. carlson wrote:
>On 2024-08-02 at 18:41:48, Michael Salman wrote:
>> I am new to using git and I encountered the following problem
>>
>> 1) Created a repository using Notepad added a file (FileA.txt). Put
>> one line of text in the file. Did a git commit -a. so far so good.
>>
>> 2) I created a branch (my-branch), did a git checkout my-branch
>>
>> 3) Using notepad loaded FileA and changed the first line of text to
>> something else. Gave command git commit -a no problems
>>
>> 4) Git checkout master looked at FileA nothing changed
>>
>> 5) Did a git merge my-branch. No conflict reported
>>
>> 6) Loaded FileA in master the text of the first line had changed to
>> what is in FileA from the branch
>>
>> Your help with this problem would be appreciated. I hope this is not
>> due to my lack of understanding
>
>Let me provide a small shell script that reproduces your report so we =
can make sure
>we're on the same page.  Here it is:
>
>----
>#!/bin/sh -e
>
>dir=3D"$(mktemp -d)"
>trap 'rm -fr "$dir"' EXIT
>
>cd "$dir"
>git init -b master
>echo "step 1" >FileA.txt
>git add .
>git commit -m 'step 1'
>git checkout -b my-branch
>echo "step 2" >FileA.txt
>git add .
>git commit -m 'step 2'
>git checkout master
>git merge my-branch
>----
>
>Now, let's look at what happens if we add `git log --graph --all =
--decorate` to the end
>of the script:
>
>----
>* commit 4dd858b4e2b96ec24055d3a19d87e2080c4f1393 (HEAD -> master, my-
>branch)
>| Author: brian m. carlson <sandals@crustytoothpaste.net>
>| Date:   Fri Aug 2 19:51:42 2024 +0000
>|
>|     step 2
>|
>* commit a1bf54082762cdcffec185d4cf6eef2c753af535
>  Author: brian m. carlson <sandals@crustytoothpaste.net>
>  Date:   Fri Aug 2 19:51:42 2024 +0000
>
>      step 1
>----
>
>What's happened here is that the commits on `my-branch` are a strict =
superset of
>the commits on `master`.  That is, `master` is an ancestor, and there =
are only new
>commits in `my-branch`.  When that happens, Git does what's called a =
fast-forward
>by default, and simply updates `master` to `my-branch` without even =
invoking the
>merge algorithm.
>That's why the contents of the branch are those of `my-branch`.
>
>The reason that Git does that is that it's much more efficient and =
produces the same
>results as actually doing a merge.  When Git does a three-way merge =
(which is the
>default behaviour), it only really considers three points in the merge: =
the two heads
>(in this case, `master` and `my-branch`), and the _merge base_, which =
is usually the
>most recent common ancestor.
>
>When it does a merge, Git determines if there is a change in a =
particular file between
>the merge base and each of the heads (not considering intermediate =
commits).  If
>one side has a change and the other does not, Git adopts that change, =
regardless of
>what happened in in between.  For this reason, you can see that the =
merge base is
>the old version of `master`, and that's also one of the heads, while =
the other one is
>`my-branch`.  So one side never has any changes because its the same =
commit, and
>the other side may have changes or not, so it's safe to just update the =
branch
>pointer to the new commit.
>
>Note that you can merge with `git merge --no-ff my-branch`, which will =
do a merge,
>create a merge commit, and avoid the fast forward, but the result is =
the same, as
>mentioned above.
>
>So I think this is working as intended.

Another option, from my own bag of tricks, is to use git merge --squash =
for this activity.
This collapses your branch into a single commit and applies it to =
master. This is done
for simplification of history. It may not be appropriate for everyone (I =
have a list of
reasons why not, if interested).

Regards,
Randall

