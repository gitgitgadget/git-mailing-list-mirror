From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH 1/2] Function stripspace now gets a buffer instead file descriptors.
Date: Thu, 12 Jul 2007 02:14:53 +0200
Message-ID: <1b46aba20707111714v63bf921dh15000e2629bcf260@mail.gmail.com>
References: <4695267A.7080202@gmail.com>
	 <7vd4yy1svw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"=?ISO-8859-1?Q?Kristian_H=F8gsberg?=" <krh@redhat.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 02:15:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8mKj-0004tj-MY
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 02:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936835AbXGLAO5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 20:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937323AbXGLAOz
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 20:14:55 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:20266 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937444AbXGLAOx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 20:14:53 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2524515wah
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 17:14:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N6XppPiLshXy3Fa4WVSb9L1v+TS3xc8a6uCZjUijJ3sma+klBKgpY2OzqcjFUjT5KE9+ZF8sDPPPD/PeQnueXtHOH0mR8HtYUIiTG/leHZ/iYdFrUtA/TNeGA0/OSLtUcsrhz7lplBDLdPNavD4xPzT/IX7E+TOY/k9OF3nNAIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CJUgBJ5UTGxauWca8dWFCVPNg0O6C/85738DRVzgPDB7SP/UL/I8zKFll7pkzXAhqHMvggeW1ZC9bU0WysgGfDO40e/iqRhXl0HFouhznFMJECPykZTlhgmjcTI9M6KaCvvCOhAi7zPvFv3/0BewQG/sew+FwaqXuMmACgomh+w=
Received: by 10.115.108.1 with SMTP id k1mr18017wam.1184199293157;
        Wed, 11 Jul 2007 17:14:53 -0700 (PDT)
Received: by 10.114.57.10 with HTTP; Wed, 11 Jul 2007 17:14:53 -0700 (PDT)
In-Reply-To: <7vd4yy1svw.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52226>

2007/7/12, Junio C Hamano <gitster@pobox.com>:
> Carlos Rica <jasampler@gmail.com> writes:
> > @@ -28,52 +26,67 @@ static int cleanup(char *line, int len)
> >   * Remove empty lines from the beginning and end
> >   * and also trailing spaces from every line.
> >   *
> > + * Note that the buffer will not be null-terminated.
> > + *
>
> The name of the sentinel character '\0' is NUL, not null (which
> is a different word, used to call a pointer that points
> nowhere).  The buffer will not be "NUL-terminated".

Thank you Junio, I will use it on the future.

> >  int cmd_stripspace(int argc, const char **argv, const char *prefix)
> >  {
> > -     stripspace(stdin, stdout, 0);
> > +     char *buffer;
> > +     unsigned long size;
> > +
> > +     size = 1024;
> > +     buffer = xmalloc(size);
> > +     if (read_pipe(0, &buffer, &size))
> > +             die("could not read the input");
>
> The command used to be capable of streaming and filtering a few
> hundred gigabytes of text on a machine with small address space,
> as it operated one line at a time, but now it cannot as it has
> to hold everything in core before starting.
>
> I do not think we miss that loss of capability too much, but I
> wonder if we can be a bit more clever about it, perhaps feeding
> a chunk at a time.  Not a very strong request, but just
> wondering if it is an easy change.

I did those changes because I was needing those tests that
I had written before in order to develop the function. After that,
we now can restore the previous function with file descriptors to
make it capable of filter a few hundred gigabytes of text, provided
that the text does not have long long lines on it.

Indeed, the implementation for composing a tag (header, cleaned
message and optional signature) in "builtin-tag.c", now pass it to
the function write_sha1_file as a buffer on memory, so it won't support
sizes bigger than memory available on the system. Messages should
not be so big, but I don't know how to limit those.
