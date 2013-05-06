From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 2/3] fast-export: improve speed by skipping blobs
Date: Mon, 6 May 2013 16:30:29 -0500
Message-ID: <CAMP44s2wh71vW6GaCfyCO398BWvVbYnwSE76bO=46XVJF3jWNg@mail.gmail.com>
References: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
	<1367793534-8401-3-git-send-email-felipe.contreras@gmail.com>
	<20130506123111.GB3809@sigill.intra.peff.net>
	<7v7gjctabm.fsf@alter.siamese.dyndns.org>
	<CAMP44s2rdkND40QDQA9T7MNGoKPtnr50nV98aExUe4bCOXZGyA@mail.gmail.com>
	<7vppx3q0z6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 06 23:30:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZSzU-0001tq-Br
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 23:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757228Ab3EFVab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 17:30:31 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:64747 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756830Ab3EFVaa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 17:30:30 -0400
Received: by mail-la0-f45.google.com with SMTP id fp12so3777495lab.32
        for <git@vger.kernel.org>; Mon, 06 May 2013 14:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=aTRzg2fSKA5J8KS9H2jKlLrbUUggZq6nEPBMfVKA3Z4=;
        b=D5hShWjwKc7yfzDQm78PT0dwBc0pUljOnKJdD0WmDwwao9v7GHcJLedwwfuoew/d5u
         yIGZCN2el7QAd9veNzoTTrQoYLypF8MHuIebHpMGWJeqyURBATa49RQ9vfReQEDU0/VZ
         gVoy67MHueLDPKecwLMZcyKzkN83g4G4rpDpjGm1MpxjWaYeSfea8cSNHKnSb1YvO8iH
         zx1LzryZ3otbYyvBRBK8EnSNeh4DzbN9ZeNibOxLKoJXv94SdCpcLs0YTIXEOPAsq8N8
         E/HvFdDJCy+TiZWoYGLyc0iDVlLlb5bPgc7mv1S+w10CzigObjozYy4TFLUXWgbc6xua
         q2VQ==
X-Received: by 10.112.154.98 with SMTP id vn2mr8728006lbb.8.1367875829234;
 Mon, 06 May 2013 14:30:29 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Mon, 6 May 2013 14:30:29 -0700 (PDT)
In-Reply-To: <7vppx3q0z6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223509>

On Mon, May 6, 2013 at 3:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> The story is different on the fast-import side, where we do say we
>>> dump the full table and a later run can depend on these marks.
>>
>> Yes, and gaining nothing but increased disk-space.
>
> I thought that the "gaining nothing" has already been refuted by the
> discussion several hours ago...
>
> cf. http://thread.gmane.org/gmane.comp.version-control.git/223275/focus=223440
>
> Puzzled...

What is being gained there? Nothing.

>>> By discarding marks on blobs, we may be robbing some optimization
>>> possibilities, and by discarding marks on tags, we may be robbing
>>> some features, from users of fast-export; we might want to add an
>>> option "--use-object-marks={blob,commit,tag}" or something to both
>>> fast-export and fast-import, so that the former can optionally write
>>> marks for non-commits out, and the latter can omit non commit marks
>>> if the user do not need them. But that is a separate issue.
>>
>> How?
>
>  * if we teach fast-import to optionally not write marks for blobs
>    and trees out, your remote-bzr can take advantage of it,

I already said remote-bzr is irrelevant. *Everybody* benefits.

>    Existing users like cvs2git that do not ask to skip marks for
>    non-commits will not be hurt and keep referring to blobs an
>    earlier run wrote out.

cvs2git does *not* store marks. It doesn't get any benefit or get hurt *at all*.

>  * if we teach fast-export to optionally write marks for blobs and
>    trees out, the users of fast-export could reuse marks for blobs
>    and trees in later runs (perhaps they can drive fast-export from
>    the output of "git log --raw", noticing blob object names they
>    already saw).  Existing users that do not ask for such a feature
>    will not be hurt.

There's absolutely no benefit from fast-export being able to load and
store blobs, the only effect is that the mark files will have tons of
entries nobody will ever use.

If you want to add options for features that only hurt, go ahead, but
the only sane default is to only store commit marks, both for
fast-export, and fast-import. Period.

Cheers.

-- 
Felipe Contreras
