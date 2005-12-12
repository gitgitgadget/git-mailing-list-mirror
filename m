From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Delitifier broken (Re: diff-core segfault)
Date: Mon, 12 Dec 2005 15:31:42 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512121529200.15597@g5.osdl.org>
References: <1134404990.5928.4.camel@localhost.localdomain>
 <7vmzj6i206.fsf@assigned-by-dhcp.cox.net> <7virtui1kj.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0512121620380.26663@localhost.localdomain>
 <7vek4igevq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 00:34:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Elx9y-0007yc-Mb
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 00:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVLLXcm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 18:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVLLXcm
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 18:32:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15558 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932234AbVLLXcl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2005 18:32:41 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBCNVmDZ007786
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Dec 2005 15:31:51 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBCNVgQO022990;
	Mon, 12 Dec 2005 15:31:45 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek4igevq.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.128 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13546>



On Mon, 12 Dec 2005, Junio C Hamano wrote:
> Nicolas Pitre <nico@cam.org> writes:
> >
> > I would say involving an empty blob with deltas _is_ the bug in the 
> > first place.  Please don't let that happen.

I agree with Nicolas.

> Not all use of delta is to produce a pack.  An empty->empty
> delta is a valid two byte \0\0 sequence, and I do not see any
> reason to forbid it.  Although using such delta to represent
> anything in a pack does *not* make any sense as you say, it
> makes other callers simpler if they do not have to check if
> from_len and to_len are empty before calling the delta code.

And you don't need to.

Do what pack-objects.c does: just call "diff_delta()" and check the result 
for NULL. If the result is NULL, then you have to do some special code, 
because that means that it's a full create or a full delete (or it's an 
unchanged empty file). Regardless, it really _is_ a special case, and it 
would be silly to generate a delta for it.

		Linus
