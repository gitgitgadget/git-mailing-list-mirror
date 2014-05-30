From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] check_refname_component: Optimize
Date: Fri, 30 May 2014 09:03:58 +0700
Message-ID: <CACsJy8CAhGT+dF511cbLZTEre9SKzs2EHfHaskuXh7sMTYL6JQ@mail.gmail.com>
References: <1401311055-480-1-git-send-email-dturner@twitter.com>
 <1401311055-480-2-git-send-email-dturner@twitter.com> <538658C0.8050001@alum.mit.edu>
 <1401320968.18134.98.camel@stross> <CACsJy8BcBmuC3KMu+5dhGiOXX=u7WtHWQzQuT=ZPTbSCduJdbw@mail.gmail.com>
 <xmqqfvjsbkz2.fsf@gitster.dls.corp.google.com> <CACsJy8BS_YhMB9ZZRx4faj=_YWZQrqm7B9AHkTGye=okja=m-Q@mail.gmail.com>
 <20140529234109.GA28683@sigill.intra.peff.net> <CACsJy8BgriBBWJ6ZzQS8S7p4SUB=bdZHdnUQsyN03g+vtApbxA@mail.gmail.com>
 <20140530000728.GC28683@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 30 04:04:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqCBN-000296-Ta
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 04:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbaE3CE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 22:04:29 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:39917 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbaE3CE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 22:04:29 -0400
Received: by mail-qg0-f41.google.com with SMTP id j5so3568507qga.28
        for <git@vger.kernel.org>; Thu, 29 May 2014 19:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pTt7rIOJQe5nOIPr+vuRuFVluuocV6yBNtCknWTdjN4=;
        b=v+jyzLsDKn8Xj+Va3n5abe7JgRusZvsHgmwiR2Y/z59Mks0ar4DB619obc7Vt8ux8s
         UflRxyoS9Qa/Y4RjTpUK4Ay7k8ff+EsqbzauxyaUldg8wXiXqxdcCVq8R/HDK5onyJWK
         cW/GC1iLYtt+xdL9LCCIg+lrrhl7TfsdDdz/AnrJ+LMtBUUUiFWNhZGJfl51bD7Svssy
         xHX7CluY2aEzJD3FjEO10aey+sTk73ik24t/oWzwuuYru0Aggot9axLmYwp9ngYTy36I
         HjB7IBuVKXok8GLp3Ke1Z5UE6M9oOc4I8MOh/kE/8Wu3S8ZgqCY3v1ne29p3LhpDErll
         WBnQ==
X-Received: by 10.140.47.167 with SMTP id m36mr15133189qga.21.1401415468106;
 Thu, 29 May 2014 19:04:28 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Thu, 29 May 2014 19:03:58 -0700 (PDT)
In-Reply-To: <20140530000728.GC28683@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250429>

On Fri, May 30, 2014 at 7:07 AM, Jeff King <peff@peff.net> wrote:
> But then we're just trusting that the "trust me" flag on disk is
> correct. Why not just trust that packed-refs is correct in the first
> place?
>
> IOW, consider this progression of changes:
>
>   1. Check refname format when we read packed-refs (the current
>      behavior).
>
>   2. Keep a separate file "packed-refs.stat" with stat information. If
>      the packed-refs file matches that stat information, do not bother
>      checking refname formats.
>
>   3. Put a flag in "packed-refs" that says "trust me, I'm valid". Check
>      the refnames when it is generated.
>
>   4. Realize that we already check the refnames when we write it out.
>      Don't bother writing "trust me, I'm valid"; readers can assume that
>      it is.
>
> What is the scenario that option (2) protects against that options (3)
> and (4) do not?
>
> I could guess something like "the writer has a different idea of what a
> valid refname is than we do". But that applies as well to (2), but just
> as "the reader who wrote packed-refs.stat has a different idea than we
> do".

The reader and the writer have to agree on the same "valid" definition
or it wouldn't work. I don't suppose this packed-refs.stat idea would
spread out to other implementations than C git, so we're still good.
If we could write a flag in packed-refs saying "trust me" and other
implementations will strip it when they update packed-refs, then we're
good too.

>
> As a side note, while it is nice that we might make check_refname_format
> faster, I think if you _really_ want to make repos with a lot of refs
> faster, it would make more sense to introduce an on-disk format that
> does not need linear parsing (e.g., something we could mmap and binary
> search, or even something dbm-ish that could be updated without
> rewriting the whole file (deletions, for example, must rewrite the
> whole file, giving quadratic performance when deleting all refs one by
> one).

Yeah, I bring up the idea because I think Mike's multiple ref backends
is the way to go (assuming that it won't take as long as pack v4
development). If we assume we'll go with that, then we can keep the
workaround to minimum.
-- 
Duy
