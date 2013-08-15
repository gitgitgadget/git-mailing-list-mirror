From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v5 1/2] branch: not report invalid tracking branch
Date: Thu, 15 Aug 2013 10:14:40 +0800
Message-ID: <CANYiYbHC1oXjMy9tb7vRJmq2LMzk0yXwjm_kMoM-U7cqvrjiZA@mail.gmail.com>
References: <CANYiYbFGBRV+EP8oV_chKvBsHLAAZeKmt0395_z9QD-bBZtErQ@mail.gmail.com>
	<96e0ed4f67eaf058466ead9228cad0dcfe1b5c6a.1376369554.git.worldhello.net@gmail.com>
	<7vfvucuwm7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 15 04:14:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9n5K-0007Oj-LK
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 04:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759105Ab3HOCOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 22:14:42 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:52938 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754447Ab3HOCOm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 22:14:42 -0400
Received: by mail-we0-f172.google.com with SMTP id t61so159520wes.3
        for <git@vger.kernel.org>; Wed, 14 Aug 2013 19:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bizm+uFrFpJeFodJLkU9TifEuR9JsblJpixckHNYf3w=;
        b=aVDjDe8HP9KOfLQmZ+7pSTOhNVB17H4wbZ7LIjR2mXuG3wXfQJ4UTzul2ToqRh6oyO
         SzGS/L+jqJ7Oj5XuzSxuQcE5xkyMKNEGDJ62Cbfx+6YA4nv8NXk0LfvY1oADi2cwzpoL
         kkV3fzv5hr+G5aM7ch04ypybDklUiA9jJd0XBSxZYDjt0tfJqC8TWNHgOPdgtpQ86/hD
         3BiKSB3gtk7TrxP6cO/13TaaHwKDl4VlQsGodWMQrl7UQvn8O+Y9/KsDul1Uvuub58ro
         oEAmH6LtxcJtVcXSDry+lonVoPBJdG4TmfwVxzMg/xcDCu52xKHvUIm8BU25pmUAfYsE
         iVjQ==
X-Received: by 10.194.11.38 with SMTP id n6mr6811443wjb.25.1376532880492; Wed,
 14 Aug 2013 19:14:40 -0700 (PDT)
Received: by 10.194.104.201 with HTTP; Wed, 14 Aug 2013 19:14:40 -0700 (PDT)
In-Reply-To: <7vfvucuwm7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232326>

2013/8/14 Junio C Hamano <gitster@pobox.com>
> >  /*
> > - * Return true if there is anything to report, otherwise false.
> > + * Return false if cannot stat a tracking branch (not exist or invalid),
> > + * otherwise true.
> >   */
> >  int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
> >  {
> > @@ -1740,18 +1741,12 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
> >       const char *rev_argv[10], *base;
> >       int rev_argc;
> >
> > -     /*
> > -      * Nothing to report unless we are marked to build on top of
> > -      * somebody else.
> > -      */
> > +     /* False unless we are marked to build on top of somebody else. */
>
> Aren't these saying the same thing?  I'd rather see the comment say
> "nothing/something to report", instead of "false/true".  The latter
> can be read from the value returned in the code, and writing that in
> the comment is redundant.  The former tells the reader what that
> "false" _means_, which is the whole point of adding a comment.

Maybe "Cannot stat unless ..." is better than "Nothing to report unless ...",
because this patch change the meaning of returns of stat_tracking_info().
And I have already updated the comments for this function.

>
> > +     *num_theirs = 0;
> > +     *num_ours = 0;
> > +
> >       /* are we the same? */
> >       if (theirs == ours)
> > -             return 0;
> > +             return 1;
>
> Shouldn't these zero assignments belong to this condition?  I.e.
>
>         if (theirs == ours) {
>                 *num_theirs = *num_ours = 0;
>                 return 1;
>         }

I will refactor like this,

> > @@ -1786,8 +1784,6 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
> >       prepare_revision_walk(&revs);
> >
> >       /* ... and count the commits on each side. */
> > -     *num_ours = 0;
> > -     *num_theirs = 0;
> >       while (1) {
> >               struct commit *c = get_revision(&revs);
> >               if (!c)

and these two variables(*num_ours and *num_theirs) have to be
initialized here again.

> > @@ -1815,6 +1811,10 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
> >       if (!stat_tracking_info(branch, &num_ours, &num_theirs))
> >               return 0;
> >
> > +     /* Nothing to report if neither side has changes. */
> > +     if (!num_ours && !num_theirs)
> > +             return 0;
>
> As far as I can tell, all callers of stat_tracking_info() pass
> non-NULL pointers to these two parameters, with or without your
> patch.  Can this ever trigger?
>
> The changes you made to builtin/branch.c seems to expect that
> returned *num_ours and *num_theirs could both be 0, so it does not
> look like the above is a typo of
>
>         if (!*num_ours && !*num_theirs)
>                 return 0;
>

It's really easy to make people puzzled, since these two hunks in this patch
both have two similar variables: num_ours and num_theirs. But they are
different.

In previous hunk, num_ours and num_theres are from stat_tracking_info(),
and they are pointers.

    int stat_tracking_info(struct branch *branch,
                           int *num_ours,
                           int *num_theirs)

But in this hunk, num_ours and num_theres are defined as integers in
funciton  format_tracking_info().

    int format_tracking_info(struct branch *branch, struct strbuf *sb)
    {
        int num_ours, num_theirs;

To make it clear, I should change the variables name to ours and theirs
just like function fill_tracking_info() in builtin/branch.c.

-- 
Jiang Xin
