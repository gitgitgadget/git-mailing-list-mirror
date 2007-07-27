From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: index-pack died on pread
Date: Thu, 26 Jul 2007 22:36:16 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707262231280.3442@woody.linux-foundation.org>
References: <333e1ca10707230552i34c2a1cfq9fae94f20023e9d7@mail.gmail.com>
 <alpine.LFD.0.999.0707230956390.3607@woody.linux-foundation.org>
 <200707260115.13234.robin.rosenberg.lists@dewire.com>
 <alpine.LFD.0.999.0707251636490.3607@woody.linux-foundation.org>
 <81b0412b0707260542o58fcb73bu81ae09aa1df84c81@mail.gmail.com>
 <alpine.LFD.0.999.0707260911040.3442@woody.linux-foundation.org>
 <7vps2e5x4y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Michal Rokos <michal.rokos@gmail.com>,
	GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 07:37:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEIVm-0003sY-Bk
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 07:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146AbXG0FhL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 01:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756276AbXG0FhL
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 01:37:11 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53767 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755419AbXG0FhJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jul 2007 01:37:09 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6R5aMFP004705
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 26 Jul 2007 22:36:23 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6R5aG4f007655;
	Thu, 26 Jul 2007 22:36:17 -0700
In-Reply-To: <7vps2e5x4y.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.73 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.15__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53893>



On Thu, 26 Jul 2007, Junio C Hamano wrote:
> 
> If you mean the offset associated with fd, we actually do.

Ahh, for some reason I thought we didn't (probably because the user likely 
doesn't care at all), but right you are..

> The original HP-UX error is confusing, as we ask pread() to
> transfer 428 bytes and it returns 0 (not returning -1 with
> EINTR).  Return value of zero is understandable, if the starting
> position is at or after the EOF, but the offset is 123601 and
> 56k objects packed from git.git repository should be longer than
> that, so that also sounds implausible.

Yeah. It is suspicious.

If somebody could run git under gdb on HP-UX (preferably compiled 
statically), and just disassemble the pread() thing, it would be 
interesting.

PA-RISC assembly is *almost* entirely unreadable, but it might show 
whether hpux-11.11 actually has a pread() system call or whether it is 
doing the "emulate with lseek" and maybe obviously buggily at that..

It really isn't that complex a system call. So I'm surprised at bugs 
there, and that makes me worry that there is something in git that 
triggers this.

		Linus
