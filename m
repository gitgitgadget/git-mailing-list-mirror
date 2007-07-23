From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] Make verify-tag a builtin.
Date: Mon, 23 Jul 2007 23:21:03 +0200
Message-ID: <1b46aba20707231421k54ad2796i5c2f21cf11b4bea5@mail.gmail.com>
References: <46A3F43C.3030101@gmail.com>
	 <Pine.LNX.4.64.0707230141080.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 23 23:21:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID5L5-0003gQ-TB
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 23:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbXGWVVH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 17:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752177AbXGWVVH
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 17:21:07 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:54661 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbXGWVVE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 17:21:04 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2165976wah
        for <git@vger.kernel.org>; Mon, 23 Jul 2007 14:21:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s3oEFIfiR2lnoE8i0nhCo/IkcDQJuUv8k65kncJNz0AaCAlTfhOEg1mKjj/DYFBctkABH71lscmxzEFCsO/CsgtUGobCCLr9gX53EF8k5lJ7HtDB4nuGgToZ/GV9gv23itHiUVb/euY/RYcEha7OeqHvts7Vr4fDNgXav5tZpsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AWdx4MrrKQGRgE2DoUEkNYEx6qP+IKNQzX+NGWc+8BOjOIK3FCB/celx64KT4ysGkrKo4jFgLZBVGw1RXPZOQWtFX/XauHgFKcGpENeC+fASCrYiYlNlQyIDOO8ssTTh1QbhpEvlS1htOhcmKwfxvQ/xzYUy8/Rj0peGlAxnmDs=
Received: by 10.115.109.1 with SMTP id l1mr3369680wam.1185225663491;
        Mon, 23 Jul 2007 14:21:03 -0700 (PDT)
Received: by 10.114.61.17 with HTTP; Mon, 23 Jul 2007 14:21:03 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707230141080.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53487>

2007/7/23, Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> On Mon, 23 Jul 2007, Carlos Rica wrote:
> > +static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
> > +{
> > +     struct child_process gpg;
> > +     const char *args_gpg[] = {"gpg", "--verify", "FILE", "-", NULL};
> > +     char *path, *eol;
> > +     size_t len;
> > +     int fd, ret;
> > +
> > +     path = xstrdup(git_path("VTAG_TMP"));
> > +     fd = open(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
> > +     if (fd < 0)
> > +             return error("could not create temporary file '%s': %s",
> > +                                             path, strerror(errno));
> > +     if (write_in_full(fd, buf, size) < 0)
> > +             return error("failed writing temporary file '%s': %s",
> > +                                             path, strerror(errno));
> > +     close(fd);
>
> I just tested something like "gpg --verify - - < <filename>" and it
> worked...

I couldn't verify tags using "gpg --verify  -  -  <file" as you
pointed in your response.

In my tests, it only allowed me to run:
"gpg --verify file.asc" or
"gpg --verify <file.asc" or
 "gpg --verify - <file.asc"
when file.asc was generated using the command "gpg --clearsign file",
in which it inserts a header:
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1
<empty-line>

I even tested to insert the header myself after creating a signed file
as git does:
   cp file otherfile
   gpg -bsa otherfile
   ...
   cat otherfile.asc >>otherfile
   ( echo -e "-----BEGIN PGP SIGNED MESSAGE-----\nHash: SHA1\n" ; cat
otherfile ) \
     | gpg --verify

Note that sending them to "diff file.asc -" also shows different signatures,
but anyway it also says "gpg: BAD signature from ...", the same message as in:
   gpg --verify - - <otherfile

and different from the "gpg: Good signature from ..." when I run:
  gpg --verify file.asc
