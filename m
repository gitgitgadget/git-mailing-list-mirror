From: Ron Garret <ron1@flownet.com>
Subject: git-mv redux: there must be something else going on
Date: Wed, 03 Feb 2010 10:25:54 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-32BD5F.10255403022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 19:26:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncjvr-0005F0-SS
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 19:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756079Ab0BCS00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 13:26:26 -0500
Received: from lo.gmane.org ([80.91.229.12]:55240 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754272Ab0BCS0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 13:26:25 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ncjvj-00059E-GG
	for git@vger.kernel.org; Wed, 03 Feb 2010 19:26:23 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 19:26:23 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 19:26:23 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138856>

Based on my current understanding of git there should be no difference 
between a git mv and a git rm followed by a git add.  But empirically 
there is a difference.  git log --M --follow is able to track files 
through git mvs even if their content changes completely.  Likewise, it 
does *not* track files through rm/add combinations even if the content 
didn't change at all.  (See experiment transcript below.)

So something in my understanding of how git works must be wrong.  Git 
must be keeping a separate record of file renames somewhere.  But where?

Just for the record, I'm not complaining about this behavior.  In fact, 
what git does is exactly what I want.  I just want to understand how it 
works.

Thanks,
rg


---

[ron@mickey:~/devel/gittest]$ cat>file1
1
2
3
4
5
[ron@mickey:~/devel/gittest]$ cat>file2
a
b
c
d
e
[ron@mickey:~/devel/gittest]$ git init
Initialized empty Git repository in /Users/ron/devel/gittest/.git/
[ron@mickey:~/devel/gittest]$ git add file1
[ron@mickey:~/devel/gittest]$ git commit -m 'Add numbers'
[master (root-commit) 54c2e4a] Add numbers
 1 files changed, 5 insertions(+), 0 deletions(-)
 create mode 100644 file1
[ron@mickey:~/devel/gittest]$ git rm file1
rm 'file1'
[ron@mickey:~/devel/gittest]$ git add file2
[ron@mickey:~/devel/gittest]$ git commit -m 'numbers->letters'
[master fe05d12] numbers->letters
 2 files changed, 5 insertions(+), 5 deletions(-)
 delete mode 100644 file1
 create mode 100644 file2
[ron@mickey:~/devel/gittest]$ git log --name-status -M --follow file2
commit fe05d1233be1bb11f4ed0e8496e4191795d515a0
Author: rongarret <ron@mickey>
Date:   Wed Feb 3 10:13:38 2010 -0800

   numbers->letters

A       file2
[ron@mickey:~/devel/gittest]$ ls
file2 git/
[ron@mickey:~/devel/gittest]$ cat>file2
6
7
8
9
10
[ron@mickey:~/devel/gittest]$ git mv file2 file3
[ron@mickey:~/devel/gittest]$ git commit -m 'letters->numbers'
[master ae3f6d4] letters->numbers
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename file2 => file3 (100%)
[ron@mickey:~/devel/gittest]$ git log --name-status -M --follow file3
commit ae3f6d440483fa41cf08819237e87d567ac3a31d
Author: rongarret <ron@mickey>
Date:   Wed Feb 3 10:15:00 2010 -0800

    letters->numbers

R100    file2   file3

commit fe05d1233be1bb11f4ed0e8496e4191795d515a0
Author: rongarret <ron@mickey>
Date:   Wed Feb 3 10:13:38 2010 -0800

   numbers->letters

A       file2
[ron@mickey:~/devel/gittest]$ ls
file3 git/
[ron@mickey:~/devel/gittest]$ mv file3 file4
[ron@mickey:~/devel/gittest]$ git rm file3
rm 'file3'
[ron@mickey:~/devel/gittest]$ git add file4
[ron@mickey:~/devel/gittest]$ git commit -m 'rm/add identical content'
[master a3d7227] rm/add identical content
 2 files changed, 5 insertions(+), 5 deletions(-)
 delete mode 100644 file3
 create mode 100644 file4
[ron@mickey:~/devel/gittest]$ git log --name-status -M --follow file4
commit a3d7227fc2edca75fff8894acd5b077d1788bb36
Author: rongarret <ron@mickey>
Date:   Wed Feb 3 10:17:23 2010 -0800

    rm/add identical content

A       file4
[ron@mickey:~/devel/gittest]$
