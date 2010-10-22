From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] Print diffs of UTF-16 to console / patches to email as
 UTF-8...?
Date: Fri, 22 Oct 2010 14:53:31 -0500
Message-ID: <20101022195331.GA12014@burratino>
References: <1287763608.31218.63.camel@drew-northup.unet.maine.edu>
 <20101022161851.GH9224@burratino>
 <E7645863-A3AD-4EE1-AF6B-71C50A859619@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <drew.northup@maine.edu>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 21:57:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Nk1-0001rM-9c
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 21:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755842Ab0JVT5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 15:57:22 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33665 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754979Ab0JVT5V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 15:57:21 -0400
Received: by yxn35 with SMTP id 35so975682yxn.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 12:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=x0djJRPfw6dXr4a9shDF3mRXhUyRcnT+y5onfT/v6KQ=;
        b=ZFp/QEpctlh7cuEJcWvk3VEBGZ9zV4iV/xY2330xXUJR+VXpBx6KwcoRpEfTOiBK3F
         57VM1u7PqU9r6h9qrcw3oEVIDj9UdVktNHSowaQlF5AutNbWwLpFzyG8fohwgnmKOOA1
         JasmvyKaMkWq91yVDPBVV4yFlRYCuN2SUx+OI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ld9qehc+tPxq8A4eiZvVkdsaa6QhG3YrA9VAbacNRHUKeVzFiosKyc3FVJWugueTDB
         93iCP9NidxBXFTkb0RnTAkHq+0ztHIfzo9YYJA7v/aQRi06I13ugPv1SCHjCE809L5i5
         7Q92MoHw9x3uBfIGZU4uT1WoTZT/ACiHKFygg=
Received: by 10.229.183.8 with SMTP id ce8mr2543280qcb.288.1287777441004;
        Fri, 22 Oct 2010 12:57:21 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id m7sm2963287qck.37.2010.10.22.12.57.18
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 12:57:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <E7645863-A3AD-4EE1-AF6B-71C50A859619@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159741>

Joshua Juran wrote:

> I would like to see the same thing for MacRoman-encoded text.[1]
> This is the encoding used by classic Mac development tools such as
> Metrowerks C/C++ (packaged as CodeWarrior) and Apple's Rez resource
> compiler (even the version in OS X).  Clearly, UTF-8 checkouts are
> not an option here.

Yes, makes sense.

There are (at least) two approaches you could use here: treat the
content as precious and use e.g. textconv for readable diffs, or
treat the content as UTF-8 text and use clean/smudge to ensure
the checkout has the right encoding.

So let's see what happens with the latter:

> I wrote a Mac<->UTF-8 converter in C++ and set it as the
> clean/smudge filter for .r (Rez) files.  Checkouts were noticeably
> slower (on a real machine, not one of my antiques).

Vague ideas to mitigate that:

 a) allow a single clean/smudge filter invocation for a batch of
    files
 b) cache, as Jeff hinted
 c) allow custom "native" clean/smudge filters, executed using dlopen()

> While the performance cost could be overlooked, a worse problem
> occurred when I checked out a branch into which the conversion of
> files from MacRoman to UTF-8 hadn't occurred.  It automatically
> dirtied my working tree, requiring me to temporarily disable the
> filter attribute and reset --hard.  I also resorted to checkout -f a
> number of times -- a bad habit, I'm sure.

The jn/merge-renormalize topic from pu might help somewhat (or might
not).  In any event, if you have a test case, I would be happy to look
at it.

> In the end I concluded that (a) these files are definitely text, and
> (b) they are natively MacRoman and should be stored that way.  There
> is no advantage to using UTF-8 since the tools can't handle it, and
> even were one to write a UTF-8-capable Rez compiler, the resources
> it outputs are still MacRoman-encoded, so no Unicode support is
> possible.
> 
> Finally, (c) the end-to-end principle applies.

Yep.

Although "definitely text" seems somewhat abstract to me.  Is the
problem that "git diff" fails to default to --text in some situation?

>                                         But Git should definitely
> convert data to match the encoding of the display device; writing
> anything but valid UTF-8 to a UTF-8 terminal is in error.

Oh, this is what you mean.  Except for log encoding, git is not paying
attention to the display encoding at all.

[...]
>                                                      But a more
> complete and robust solution would be to store the encoding
> somewhere, possibly in the blob itself, or in the tree storing the
> filename.

How about Jakub's idea of keeping it in .gitattributes (or some
similarly visible key/value store)?  Two reasons:

 1. When asked to declare encoding, half the time people will be
    wrong.  So it seems worthwhile to make the declared encoding
    visible enough to fix.

 2. Two ASCII files identical except that one is declared as
    latin1 and the other utf8 should be considered identical.

Thanks for some food for thought.
