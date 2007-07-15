From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Sun, 15 Jul 2007 12:06:53 +0200
Message-ID: <e5bfff550707150306t3196f723ia3071ac301fb3f24@mail.gmail.com>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
	 <7vodiehko7.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550707141346q2eba4ab8ka1c85e8b5a2c1b1d@mail.gmail.com>
	 <20070715093529.GD2568@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 12:06:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA10F-0004Rg-6h
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 12:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757760AbXGOKGz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 06:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757851AbXGOKGz
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 06:06:55 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:52494 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757648AbXGOKGy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 06:06:54 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1218006wah
        for <git@vger.kernel.org>; Sun, 15 Jul 2007 03:06:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dvmPdFbuX6CZr/z+x/rh3FNrB5ng5A59F6uKEING6WhQv9bWCpJQz7Ym5ewSW8wNvD62mzdcW5Zj1tEyfq1yh6LJoAvn0PvSk1qqWy5sPpALhUgG5daAAr/3BF98KSu9/p0Kub4pfIsXzQck74hvYVBAVIsGpY/WGGtxO8HzHUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rXX3NlR/NwoVayX0q2UdkLUe+YRvpJ6ayokzl/zFXO7iB/Ga5ioZJqPFfTBnSNiLpNkUthuGfFiyUuxHd5qUY13c+vgOEerXcl65ExFe9tBOHk/9t/Ehkjy576kLQ/PRdYJQWSoSH+uKO5H5wYLpn8QdIA+FocmqW0jbigW4I6E=
Received: by 10.114.103.1 with SMTP id a1mr3177191wac.1184494013175;
        Sun, 15 Jul 2007 03:06:53 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Sun, 15 Jul 2007 03:06:53 -0700 (PDT)
In-Reply-To: <20070715093529.GD2568@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52539>

On 7/15/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> Marco Costalba, Sat, Jul 14, 2007 22:46:39 +0200:
> > Finding the delimiting '\0' it means to loop across the whole buffers
> > and _this_ is the expensive and not needed part. If just after the
>
> It is _not_ expensive. It could be made expensive, though. By using
> QString and QByteArray, for instance.
>

The searching we are talking about is this (Rev::indexData() in
git_startup.cpp):

int end = ba.indexOf('\0', idx); // this is the slowest find

the starting point 'idx' is at the beginning of the log message.


Qt implemantation of indexOf() is this (src/corelib/tools/qbytearray.cpp):

int QByteArray::indexOf(char ch, int from) const
{
    if (from < 0)
        from = qMax(from + d->size, 0);
    if (from < d->size) {
        const char *n = d->data + from - 1;
        const char *e = d->data + d->size;
        while (++n != e)
        if (*n == ch)
            return  n - d->data;
    }
    return -1;
}

Hope this clears any doubts regarding (supposed) slowness of Qt classes.

> > first line would be possible to point to the beginning of the next
> > revision this seeking for '\0' would be not necessary anymore.
>
> But this will make your reading different: you have to handle the case
> when the next revision is not _fully_ read in yet, but you already
> know its size.
>

Reading and creating revision is made as a streaming, it means that
when there is new data  from git a new Rev struct (well it's a class
indeed, but there's no diference) is created and populated with index
data: offset of the rev, parents number, offset of log message and so
on.

If, *while parsing the data* a truncated rev is found (we are at EOF
and no '\0' is found) the whole rev is discarded and deleted, we wait
for some more data and restart the process.

Because the above event is quite rare given the size of the buffers
where git row data is stored, no really loss of speed occurs and we
have the (big) advantage of indexing *while* searching for '\0', so to
scan data only once.

This is how it works now.

With the proposed patch will be easier to find a truncated rev,
because as soon as we know the rev size, after reading it from the
stream, we check:

             if (revision_offset + size > byte_array_size)
                       truncated_rev;


>
> P.S. BTW, why do you have some 20 source files marked executable in
> your qgit4 repository?
>

Importing from Windows: ntfs does not handles file attributes
correctly, I should clean up permissions but I'm lazy ;-)


Marco

P.S: I have an experimental branch where the above is implemented, I
cannot publish now because it requires the --show-size change in git,
but after initial testing I have found that with the above applied the
overhead of qgit on git-log it's about of only 16%.

It means that if git-log runs in say 3 seconds (warm cache), qgit with
the same git log arguments runs in about 3.5 seconds.

With cold cache overhead is also less because disk access is accounted
on the git side ;-)
