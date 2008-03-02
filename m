From: Tim Stoakes <tim@stoakes.net>
Subject: `git svn dcommit` segfault
Date: Sun, 2 Mar 2008 15:50:35 +1030
Message-ID: <20080302052034.GE9577@mail.stoakes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 06:21:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVgdC-0006tr-Hi
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 06:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbYCBFU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 00:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbYCBFU0
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 00:20:26 -0500
Received: from hosted02.westnet.com.au ([203.10.1.213]:37895 "EHLO
	hosted02.westnet.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbYCBFUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 00:20:25 -0500
Received: from hosted02.westnet.com.au (hosted02.westnet.com.au [127.0.0.1])
	by hosted02.westnet.com.au (Postfix) with SMTP id 12D7E49989
	for <git@vger.kernel.org>; Sun,  2 Mar 2008 14:20:23 +0900 (WST)
Received: from mail.stoakes.net (dsl-202-173-137-105.sa.westnet.com.au [202.173.137.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hosted02.westnet.com.au (Postfix) with ESMTP id 7762949A92
	for <git@vger.kernel.org>; Sun,  2 Mar 2008 14:20:21 +0900 (WST)
Received: from noodle.stoakes.net (unknown [192.168.20.209])
	by mail.stoakes.net (Postfix) with ESMTP id 9E4A628C006
	for <git@vger.kernel.org>; Sun,  2 Mar 2008 15:50:20 +1030 (CST)
Received: by noodle.stoakes.net (Postfix, from userid 1000)
	id 5E1CC7F01D; Sun,  2 Mar 2008 15:50:35 +1030 (CST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-PMX-Branch: TNG-Outgoing
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75721>

Hi all,

I've been using git-svn on this repository for a while now, and all has
been well. However, this time it segfaulted in the middle of a dcommit
(4 commits into about 15). I've had to sanitise the file names, as this
is a commercial project.

$ git svn dcommit
...
        M       <snip_file>
Committed r164
        M       <snip_file>
r164 = 72ff1bf62f9b3828efb93d1b2681d154e960b8a2 (git-svn)
No changes between current HEAD and refs/remotes/git-svn
Resetting to the latest refs/remotes/git-svn
<snip_file>: needs update
<snip_file>: needs update
<snip_file>: needs update
<snip_file>: needs update
<snip_file>: needs update
<snip_file>: needs update
<snip_file>: needs update
<snip_file>: needs update
<snip_file>: needs update
<snip_file>: needs update
<snip_file>: needs update
<snip_file>: needs update
<snip_file>: needs update
Segmentation fault

It was git-svn that segfaulted I assume, not any git commands it calls,
because I see this in my syslog:
git-svn[27348]: segfault at 18 rip 2b9bc87e17e3 rsp 7fffe6ed04f0 error 4


And now I have a dirty checkout:
$ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   <snip_file>
#       modified:   <snip_file>
#       modified:   <snip_file>
#       modified:   <snip_file>
#       modified:   <snip_file>
#       modified:   <snip_file>
#       modified:   <snip_file>
#       modified:   <snip_file>
#       modified:   <snip_file>
#       modified:   <snip_file>
#       modified:   <snip_file>
#       modified:   <snip_file>
#       modified:   <snip_file>
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#           <snip_file>
#           <snip_file>
#           <snip_file>
#           <snip_file>
#           <snip_file>
#           <snip_file>
#           <snip_file>
no changes added to commit (use "git add" and/or "git commit -a")

It *looks* as if this dirty state is the sum total of the outstanding
commits, so I don't think I've lost my work, only my history of that
work.


`git log` shows up to r164, the last one before the segfault.


I can't run dcommit again, because my checkout is now dirty:
$ git svn dcommit
Cannot dcommit with a dirty index.  Commit your changes first, or stash
them with `git stash'.


fsck shows some dangling entries:
$ git fsck
dangling blob 6d806e5c5dc0bfcbae3511a37695e58ae0e0c527
dangling tree d8603f524dbb9d2c4a76fe5b2c147c1140daf808
dangling tree 93027419e21371bb94e488ab6dec085147622ffa
dangling blob 0155d5f782e77a77a70b2fd7835cd84bd0bfb829
dangling tree 05164a3f07b46d0e2cf700688e3484229beb31b4
dangling blob 0db60b87c33d0cdfdabfd24028dbb1185caabc4f
dangling tree 74560de127259a16519dc69b10aace3e167c0150
dangling blob 23e81c44b8325f976146072f061b97c015006d3b
dangling tree f72af1a9c583c560b17668a0417a8d653a5110df
dangling blob 44cc9844484fd072f98d4ac0f6e395a57c5d9277


I'd re-run it to get a core file, but I don't know how to get myself
back into the initial state.

I'm using 'git version 1.5.4.3', and 'svn, version 1.4.6 (r28521)' on
the client. The server is 'svn, version 1.3.1 (r19032)', I think.

I'm a bit stuck! Any help is much appreciated. Would any other
information be useful?

Thanks
Tim

-- 
Tim Stoakes
