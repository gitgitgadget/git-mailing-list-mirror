From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [ANNOUNCE] Git v1.8.4
Date: Mon, 26 Aug 2013 20:06:37 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1308232242180.14472@syhkavp.arg>
References: <xmqqfvu0nkim.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 02:06:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE6o6-0003Bf-Ov
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 02:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290Ab3H0AGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 20:06:44 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46624 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189Ab3H0AGn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 20:06:43 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS500GXOXN64KA0@VL-VM-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Aug 2013 20:06:42 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 340DD2DA052D; Mon, 26 Aug 2013 20:06:42 -0400 (EDT)
In-reply-to: <xmqqfvu0nkim.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Content-id: <alpine.LFD.2.03.1308252027201.14472@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233038>

On Fri, 23 Aug 2013, Junio C Hamano wrote:

> The latest feature release Git v1.8.4 is now available at the usual
> places.  It contains 870+ changes from ~100 contributors (among
> which 33 people are new) since v1.8.3.
> 
> We will have two more releases til the end of this year; the release
> after that could be Git 2.0.

May I land a big teaser for a possible Git 2.0 feature?

Here's some cues:

$ cd git
$ git describe
v1.8.4
$ ls -l .git/objects/pack/
total 44240
-r--r--r-- 1 nico nico  4535112 Aug 26 17:16 pack-b04833b53befec3e6cb459fd72ade62c310a0a0e.idx
-r--r--r-- 1 nico nico 40762151 Aug 26 17:16 pack-b04833b53befec3e6cb459fd72ade62c310a0a0e.pack
$ git packv4-create
Usage: git-packv4-create <src_packfile> <dst_packfile>
$ mkdir test
$ git packv4-create .git/objects/pack/pack-b04833b53befec3e6cb459fd72ade62c310a0a0e test/foo
Scanning objects: 100% (161930/161930), done.
Writing objects: 100% (161930/161930), done.
$ ls -l test
total 31952
-rw------- 1 nico nico  1296512 Aug 26 19:28 foo.idx
-rw------- 1 nico nico 31420190 Aug 26 19:28 foo.pack

[...]

$ cd linux
$ git describe
v3.11-rc7
$ ls -l .git/objects/pack/
total 756068
-r--r--r-- 1 nico nico  88195164 Aug 26 17:25 pack-7fe7cd3b8af810808649d114a11b8aab1f7c5ae9.idx
-r--r--r-- 1 nico nico 686006356 Aug 26 17:25 pack-7fe7cd3b8af810808649d114a11b8aab1f7c5ae9.pack
$ mkdir test
$ git packv4-create .git/objects/pack/pack-7fe7cd3b8af810808649d114a11b8aab1f7c5ae9 test/foo
Scanning objects: 100% (3149789/3149789), done.
Writing objects: 100% (3149789/3149789), done.
$ ls -l test
total 597016
-rw------- 1 nico nico  25199384 Aug 26 19:41 foo.idx
-rw------- 1 nico nico 586134328 Aug 26 19:41 foo.pack


Yes, after being vaporware for many many years (I don't even remember 
when I started making references to a possible pack format version 4 -- 
certainly more than 6 years ago) I finally completed the code to produce 
a new pack format I'm actually happy with.

Hundreds of hours went into this work over the years.  Lots of head 
scratching, many dead ends and scrapped attempts.  What didn't help is 
the fact that I never had much time to dedicate to this project.  
Significant portions of the surviving code were even written when I was 
on vacation in the Carabeans.  And even when it finally worked, the 
required code cleanup work was impressive.

Note this is the pack _creation_ code only.  Nothing is able to read 
this pack format just yet.  What I'm willing to do is a simple 
compatibility layer that recreates the canonical object representation 
when accessed.  This should already make runtime Git significantly 
faster when performing graph traversal.

But the biggest gain will come from direct interpretation of the native 
pack data encoding.  However I'll let others do that part, as well as 
the required fsck support and all the backward compatibility handling, 
etc.  Now that the encoding design is pretty much settled I think it is 
good for review, and for others to get involved as well.

Interested?  ;-)


Nicolas
