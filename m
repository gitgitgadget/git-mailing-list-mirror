From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: regression in multi-threaded git-pack-index
Date: Tue, 19 Mar 2013 16:41:53 +0100
Message-ID: <87hak74cse.fsf@pctrast.inf.ethz.ch>
References: <20130315224240.50AA340839@wince.sfo.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4g?= =?utf-8?B?VGjDoWkgTmfhu41j?= Duy 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 16:42:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHygD-0007S5-PG
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 16:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545Ab3CSPl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 11:41:57 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:40356 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932285Ab3CSPl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 11:41:56 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Mar
 2013 16:41:49 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.171.78) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Mar
 2013 16:41:53 +0100
In-Reply-To: <20130315224240.50AA340839@wince.sfo.corp.google.com> (Stefan
	Zager's message of "Fri, 15 Mar 2013 15:42:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.171.78]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218523>

szager@google.com (Stefan Zager) writes:

> We have uncovered a regression in this commit:
>
> b8a2486f1524947f232f657e9f2ebf44e3e7a243
>
> The symptom is that 'git fetch' dies with:
>
> error: index-pack died of signal 10
> fatal: index-pack failed

So after that fun detour into threading issues, I have actually managed
to reproduce this problem on OS X even with the three in-flight patches
already applied.

I reduced the issue to this file:

  http://thomasrast.ch/download/broken-pack

on which you can run this command in the repo that Stefan provided:

  git index-pack --keep --stdin -v --pack_header=2,50757 <broken-pack

I got the file by patching fetch-pack.c to pipe the pack to 'dd
of=broken-pack' instead of index-pack, as I couldn't find any other way
of getting at the data stream before index-pack ruins it.

The funny thing about it is that I get this on OS X:

  $ git index-pack --keep --stdin -v --pack_header=2,50757 <borked
  Receiving objects: 100% (50757/50757), 24.52 MiB | 23.91 MiB/s, done.
  Bus error: 10tas:  24% (10194/42272)

(notice the error) and also

  $ gdb --args $(which git)
  GNU gdb 6.3.50-20050815 (Apple version gdb-1705) (Fri Jul  1 10:50:06 UTC 2011)
  Copyright 2004 Free Software Foundation, Inc.
  GDB is free software, covered by the GNU General Public License, and you are
  welcome to change it and/or distribute copies of it under certain conditions.
  Type "show copying" to see the conditions.
  There is absolutely no warranty for GDB.  Type "show warranty" for details.
  This GDB was configured as "x86_64-apple-darwin"...Reading symbols for shared libraries .... done

  (gdb) r index-pack --keep --stdin -v --pack_header=2,50757 <borked
  Starting program: /Users/trast/.local/bin/git index-pack --keep --stdin -v --pack_header=2,50757 <borked
  Reading symbols for shared libraries +++........................ done
  Receiving objects: 100% (50757/50757), 24.52 MiB | 13.06 MiB/s, done.
  Resolving deltas:  25% (10568/42272)   
  Program received signal EXC_BAD_ACCESS, Could not access memory.
  Reason: KERN_PROTECTION_FAILURE at address: 0x000000014484dfe8
  [Switching to process 96573 thread 0x10f]
  0x000000010017ee20 in use_pack (p=0x100500f30, w_cursor=0x14484e1a0, offset=69638148, left=0x0) at sha1_file.c:866
  866             if (!win || !in_window(win, offset)) {

This seems to be a SIGBUS triggered by stack overflow, largely based on
the observation that

  (gdb) p &p
  $6 = (struct packed_git **) 0x144748058

I can't see anything wrong with the values as such, but if you have good
ideas what I should ask of that debugger, I'm keeping the session
around.

Furthermore, if I run the same command on linux in the provided repo, I
get this instead:

  $ git index-pack --fix-thin --keep --stdin -v --pack_header=2,50757 <../broken-pack
  Receiving objects: 100% (50757/50757), 24.52 MiB | 18.84 MiB/s, done.
  Resolving deltas: 100% (42272/42272), completed with 8264 local objects.
  pack    1cd9880470ea812835edde58e8d7752818dc1ead

But when I do it with Peff's patch applied, I get:

  $ git index-pack --fix-thin --keep --stdin -v --pack_header=2,50757 <../broken-pack
  Empfange Objekte: 100% (50757/50757), 24.52 MiB | 17.92 MiB/s, done.
  git: builtin/index-pack.c:897: find_unresolved_deltas_1: Assertion `child->real_type == OBJ_OFS_DELTA' failed.
  Aborted

I think the patch is probably still good as it stands, but there's some
underlying breakage going on that hides the problem if we don't clear
that memory...

I'm still looking, but I wanted to get this -- and in particular the
pack -- out for you to play with ;-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
