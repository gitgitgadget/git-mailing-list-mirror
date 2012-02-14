From: =?ISO-8859-1?Q?Laurent_Charri=E8re?= <lcharriere@promptu.com>
Subject: git-p4 useclientspec broken?
Date: Mon, 13 Feb 2012 16:47:00 -0800
Message-ID: <4F39AF04.5080607@promptu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 02:17:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx711-0001Xd-OZ
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 02:17:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757576Ab2BNBRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 20:17:03 -0500
Received: from moat.promptu.com ([209.234.175.58]:53114 "EHLO
	pacman.mp.promptu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751445Ab2BNBRB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 20:17:01 -0500
X-Greylist: delayed 1800 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Feb 2012 20:17:01 EST
Received: from [192.168.0.95] (malibu.mp.promptu.com [192.168.0.95])
	by pacman.mp.promptu.com (Postfix) with ESMTP id F017820185
	for <git@vger.kernel.org>; Mon, 13 Feb 2012 16:47:00 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190695>

Since I've upgraded to 1.7.9 (on OS X Lion, FWIW), git-p4 submit fails 
to apply any patches if I use useclientspec=true when cloning.

My p4 client is as follows:

Client:	malibu
(...)
Root:	/Users/lcharriere/Documents/Perforce/all
(...)
View:
	//sandbox/... //malibu/sandbox/...
	//depot/... //malibu/depot/...

Sequence of steps to reproduce:

$ git p4 clone //sandbox/lcharriere/foo --use-client-spec
$ cd foo && find .
./.git
(...)
./sandbox/lcharriere/foo/.gitignore
./sandbox/lcharriere/foo/foo.py

-- This is new behavior to me, BTW. Previously, I would have seen
./.git
(...)
./.gitignore
./foo.py

$ cat "test" >> sandbox/lcharriere/foo/.gitignore
$ git commit -a -m "test"
git commit -a -m "test"
[master 7398144] test
  1 files changed, 1 insertions(+), 0 deletions(-)
$ git p4 submit
Perforce checkout for depot path //sandbox/lcharriere/foo/ located at 
/Users/lcharriere/Documents/Perforce/all/sandbox/lcharriere/foo/
Synchronizing p4 checkout...
... - file(s) up-to-date.
Applying 739814457a8faa84dc0bddd830f671569576b177 test

sandbox/lcharriere/foo/.gitignore - file(s) not on client.
error: sandbox/lcharriere/foo/.gitignore: No such file or directory
Unfortunately applying the change failed!
What do you want to do?
[s]kip this patch / [a]pply the patch forcibly and with .rej files / 
[w]rite the patch to a file (patch.txt)


I tried to follow what's going on with pdb:
* self.depotPath is //sandbox/lcharriere/foo, so git-p4 chdir's to 
/Users/lcharriere/Documents/Perforce/all/sandbox/lcharriere/foo/
* In P4Submit.applyCommit, line 926 is:
p4_edit(path)
At this point path is 'sandbox/lcharriere/foo/.gitignore'

I'm guessing this is why the p4 executable doesn't find it. The path 
should be .gitignore. Is it possible that the new behavior I mentioned 
above of reproducing the depot hierarchy when useclientspec is true is 
having unintended side effects, or is a bug?
