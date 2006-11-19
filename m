X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [WISH] Store also tag dereferences in packed-refs
Date: Sun, 19 Nov 2006 12:18:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611191156520.3692@woody.osdl.org>
References: <e5bfff550611180115j135746a1h916e8ae029d1374d@mail.gmail.com> 
 <7vmz6oeh2k.fsf@assigned-by-dhcp.cox.net>  <20061118184345.GO7201@pasky.or.cz>
  <e5bfff550611181047w6712774fkccc697d312b87c7e@mail.gmail.com> 
 <7vac2oefuz.fsf@assigned-by-dhcp.cox.net>  <e5bfff550611181628o41e11652ycd17ddad5dd21225@mail.gmail.com>
  <Pine.LNX.4.64.0611181706250.3692@woody.osdl.org> 
 <e5bfff550611190140n3277ee26v95feba26dd3348fa@mail.gmail.com> 
 <Pine.LNX.4.64.0611190945500.3692@woody.osdl.org>
 <e5bfff550611191107o63d89d8bp5ff4080803a0d784@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 19 Nov 2006 20:18:45 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <e5bfff550611191107o63d89d8bp5ff4080803a0d784@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.159 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31860>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glt7i-0006hC-Br for gcvg-git@gmane.org; Sun, 19 Nov
 2006 21:18:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756808AbWKSUSj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 15:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756819AbWKSUSj
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 15:18:39 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52434 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1756808AbWKSUSi (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 15:18:38 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAJKIVix006064
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 19
 Nov 2006 12:18:31 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAJKIUGi016627; Sun, 19 Nov
 2006 12:18:31 -0800
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org



On Sun, 19 Nov 2006, Marco Costalba wrote:
> 
> But why my numbers are bad both in git, in Linux and also qgit (not
> posted) local repo? If it is a single case other repos should load
> fast.

Well, it's almost guaranteed to not really be a "single" case.

An inode on disk is usually ~128 bytes or so, which means that you'll be 
able to fit quite a number of inodes in a page-sized allocation of disk 
cache. If _any_ of the sectors was slow to access (because of IO retries, 
disk sector remapping, whatever), all those inodes will be slow to access.

(It might also be a specific area on the disk, or something).

> Its a Thinkpad 2.5 inches HD, 2 years old (IBM/Hitachi Travelstar 40GNX
> family)

That's a 5400rpm disk with an average seektime of 12ms, and full stroke 
typical seek of 23ms.

A "stat64()" will do more than a single IO when it's cold-cache (the 
kernel will have to look up the directory entry and the inode, of course), 
but you _should_ see just a few IO's (2-3), so quite frankly, normally I'd 
expect to see times in the 0.03s - 0.05s range _maximum_. You'd see less 
if even just part of it was cached (which is normal, exactly because 
things like directory entries are contiguous on disk etc).

And that seems to match your other numbers.

The 0.8s number really is an outlier. It sounds like the drive didn't find 
the sector at first, perhaps had to go to its remapping table, seek around 
a bit more, take a break just to calm down, and then perhaps recalibrate 
itself (or write a SMART record entry).

> >  - your disk is failing, and ends up doing error recovery etc.
> 
> No recent errors are reported:
> 
> Stripped from smartctl -a /dev/hda

Ok, I'm not actually all that familiar with all the SMART error codes, but 
it _looks_ healthy. You do have one Spin_Up_Time event (that is 
marked pre-fail), and those two IDNF errors you have:

>  10 51 01 0f 8e a8 e4  Error: IDNF at LBA = 0x04a88e0f = 78155279
>  10 51 01 0f 8e a8 e4  Error: IDNF 1 sectors at LBA = 0x04a88e0f = 78155279

makes me wonder a bit, but for all I know, it's not actually serious. I 
_think_ the IDNF error means that it couldn't find a sector, but..

