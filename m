From: Mike Hommey <mh@glandium.org>
Subject: Small issue with rerere when one file fails to automatically merge
Date: Fri, 26 Sep 2008 07:55:52 +0200
Organization: glandium.org
Message-ID: <20080926055552.GA31063@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 26 07:57:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kj6KQ-000308-Fq
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 07:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353AbYIZF4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 01:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbYIZF4K
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 01:56:10 -0400
Received: from vuizook.err.no ([194.24.252.247]:45894 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbYIZF4I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 01:56:08 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1Kj6J7-0000EE-U9
	for git@vger.kernel.org; Fri, 26 Sep 2008 07:56:04 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1Kj6Iy-0008IU-KW
	for git@vger.kernel.org; Fri, 26 Sep 2008 07:55:52 +0200
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): Spam detection software, running on the system "vuizook.err.no", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, I recently got this issue with rerere, that can be reproduced
	with the workflow below. The problem is that rerere does its job, but fails
	to mark the files as being merged when one of the files auto merging failed.
	[...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RDNS_DYNAMIC           Delivered to trusted network by host with
	dynamic-looking rDNS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96827>

Hi,

I recently got this issue with rerere, that can be reproduced with the
workflow below. The problem is that rerere does its job, but fails
to mark the files as being merged when one of the files auto merging
failed.

I haven't taken the time to look into rerere to fix this, though.

$ git init
Initialized empty Git repository in /tmp/test/.git/
[master]$ git config rerere.enabled true
[master]$ echo a > a
[master]$ echo b > b
[master]$ git add a b
[master]$ git commit -m 1
Created initial commit fb0ebe4: 1
 2 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 a
 create mode 100644 b
[master]$ git branch foo
[master]$ git branch foo2
[master]$ echo aa > a
[master]$ echo bb > b
[master]$ git commit -a -m 2
Created commit 69f9bf3: 2
 2 files changed, 2 insertions(+), 2 deletions(-)
[master]$ git co foo
Switched to branch "foo"
[foo]$ echo ab > a
[foo]$ echo bc > b
[foo]$ git commit -a -m 3
Created commit 991c054: 3
 2 files changed, 2 insertions(+), 2 deletions(-)
[foo]$ git merge master
Auto-merging a
CONFLICT (content): Merge conflict in a
Auto-merging b
CONFLICT (content): Merge conflict in b
Recorded preimage for 'a'
Recorded preimage for 'b'
Automatic merge failed; fix conflicts and then commit the result.
[foo]$ echo aab > a
[foo]$ echo bbc > b
[foo]$ GIT_EDITOR=cat git commit -a
<snip>
Recorded resolution for 'a'.
Recorded resolution for 'b'.
Created commit 98c88e2: Merge branch 'master' into foo
[foo]$ git co foo2
Switched to branch "foo2"
[foo2]$ echo ab > a
[foo2]$ echo bd > b
[foo2]$ git commit -a -m 4
Created commit 9c65461: 4
 2 files changed, 2 insertions(+), 2 deletions(-)
[foo2]$ git merge master
Auto-merging a
CONFLICT (content): Merge conflict in a
Auto-merging b
CONFLICT (content): Merge conflict in b
Recorded preimage for 'b'
Resolved 'a' using previous resolution.
Automatic merge failed; fix conflicts and then commit the result.
[foo2]$ git status
a: needs merge
b: needs merge
# On branch foo2
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       unmerged:   a
#       unmerged:   b
#
no changes added to commit (use "git add" and/or "git commit -a")
[foo2]$ cat a
aab
[foo2]$ cat b
<<<<<<< HEAD:b
bd
=======
bb
>>>>>>> master:b

One would expect a not to be unmerged.

Mike
