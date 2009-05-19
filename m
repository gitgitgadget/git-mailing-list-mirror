From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Tue, 19 May 2009 13:21:58 +0200
Message-ID: <op.ut6ciwjl1e62zd@balu.cs.uni-paderborn.de>
References: <op.utv93sdo1e62zd@merlin.emma.line.org>
 <op.utwdsutn1e62zd@merlin.emma.line.org>
 <7v8wl01iev.fsf@alter.siamese.dyndns.org>
 <op.utwyczlf1e62zd@merlin.emma.line.org>
 <20090514182249.GA11919@sigill.intra.peff.net>
 <op.utxydvnu1e62zd@merlin.emma.line.org>
 <20090515020206.GA12451@coredump.intra.peff.net> <op.uty0pjb51e62zd@balu>
 <m34ovmlcve.fsf@localhost.localdomain> <4A0D8211.5010806@viscovery.net>
 <81b0412b0905150851q232b3f6s95df89e72d4dc381@mail.gmail.com>
 <4A0D9696.1040805@op5.se> <7v3ab6uuw4.fsf@alter.siamese.dyndns.org>
 <4A0E67E9.3020208@op5.se> <7vtz3lnf1x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Jakub Narebski" <jnareb@gmail.com>, "Jeff King" <peff@peff.net>,
	git@vger.kernel.org, "Brandon Casey" <casey@nrlssc.navy.mil>,
	"Sverre Rabbelier" <srabbelier@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue May 19 13:22:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6NPK-0005XB-7J
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 13:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbZESLWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 07:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbZESLWG
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 07:22:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:50842 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752701AbZESLWE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 07:22:04 -0400
Received: (qmail invoked by alias); 19 May 2009 11:22:01 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu.cs.uni-paderborn.de) [131.234.21.37]
  by mail.gmx.net (mp014) with SMTP; 19 May 2009 13:22:01 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX18G/vhYzNAGliGVhR/aJkZwurIoTmDniNxaiqPbHq
	DC+OT5f7pHJcN7
Received: from localhost ([127.0.0.1] helo=balu.cs.uni-paderborn.de)
	by balu.cs.uni-paderborn.de with esmtp (Exim 4.69)
	(envelope-from <matthias.andree@gmx.de>)
	id KJW28N-0004G0-HN; Tue, 19 May 2009 13:21:59 +0200
In-Reply-To: <7vtz3lnf1x.fsf@alter.siamese.dyndns.org>
User-Agent: Opera Mail/9.64 (Win32)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119517>

Am 16.05.2009, 19:16 Uhr, schrieb Junio C Hamano <gitster@pobox.com>:


> The workflow for a such case would be:
>
>  (0) I notice the signing key was somehow compromised; roll a new key,
>      re-sign the tags, and send out a "I had to re-tag, and here is a  
> list
>      of the old and new tag object names you can use to verify" message;
>
>  (1) You read such a message,  You do "git for-each-ref refs/tags" to see
>      the object names to check with my message, and realize that you have
>      stale tags.  So does Joe Dev but he may be slower to react;
>
>  (2) You fetch (or ls-remote) from Joe Dev which is your preferrerd  
> mirror
>      of my tree and notice he hasn't updated, and let him know.  In the
>      meantime you fetch "git fetch --tags" from me, and verify the result
>      against my message.
>
>  (3) Joe Dev would do the same.
>
> That's largely manual, cumbersome, and makes everybody involved painfully
> aware of what is going on, which may be an advantage over silently
> updating with a new tag without telling anybody.
>
> But you can improve the situation without losing security by doing
> something like this.

Let's do things step by step and fix the current issue - and I fear there  
won't be an easy technical solution, so let's amend to the documentation  
for the nonce.

OK, what I was trying to do is rewrite history to fix up some b0rked  
internal addresses. That's a repository for a mostly frozen project, which  
is more a reference point than a basis for development. I had to recreate  
the few tag signatures they were, and hence I used "git tag -f" without  
thinking too much. I had seen the section on re-tagging, and am aware of  
it, but it somehow didn't apply to my situation.

I think we ought

(1) to fix the git tag -h output and manual page for consistency, and

(2) to add a note to make users aware that they can also tag tags (the  
[<object>] in SYNOPSIS may not be hint enough, as Git seems to differ  
substantially from other SCM systems in this respect - so this is a  
usability concern that deserves documentation).

I'll suggest something, but that can take a couple of days.

What else can we tag in Git? Commits and Tags.  Is it sensible and does it  
work to tag blobs or trees?

-- 
Matthias Andree
