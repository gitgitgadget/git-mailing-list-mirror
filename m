From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1410: Fix for case insensitive filesystems
Date: Sun, 9 Nov 2014 22:34:19 -0800
Message-ID: <CAPc5daV9g+kio2esi9avj+5ivQyaTkR4mo12gS-Cxt1KCOKMnA@mail.gmail.com>
References: <1415584086-41637-1-git-send-email-brian@gernhardtsoftware.com> <20141110062356.GA8047@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 07:34:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XniYn-0005Wj-Jn
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 07:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbaKJGem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 01:34:42 -0500
Received: from mail-pd0-f171.google.com ([209.85.192.171]:43337 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbaKJGek (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 01:34:40 -0500
Received: by mail-pd0-f171.google.com with SMTP id r10so7212402pdi.2
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 22:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=9scac5t8hhFIH81nmGDY7t2ZHHw84yeTbWRAboEKvLs=;
        b=W7oooNDTbCvKnDsO1ACOA+jy366rFKTsPkdibMgyXkAO7PM3oBjIkS1eEZE1UI/VH/
         n9CouLKKu2KNEif7at07CO9iwWaIXpwM/m1o0p+Kve/giz3GQ1daOV4lIzFzJPclmUji
         n5KETFei1BdpDipXU7cy+mohy4sgFSRJAuJuTz1w+b9O59XuKWixJVoDlPEwZuiEsUVG
         Pe1wgshHE6E7zUl8c7CEL8Ap/dFWADUcwNxk/s5TWa/7nr2zTp3QB8rg2541JLWv66yZ
         RzEzRsVjMZNe0v5+vHyOC0eV6MotWlWW6xL8ngIgaJMVE8atDe8V5OTKlgidq6neUWHh
         ZFfw==
X-Received: by 10.66.66.135 with SMTP id f7mr4185108pat.81.1415601279738; Sun,
 09 Nov 2014 22:34:39 -0800 (PST)
Received: by 10.66.74.134 with HTTP; Sun, 9 Nov 2014 22:34:19 -0800 (PST)
In-Reply-To: <20141110062356.GA8047@peff.net>
X-Google-Sender-Auth: mZZmju02Q9vk5_UbzSUskdVjzBA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 9, 2014 at 10:23 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Nov 09, 2014 at 08:48:06PM -0500, Brian Gernhardt wrote:
>
>> A pair of recently added tests used branches a and a/b, but earlier
>> tests created files A and A/B.  On case insensitive filesystems (such
>> as HFS+), that causes git to complain about the name being ambiguous
>> between branch and file.  Resolve by renaming the branches to aa and
>> aa/bb.
>
> Already being discussed here:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/259250/focus=259253
>
> :)

Related tangent for a moderately near future.

One thing that we may want to play with around this topic is to try
building an alternative "ref backend" that is backed by a filesystem,
lays out things pretty much the same way as the current "refs" (i.e.
one file per ref, directory hierarchy corresponds to slashes in the
refname, one file per reflog, etc.), but can be stored on a case
insensitive filesystem, as a demonstration of Ronnie's "ref-transaction"
restructuring series.

Perhaps such a backend may store branch 'a' as 'refs/heads/a' while
storing branch 'A' as 'refs/heads/%41' or something, and causes the
right thing to happen when "for-each-ref" enumerates the refs by
unquoting quoted names and when "checkout" asks to check out
such a branch.
