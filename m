From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH V2 6/6] WIP/RFC/entry.c: fix a memleak
Date: Fri, 27 Mar 2015 20:14:28 -0400
Message-ID: <CAPig+cR8zA_FLhhnUgKZPdUFpCM3yNKNfbEBH+yoY=G44xGk8w@mail.gmail.com>
References: <1427495569-10863-1-git-send-email-sbeller@google.com>
	<1427495569-10863-7-git-send-email-sbeller@google.com>
	<CAPig+cSHntg6KwZr3h6nhO7AK0v+FcbVAA4b_kvHdEg_=9o_eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	John Keeping <john@keeping.me.uk>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 01:14:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbeOl-0002wH-GW
	for gcvg-git-2@plane.gmane.org; Sat, 28 Mar 2015 01:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbbC1AOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 20:14:31 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:36722 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbbC1AOb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 20:14:31 -0400
Received: by labe2 with SMTP id e2so81988864lab.3
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 17:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=mNVL5SMXJtLXnElHS6WMQ4Tb02nOlTACNb4vA40kyDQ=;
        b=FBafOJnjOXEN0dsMy5rS+Qj7OyKx5e3JThq+gk5Nt626IeaG6IrYww0kkCsf0MXJRo
         PckqBSIFAc22KvuHPiz2PnWPOgCr5mQw4nreJLlGOtacdz5oBjoQ66/M4qSz+nBejix/
         makmTkH7+pHH4jYLGnKMCizGARPaX73BA+oR4IV/xVVIMqWpyqbErfn3hkokKF5EqgsZ
         gjt7N2vMnHqGqrtUju7VR9ZJY36jenwW0I5RhSOgZhhQbRm+zWxuGJhnJWvJrV9TZGys
         /2exby0pUr7QJZx8PL+oyOrfKyXVSQRb6tYBFFiejGSk65Lt1TD+yr+JyLYcsDKMHCrk
         AYzw==
X-Received: by 10.152.20.37 with SMTP id k5mr5459470lae.102.1427501669020;
 Fri, 27 Mar 2015 17:14:29 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Fri, 27 Mar 2015 17:14:28 -0700 (PDT)
In-Reply-To: <CAPig+cSHntg6KwZr3h6nhO7AK0v+FcbVAA4b_kvHdEg_=9o_eg@mail.gmail.com>
X-Google-Sender-Auth: vNwA-EOTb7ow8RaSs_QzztvKSCE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266409>

On Friday, March 27, 2015, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Mar 27, 2015 at 6:32 PM, Stefan Beller <sbeller@google.com> wrote:
> > I  observe that filter is going out of scope, but the
> > implementation proposed in this patch produces just a
> > crash instead of any helpful fix.
> >
> > Signed-off-by: Stefan Beller <sbeller@google.com>
> > ---
> > diff --git a/entry.c b/entry.c
> > index 1eda8e9..5383001 100644
> > --- a/entry.c
> > +++ b/entry.c
> > @@ -152,8 +152,10 @@ static int write_entry(struct cache_entry *ce,
> >                 if (filter &&
> >                     !streaming_write_entry(ce, path, filter,
> >                                            state, to_tempfile,
> > -                                          &fstat_done, &st))
> > +                                          &fstat_done, &st)) {
> > +                       free_stream_filter(filter);
>
> Aside from the crash you are seeing, this is a bogus fix anyway.
> You're only freeing 'filter' if it was allocated _and_ if
> streaming_write_entry() returned 0. I would guess your intention was
> to free 'filter' regardless of the result of streaming_write_entry().

Unless streaming_write_entry() is freeing the filter for you -- there
is a free_stream_filter() call in close_method_decl() in streaming.c
-- in which case your new free_stream_filter() call would attempt to
free the already-freed filter.
