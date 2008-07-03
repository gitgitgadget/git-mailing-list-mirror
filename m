From: SungHyun Nam <goweol@gmail.com>
Subject: bug found (Re: git-fast-export SIGSEGV on solaris + backtrace)
Date: Thu, 03 Jul 2008 09:59:58 +0900
Message-ID: <486C248E.4060205@gmail.com>
References: <4869B91B.9000709@posdata.co.kr>
Reply-To: namsh@posdata.co.kr
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 03 03:01:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEDCA-0003CX-1h
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 03:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbYGCBAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 21:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbYGCBAL
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 21:00:11 -0400
Received: from main.gmane.org ([80.91.229.2]:53111 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751507AbYGCBAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 21:00:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KEDB8-0007Mr-QU
	for git@vger.kernel.org; Thu, 03 Jul 2008 01:00:07 +0000
Received: from 203.238.196.197 ([203.238.196.197])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Jul 2008 01:00:06 +0000
Received: from goweol by 203.238.196.197 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Jul 2008 01:00:06 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 203.238.196.197
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <4869B91B.9000709@posdata.co.kr>
X-Stationery: 0.4.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87214>

Hello,

 From the gdb trace:

(gdb) p deco
$1 = (struct object_decoration *) 0x193150
(gdb) p idnums
$3 = {name = 0x0, size = 1500, nr = 7, hash = 0x190270}

It was 'off-by-one' error.
0x190270 + (1500 * 8) = 0x193150.

And the code says it:
         for (i = 0; i < idnums.size; ++i) {
                 deco++;
                 if (deco && deco->base && deco->base->type == 1) {

The 'deco' should be post-incremented? or
Checking code should be  (i < idnums.size - 1)?

Regards,
namsh

And very minor cleanup:

diff --git a/decorate.c b/decorate.c
index 23f6b00..d8b428c 100644
--- a/decorate.c
+++ b/decorate.c
@@ -36,7 +36,7 @@ static void *insert_decoration(struct decoration *n, 
struct o>
  static void grow_decoration(struct decoration *n)
  {
         int i;
-       int old_size = n->size;
+       int old_size;
         struct object_decoration *old_hash;

         old_size = n->size;

SungHyun Nam wrote:
> Hello,
> 
> Because recent GIT test failed on t9301-fast-export.sh, I traced
> it. And I found git-fast-export killed by SIGSEGV. I include a
> gdb backtrace below.
> If you want to me to check other things, please let me know.
> 
> Regards,
> namsh
> 
> [marks] ~/srcs/git/t/trash directory[66]$ gdb ../../git-fast-export
> GNU gdb 6.0
> Copyright 2003 Free Software Foundation, Inc.
> GDB is free software, covered by the GNU General Public License, and you 
> are
> welcome to change it and/or distribute copies of it under certain 
> conditions.
> Type "show copying" to see the conditions.
> There is absolutely no warranty for GDB.  Type "show warranty" for details.
> This GDB was configured as "sparc-sun-solaris2.9"...
> (gdb) r --export-marks=tmp-marks HEAD
> Starting program: /flyvo2/home/namsh/srcs/git/git-fast-export 
> --export-marks=tmp-marks HEAD
> blob
> mark :1
> data 8
> Wohlauf
> 
> reset refs/heads/marks
> commit refs/heads/marks
> mark :2
> author A U Thor <author@example.com> 1112911993 -0700
> committer C O Mitter <committer@example.com> 1112911993 -0700
> data 8
> initial
> M 100644 :1 file
> 
> blob
> mark :3
> data 9
> die Luft
> 
> blob
> mark :4
> data 12
> geht frisch
> 
> commit refs/heads/marks
> mark :5
> author A U Thor <author@example.com> 1112912053 -0700
> committer C O Mitter <committer@example.com> 1112912053 -0700
> data 7
> second
> from :2
> M 100644 :3 file
> M 100644 :4 file2
> 
> blob
> mark :6
> data 4
> und
> 
> commit refs/heads/marks
> mark :7
> author A U Thor <author@example.com> 1112912113 -0700
> committer C O Mitter <committer@example.com> 1112912113 -0700
> data 6
> third
> from :5
> M 100644 :6 file2
> 
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0x00043024 in export_marks (file=0xffbff0df "tmp-marks")
>     at builtin-fast-export.c:384
> 384                     if (deco && deco->base && deco->base->type == 1) {
> (gdb) p deco
> $1 = (struct object_decoration *) 0x193150
> (gdb) p deco->base
> $2 = (struct object *) 0x2009
> (gdb) p *(struct object_decoration *) 0x193150
> $5 = {base = 0x2009, decoration = 0x0}
> (gdb) p idnums
> $3 = {name = 0x0, size = 1500, nr = 7, hash = 0x190270}
> (gdb) p *(struct object_decoration *) 0x190270
> $6 = {base = 0x0, decoration = 0x0}
> (gdb) p *(struct object_decoration *) 0x190280
> $9 = {base = 0x0, decoration = 0x0}
> (gdb) p *(struct object_decoration *) 0x190290
> $10 = {base = 0x0, decoration = 0x0}
> (gdb) p *(struct object_decoration *) 0x1902a0
> $11 = {base = 0x0, decoration = 0x0}
> (gdb) p *(struct object_decoration *) 0x1902b0
> $12 = {base = 0x0, decoration = 0x0}
> (gdb) p *(struct object_decoration *) 0x1902c0
> $13 = {base = 0x0, decoration = 0x0}
> (gdb) p *(struct object_decoration *) 0x193140
> $14 = {base = 0x0, decoration = 0x0}
> (gdb) p *(struct object_decoration *) 0x193160
> $15 = {base = 0x35323962, decoration = 0x63613534}
> (gdb)
> 
