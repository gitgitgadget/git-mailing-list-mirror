From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Files not deleted when merging after a rename
Date: Wed, 23 Jan 2008 11:19:42 +0300
Message-ID: <20080123081942.GM14871@dpotapov.dyndns.org>
References: <d997e2110801211145o5fe0a1bbpb1e32dd71b70568e@mail.gmail.com> <20080121212015.GB5263@steel.home> <d997e2110801211345x6ee35d48s2038fbd773149110@mail.gmail.com> <20080122072825.GA2971@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Desnoyer <mdesnoyer@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 09:20:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHaqS-0005gs-Km
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 09:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbYAWITt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 03:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754001AbYAWITs
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 03:19:48 -0500
Received: from smtp05.mtu.ru ([62.5.255.52]:63390 "EHLO smtp05.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753667AbYAWITr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 03:19:47 -0500
Received: from smtp05.mtu.ru (localhost [127.0.0.1])
	by smtp05.mtu.ru (Postfix) with ESMTP id 57D1CA2CA71;
	Wed, 23 Jan 2008 11:19:43 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-188-241.pppoe.mtu-net.ru [85.141.188.241])
	by smtp05.mtu.ru (Postfix) with ESMTP id F3C65A2CA4C;
	Wed, 23 Jan 2008 11:19:42 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JHapi-00075F-WF; Wed, 23 Jan 2008 11:19:43 +0300
Content-Disposition: inline
In-Reply-To: <20080122072825.GA2971@steel.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp05.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71519>

On Tue, Jan 22, 2008 at 08:28:25AM +0100, Alex Riesen wrote:
> 
> Were these subdirectories containing exclusively tracked files?
> Or is it Winblows and some process was blocking the deletion?

The issue is not Windows specific and the problem can be reproduced
with different versions of Git including the latest from Git master.

In fact, user B does not have to made any changes, it is enough that
merge was not fast-forward. In contrast with fast-forward merge, which
just update the references, the recursive merge requires the working
directory to perform the merge. Because directories are not trucked,
there is no way to tell at the end whether an empty directory was
created by user before or it became empty as result of merge.

Probably, the problem can be solved by remembering the list of empty
directories before performing a real merge and then, on success, to
remove all empty directories that are not in that list.

Here is a script that demonstrates the issue.

=== CUT ===
#!/bin/sh

set -e
rm -rf shared userA userB

mkdir shared
cd shared
git init
mkdir -p foo/bar
for line in Files not deleted when merging after a rename; do
	echo $line; done > foo/bar/testfile
git add foo/bar/testfile
git commit -m 'add foo/bar/testfile'
cd ..

git clone file://$PWD/shared/.git userA
git clone file://$PWD/shared/.git userB

cd userA
git mv foo/bar bar
git commit -m 'mv foo/bar bar'
git push
cd ..

cd userB
echo 'more' >> foo/bar/testfile
git commit -a -m 'edit foo/bar/testfile'
git pull
find *

=== CUT ===
