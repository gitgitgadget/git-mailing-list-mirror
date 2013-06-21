From: Yann Droneaud <ydroneaud@opteya.com>
Subject: git rebase fail with CRLF conversion
Date: Fri, 21 Jun 2013 15:41:50 +0200
Organization: OPTEYA
Message-ID: <fb20a7d711fdd218f58f1f2090b1c515@meuh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 15:41:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq1b9-0007lr-MS
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 15:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161398Ab3FUNlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 09:41:52 -0400
Received: from mx-out.ocsa-data.net ([194.36.166.37]:57044 "EHLO
	mx-out.ocsa-data.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161361Ab3FUNlv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 09:41:51 -0400
Received: from [192.168.111.12] (helo=rc.ouvaton.coop)
	by mx-out.ocsa-data.net with esmtpa (Exim - FreeBSD Rulez)
	id 1Uq1b4-000I7h-8H
	for <git@vger.kernel.org>; Fri, 21 Jun 2013 15:41:50 +0200
X-Sender: ydroneaud@opteya.com
User-Agent: Roundcube Webmail/0.8.4
X-abuse-contact: abuse@ocsa-data.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228613>

Hi (again),

Following my previous email "Tracking vendor release with Git" [1][2],
and the advice from Git users/developers, I'm trying to use 
.gitattributes
to handle CRLF/LF conversion.

I'm following advices from:

  - "Dealing with line endings"
    https://help.github.com/articles/dealing-with-line-endings

  - "Tim's Blog, Mind the End of Your Line"
    http://timclem.wordpress.com/2012/03/01/mind-the-end-of-your-line/

  - "7.2 Customizing Git - Git Attributes"
    http://git-scm.com/book/ch7-2.html

  - "gitattributes(5) Manual Page"
    https://www.kernel.org/pub/software/scm/git/docs/gitattributes.html

While testing the behavor of Git regarding CRLF handling,
I've found git rebase fail when trying to apply a commit
that's going to fix/convert CRLF to LF.

I'm using the following script:

A file with CRLF end of line (EOL) "test" is added and commited,
then a file .gitattributes is added and commited.
The .gitattributes has a single line "test text" to ask git to do
EOL conversion.
After adding this .gitattributes file, Git start complaining about
the line ending to file "test". The file is fixed and commited.

Then this branch is rebased on top of another parent.
And here come the failures:


Most of the time git rebase failed with the following error:

  ...
  First, rewinding head to replay your work on top of it...
  Applying: Commit raw
  Applying: Added git attributes
  Applying: Normalization
  Using index info to reconstruct a base tree...
  Falling back to patching base and 3-way merge...
  error: Your local changes to the following files would be overwritten 
by merge:
        test
  Please, commit your changes or stash them before you can merge.
  Aborting
  Failed to merge in the changes.
  Patch failed at 0003 Normalization
  ...


But sometime it failed with another error:

with core.safecrlf = warn:

  ...
  First, rewinding head to replay your work on top of it...
  Applying: Commit raw
  Applying: Added git attributes
  warning: CRLF will be replaced by LF in test.
  The file will have its original line endings in your working 
directory.
  Applying: Normalization
  fatal: unrecognized input
  Repository lacks necessary blobs to fall back on 3-way merge.
  Cannot fall back to three-way merge.
  Patch failed at 0003 Normalization
  ...

with core.safecrlf = true:

  ...
  First, rewinding head to replay your work on top of it...
  Applying: Commit raw
  Applying: Added git attributes
  fatal: CRLF would be replaced by LF in test.
  Applying: Normalization
  fatal: unrecognized input
  Repository lacks necessary blobs to fall back on 3-way merge.
  Cannot fall back to three-way merge.
  Patch failed at 0003 Normalization
  ...


In thoses two latter cases, running "git add" does not fail with a 
fatal error: it does nothing.
I need to run "touch test" to make "git add" fail with error "fatal: 
CRLF would be replaced by LF in test.


I believe "git rebase" should not fail here, but more, it must not fail 
in a different fashion randomly.

Please find in reply to this email:
  - a shell script to demonstrate the behavor
  - a patch to t0020-crlf.sh to add two rebase tests.

1. <1370970410-7935-1-git-send-email-ydroneaud@opteya.com>
2. <http://thread.gmane.org/gmane.comp.version-control.git/227466>
    <http://marc.info/?l=git&m=137097069115462&w=2>


Regards

-- 
Yann Droneaud
OPTEYA
