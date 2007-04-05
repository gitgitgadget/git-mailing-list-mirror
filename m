From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 10/13] update delta handling in write_object() for --pack-limit
Date: Thu, 5 Apr 2007 16:41:03 -0700
Message-ID: <56b7f5510704051641s69c9bdf1t8ce75385456bb4da@mail.gmail.com>
References: <56b7f5510704051538na4393d7k5e51ed2a511cc86e@mail.gmail.com>
	 <7v3b3emmv6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 01:41:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZbZl-0000yk-Pq
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 01:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbXDEXlG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 19:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbXDEXlG
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 19:41:06 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:45283 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbXDEXlF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 19:41:05 -0400
Received: by wr-out-0506.google.com with SMTP id 71so474608wri
        for <git@vger.kernel.org>; Thu, 05 Apr 2007 16:41:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BhY8HUUlhY+l5Al8wP7EOsBIXqnTmqUP+hiZcPnk28otzle1mD2U5UjBf99ttdcVw5n2YdjznEaKyv9d98LOJC8ZzMXHdaP8Yb3LdV+e6uzAB4ARVQSPT/q72pODOj3SGVHdX0+sfft3Y/w2mOMrUyghGDFoQzFXvU2YxQksZWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b4OoiF57NQTP+nF5z4XHwFl3KUMqq4WCjIbLfzab2Fnm6jbEuel4J89rcArBE28wGH1kiZ0lCPnQ80on2QBuLhiT8QTGydicE3gxpZoM/4+z9bEmQ0GmKms47P9h9bg68DhUL7l7eP8G9zcordg5sSm8Jlc0W0Ka6R3U7L6nGZ8=
Received: by 10.114.179.1 with SMTP id b1mr992189waf.1175816463656;
        Thu, 05 Apr 2007 16:41:03 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Thu, 5 Apr 2007 16:41:03 -0700 (PDT)
In-Reply-To: <7v3b3emmv6.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43885>

On 4/5/07, Junio C Hamano <junkio@cox.net> wrote:
> "Dana How" <danahow@gmail.com> writes:
> >       if (!to_reuse) {
> > +             int usable_delta =      !entry->delta ? 0 :
> > +                                     !offset_limit ? 1 :
> > +                                     entry->delta->no_write ? 0 :
> > +                                     entry->delta->offset ? 1 : 0;
> >               buf = read_sha1_file(entry->sha1, &type, &size);
> >               if (!buf)
> >                       die("unable to read %s", sha1_to_hex(entry->sha1));
> >               if (size != entry->size)
> >                       die("object %s size inconsistency (%lu vs %lu)",
> >                           sha1_to_hex(entry->sha1), size, entry->size);
> > -             if (entry->delta) {
> > +             if (usable_delta) {
> >                       buf = delta_against(buf, size, entry);
> >                       size = entry->delta_size;
> >                       obj_type = (allow_ofs_delta && entry->delta->offset) ?
>
> This really needs explanation on *why*, at least in the commit
> log, and perhaps also in the code as comment.
Yes,  I need retraining ;-)  I'm accustomed to more expensive
commits in which the log message describes the objective,
not the details.  Or,  I could have followed the example of the
comments on the initialization for "to_reuse".

> Here is my attempt to understand that logic (please make
> necessary corrections).
>
>  (1) When there is no delta base found by the earlier
>      find_deltas()/try_delta() loop, obviously we cannot write
>      deltified so we write plain.
>
>  (2) Otherwise if we are not offset limited, then we keep the
>      old way of using that delta base.
>
>  (3) If the delta base is not in this pack (because of
>      offset-limit chomping the pack into two or more), then we
>      cannot use it as the base.
>
>  (4) If the delta has already been written, we can use it as the
>      base for this object, but otherwise we cannot.
>
> (3) makes me wonder if we can still allow it in the thin-pack
> case by just loosening the condition here.
You are correct.  In response to someone's previous question I think
I said I hadn't handled the --thin-pack cases yet.  Do you
think these will matter?  There is strong sentiment on this list that a pack
should be split at the receiver, not the transmitter, so --thin-pack
and --pack-limit wouldn't be used together.  If you think this
combination does matter,  I'd prefer to add the extra cases
in a separate follow-on patch if that's OK.

> Also I need explanation to understand why (4) is needed --
> doesn't write_one() always write base object out before writing
> a deltified object that depends on it?
Yes, write_one() does that. I was being too cautious,
since I had only known (some of) the code for a few hours!
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
