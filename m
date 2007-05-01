From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 4/8] git-repack --max-pack-size: add fixup_header_footer()
Date: Mon, 30 Apr 2007 22:41:33 -0700
Message-ID: <56b7f5510704302241n79601619kda8251a9f7776884@mail.gmail.com>
References: <463679EB.2010301@gmail.com> <20070501050633.GZ5942@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 01 07:41:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hil7K-0005e5-O1
	for gcvg-git@gmane.org; Tue, 01 May 2007 07:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423794AbXEAFlf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 01:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423798AbXEAFlf
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 01:41:35 -0400
Received: from nz-out-0506.google.com ([64.233.162.231]:53552 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423794AbXEAFle (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 01:41:34 -0400
Received: by nz-out-0506.google.com with SMTP id o1so2143810nzf
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 22:41:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pSpd1Ot67SKrhgiry6MVCvSLf70Z4xM7shBTrVi2IN9iH3DX7wKOW54cDzqtekYUrP/A6msKqXSb5neSYvI5KvXN4lkAHYP7VyxtwGZk3S+5+D+RDwyIN21Pk/asc2UA/xL74ekOf7W6DxFmeo73zosrw5HmvPXk+i05ZdvjHmY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TXDyUIMiR1XhFLe22gpwedj7VcGzvAIMPp5X8wtSvhBH1UTaB6yjLx4OSfBa4Es6DAO6FwUflkr0kpQAfZrhCOvgoSmIcXdYJD4L75vnvUxxv9U0g63LmwWhc1TFW8XyWYbRZUN8bZ/VySHtaXwmDohwO4MyIt+EkrelLoVNu64=
Received: by 10.114.106.1 with SMTP id e1mr684552wac.1177998093393;
        Mon, 30 Apr 2007 22:41:33 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Mon, 30 Apr 2007 22:41:33 -0700 (PDT)
In-Reply-To: <20070501050633.GZ5942@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45917>

On 4/30/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Dana How <danahow@gmail.com> wrote:
> > Add our own version of the one in fast-import.c here.
> > Needed later to correct bad object count in header for split pack.
> ...
> > diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> > --- a/builtin-pack-objects.c
> > +++ b/builtin-pack-objects.c
> > @@ -562,6 +562,42 @@ static off_t write_one(struct sha1file *f,
> > +static void fixup_header_footer(int pack_fd, unsigned char *pack_file_sha1,
> > +                             char *pack_name, uint32_t object_count)
> > +{
>
> This looks a *lot* like the code in fast-import.c.
I hope so!  That's where I copied it from.

> Why not
> refactor both to use the same implementation and stuff it away in
> say pack-check.c (for lack of a better place), or start a new file
> (pack-write.c)?
Actually I didn't just copy it, I tried to rewrite it for my use
as well as the fast-import.c use (note there is a 3rd copy
in some *index*.c file which I didn't try to merge in yet).
However I didn't yet put it in a new file or change fast-import.c
to call it since I wanted to change as little as possible.

> There is a *lot* of code in fast-import.c (over 2,000 lines) that
> was half-copied from other core code, and that was half created
> on its own.  This is also true in index-pack.c and pack-objects.c;
> I'd like to see these implementations unify more rather than copy
> code from each other.
>
> I know git-blame will identify the original author quite well,
> but I'd really like to avoid adding lots more code to maintain
> if we can avoid it.

I agree with all your arguments.  I had several reasons
to avoid extra rearrangements/refactorings:
(a) First patch to git, not previously known to me;
(b) I prefer to separate new functionality from "clean-up" work;
(c) I didn't really view myself as the person to make the *writing*
    code in git as well organized/minimized as the *reading* code
    [e.g. the sliding mmap stuff -- nice!];
(d) Apparently you and Nicolas Pitre have a lot of pending changes
    affecting the packing code.

I'd have no problem submitting a follow-on patch later containing
some clean-up work if you & NP clear it, so I know I won't have
problems from (d).  Note I had to completely rewrite this patch
when NP submitted some of his pending stuff.

NP wrote that you posted a summary of v3/v4 pack ideas,
but I couldn't find it in the list archives.  Could you either
email it to me, or (re-)post it to the list?

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
