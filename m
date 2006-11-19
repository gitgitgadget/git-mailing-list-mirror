X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [WISH] Store also tag dereferences in packed-refs
Date: Sun, 19 Nov 2006 12:36:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611191219350.3692@woody.osdl.org>
References: <e5bfff550611180115j135746a1h916e8ae029d1374d@mail.gmail.com> 
 <7vmz6oeh2k.fsf@assigned-by-dhcp.cox.net>  <20061118184345.GO7201@pasky.or.cz>
  <e5bfff550611181047w6712774fkccc697d312b87c7e@mail.gmail.com> 
 <7vac2oefuz.fsf@assigned-by-dhcp.cox.net>  <e5bfff550611181628o41e11652ycd17ddad5dd21225@mail.gmail.com>
  <Pine.LNX.4.64.0611181706250.3692@woody.osdl.org> 
 <e5bfff550611190140n3277ee26v95feba26dd3348fa@mail.gmail.com> 
 <Pine.LNX.4.64.0611190945500.3692@woody.osdl.org> 
 <e5bfff550611191107o63d89d8bp5ff4080803a0d784@mail.gmail.com>
 <e5bfff550611191209s63982818vd3999b543e68e8df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 19 Nov 2006 20:37:19 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <e5bfff550611191209s63982818vd3999b543e68e8df@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.159 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31861>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GltPd-00014B-6z for gcvg-git@gmane.org; Sun, 19 Nov
 2006 21:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933239AbWKSUgz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 15:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933241AbWKSUgy
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 15:36:54 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47318 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S933239AbWKSUgx (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 15:36:53 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAJKalix007194
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 19
 Nov 2006 12:36:48 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAJKakaJ017180; Sun, 19 Nov
 2006 12:36:46 -0800
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org



On Sun, 19 Nov 2006, Marco Costalba wrote:
> 
> It does not seems there are strange delays, but total time it's high
> (very I/O bound)

This looks more normal. No truly horrid IO times. With your disk, having 
an uncached "stat64()" taking ~50ms is not at all impossible, if you just 
end up having to do a few seeks for directory/inode information.

> $ time strace -o tracefile -Ttt git show-ref -d >> /dev/null
> 0.02user 0.01system 0:02.39elapsed 1%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (127major+894minor)pagefaults 0swaps

So in addition to the "stat()" calls on all the objects you have 
referenced, you also had 127 page faults that needed to do IO (probably a 
combination of executable and pack-file accesses). 

I think the only way to avoid this is likely to try to either not do the 
object lookups at all (which you really cannot currently avoid with "-d", 
since the whole point is to dereference the objects if they are tags), or 
to do some silly optimizations like fsck does.

For example, it's often (but not always) faster to do all the readdir's 
separately, and then sort the thing by inode number, and try to avoid 
back-and-forth movement. But quite frankly, that kind of stuff probably 
isn't sane to do in "git show-refs".

So the optimizations that _can_ be done are:

 - add dereference info to .git/packed-refs

   This would allow us to simply not do the expensive object lookup for 
   every single tag. We'd still have to do it for non-packed objects, of 
   course, but the cost here tends to be that over time you might have 
   hundreds of tags, and even if each tag only takes 0.02s to look up, 
   you're going to be slow.

 - avoid the references for "heads/" (which we know are supposed to be 
   commits, and cannot be tags) and when not specifying "-d". This won't 
   help your case very much, though. If you want "-d", you want it, and 
   the _big_ number of refs tends to be in tags, not branches, anyway.

 - using a filesystem wih nicer locality behaviour for directory entries 
   and inodes. This can cut down costs of cold-cache case by a factor of 
   two, but right now there are no good filesystems that do this (but see 
   for example "spadfs" that Mikulas Patocka announced a few weeks ago on 
   linux-kernel - it would seem to have the possibility of being better in 
   this area. I looked at the code and it looked like it could become 
   very reasonable, but I've not actually _tested_ it, soo...)

Anyway, I think that if we really want to make "git show-refs" go fast 
when things are cold in the cache, and with lots ot tags and "-d" (which 
is a reasonable case to optimize for: it's probably exactly what we end up 
doing both for gitweb _and_ for "git-send-pack"), we'd need to expand the 
packed-refs file with the deref cache.

Junio?

