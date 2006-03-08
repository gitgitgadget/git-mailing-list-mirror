From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFH] zlib gurus out there?
Date: Tue, 07 Mar 2006 17:22:59 -0800
Message-ID: <7vslptivbg.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
	<7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net>
	<20060224174422.GA13367@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
	<20060224183554.GA31247@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0602241350190.31162@localhost.localdomain>
	<20060224192354.GC387@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0602241152290.22647@g5.osdl.org>
	<7vpslc8oni.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602241613030.31162@localhost.localdomain>
	<Pine.LNX.4.64.0602241637480.22647@g5.osdl.org>
	<Pine.LNX.4.64.0602242130030.31162@localhost.localdomain>
	<Pine.LNX.4.64.0602241952140.22647@g5.osdl.org>
	<Pine.LNX.4.64.0602242326381.31162@localhost.localdomain>
	<Pine.LNX.4.64.0602250012230.31162@localhost.localdomain>
	<7vzmk1izpa.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603071658300.32577@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 08 02:23:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGnOO-0000ML-3n
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 02:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWCHBXE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 20:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbWCHBXE
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 20:23:04 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:9125 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751382AbWCHBXB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Mar 2006 20:23:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060308012125.RIVP20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 7 Mar 2006 20:21:25 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603071658300.32577@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 7 Mar 2006 16:59:49 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17358>

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 7 Mar 2006, Junio C Hamano wrote:
>> 
>> However, I am stuck with the first step, which is to do a full
>> flush after the header.  An obvious change to the code quoted
>> above writes out a corrupt object:
>> 
>> 	/* First header.. */
>> 	stream.next_in = hdr;
>> 	stream.avail_in = hdrlen;
>> -	while (deflate(&stream, 0) == Z_OK)
>> +	while (deflate(&stream, Z_FULL_FLUSH) == Z_OK)
>> 		/* nothing */;
>
> No, I don't think that's good. You're only doing a partial deflate, you 
> can't ask for a Z_FULL_FLUSH. That only works if you give it the whole 
> buffer, and you don't.

So, in short there is no way to create:

    hdr part deflated.
    flush.
    data part deflated independently.

and have the current sha1_read_file() not to notice that flush,
while I can inspect the deflated stream to find the "flush", and
copy only the defalted data part into a pack?  Bummer...  I was
really shooting for full backward compatibility.
