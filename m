From: Paul Grayson <pdg@alum.mit.edu>
Subject: uncommitted changes in a renamed directory are clobbered on merge
Date: Wed, 9 Nov 2011 21:28:59 -0800
Message-ID: <CAFk1Bv98FR3a=DyhoEjRDv-Eh5iwoJSe-ZxKPDxcQbv3q7E=0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 06:29:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RONCI-0004D7-Iz
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 06:29:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933767Ab1KJF3C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 00:29:02 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48423 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933648Ab1KJF3A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 00:29:00 -0500
Received: by iage36 with SMTP id e36so2509266iag.19
        for <git@vger.kernel.org>; Wed, 09 Nov 2011 21:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=y/AxKbSbNb0VmQANV/Tt32A6397t2wgqRQy40Byt8XY=;
        b=OHK51iBkIQW3LG2iFeApjTzchmFFwDVKDV4IF48PnGH6GQk/1WMHrI/hwPYYukHASu
         A+dMSAmX7oPe2qs6x41pTeiz1OVTSQNNPr9KazFsb9P+LSR03XBh2xQfDKX7WXKCzSup
         W1qAo48wmpMV0pYBHhXfvliSkuqtUHWLLLLeE=
Received: by 10.42.158.9 with SMTP id f9mr6068021icx.31.1320902939578; Wed, 09
 Nov 2011 21:28:59 -0800 (PST)
Received: by 10.43.43.195 with HTTP; Wed, 9 Nov 2011 21:28:59 -0800 (PST)
X-Google-Sender-Auth: 9Q5x9Jcsj873LBjg8hF4NbUrLfc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185187>

Hello,

While merging with uncommitted changes is strongly discouraged, Git
generally tries to not overwrite your work without warning.  However,
there are some situations where Git silently erases uncommitted
changes.  Specifically, it seems that if you rename a directory on one
branch, make uncommitted changes to files within that branch, then
merge in another branch, files that would conflict get replaced by the
version on the other branch.  We have observed this on Git versions
1.7.5.4 and 1.7.7.3.

I have placed a script demonstrating this problem at
https://gist.github.com/1354160

Here is a shell transcript showing what it looks like:

gitbug$ git init single
Initialized empty Git repository in /home/paul/gitprojects/gitbug/single/.git/
gitbug$ cd single/
gitbug/single$ mkdir test
gitbug/single$ echo "hi" > test/test.txt
gitbug/single$ git add .
gitbug/single$ git commit -am "initial revision"
[master (root-commit) 8be9a1e] initial revision
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 test/test.txt
gitbug/single$ git checkout -b branch1
Switched to a new branch 'branch1'
gitbug/single$ git mv test/ test2
gitbug/single$ git commit -am "renamed test to test2"
[branch1 80d497c] renamed test to test2
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename {test => test2}/test.txt (100%)
gitbug/single$ git checkout master
Switched to branch 'master'
gitbug/single$ echo "change on master" >> test/test.txt
gitbug/single$ git commit -am "made a change on master"
[master 51d3a75] made a change on master
 1 files changed, 1 insertions(+), 0 deletions(-)
gitbug/single$ git checkout branch1
Switched to branch 'branch1'
gitbug/single$ echo "change on branch1" >> test2/test.txt
gitbug/single$ git merge master
Auto-merging test2/test.txt
Merge made by recursive.
 test2/test.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
gitbug/single$ cat test2/test.txt
hi
change on master
gitbug/single$

I expected the merge to fail as it usually does when there is a
conflict with uncommitted changes.  Instead, it silently deleted the
changes in test.txt.

One of our developers just lost a few hours of work to this bug.  Please fix!

Sincerely,
Paul Grayson
