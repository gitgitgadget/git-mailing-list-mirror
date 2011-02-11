From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] mergetool: don't skip modify/remove conflicts
Date: Thu, 10 Feb 2011 21:46:12 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102102130040.29809@debian>
References: <1297134518-4387-1-git-send-email-martin.von.zweigbergk@gmail.com> <7vzkq4opaw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 03:46:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pnj1k-0008Vr-KT
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 03:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356Ab1BKCqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 21:46:20 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49696 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231Ab1BKCqT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 21:46:19 -0500
Received: by vws16 with SMTP id 16so1381077vws.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 18:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=r+4ns9ZbEodw37iX0+nLPMHlEZ2k2QcluKsPke0wgIs=;
        b=mIXgVtN7sIsxMercZiIxMayXWsbo51r+vsgijc3s62plN0p4y3FJQsvIW4Rsdgcxet
         a99IngjJ+Vh6gA398cJWb0nneFMOZZjl2tzvQdpVEfhUh/EpKK/Anwi9gEktpyQwptMd
         SpILQr5oFnsVyiolv/AnyyxVMVgenOmAGlN70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=yC3Qljdf+ZEk+j6nTIWOys1uUMYGhOBuUi2TrTD/CarIsCowfrPl2affOKvnpsCfUK
         EBFChRXnFwE69GPWxUz6812Qi8Lm+BbR3ux4V2GIU/1QYBCuq4Ix9Rvsa467jzwQzXiF
         8R+Lz8nD2F0TS4ZJDyQh4rLrHQZNKD9XKyn7s=
Received: by 10.220.76.132 with SMTP id c4mr5523657vck.252.1297392378854;
        Thu, 10 Feb 2011 18:46:18 -0800 (PST)
Received: from [192.168.1.104] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id l6sm167536vcp.14.2011.02.10.18.46.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 18:46:17 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <7vzkq4opaw.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166535>

On Wed, 9 Feb 2011, Junio C Hamano wrote:

> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
> 
> > +extern void *RERERE_UTIL_STAGED;
> 
> This is for what kind?  The contents on the filesystem is ready to go,
> added to the index, but still in MERGE_RR (i.e. "git rerere" not run yet)?

Correct.

> Is the real problem that git-mergetool is not running rerere when it
> should, I wonder...

You mean that maybe it should call rerere for files that are added to
the index?

> >  		it = string_list_insert(conflict, (const char *)e->name);
> > -		it->util = NULL;
> > +		it->util = RERERE_UTIL_PUNTED;
> >  		if (ce_stage(e) == 1) {
> > +			it->util = RERERE_UTIL_STAGED;
> 
> Hmm, I thought that you were taling about paths that the user
> hand-resolved and then ran "git add" on.  Why is this marked "STAGED"?

Very good question. It shouldn't.

> Either your logic is wrong, or the name of the symbol is.

The former. What I really wanted to check is if the file has been
added to the index. I am currently struggling with how to do this
correctly. My inexperience with the git internals makes it a very slow
process with a lot of guesses and trial and error.

> > -		if (!conflict.items[i].util)
> > -			continue; /* punted */
> > +		if (conflict.items[i].util == RERERE_UTIL_PUNTED ||
> > +			conflict.items[i].util == RERERE_UTIL_STAGED)
> > +			continue;
> 
> There are a few repetition of "if it is marked with PUNTED or STAGED"; can
> you make it into a small helper function and give it a _meaningful_ name?
> What does it mean for an entry to be marked with either of these marks?

There is another big problem here. I had not realized that the util
field would be freed later (being spoilt by GCing languages, I guess)
and that will of course fail if it is one of the two constants I
defined. I stupidly did not run the commands manually, but relied only
on the test cases, so I didn't notice the segfault at the end. Somehow
all the test cases still pass.

I think this means that anyone intending to run rerere should not
build pu at the moment, right? I'm really sorry about the
inconvenience :-(. 

/Martin
