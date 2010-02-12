From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Bug#569505: git-core: 'git add' corrupts repository if the
 working directory is modified as it runs
Date: Thu, 11 Feb 2010 18:27:41 -0600
Message-ID: <20100212002741.GB9883@progeny.tock>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zygo Blaxell <zblaxell@gibbs.hungrycats.org>
To: git@vger.kernel.org, 569505-forwarded@bugs.debian.org
X-From: git-owner@vger.kernel.org Fri Feb 12 01:27:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfjNu-0007sd-UJ
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 01:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757651Ab0BLA1p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 19:27:45 -0500
Received: from mail-iw0-f195.google.com ([209.85.223.195]:52191 "EHLO
	mail-iw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757348Ab0BLA1o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 19:27:44 -0500
Received: by iwn33 with SMTP id 33so2219664iwn.5
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 16:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=35QzUTfVnRb98bZ8JUEjAPYVh0jJw7PgliG62b9L3FE=;
        b=IghCggBZZ4a0ZbWL4eHhds1tcpICSff0LYfuO67bLMN5lV2D62dENMymvKxZvGtZw4
         2xIsGciJGDuHh7LRcGegWVEw+KZYg1s0Q7zvDpvCpNRsdWy5rozjb589osTQvOMxq2HR
         NyqNb9HEBlWrCCoxkpYRz7iSQa/Oob+2KccwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=idmtZihDFP2D9JiNhgsZ4kYFwdzQ5WbB7XxSab8IthD+2O/cbjOpAULlNaLFiSloGx
         TpqtHjtcLRoT+Eci1KyWTiihopjYFzzzdAUXUuTyQilLUHePUf1GcRW9aJiu9rJZA4pu
         7XHpOt0K4E/FTeFOvOkI9g/W5t5a0IISvpSx8=
Received: by 10.231.146.74 with SMTP id g10mr931535ibv.98.1265934463445;
        Thu, 11 Feb 2010 16:27:43 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm2366936iwn.2.2010.02.11.16.27.42
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 11 Feb 2010 16:27:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139648>

Hi gitsters,

Zygo Blaxell reported through http://bugs.debian.org/569505 that =E2=80=
=98git
update-index=E2=80=99 has some issues when the files it is adding chang=
e under
its feet:

My thoughts:

 - Low-hanging fruit: it should be possible for update-index to check
   the stat information to see if the file has changed between when it
   first opens it and when it finishes.

 - Zygo reported suppress that =E2=80=98git gc=E2=80=99 didn=E2=80=99t =
notice the problem.
   Should =E2=80=98git gc=E2=80=99 imply a =E2=80=98git fsck --no-full=E2=
=80=99?

 - Recovering from this kind of mistake in early history is indeed
   hard.  Any tricks for doing this?  Maybe fast-export | fast-import
   can do something with this, or maybe replace + filter-branch once
   it learns to be a little smarter.

 - How do checkout-index and cat-file blob react to a blob whose
   contents do not reflect its object name?  Are they behaving
   appropriately?  I would want cat-file blob to be able to retrieve
   such a broken blob=E2=80=99s contents, checkout-index not so much.

I imagine there are other things to learn, too.  The report and
reproduction recipe follow.

Thoughts?
Jonathan

Package: git-core
Version: 1:1.6.6.1-1
Severity: important

'git add' will happily corrupt a git repo if it is run while files in
the working directory are being modified.  A blob is added to the index
with contents that do not match its SHA1 hash.  If the index is then
committed, the corrupt blob cannot be checked out (or is checked out
with incorrect contents, depending on which tool you use to try to get
the file out of git) in the future.

Surprisingly, it's possible to clone, fetch, push, pull, and sometimes
even gc the corrupted repo several times before anyone notices the
corruption.  If the affected commit is included in a merge with history
from other git users, the only way to fix it is to rebase (or come up
with a blob whose contents match the affected SHA1 hash somehow).

It is usually possible to retrieve data committed before the corruption
by simply checking out an earlier tree in the affected branch's history=
=2E

The following shell code demonstrates this problem.  It runs a thread
which continuously modifies a file, and another thread that does
'git commit -am' and 'git fsck' in a continuous loop until corruption
is detected.  This might take up to 20 seconds on a slow machine.

	#!/bin/sh
	set -e

	# Create an empty git repo in /tmp/git-test
	rm -fr /tmp/git-test
	mkdir /tmp/git-test
	cd /tmp/git-test
	git init

	# Create a file named foo and add it to the repo
	touch foo
	git add foo

	# Thread 1:  continuously modify foo:
	while echo -n .; do
		dd if=3D/dev/urandom of=3Dfoo count=3D1024 bs=3D1k conv=3Dnotrunc >/d=
ev/null 2>&1
	done &

	# Thread 2:  loop until the repo is corrupted
	while git fsck; do
		# Note the implied 'git add' in 'commit -a'
		# It will do the same with explicit 'git add'
		git commit -a -m'Test'
	done

	# Kill thread 1, we don't need it any more
	kill $!

	# Success!  Well, sort of.
	echo Repository is corrupted.  Have a nice day.

I discovered this bug accidentally when I was using inotifywait (from
the inotify-tools package) to automatically commit snapshots of a worki=
ng
directory triggered by write events.

I tested this with a number of kernel versions from 2.6.27 to 2.6.31.
All of them reproduced this problem.  I checked this because strace
shows 'git add' doing a mmap(..., MAP_PRIVATE, ...) of its input file,
so I was wondering if there might have been a recent change in mmap()
behavior in either git or the kernel.

git 1.5.6.5 has this problem too, but some of the error messages are
different, and the problem sometimes manifests itself as silent corrupt=
ion
of other objects (e.g. if someone checks out a corrupt tree and then do=
es
'git add -u' or 'git commit -a', they will include the corrupt data in
their commit).
