From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Tue, 23 Sep 2014 09:45:50 +0200
Message-ID: <CAP8UFD2W1r9859FgpBXqvdNLAfXoCwjpEFpTKXU6fGuC_8uvBg@mail.gmail.com>
References: <1402589505-27632-1-git-send-email-mst@redhat.com>
	<xmqqioo654mg.fsf@gitster.dls.corp.google.com>
	<20140613080036.GA2117@redhat.com>
	<xmqqy4x03ecm.fsf@gitster.dls.corp.google.com>
	<20140615102736.GA11798@redhat.com>
	<xmqqy4wwraoz.fsf@gitster.dls.corp.google.com>
	<20140618030903.GA19593@redhat.com>
	<CAPc5daVTZynCKMubZmreAjBh3i51wPaAA+8vSRwB9dGrrJb6FA@mail.gmail.com>
	<xmqq38f2jed3.fsf@gitster.dls.corp.google.com>
	<20140922140144.GA9769@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 09:46:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWKnc-0000eV-MQ
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 09:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbaIWHpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 03:45:54 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:60548 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbaIWHpw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 03:45:52 -0400
Received: by mail-ig0-f180.google.com with SMTP id a13so4116808igq.13
        for <git@vger.kernel.org>; Tue, 23 Sep 2014 00:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lCjWF5p71UZ4YVgKwZWWMFJ8tHyqRAksAR6+RW0ZDNg=;
        b=i/4rPw1rdB5S6U3fs+uU9g4rDszAbglC7WqvE82SNPualmL0jVRwB5TWcSno1m5SKh
         60VpiWc9SydLuKNSAuU8xlT5L7Fq3wTE0ifWasi4ApIHogOiNFrylNWrMCO8ROnoLnYU
         KPtyJNiIAtYUB6/d7XufAeBoeL66YPrElYhlsJlOcAjbza8pl5PsP0CMPQ63zxtczoe7
         ZyqK/R6zcHHMQT2XJ2BM85bCwh/Rb3IZMCdOZTJLOcoj4wJZNjQh/JxBb1fg8Do12zWA
         JD1ZMbzexWR25JVR++yGwSZPc570WstJLD4wAZvfkbfT8gH6R9dZ/PIn28hF4M7YZjsT
         +aqQ==
X-Received: by 10.50.103.106 with SMTP id fv10mr20183414igb.40.1411458350781;
 Tue, 23 Sep 2014 00:45:50 -0700 (PDT)
Received: by 10.50.250.179 with HTTP; Tue, 23 Sep 2014 00:45:50 -0700 (PDT)
In-Reply-To: <20140922140144.GA9769@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257396>

Hi Michael,

On Mon, Sep 22, 2014 at 4:01 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Hi Junio, Christian,
> it's been a while.
> I see that the work on trailers is going on.
> I tried going over the documentation but I could not figure
> out how would one implement multiple signatures using the
> trailers mechanism.
>
> As a reminder, this old patchset (that I replied to) enhanced git am -s
> with an option to add different signatures depending on
> the option passed to the -s flag.
> E.g. I have
> [am "a"]
>         signoff = "Acked-by: Michael S. Tsirkin <mst@redhat.com>"
>
> [am "r"]
>         signoff = "Reviewed-by: Michael S. Tsirkin <mst@redhat.com>"
>
> [am "t"]
>         signoff = "Tested-by: Michael S. Tsirkin <mst@redhat.com>"
>
> and now:
>         git am -s art
> adds all 3 signatures when applying the patch.

This is probably not as simple as you would like but it works with
something like:

$ git interpret-trailers --trailer "Acked-by: Michael S. Tsirkin
<mst@redhat.com>" --trailer "Reviewed-by: Michael S. Tsirkin
<mst@redhat.com>"  --trailer "Tested-by: Michael S. Tsirkin
<mst@redhat.com>" 0001-foo.patch >to_apply/0001-foo.patch

and then:

$ git am to_apply/*.patch

Also by using something like:

$ git config trailer.a.key Acked-by
$ git config trailer.r.key Reviewed-by
$ git config trailer.t.key Tested-by

the first command could be simplified to:

$ git interpret-trailers --trailer "a: Michael S. Tsirkin
<mst@redhat.com>" --trailer "r: Michael S. Tsirkin <mst@redhat.com>"
--trailer "t: Michael S. Tsirkin <mst@redhat.com>" 0001-foo.patch
>to_apply/0001-foo.patch

And if you use an env variable:

$ ME="Michael S. Tsirkin <mst@redhat.com>"
$ git interpret-trailers --trailer "a: $ME" --trailer "r: $ME"
--trailer "t: $ME" 0001-foo.patch >to_apply/0001-foo.patch

Maybe later we will integrate git interpret-trailers with git commit,
git am and other commands, so that you can do directly:

git am --trailer "a: $ME" --trailer "r: $ME"  --trailer "t: $ME" 0001-foo.patch

Maybe we wil also assign a one letter shortcut to --trailer, for
example "z", so that could be:

git am -z "a: $ME" -z "r: $ME"  -z "t: $ME" 0001-foo.patch

We could also allow many separators in the same -z argument as long as
they are separated by say "~", so you could have:

git am -z "a: $ME~r: $ME~t: $ME" 0001-foo.patch

And then we could also allow people to define default values for
trailers with something like:

$ git config trailer.a.defaultvalue "Michael S. Tsirkin <mst@redhat.com>"
$ git config trailer.r.defaultvalue "Michael S. Tsirkin <mst@redhat.com>"
$ git config trailer.t.defaultvalue "Michael S. Tsirkin <mst@redhat.com>"

So that in the end you could have:

git am -z a~r~t 0001-foo.patch

which is very close to "git am -s art".

Best,
Christian.
