From: James Pickens <jepicken@gmail.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached HEAD 
	was
Date: Thu, 15 Oct 2009 16:47:57 -0700
Message-ID: <885649360910151647v27a15334x63fe3b6f5035dbd2@mail.gmail.com>
References: <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
	 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
	 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
	 <20091014230934.GC29664@coredump.intra.peff.net>
	 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
	 <alpine.LFD.2.00.0910151436180.20122@xanadu.home>
	 <7v1vl45t9k.fsf@alter.siamese.dyndns.org>
	 <20091015212632.GA13180@coredump.intra.peff.net>
	 <7v1vl42uid.fsf@alter.siamese.dyndns.org>
	 <7vfx9k1faa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 01:50:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mya5s-0006vi-Lt
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 01:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935610AbZJOXsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 19:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935608AbZJOXse
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 19:48:34 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:46106 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935607AbZJOXse (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 19:48:34 -0400
Received: by yxe17 with SMTP id 17so1567945yxe.33
        for <git@vger.kernel.org>; Thu, 15 Oct 2009 16:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=VQy3uHCl+nK12eqagyMLPiEnTIeuGjrK1CgDBzt1OQI=;
        b=X5G28eUEHT2rCK80x2pQWYFspxaYZgDbZQRNnq/6CsYXD3kPrwNDKcTENhPuQwN+vZ
         KZ1yN6rAPUk0XQiipHZUkewIuLnD4EIq5YhU+rPxZd86GicbrkyfhoYgBancfQxHbUY1
         NdJsmJhbUf7TX98hwSDoja6v3trbxl1MFDPQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=NHf5IS0iXdmYYVGyLR+Vh9J24UhnAQebV3tBzsq3Cnjoy210Gy7UcAJKR+mdWmCkp9
         XcgcCvKOPz6F3J+uxpSMo2tyOmsYPomTn84Zl8MTJi0cnmlghguR+F+A/0971O4f+cmq
         skGd7EaFmvrC5uuW6vx7KfhjiugVtRgq3yspA=
Received: by 10.101.181.26 with SMTP id i26mr1112741anp.56.1255650477911; Thu, 
	15 Oct 2009 16:47:57 -0700 (PDT)
In-Reply-To: <7vfx9k1faa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130439>

On Thu, Oct 15, 2009 at 3:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>     $ git checkout origin/next ;# ditto
>>     $ git symbolic-ref HEAD
>>     refs/remotes/origin/next
>
> Ok, after reading Daniel's message to remind us that "git fetch" after
> this will get us into trouble, I agree that detaching HEAD is inevitable.

Some people liked the idea, so let's not give up just yet.  Here are a few
things Git could do when a fetch wants to update the currently checked out
branch:

1. Refuse the fetch.
2. Update the ref, leaving the user with a work tree and index that don't
   match their HEAD.
3. Detach the HEAD, then update the ref.
4. Update the ref, then check it out.

Option 1 is ok, as long as the "next step" is not too complicated.  It's no
good if the user has to checkout a different branch, then fetch, then
checkout the original branch again.

Option 2 is crap.

Option 3 seems reasonable, but it might be just as scary/confusing to
newbies as the current behavior, so I don't think it should be the default.

Option 4 also seems reasonable, but you run into problems if the user had
changed the index or work tree.  In that case Git could do 'checkout
--merge' automatically.  This option is also less "pure" since it lets 'git
fetch' modify the index and work tree.

So how about this:
* 'git fetch' refuses the fetch by default.
* 'git fetch --detach' detaches HEAD, then updates the ref
* 'git pull' detaches HEAD, updates the ref, then checks out the new ref
  with --merge.

BTW I'm not convinced this is any better than the current UI... just
thinking out loud.  And I find it more than a little depressing that most
of these ideas have already been discussed almost 3 years ago (thanks Jeff
for the pointer).

James
