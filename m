From: Luben Tuikov <ltuikov@yahoo.com>
Subject: SIGSEGV in merge recursive
Date: Fri, 29 Dec 2006 11:49:43 -0800 (PST)
Message-ID: <699806.13055.qm@web31803.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Dec 29 20:49:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0Njn-0002ws-Us
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 20:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbWL2Ttp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 14:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965129AbWL2Ttp
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 14:49:45 -0500
Received: from web31803.mail.mud.yahoo.com ([68.142.207.66]:41282 "HELO
	web31803.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965121AbWL2Tto (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Dec 2006 14:49:44 -0500
Received: (qmail 15128 invoked by uid 60001); 29 Dec 2006 19:49:43 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=GfU2hQxH9yU9Nvla/Or12zORtzLftLSAYhcsaTxVsWt8nmQDX9xcGHQeshrYs4BUZWTeNW/i0W4Iw3eme3U8UGCLXO+Mz8al/zS9q04BEgF1xtm4xytXdPHW2fIwQhvXa9LiQcZ39o4q6b0fa9JUOQK4I75bm8dO/xAqd3oMBjo=;
X-YMail-OSG: RArxWd8VM1megffZk1LXV10TJOx6LgrafEXqxpH7PIn5WhcQfDBRyOAufs1YplRw8R.th5e2MSeOgcwIFg9f7fmyUu4PchWRBfYCbJBIFslX3pF9vRvFoHK0utasJtEQN8Y5BEaRyvYk.6uu9yb9q3ZRZf5PQnMlw..bT1B4.xR.1Uve1_jC85kBj_N8
Received: from [71.84.31.238] by web31803.mail.mud.yahoo.com via HTTP; Fri, 29 Dec 2006 11:49:43 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35605>

This time it happens when merging one of my git trees into another:

$git-pull . git-upstream
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
git-merge-recursive 777f68432f1db967573e5722bf0fd08af05e748f -- HEAD
d985fdaf7a4b8b1dde313c8fad12983dc4ce20f7
Merging HEAD with d985fdaf7a4b8b1dde313c8fad12983dc4ce20f7
Merging:
52d5052 Merge branch 'git-upstream' into git-lt-work
d985fda Merge branch 'next' into git-upstream
found 1 common ancestor(s):
777f684 Merge branch 'next' into git-upstream
Auto-merging .gitignore
/home/luben/bin/git-merge: line 441:  2889 Segmentation fault      git-merge-$strategy $common --
"$head_arg" "$@"
Merge with strategy recursive failed.

(git-upstream has already had "next" merged into it without a problem.)

And here is the backtrace:

$gdb ~/bin/git-merge-recursive
GNU gdb 6.5
Copyright (C) 2006 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i686-pc-linux-gnu"...Using host libthread_db library
"/lib/libthread_db.so.1".

(gdb) run 777f68432f1db967573e5722bf0fd08af05e748f -- HEAD
d985fdaf7a4b8b1dde313c8fad12983dc4ce20f7
Starting program: /home/luben/bin/git-merge-recursive 777f68432f1db967573e5722bf0fd08af05e748f --
HEAD d985fdaf7a4b8b1dde313c8fad12983dc4ce20f7
Failed to read a valid object file image from memory.
Merging HEAD with d985fdaf7a4b8b1dde313c8fad12983dc4ce20f7
Merging:
52d5052 Merge branch 'git-upstream' into git-lt-work
d985fda Merge branch 'next' into git-upstream
found 1 common ancestor(s):
777f684 Merge branch 'next' into git-upstream
Auto-merging .gitignore

Program received signal SIGSEGV, Segmentation fault.
0x08070469 in xdl_merge (orig=0xbff3aae0, mf1=0xbff3aad8, 
    name1=0x80f5208 "HEAD:.gitignore", mf2=0xbff3aad0, 
    name2=0x80f59a8 "d985fdaf7a4b8b1dde313c8fad12983dc4ce20f7:.gitignore", 
    xpp=0xbff3aae8, level=2, result=0xbff3aac8) at xdiff/xmerge.c:200
warning: Source file is more recent than executable.
200                      */
(gdb) bt
#0  0x08070469 in xdl_merge (orig=0xbff3aae0, mf1=0xbff3aad8, 
    name1=0x80f5208 "HEAD:.gitignore", mf2=0xbff3aad0, 
    name2=0x80f59a8 "d985fdaf7a4b8b1dde313c8fad12983dc4ce20f7:.gitignore", 
    xpp=0xbff3aae8, level=2, result=0xbff3aac8) at xdiff/xmerge.c:200
#1  0x0804a6c2 in merge_file (o=0xbff3accc, a=0xbff3ac74, b=0xbff3aca0, 
    branch1=0xbff3c928 "HEAD", 
    branch2=0xbff3c92d "d985fdaf7a4b8b1dde313c8fad12983dc4ce20f7")
    at merge-recursive.c:660
#2  0x0804c296 in merge_trees (head=0x80924c8, merge=0x80924e8, 
    common=0x8092508, branch1=<value optimized out>, 
    branch2=<value optimized out>, result=0xbff3add0) at merge-recursive.c:1067
#3  0x0804c9cd in merge (h1=0x80874c0, h2=0x8087544, 
    branch1=0xbff3c928 "HEAD", 
    branch2=0xbff3c92d "d985fdaf7a4b8b1dde313c8fad12983dc4ce20f7", 
    call_depth=0, ancestor=0x8087518, result=0xbff3ae24)
    at merge-recursive.c:1238
#4  0x0804cc78 in main (argc=3, argv=0xbff3aea4) at merge-recursive.c:1320

      Luben
