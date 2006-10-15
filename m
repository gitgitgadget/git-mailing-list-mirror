From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] pack-objects: use of version 3 delta is now optional.
Date: Sun, 15 Oct 2006 11:57:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610151150530.3952@g5.osdl.org>
References: <7v4pu62ite.fsf@assigned-by-dhcp.cox.net> <7virim10rb.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610151135110.17085@xanadu.home> <7vac3xzbze.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 15 20:58:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZBBn-0001vX-HI
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 20:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWJOS6O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 14:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbWJOS6O
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 14:58:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55263 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030216AbWJOS6O (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Oct 2006 14:58:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9FIvjaX006606
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 15 Oct 2006 11:57:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9FIvibl021318;
	Sun, 15 Oct 2006 11:57:45 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vac3xzbze.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.468 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28928>



On Sun, 15 Oct 2006, Junio C Hamano wrote:
> 
> I think that is sensible.  I also was thinking that we should
> call the current one packv3 and the one with delta-base-offset
> packv4.

Quite frankly, I wonder if the pure "copy size extension" (aka "v3") thing 
is really worth it at all. 

I mean, seriously, how much does it buy us? A couple of bytes per every 
64kB of delta copied? And the downside is that you can't re-use the deltas 
with old clients and/or you have to re-create a "v2" delta at run-time 
from a v3 delta by inflating, fixing and deflating it.

So I would suggest:

 - call the delta-base-offset thing the "v3" pack format.

 - forget about the current "v3 delta" entirely. We might as well continue 
   to support reading it, but there's no point in actually ever generating 
   it. 

In other words, I think the current situation in top-of-master is the 
right situation. There's simply no point in adding code to convert v3 to 
v2 on the fly - even if it's not rocket science, it's just not _worth_ it.

(You could also have the extended copy deltas in v3-only, and only send it 
to clients that you know supports it. However, the "convert to v2" format 
issue still rears its ugly head, and as a result I just don't think it's 
_ever_ worth it).

		Linus
