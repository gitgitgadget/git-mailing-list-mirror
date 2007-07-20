From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 17:33:29 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707191726510.27249@woody.linux-foundation.org>
References: <858x9ez1li.fsf@lola.goethe.zz>
 <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
 <vpq4pk1vf7q.fsf@bauges.imag.fr> <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org>
 <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
 <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
 <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org>
 <9436820E-53D1-425D-922E-D4C76578E40A@silverinsanity.com>
 <863azk78yp.fsf@lola.quinscape.zz> <FA38709A-7C68-4D66-BA26-B5ED49DFA85A@silverinsanity.com>
 <7vk5sw2ba7.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0707191706120.27249@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	David Kastrup <dak@gnu.org>,
	"Shawn O.Pearce" <spearce@spearce.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 02:34:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBgRy-0007I9-SP
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 02:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762050AbXGTAdz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 20:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760856AbXGTAdy
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 20:33:54 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33178 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755986AbXGTAdx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jul 2007 20:33:53 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6K0XZL2026878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 19 Jul 2007 17:33:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6K0XTZd030895;
	Thu, 19 Jul 2007 17:33:30 -0700
In-Reply-To: <alpine.LFD.0.999.0707191706120.27249@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.193 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53044>



On Thu, 19 Jul 2007, Linus Torvalds wrote:
> 
> That's physically impossible with the git data-structures (since there is 
> no way of saving "this directory was added empty" in the tree structures, 
> nor any point to it), so I think it's just insane rambling.

Of course, it's physically *possible* to have a tree that contains two 
entries for the same name: first the "empty tree" and then the "real 
tree", and yeah, in theory you could track things that way.

So I guess the "physically impossible" was a bit strong. You'd have to 
have a totally insane format, and you'd have to violate deeply seated 
rules about what trees look like (and the index too, for that matter: we'd 
have to do the same for the index, and keep the S_IFDIR entry alive 
despite having other entries that are children of it), but it's 
*possible*.

It's just a really bad idea.

So to be sane, when you add files, the empty directory entry has to go 
away. Otherwise you could have two very different trees that encode the 
same *content* (just with different ways of getting there - depending on 
whether you have a history with empty trees or not), and that's very much 
against the philosophy of git, and breaks some fundamental rules (like the 
fact that "same content == same SHA1").

In fact, that may be the best way to explain why it's *not* an option to 
have "empty trees remain empty trees if we remove the last file from 
them": git fundamnetally tracks "content snapshots", and anything that 
implies the content containing any history is against the rules.

So the whole notion of "remembering" whether a directory was added 
explicitly as an empty directory or not is just not a sensible concept in 
git. 

		Linus
