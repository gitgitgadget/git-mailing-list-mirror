From: Stefan Naewe <stefan.naewe@gmail.com>
Subject: Re: [PATCH] revision.c: fix possible null pointer access
Date: Thu, 3 Dec 2015 22:15:56 +0100
Message-ID: <CAJzBP5SNeuMcKLqdCBrHsYHdmOnuvyrvk7wao4b30Op2SE_ykw@mail.gmail.com>
References: <1449171136-31566-1-git-send-email-stefan.naewe@gmail.com>
	<xmqqlh9bthyb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitlist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 22:16:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4bEQ-0002LM-GB
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 22:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077AbbLCVP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2015 16:15:58 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34660 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064AbbLCVP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2015 16:15:57 -0500
Received: by wmvv187 with SMTP id v187so46978244wmv.1
        for <git@vger.kernel.org>; Thu, 03 Dec 2015 13:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=x0Y7Fn3hdLcKZRyhkJ442JzIQPStPZD38McRgA5LEZ4=;
        b=eXBYotw+XfMUW8FDy8I970pJjieKwUj3IWJp8gVB9yXdFPsq8rFRXaLxQseXafCGeP
         r1MS4iW2gktzR55WxiAqnj7ld4JE9ReoXR5qObNdl5nXxZ1yeK3jbjcqK1rDnpZR0xGy
         jvV8RqxRjHnfSSMVkH9ocFpvFHEWdUd6go4Fs9XGthznIRbGZ/HVj20tYOpCFYO8QCGR
         UaPCeA4zOl0n19hKH/jJvSg21lcYPYjJk3xnwwNRXZQ018n8mbUjJXxIZcq0XSr/Z8Hr
         9KeEovzddk5SLB6M9hn/DzCPwmIGlYFrw2bJTELI+1uN+YxfB37N7P/GS85vmiV4t4K8
         zc/A==
X-Received: by 10.28.227.198 with SMTP id a189mr792149wmh.74.1449177356411;
 Thu, 03 Dec 2015 13:15:56 -0800 (PST)
Received: by 10.28.234.146 with HTTP; Thu, 3 Dec 2015 13:15:56 -0800 (PST)
In-Reply-To: <xmqqlh9bthyb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281973>

On Thu, Dec 3, 2015 at 9:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Naewe <stefan.naewe@gmail.com> writes:
>
> > Two functions dereference a tree pointer before checking
>
> Reading them a bit carefully, a reader would notice that they
> actually do not dereference the pointer at all.  It just computes
> another pointer and that is done by adding the offset of object
> member in the tree struct.
>
> > if the pointer is valid. Fix that by doing the check first.
> >
> > Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
> > ---
> > This has been reported through the CppHints newsletter (http://cpphints.com/hints/40)
> > but doesn't seem to have made its way to the ones who care (the git list
> > that is...)
>
> Nobody would be surprised, unless the newsletter was sent to this
> list, which I do not think it was (but if it was sent while I was
> away, then it is very possible that I didn't see it).
>
> >  revision.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/revision.c b/revision.c
> > index 0fbb684..bb40179 100644
> > --- a/revision.c
> > +++ b/revision.c
> > @@ -104,7 +104,12 @@ static void mark_tree_contents_uninteresting(struct tree *tree)
> >  {
> >       struct tree_desc desc;
> >       struct name_entry entry;
> > -     struct object *obj = &tree->object;
> > +     struct object *obj;
> > +
> > +     if (!tree)
> > +             return;
> > +
> > +     obj = &tree->object;
>
> This is questionable; if you check all the callers of this function
> (there are two of them, I think), you would notice that they both
> know that tree cannot be NULL here.

OK.

>
> >
> >       if (!has_sha1_file(obj->sha1))
> >               return;
> > @@ -135,10 +140,13 @@ static void mark_tree_contents_uninteresting(struct tree *tree)
> >
> >  void mark_tree_uninteresting(struct tree *tree)
> >  {
> > -     struct object *obj = &tree->object;
> > +     struct object *obj;
> >
> >       if (!tree)
> >               return;
> > +
> > +     obj = &tree->object;
> > +
> >       if (obj->flags & UNINTERESTING)
> >               return;
>
> This one is not wrong per-se, but an unnecessary change, because no
> deferencing is involved.

But 'tree->object' is dereferencing tree, isn't it ? Like '(*tree).object'.

??

> At least, please lose the blank line after
> the new assignment.

Will do, if you want this patch at all.

> >       obj->flags |= UNINTERESTING;
>
> Thanks.

Thanks,
  Stefan
-- 
----------------------------------------------------------------
python -c "print '73746566616e2e6e6165776540676d61696c2e636f6d'.decode('hex')"
