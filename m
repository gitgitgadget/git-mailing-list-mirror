From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Fri, 15 May 2009 00:35:45 +0200
Message-ID: <op.utxydvnu1e62zd@merlin.emma.line.org>
References: <op.utv93sdo1e62zd@merlin.emma.line.org>
 <op.utwdsutn1e62zd@merlin.emma.line.org>
 <7v8wl01iev.fsf@alter.siamese.dyndns.org>
 <op.utwyczlf1e62zd@merlin.emma.line.org>
 <20090514182249.GA11919@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Brandon Casey" <casey@nrlssc.navy.mil>,
	"Sverre Rabbelier" <srabbelier@gmail.com>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 15 00:36:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4jWw-0005vQ-ML
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 00:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754500AbZENWft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 18:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753624AbZENWft
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 18:35:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:50564 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753565AbZENWfs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 18:35:48 -0400
Received: (qmail invoked by alias); 14 May 2009 22:35:48 -0000
Received: from e177047208.adsl.alicedsl.de (EHLO mandree.no-ip.org) [85.177.47.208]
  by mail.gmx.net (mp020) with SMTP; 15 May 2009 00:35:48 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1/CeKUrc+7C0IHN+e9QzKLWzk0WMqvPXq/BWR5hRD
	xbRTenFkJMFejQ
Received: from merlin.emma.line.org (localhost [127.0.0.1])
	by merlin.emma.line.org (Postfix) with ESMTP id 168359447B;
	Fri, 15 May 2009 00:35:46 +0200 (CEST)
In-Reply-To: <20090514182249.GA11919@sigill.intra.peff.net>
User-Agent: Opera Mail/9.64 (Linux)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119232>

Am 14.05.2009, 20:22 Uhr, schrieb Jeff King <peff@peff.net>:

> On Thu, May 14, 2009 at 11:37:37AM +0200, Matthias Andree wrote:
>
>> HOWEVER, I see two problems here (yes, they are corner cases):
>>
>> #1: git tag -f ("replace tag") fails to "replace" a heaviweight tag if I
>> try to replace a tag by itself (or create a cycle by some other means).
>>
>> The new "foo" is unique in refs (OK), but it's *not unique* in objects
>> (FAIL), as the old "foo" is referenced by the new "foo" and bears the  
>> same
>> tag name.
>>
>> It screws the repo, breaking the uniqueness of tags. Basically, git tag  
>> -f
>> is implementing a half-baked, non-working "rebase tag objects"
>> functionality.
>
> Can you explain how this "screws the repo"? The refs are unique, and in
> your examples, a tag object replaced by "git tag -f" no longer has a ref
> pointing to it (but in your example of making a tag of a tag, then of
> course the original is still reachable indirectly). The "unique in
> objects" you refer to is that the tag itself says "here is the name
> under which I was tagged". That name is purely informative and has
> nothing to do with ref lookup or reachability.
>
> In your examples, I don't see any behavior that is causing actual
> problems.

Hi Jeff,

so you, Alex and Brandon say git doesn't malfunction here. Hope you don't  
mind my insisting, and to keep this concise, I'll send only one answer to  
several posts (the whole discussion is too verbose already).

I agree that the resulting object structure is still a directed acyclic  
graph, so I'll not criticize the object structure.

The semantic meaning however is missing. Let me take a different vantage  
and look at the same situation, leaving the object graph aside.

This "git tag -f -s same same" operation gives me a signed nothing, and  
the ref indeed no longer points to the old tag.  But what's the new  
signature or tag good for?  I tagged & signed an object that was removed  
in the process.  I have a tagged and signed nothing. (Yes, there is an  
underlying object, but it takes lots of fiddling with the LL tools to get  
at it.)

> Deleting the ref makes it dangling, unless something else is referencing
> it. In your examples, since you tag the tag, the original tag is still
> referenced.

That's what I see, yes. But again, what good is the signed nothing?

> Of course the _old_ tag1 is still there. It is referenced by tag2, which
> still has a ref. Again you are confusing the right-hand side of "git
> rev-list --objects" with actual ref names.

Indeed it's not git show-ref...

> I am not ruling out the possibility that there is some piece of code
> that will be confused by the situation you have created, but it has
> nothing to do with graph walking. It would have to be a piece of code
> which cares about the uniqueness of informative names inside tag
> objects.

That's true, and apparently git fast-export is one of those pieces of code.

Thanks

-- 
Matthias Andree
