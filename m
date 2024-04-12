Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E33205E2B
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938609; cv=none; b=WYyxH7BrIpsXgpnvwArthSjl8jZhZCjtzEiQQYgTY+qeuQXLJ1qxpT047UjtfTfl992n2n9U2v4GfZqC/qHH7+F1DmixcxhpgwwuF293fqLSAufU3Eim8a2xeFXeCpxnc9SFW9HfJksbcKyhjQpNOdpA0AoSBXxbEBd4a2EC8I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938609; c=relaxed/simple;
	bh=wP37qscwHWKN9W7k0Bkgzx0l0fatTT8XZInSNsc5pB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtNQtzWtvLhGb9Gbf37KPzppC5kM88P1sPXssfg18JYsrKd88gMaK9R1vHfSCcV8XedSNJEvAcpubgYDIfLEvBcciSwEFGttP5ebR0UllrCgPsfl/pCSz1X36G0aeo9xwHRxprlViKEwXExtdhHXCJDPJvP4lDGKBV0+9SRrwlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.107])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4VGMBz5Rbyz5wFd
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 18:16:43 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4VGMBq4VGLzRnmG;
	Fri, 12 Apr 2024 18:16:35 +0200 (CEST)
Message-ID: <01cf64db-2ff5-4be5-8968-d280ab0ffc50@kdbg.org>
Date: Fri, 12 Apr 2024 18:16:35 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Clones from local repositories do not work correctly under
 Windows
Content-Language: en-US
To: "L. E. Segovia" <amy@amyspark.me>
Cc: git@vger.kernel.org
References: <44020a6a-707f-4505-adde-e79cda63d711@amyspark.me>
 <2f069d1f-aa4a-4259-9cc5-dcf912f59a17@kdbg.org>
 <e25bbce7-8338-430b-865f-690fe3c94fb6@amyspark.me>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <e25bbce7-8338-430b-865f-690fe3c94fb6@amyspark.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 12.04.24 um 15:05 schrieb L. E. Segovia:
> Under a MSYS2 shell, follow these steps (feel free to replace the choice
> of remote repo with any other supporting a Rust crate):
> 
> 1. `cd` to a directory of your choice (let's call it `dirA`).
> 2. `git clone https://gitlab.gnome.org/GNOME/librsvg.git .`
> 3. `git checkout -b cerbero_build`.
> 4. `cd ..`
> 5. `git clone <full path to dirA> -s -b cerbero_build dirB`
> 6. `cd dirB`
> 7. `git status`
> 
> Now switch to any other shell of your choice, such as Git Bash, CMD, or
> PowerShell, and try issuing commands such as `git status`. It will
> result in a wall of "error: unable to normalize..."

Thanks, that is much more helpful. Here are my assumption, my
explanation of the symptoms, and the conclusion (which is basically "if
it hurts, don't do it"):

I assume that you have two installations of Git. One installation is
used when you use the git command from the MSYS2 shell; it is the MSYS2
version. The other installation is Git for Windows or equivalent that is
used by all the other shells.

When you clone a repository with -s, a .git/objects/info/alternates file
is initialized that contains the path to the original repository. You
can see its contents with `git count-objects -v`. I tested the
reproduction recipe with my own build (which is a MinGW build, much like
Git for Windows), and it looks like this:

C:\Temp\repoclone>git count-objects -v
count: 0
size: 0
in-pack: 0
packs: 0
size-pack: 0
prune-packable: 0
garbage: 0
size-garbage: 0
alternate: C:/Temp/repoorig/.git/objects

See the last line? It begins with a drive letter. When you call the
command with the MSYS2 version, it will look more like this:

alternate: /c/Temp/repoorig/.git/objects

This is the MSYS2/Cygwin absolute path with a "drive letter".
Unfortunately, this kind of path is unintelligible for Git for Windows.
It expects absolute paths to begin with drive letter-colon or a
double-slash or double-backslash. For this reason, it reports "unable to
normalize alternate object path".

The conclusion is: Do not use two different flavors of Git on a
repository that is set up with a link to an alternate repository.

BTW, I did not do the followup test with `git am`. (Actually, I did, but
there were no errors.) So, I cannot tell why your MSYS2 version suddenly
also reports the "unable to normalize" error.

-- Hannes

