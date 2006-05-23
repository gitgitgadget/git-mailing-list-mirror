From: fork0@t-online.de (Alex Riesen)
Subject: file name case-sensitivity issues
Date: Tue, 23 May 2006 23:06:15 +0200
Message-ID: <20060523210615.GB5869@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 23 23:08:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fie7F-0002x1-Ae
	for gcvg-git@gmane.org; Tue, 23 May 2006 23:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWEWVI2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 17:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWEWVI2
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 17:08:28 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:15289 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932272AbWEWVI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 May 2006 17:08:27 -0400
Received: from fwd30.aul.t-online.de 
	by mailout10.sul.t-online.com with smtp 
	id 1Fie6p-000348-03; Tue, 23 May 2006 23:08:07 +0200
Received: from tigra.home (Gn3VBZZYQeldvmVddO6pPBZRhduCcvrYWCj3abcK-njSGgTpQxaI0q@[84.160.89.249]) by fwd30.sul.t-online.de
	with esmtp id 1Fie52-1Nlsoq0; Tue, 23 May 2006 23:06:16 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 5F7D3277B5;
	Tue, 23 May 2006 23:06:15 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1Fie51-0005mS-8B; Tue, 23 May 2006 23:06:15 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-ID: Gn3VBZZYQeldvmVddO6pPBZRhduCcvrYWCj3abcK-njSGgTpQxaI0q
X-TOI-MSGID: a5a659bf-1ead-497f-9385-b1192da79569
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20638>

Very simple to reproduce on FAT and NTFS, and under Windows, as usual,
when a problem is especially annoying. I seem to have no chance to
get my hands on this myself, so I at least let everyone know about the
problem.

The case goes as follows:

  $ mkdir case-sensitivity-test
  $ cd case-sensitivity-test
  $ git init-db
  defaulting to local storage area
  $ echo foo > foo
  $ echo bar > bar
  $ git add foo bar
  $ git commit -m initial\ commit
  Committing initial tree 89ff1a2aefcbff0f09197f0fd8beeb19a7b6e51c
  $ git checkout -b side
  $ echo bar-side >> bar
  $ git commit -m side\ commit -o bar
  $ git checkout master
  $ rm foo
  $ git update-index --remove foo
  $ echo FOO > FOO # note case change
  $ git add FOO
# this is on linux, vfat  on an usbstick (mounted with default case
# conversion, which is "lower". That's why the file can't be found).
# Have no Windows at home. On Windows the FOO is created and "git add"
# just passes. We just assume it did add the file, as it would there.
  git-ls-files: error: pathspec 'FOO' did not match any.
  Maybe you misspelled it?
  $ git commit -m case\ change
  $ git pull . side
  Trying really trivial in-index merge...
  git-read-tree: fatal: Untracked working tree file 'foo' would be overwritten by merge.
  Nope. Really trivial in-index merge is not possible.
  Merging HEAD with 7b0cad3a104487fa92afa06736294338acb84281
  Merging:
  7f6a8ba3e41683ef5b55921d050092e766aad4a5 case change
  7b0cad3a104487fa92afa06736294338acb84281 side commit
  found 1 common ancestor(s):
  f857aaf5f1d3716d25ca7751f12de30420d9b2aa initial commit
  git-read-tree: git-read-tree: fatal: Untracked working tree file 'foo' would be overwritten by merge.

  No merge strategy handled the merge.

Well, what now?

What I did was to replace that die() with error() in
read-tree.c:verify_absent, which if cause is not acceptable.
I'll try to find a solution sometime later, but I really hope
someone will find it sooner (because it'll take some time for me).
Hope it didn't bit anyone yet...
