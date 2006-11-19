X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [WISH] Store also tag dereferences in packed-refs
Date: Sun, 19 Nov 2006 10:05:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611190945500.3692@woody.osdl.org>
References: <e5bfff550611180115j135746a1h916e8ae029d1374d@mail.gmail.com> 
 <7vmz6oeh2k.fsf@assigned-by-dhcp.cox.net>  <20061118184345.GO7201@pasky.or.cz>
  <e5bfff550611181047w6712774fkccc697d312b87c7e@mail.gmail.com> 
 <7vac2oefuz.fsf@assigned-by-dhcp.cox.net>  <e5bfff550611181628o41e11652ycd17ddad5dd21225@mail.gmail.com>
  <Pine.LNX.4.64.0611181706250.3692@woody.osdl.org>
 <e5bfff550611190140n3277ee26v95feba26dd3348fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 19 Nov 2006 18:06:15 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <e5bfff550611190140n3277ee26v95feba26dd3348fa@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.159 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31846>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glr3G-0004Vf-Eh for gcvg-git@gmane.org; Sun, 19 Nov
 2006 19:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932679AbWKSSFy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 13:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbWKSSFy
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 13:05:54 -0500
Received: from smtp.osdl.org ([65.172.181.25]:27823 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S932679AbWKSSFx (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 13:05:53 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAJI5kix030810
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 19
 Nov 2006 10:05:46 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAJI5iUP013370; Sun, 19 Nov
 2006 10:05:45 -0800
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org



On Sun, 19 Nov 2006, Marco Costalba wrote:
> 
> Sure. File ran against git tree attached.

Ok. Nothing really strange stands out - it's a nice trace with just over 
400 system calls. I'd expect it to finish in no time at all (tracing will 
add some overhead, since you context switch back and forth between the 
tracer and the tracee, but it's really not doing a lot, so even with 
tracing it should execute almost instantaneously).

So it all looks _almost_ fine..

Except for this one:

   10:19:04.449236 stat64(".git/objects/3a/41a48d139d1425c1d27e3fbe4f511fb7e09e94", {st_mode=S_IFREG|0444, st_size=278, ...}) = 0 <0.817989>

That's a _single_ "stat64()" system call that takes almost a second to 
execute. All the rest are in the millisecond range, and sometimes a 
hundreth of a second or two. Ie doing

	grep -v ' <0.0[012]' tracefile_git_tree.txt

on your tracefile, there's really not a lot of system calls that take a 
long time, and that one stat _really_ stands out (the others are 3 or four 
hundredths of a second, and then suddenly you have one that is 20 times 
longer than even the slowest other ones.

Basically, you seem to have a _single_ object access that takes up half 
the time of the whole program.

It's the object for 'refs/tags/v1.4.4-rc1' in case you care, btw. 

> If you want I can repack and prune, but for now I just wait to avoid
> to corrupt this test case.

What you could try to do is to re-run it a few times (cold-cache) and see 
if those numbers really are stable, and if it's always the same object 
that takes that long.

In fact, you could even do a simple

	time ls -l .git/objects/3a/41a48d139d1425c1d27e3fbe4f511fb7e09e94

for the cold-cache case, and see if just even _that_ takes almost a 
second.

If it _is_ stable, there's two possibilities:

 - you have a large and slow disk, and that one object really is way out 
   there on the other side of the disk, and seeking really takes almost a 
   second.

   Quite frankly, I expected that the time when a single stat() took 
   almost a second was a decade or more in the past, back in the days of 
   floppy-disks. But what do I know?

 - your disk is failing, and ends up doing error recovery etc.

   Maybe worth running "smartctl -a /dev/hda" or whatever, to see if the 
   disk already knows it is having problems.

Anyway, repacking will fix this, but quite frankly, you might have a 
reason to be a bit nervous about that disk if I were you.

(NOTE NOTE NOTE! There could be other reasons for that second delay. If 
the machine was under heavy load, or was running low on memory, maybe the 
long delay was just due to havign to swap things out or run other things 
instead. That's why it might be interesting to see if the number is 
"stable" in that it's always that same object..)

