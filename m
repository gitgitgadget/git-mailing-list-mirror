From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [RFC] Zit (v2): the git-based single file content tracker
Date: Thu, 23 Oct 2008 19:22:48 +0200
Message-ID: <gdqbta$rhe$1@ger.gmane.org>
References: <gdok16$vh2$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 23 19:24:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt3v6-0004wB-8V
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 19:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbYJWRXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 13:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbYJWRXH
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 13:23:07 -0400
Received: from main.gmane.org ([80.91.229.2]:45272 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750841AbYJWRXF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 13:23:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kt3th-00053M-6q
	for git@vger.kernel.org; Thu, 23 Oct 2008 17:22:57 +0000
Received: from 94.37.30.171 ([94.37.30.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Oct 2008 17:22:57 +0000
Received: from giuseppe.bilotta by 94.37.30.171 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Oct 2008 17:22:57 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 94.37.30.171
User-Agent: KNode/0.10.9
X-Face: ::w9}R^l{WGM\{y)C0QF@4^U,',W3Mk^X0HP)=:bKM^Z]A9+6bY6fe3}O*]fH{l<j1/9RTp  `KR0idy]Im#9^%}P5Dga'>AViT_'?&>&ufo2_X5Vs3C^tPO@drZRuu&6iK}x}~9`F\-dNZ>(p|V7`4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98977>

I decided to give the simpler GIT_DIR approach another go.

The reworked Zit ( git://git.oblomov.eu/zit ) works by creating
.file.git/ to track file's history. .file.git/info/excludes is
initialized to the very strong '*' pattern to ensure that things such
as git status etc only consider the actually tracked file.

The obvious advantage over the previous implementation is that we
don't rely on fragile and non-portable hardlinks. The disadvantage
is that something really bad can happen if a command fails to obey
GIT_DIR or GIT_WORK_TREE correctly.

Command delegation is made a little smarter:

zit somecommand file [args...]

gets delegated to

git somecommand [args...]

with GIT_DIR=.file.git and GIT_WORK_TREE="`pwd`", which works
surprisingly well. To prevent stupid expressions such as zit add file
file or zit commit file file, add and commit put the filename back at
the end of the parameter list.

Commands that seem to work correctly so far are init, add, log,
status, diff, remote, push, pull, and even rebase -i.

Commands that definitely need some work are rm (should it just remove
the .file.git/ dir?) and mv (hairy: we would need to rename .file.git
to .newname.git too, but rollbacks are likely to break things).

The only new command introduced by zit is zit list, which lists all
zit-tracked files in the current directory, currently in a very
braindead way (e.g. I'd like it to display the proper status, such as
C M or whatever; suggestions welcome).

On the TODO list is also some smart way to guess which file we're
talking about when no file is specified. Basically, the idea is to
check if there's only one tracked file, or only one changed tracked
file, and allow a missing file option in that case.

As usual, comments suggestions and critiques welcome.

-- 
Giuseppe "Oblomov" Bilotta
