From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] Rename read_pipe() with read_fd() and make its buffer nul-terminated.
Date: Wed, 18 Jul 2007 17:40:09 +0200
Message-ID: <1b46aba20707180840l6c12fecfy4c610fe3a1a36c5e@mail.gmail.com>
References: <469DBC8A.6090704@gmail.com>
	 <7vps2q6tjf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"=?ISO-8859-1?Q?Kristian_H=F8gsberg?=" <krh@redhat.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 17:40:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBBdQ-0004BY-EK
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 17:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363AbXGRPkN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 11:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758738AbXGRPkM
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 11:40:12 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:49400 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289AbXGRPkK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 11:40:10 -0400
Received: by wa-out-1112.google.com with SMTP id v27so260867wah
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 08:40:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rmh5V67s/io1s73iykZH/XlaUtN2e1YTICbv2a0NgTSJRZunrHVceul6YvJoJfrK7zBS+9avWK1xVzXoZSrLtAi5TWQyYV/MtS5HeLB9tCsKn4JjkX8CBkcGiDwmed0MWsqkxg92iPfw7J81j0/KKGNt48vyXVO3UWQvHxX301I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h8abGyDZHosy4oZNG+fVb4Nxe88riZ3y+kr6VqedpTz7GpPWbL7X6Jqx6m7JwNDwyNKw9U8EqeLr00tZVOkR/cjQyZVSMetBt3RBcaNB3b8vHdem2HSawvzecaLCBNj9uzXY7hPL8OyfE321x7w1ddjILx513npQ1ZjwNocAW6c=
Received: by 10.114.110.1 with SMTP id i1mr1587427wac.1184773209982;
        Wed, 18 Jul 2007 08:40:09 -0700 (PDT)
Received: by 10.114.61.17 with HTTP; Wed, 18 Jul 2007 08:40:09 -0700 (PDT)
In-Reply-To: <7vps2q6tjf.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52868>

2007/7/18, Junio C Hamano <gitster@pobox.com>:
>
> >       unsigned long size = *return_size;
> >       ssize_t iret;
> >       unsigned long off = 0;
> >
> > +     if (!buf || size <= 1) {
> > +             size = alloc_nr(size);
> > +             buf = xrealloc(buf, size);
> > +     }
> > +
>
> Hmph.  The reason this is not "!size" is because you would want
> more than one.  As your plan is to use this mostly for the -F
> option of "tag/commit", I suspect using a bit larger default,
> such as 80 (just a line), or probably 1k (most log messages
> would fit in such a buffer), would be more practical.

The true reason is because I before tried using (size-1) instead of (size)
in xread(..., size - off), and then I forgot to remove that condition. Sorry.

>
> >       do {
> >               iret = xread(fd, buf + off, size - off);
> >               if (iret > 0) {
> >                       off += iret;
> >                       if (off == size) {
> > -                             size *= 2;
> > +                             size = alloc_nr(size);
> >                               buf = xrealloc(buf, size);
> >                       }
> >               }
> >       } while (iret > 0);
> >
> > +     if (off == size)
> > +             buf = xrealloc(buf, size + 1);
> > +     buf[off] = '\0';
> > +
>
> I wonder if doing xread(... (size-1) - off) in the loop would
> ensure (off <= size-1) here.  You also would need to update the
> realloc condition inside loop if you do so.

I have chosen that solution to leave the code easy to read, but the
(size-1) version will avoid that additional (but non-frequent) realloc.

I will resend the fixed patch along with the builtin-tag.c one.
