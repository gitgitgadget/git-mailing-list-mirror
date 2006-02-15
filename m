From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling large files with GIT
Date: Wed, 15 Feb 2006 07:44:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602150715470.3691@g5.osdl.org>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>
 <87slqty2c8.fsf@mid.deneb.enyo.de> <46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com>
 <Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk>
 <Pine.LNX.4.64.0602121939070.3691@g5.osdl.org> <Pine.LNX.4.64.0602122049010.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602122058260.3691@g5.osdl.org> <43F113A5.2080506@f2s.com>
 <Pine.LNX.4.63.0602141953000.22451@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0602141108050.3691@g5.osdl.org> <43F249F7.5060008@vilain.net>
 <Pine.LNX.4.64.0602141357300.3691@g5.osdl.org> <7vy80dpo9g.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602141741210.3691@g5.osdl.org> <Pine.LNX.4.64.0602141811050.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602141829080.3691@g5.osdl.org> <Pine.LNX.4.64.0602141953081.3691@g5.osdl.org>
 <7vd5hpj6ab.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 15 16:45:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9Oph-0006hB-8b
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 16:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945991AbWBOPok (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 10:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945990AbWBOPok
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 10:44:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25837 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1945991AbWBOPoj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Feb 2006 10:44:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1FFiADZ022889
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 15 Feb 2006 07:44:10 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1FFi9mS032428;
	Wed, 15 Feb 2006 07:44:09 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5hpj6ab.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16245>



On Wed, 15 Feb 2006, Junio C Hamano wrote:
> 
> I was thinking about implementing mergers as a pipeline:
> 
> 	git-merge-tree O A B |
>         git-merge-renaming A |
>         git-merge-aggressive A |
>         git-merge-filemerge

Great minds think alike.

> git-merge-tree (yours) does not do trivial collapsing, and
> produce raw-diff from A.

(It does _truly_ trivial collapsing, but I think we both agree: it doesn't 
do anything that we used to go git-merge-one-file on)

> git-merge-renaming reads it, finds
> copied/renamed entries (maybe reusing parts of diffcore), and
> writes out the results in the same format as merge-tree output

I was considering perhaps doing a first cut at that in git-merge-tree 
already. Not sure.

One issue is that I think I may have to change the output format if I do 
that. I should anyway. 

Why?

It's hard to see where "one event" stops, and another starts. I stupidly 
initially thought that you can do it entirely based on looking at the 
numbers, but you can't. Right now you have to look at the pathname too, 
which is kind of sad, and doesn't work after rename detection (since then 
the pathnames won't be sorted any more, and one "event" can have different 
pathnames in different stages).

[ Side note: it doesn't even work for file/directory conflicts, which can 
  have the same name, but are two different "events". So you'd actually 
  have to look at both mode _and_ filename to sort out if two lines that 
  start with "1" and "3" respectively are one event (removal in first 
  branch) or two events ("1" on one file: removal in both branches + "3" 
  on another file: add in second branch) ]

So to do the rename output, you can't use the same format as merge-tree 
uses right _now_. We'd have to add a marker to mark what the event 
boundaries are.

The "mark" could be a running "event number", or even as easy as an 
alternating character ("#" vs " " as the second character in the line or 
similar)

So instead of

	2 100644 ff280e2e1613e808e4d7844376134dfa2bb1fc21 Documentation/cputopology.txt
	2 100644 28c5b7d1eb90f0ccd8e0307c170f89bd7954dc9c Documentation/hwmon/f71805f
	1 100644 b88953dfd58022aef1680c266c7438605b146fc8 Documentation/i2c/busses/i2c-sis69x
	3 100644 b88953dfd58022aef1680c266c7438605b146fc8 Documentation/i2c/busses/i2c-sis69x
	2 100644 00a009b977e92b1a942d1138afdccf1b725df956 Documentation/i2c/busses/i2c-sis96x
	2 100644 90a5e9e5bef1daa9d0f0621e209827f0d180f384 Documentation/unshare.txt
	2 100644 5127f39fa9bf9a384a6529c6d5deb1002e945de5 arch/arm/mach-s3c2410/s3c2400-gpio.c
	2 100644 8b2394e1ed4088c3b8d38e87e58bde2f38152bf7 arch/arm/mach-s3c2410/s3c2400.h
	 ...

it migth be

	2#100644 ff280e2e1613e808e4d7844376134dfa2bb1fc21 Documentation/cputopology.txt
	2 100644 28c5b7d1eb90f0ccd8e0307c170f89bd7954dc9c Documentation/hwmon/f71805f
	1#100644 b88953dfd58022aef1680c266c7438605b146fc8 Documentation/i2c/busses/i2c-sis69x
	3#100644 b88953dfd58022aef1680c266c7438605b146fc8 Documentation/i2c/busses/i2c-sis69x
	2 100644 00a009b977e92b1a942d1138afdccf1b725df956 Documentation/i2c/busses/i2c-sis96x
	2#100644 90a5e9e5bef1daa9d0f0621e209827f0d180f384 Documentation/unshare.txt
	2 100644 5127f39fa9bf9a384a6529c6d5deb1002e945de5 arch/arm/mach-s3c2410/s3c2400-gpio.c
	2#100644 8b2394e1ed4088c3b8d38e87e58bde2f38152bf7 arch/arm/mach-s3c2410/s3c2400.h
	 ...

where you can clearly see the "grouping" without having to even look at 
the filename.

(The example I show actually has a rename-with-modifications that was made 
on the first branch: notice that i2c-sis69x vs i2c-sis96x thing?)

I don't know exactly what the "after rename detection" output format would 
be, but it _might_ turn that

	...
	1#b889... i2c-sis69x
	3#b889... i2c-sis69x
	2 00a0... i2c-sis96x
	...

into one event:

	...
	1#b889... i2c-sis69x
	2#00a0... i2c-sis96x
	3#b889... i2c-sis69x
	...

and then the actual file-merge logic would have to merge the names as well 
as the file contents (and in this case, the final name would thus be 
"i2c-sis96x", since one branch hadn't changed it).

Hmm?

		Linus
