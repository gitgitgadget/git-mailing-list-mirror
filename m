From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/3] Diff overhaul, adding the other half...
Date: Sat, 21 May 2005 11:45:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505211137250.2206@ppc970.osdl.org>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org> <7vzmuokjhg.fsf@assigned-by-dhcp.cox.net>
 <7vfywgkj90.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505211016140.2206@ppc970.osdl.org>
 <7vzmuoh2ma.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505211124440.2206@ppc970.osdl.org>
 <Pine.LNX.4.58.0505211128570.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:43:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZYvk-0006XC-Gk
	for gcvg-git@gmane.org; Sat, 21 May 2005 20:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVEUSnh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 14:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVEUSnh
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 14:43:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:29612 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261769AbVEUSna (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 May 2005 14:43:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4LIhPjA010571
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 21 May 2005 11:43:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4LIhO2K008953;
	Sat, 21 May 2005 11:43:25 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0505211128570.2206@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 21 May 2005, Linus Torvalds wrote:
> 
> Which is a sensible default, and I note that you sent a separate email for 
> testing the extreme case. I'll try that out too, just for fun,

Hmm.. It's not working well. Not only does it take a lot of CPU time (do 
an fsck first to make sure you're not seekign the disk all over the 
place), but it "finds" lots of things like this:

	diff --git a/drivers/usb/misc/emi62_fw_m.h b/drivers/media/dvb/bt8xx/dst_ca.h
	similarity index 99%
	copy from drivers/usb/misc/emi62_fw_m.h
	copy to drivers/media/dvb/bt8xx/dst_ca.h
	--- a/drivers/usb/misc/emi62_fw_m.h
	+++ b/drivers/media/dvb/bt8xx/dst_ca.h
	@@ -1,8853 +1,58 @@
	 /*
	- * This file is generated from three different files, provided by Emagic.
	- */
	-/* generated Tue Jun 3 21:36:11 EEST 2003 */
	+       CA-driver for TwinHan DST Frontend/Card
 
which looks quite bogus (it they aren't similar at all, and the diff is 
huge).

I think that your similarity check has a tendency to do bad things if one 
of the files is huge: in this case we have

	torvalds@ppc970:~/v2.6/linux> wc -c drivers/media/dvb/bt8xx/dst_ca.h drivers/usb/misc/emi62_fw_m.h
	  1591 drivers/media/dvb/bt8xx/dst_ca.h
	795679 drivers/usb/misc/emi62_fw_m.h
	797270 total

and you consider them "similar", probably because it turns out that 
a delta that just removes everything is very small (it's just a "delete 
bytes x-y") so you compare that "small" delta to a "large total file" and 
you think it's an almost perfect match.

Now, for _renames_ that is actually half-way the right thing to do, but 
for copies, you should compare the size not to the _sum_ of the two files, 
but to just the size of the file that you generate.

But it's a fun example ;)

		Linus
