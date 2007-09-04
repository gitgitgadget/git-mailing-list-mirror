From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] Functions for updating refs.
Date: Wed, 5 Sep 2007 01:32:32 +0200
Message-ID: <1b46aba20709041632x60ee4d3eweae9f5217d2f3b86@mail.gmail.com>
References: <46DD6020.4050401@gmail.com>
	 <7v642qnwr7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 01:32:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IShsu-0005sK-9F
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 01:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713AbXIDXcf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 19:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754651AbXIDXcf
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 19:32:35 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:2505 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754290AbXIDXce (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 19:32:34 -0400
Received: by wr-out-0506.google.com with SMTP id 36so964271wra
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 16:32:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OgQJK26tekpG1768MB9pjIwJLWMKbqFjz/R9MSHQ1AbzOgE6Y8YbBwl/EOb/Wz9Q/kcaN04mQe3r+i7+DscE6IDrsFXv4tC+gY7UZ5VTv/mNZkPoQdwCX75v0EkHHBSP2JJ/ab+GhCoFAUKLxmETO/b8hh08GlH6JpsOK98UslQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EszQeGyx58k4f5OI9dnlYwLpdZmddW1wJ//MXZXiPOzvAJQXhDCjgUOwG1zZ4lTQj88DqwaguGW0CfBqFnd+4ShmmhRDrQBvXNIe24OMCBCqNXwCHU6dgh6AUZHzHiberwF3tr3D5UKhHPcD+gcejig4YwEwANUMwACD5/42R9s=
Received: by 10.142.51.4 with SMTP id y4mr324510wfy.1188948752539;
        Tue, 04 Sep 2007 16:32:32 -0700 (PDT)
Received: by 10.143.10.14 with HTTP; Tue, 4 Sep 2007 16:32:32 -0700 (PDT)
In-Reply-To: <7v642qnwr7.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57658>

2007/9/4, Junio C Hamano <gitster@pobox.com>:
> Carlos Rica <jasampler@gmail.com> writes:
>
> > diff --git a/refs.c b/refs.c
> > index 09a2c87..4fd5065 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -1455,3 +1455,35 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
> >  {
> >       return do_for_each_reflog("", fn, cb_data);
> >  }
> > +
> > +int update_ref_or_die(const char *action, const char *refname,
> > +                             const unsigned char *sha1,
> > +                             const unsigned char *oldval, int flags)
> > +{
> > +     static struct ref_lock *lock;
> > +     lock = lock_any_ref_for_update(refname, oldval, flags);
> > +     if (!lock)
> > +             die("Cannot lock the ref '%s'.", refname);
> > +     if (write_ref_sha1(lock, sha1, action) < 0)
> > +             die("Cannot update the ref '%s'.", refname);
> > +     return 0;
> > +}
> > +
> > +int update_ref_or_error(const char *action, const char *refname,
> > +                             const unsigned char *sha1,
> > +                             const unsigned char *oldval, int quiet)
> > +{
> > +     static struct ref_lock *lock;
> > +     lock = lock_any_ref_for_update(refname, oldval, 0);
> > +     if (!lock) {
> > +             if (!quiet)
> > +                     error("Cannot lock the ref '%s'.", refname);
> > +             return 1;
> > +     }
> > +     if (write_ref_sha1(lock, sha1, action) < 0) {
> > +             if (!quiet)
> > +                     error("Cannot update the ref '%s'.", refname);
> > +             return 1;
> > +     }
> > +     return 0;
> > +}
>
> This makes me wonder three things:
>
>  - Why doesn't "or_error" side allow "flags" as "or_die" one?
>    Could the 'quiet' option become part of "flags" perhaps?

I saw that the only code that needed the flags was the
builtin-update-ref.c, and it also needed to die(). The
others I saw only want that parameter set to 0.
builtin-tag.c was doing die() also, not using flags, though.

>  - They look quite similar.  Is it a good idea to refactor them
>    further, or they are so small it does not matter?

I would like to know how to refactor it, however the code I saw
sometimes needs to call die(), others to error() and others
need to get only a value of success or not.

The function die() returns 128 and terminates the program,
prepending "fatal: " in the message, while error() doesn't exit
and prepend "error: ", so they were very different and I
resolved to separate them.

Another option is returning different error codes, so
the caller could decide what to output in each case, but
I thought that these functions were only useful to unify those
instructions with those error messages for this common
operation that many builtins use, specially when they come
from scripts who call to "git update-ref".

>
>  - Why isn't lock released with unlock_ref()?

I inspected this some weeks ago, and I finally came to think
that it is released in the write_ref_sha1 call after the lock.
But the code was complex, can someone confirm this?
