From: Kevin Green <Kevin.T.Green@morganstanley.com>
Subject: rename/copy detection not working for git-log?
Date: Tue, 11 Aug 2009 09:21:44 -0400
Message-ID: <20090811132144.GJ6327@morganstanley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 15:32:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MarSK-0001WU-KY
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 15:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477AbZHKNbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 09:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753394AbZHKNbt
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 09:31:49 -0400
Received: from hqmtaint01.ms.com ([205.228.53.68]:44164 "EHLO
	hqmtaint01.ms.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbZHKNbt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 09:31:49 -0400
X-Greylist: delayed 603 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Aug 2009 09:31:48 EDT
Received: from hqmtaint01 (localhost.ms.com [127.0.0.1])
	by hqmtaint01.ms.com (output Postfix) with ESMTP id 5663988C355
	for <git@vger.kernel.org>; Tue, 11 Aug 2009 09:21:45 -0400 (EDT)
Received: from ny0031as02 (unknown [170.74.93.53])
	by hqmtaint01.ms.com (internal Postfix) with ESMTP id 32501B00038
	for <git@vger.kernel.org>; Tue, 11 Aug 2009 09:21:45 -0400 (EDT)
Received: from np315c1n4 (localhost [127.0.0.1])
	by ny0031as02 (msa-out Postfix) with ESMTP id 25342E983CF;
	Tue, 11 Aug 2009 09:21:45 -0400 (EDT)
Received: from menevado.ms.com (unknown [144.203.222.190])
	(Authenticated sender: smtp/menevado)
	by ny0031as02 (msa-in Postfix) with ESMTPA id 042D2E24036;
	Tue, 11 Aug 2009 09:21:45 -0400 (EDT)
Received: by menevado.ms.com (Postfix, from userid 49008)
	id CE3D5530210; Tue, 11 Aug 2009 09:21:44 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Anti-Virus: Kaspersky Anti-Virus for MailServers 5.5.35/RELEASE, bases: 11082009 #2366800, status: clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125557>


Hi,

I'm pretty sure I've seen this working as expected at some point in the
past, but I'm now not able to get the full history of a file that's
been moved to another directory and I can't understand why.  Here's a
simple way to reproduce:

  $ git init
  Initialized empty Git repository in /var/tmp/git/.git/
  $ mkdir bin
  $ cat > bin/test.sh
  #!/bin/sh

  echo Hello, world!
  $ git add .
  $ git commit -m 'initial import'
  [master (root-commit) b9dc5be] initial import
   1 files changed, 3 insertions(+), 0 deletions(-)
    create mode 100644 bin/test.sh
  $ mkdir scripts
  $ git mv bin/test.sh scripts/test.sh
  $ git commit -m 'move bin/ to scripts/'
  [master b4c6c72] move bin/ to scripts/
   1 files changed, 0 insertions(+), 0 deletions(-)
    rename {bin => scripts}/test.sh (100%)
  $ echo 'echo Goodbye!' >> scripts/test.sh
  $ git commit -a -m 'make a change in scripts/'
  [master 59830d5] make a change in scripts/
   1 files changed, 1 insertions(+), 0 deletions(-)


This now has full history of:

  $ git log --pretty=oneline
  59830d59f6b4d48b28f2ae8d51e921a9c8842b06 make a change in scripts/
  b4c6c72c548a1c17550c01350beede235d481aa4 move bin/ to scripts/
  b9dc5be440d2c843554e9b0302435d9a6f78cd65 initial import 

and the history of scripts/test.sh is as I expect:

  $ git log --pretty=oneline -- scripts/test.sh
  59830d59f6b4d48b28f2ae8d51e921a9c8842b06 make a change in scripts/
  b4c6c72c548a1c17550c01350beede235d481aa4 move bin/ to scripts/

and the history of bin/test.sh is as I would expect:

  $ git log --pretty=oneline -- bin/test.sh
  b4c6c72c548a1c17550c01350beede235d481aa4 move bin/ to scripts/
  b9dc5be440d2c843554e9b0302435d9a6f78cd65 initial import


But, I would expect that some combination of -M and -C would find me
the full history of the current test.sh script so I could see what
happened to it before it was moved.  (Okay, the example above is not so
interesting, but in the real world, bin/test.sh would have had lots of
commits before moving):

  $ git log --pretty=oneline -M -C -C -- scripts/test.sh
  59830d59f6b4d48b28f2ae8d51e921a9c8842b06 make a change in scripts/
  b4c6c72c548a1c17550c01350beede235d481aa4 move bin/ to scripts/

git-blame seems to get this right:

  $ git blame scripts/test.sh
  ^b9dc5be bin/test.sh     (Kevin Green 2009-08-11 09:07:06 -0400 1) #!/bin/sh
  ^b9dc5be bin/test.sh     (Kevin Green 2009-08-11 09:07:06 -0400 2)
  ^b9dc5be bin/test.sh     (Kevin Green 2009-08-11 09:07:06 -0400 3) echo Hello, world!
  59830d59 scripts/test.sh (Kevin Green 2009-08-11 09:08:29 -0400 4) echo Goodbye!


What am I missing?


Thanks

--Kevin
