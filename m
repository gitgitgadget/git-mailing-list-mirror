Received: from ambassador.madduck.net (ambassador.madduck.net [188.174.253.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D49C19E982
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.174.253.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733307822; cv=none; b=Ul11pDAAxSN13XjqOxMfjArpaN24+Sn5bnemPJ3GgPGIa4ACa4AD7AJp/SlYqFRChJPFgHvflLgktYZfecImOV3YrCZGYrejOYkRh4HetuL0HkuDza7AZcxUpMLfFXpu1AHbGwNEySq7UJSEN0goZlnrMa8fmlVpRx6pzA5gIMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733307822; c=relaxed/simple;
	bh=iXjoiTdOyvsgJzC0PC4zmqv7PM71SO5sNHyXEhGgzRU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JnMqodBsTun6VHq36rRrRrNyidh8Jaapml5St6Yk+0Yr1oY3ehxW7v9YuktuGAUrYigCsINRYecde7fQMN8OcsayK+Ek8iIIsg3MZE+Iq0YDzqpCi4lL/ud6NubpP66/YLbYZSU87x0IoyoSc3HhAHU3PBH3AzUwNThOvcNrHJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=madduck.net; spf=pass smtp.mailfrom=madduck.net; dkim=pass (1024-bit key) header.d=madduck.net header.i=@madduck.net header.b=TQX2Cr6Q; arc=none smtp.client-ip=188.174.253.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=madduck.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=madduck.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=madduck.net header.i=@madduck.net header.b="TQX2Cr6Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=madduck.net;
	s=2015-11-14; t=1733307816;
	bh=iXjoiTdOyvsgJzC0PC4zmqv7PM71SO5sNHyXEhGgzRU=;
	h=Date:From:To:Subject:From;
	b=TQX2Cr6QYybezG+YyqjEzTW2Us+y+nPFS/3Y01t4Si2UnjGLyLwg8/p1nyY1I/jtI
	 9Mc/qRYXQPvRiT4Y8uIChR035WllHnILwgudHartGHJE92FONCl77t+ltAxyqSOaqi
	 M1jEwiNmvqGeOL41BPO+oNgW2636FgiwYDF92XVI=
X-MadduckNet-Submission: from albatross.fo.krafftwerk.de (host-80-81-19-185.customer.m-online.net [80.81.19.185]); Creds Client CN "albatross.fo.krafftwerk.de", Issuer "E5" (not verified)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.7 at ambassador.madduck.net
Date: Wed, 4 Dec 2024 11:23:36 +0100
From: martin f krafft <madduck@madduck.net>
To: git@vger.kernel.org
Subject: git-daemon not consulting ~/.gitconfig
Message-ID: <fj5vgwmc5wtyzcxxnmcgw7whclm6qf7p5sxzh3nbao3feyutj6@daizbooxk22j>
X-OS: Debian GNU/Linux trixie/sid kernel 6.11.9-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Description: Plain-text version
Content-Disposition: inline

Hello,

I found that git-daemon stopped serving repositories managed by 
gitolite, i.e. by a different Unix user. Hence, no big surprise that 
I would get

```
git-daemon[3126249]: detected dubious ownership in repository at '/srv/git/repositories/madduck/pub/etc/ssh.git'
                      To add an exception for this directory, call:
                      git config --global --add safe.directory /srv/git/repositories/madduck/pub/etc/ssh.git
```

in the logs. However, adding the config to `~gitdaemon/.gitconfig` 
did not have the desired effect. Neither did adding it to 
`~root/.gitconfig` and only `/etc/gitconfig` works.

So I checked `strace` and found that when invoked by `git-daemon`, 
Git doesn't even consult `~/.gitconfig`, and I think this may be a 
bug.

Here is the relevant strace for an access to git-daemon that 
triggers the above
error:

```
root@alan:~# strace -fp 3146653 -e file 2>&1 | grep config
[pid 3154713] access("/etc/gitconfig", R_OK) = 0
[pid 3154713] openat(AT_FDCWD, "/etc/gitconfig", O_RDONLY) = 3
[pid 3154713] access("/etc/gitconfig", R_OK) = 0
[pid 3154713] openat(AT_FDCWD, "/etc/gitconfig", O_RDONLY) = 4
[pid 3154713] openat(AT_FDCWD, "./config", O_RDONLY) = 4
[pid 3154713] access("/etc/gitconfig", R_OK) = 0
[pid 3154713] openat(AT_FDCWD, "/etc/gitconfig", O_RDONLY) = 4
[pid 3154713] access("config", R_OK)    = 0
[pid 3154713] openat(AT_FDCWD, "config", O_RDONLY) = 4
[pid 3154714] access("/etc/gitconfig", R_OK) = 0
[pid 3154714] openat(AT_FDCWD, "/etc/gitconfig", O_RDONLY) = 3
[pid 3154714] access("/etc/gitconfig", R_OK) = 0
[pid 3154714] openat(AT_FDCWD, "/etc/gitconfig", O_RDONLY) = 3
[pid 3154714] openat(AT_FDCWD, "./config", O_RDONLY) = 3
[pid 3154714] access("/etc/gitconfig", R_OK) = 0
[pid 3154714] openat(AT_FDCWD, "/etc/gitconfig", O_RDONLY) = 3
[pid 3154714] access("config", R_OK)    = 0
[pid 3154714] openat(AT_FDCWD, "config", O_RDONLY) = 3
```

[System Info]
git version:
git version 2.39.5
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.1.0-28-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.119-1 (2024-11-22) x86_64
compiler info: gnuc: 12.2
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /bin/bash


-- 
martin krafft | https://matrix.to/#/#madduck:madduck.net
 
officer, arrest that man! he's whistling a copyrighted song.
{: .blockquote }
 
spamtraps: madduck.bogus@madduck.net
{: .hidden }

