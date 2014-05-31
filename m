From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] check_refname_component: Optimize
Date: Sat, 31 May 2014 18:21:19 +0700
Message-ID: <CACsJy8BcmT1AKe=EYrYUs9Xyu9YUNbA3YUDafg2rZ9fabVgEiQ@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Sat May 31 13:21:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqhMI-0001b2-Jl
	for gcvg-git-2@plane.gmane.org; Sat, 31 May 2014 13:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756490AbaEaLVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2014 07:21:50 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:48888 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754547AbaEaLVt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2014 07:21:49 -0400
Received: by mail-qa0-f49.google.com with SMTP id cm18so256406qab.8
        for <git@vger.kernel.org>; Sat, 31 May 2014 04:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=n9j5RtHy2fRl2DcK0VNQHdzyzOguLO6b2unEQOPMpOo=;
        b=Jz6KI6jKgEFx8JdlJmubwSJCnFhSxe/llwwDJdsCzjTfUvunAm4H5TE1lOKB3VbgcG
         VgfwKPmVg6LDG5VMONGC1w/U6Fp7DfqXtxmS90nwpOByCZAcin12Tvy0cibjxTeYBnJf
         dksbmhcjlkVcYspw6WQHKJMEDuvK7nnpbwjuZxYEWWoEVw7404DPDW3lAhc/WOpgPIQx
         O+KdWt8mHt6b7EuCI1SWM8efCYwgMTpFT0oYSNwkRoeSgJp9AcJAR7nrHx2LGg8dwaYR
         w5c0QNjcWx+/YrUltN6MpXIIcbA0QE8T6t4zIbSFLvmQMDBEWc6VhvYOHYILGUKXEpzw
         StpQ==
X-Received: by 10.140.91.161 with SMTP id z30mr27737992qgd.65.1401535309044;
 Sat, 31 May 2014 04:21:49 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Sat, 31 May 2014 04:21:19 -0700 (PDT)
In-Reply-To: <20140530000728.GC28683@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250507>

On Fri, May 30, 2014 at 7:07 AM, Jeff King <peff@peff.net> wrote:
> But then we're just trusting that the "trust me" flag on disk is
> correct. Why not just trust that packed-refs is correct in the first
> place?

I missed one thing in the first reply: because packed-refs is a plain
text file, the user could be tempted to edit it manually (I know I did
a few times for fast rename) and so it could not be trusted. If we
ignore this (and I think we can, it's not like we encourage people to
edit files in $GIT_DIR), then #3 and #4 are as good as #2.

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
-- 
Duy
