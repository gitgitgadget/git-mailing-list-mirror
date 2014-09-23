From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Tue, 23 Sep 2014 11:07:00 +0300
Message-ID: <20140923080700.GA16527@redhat.com>
References: <xmqqioo654mg.fsf@gitster.dls.corp.google.com>
 <20140613080036.GA2117@redhat.com>
 <xmqqy4x03ecm.fsf@gitster.dls.corp.google.com>
 <20140615102736.GA11798@redhat.com>
 <xmqqy4wwraoz.fsf@gitster.dls.corp.google.com>
 <20140618030903.GA19593@redhat.com>
 <CAPc5daVTZynCKMubZmreAjBh3i51wPaAA+8vSRwB9dGrrJb6FA@mail.gmail.com>
 <xmqq38f2jed3.fsf@gitster.dls.corp.google.com>
 <20140922140144.GA9769@redhat.com>
 <CAP8UFD2W1r9859FgpBXqvdNLAfXoCwjpEFpTKXU6fGuC_8uvBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 10:03:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWL4h-00080Z-Fp
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 10:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541AbaIWIDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 04:03:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14227 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559AbaIWIDm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 04:03:42 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s8N83ax5030659
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Sep 2014 04:03:36 -0400
Received: from redhat.com (dhcp-4-119.tlv.redhat.com [10.35.4.119])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s8N83YDI025621;
	Tue, 23 Sep 2014 04:03:35 -0400
Content-Disposition: inline
In-Reply-To: <CAP8UFD2W1r9859FgpBXqvdNLAfXoCwjpEFpTKXU6fGuC_8uvBg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257401>

On Tue, Sep 23, 2014 at 09:45:50AM +0200, Christian Couder wrote:
> Hi Michael,
> 
> On Mon, Sep 22, 2014 at 4:01 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > Hi Junio, Christian,
> > it's been a while.
> > I see that the work on trailers is going on.
> > I tried going over the documentation but I could not figure
> > out how would one implement multiple signatures using the
> > trailers mechanism.
> >
> > As a reminder, this old patchset (that I replied to) enhanced git am -s
> > with an option to add different signatures depending on
> > the option passed to the -s flag.
> > E.g. I have
> > [am "a"]
> >         signoff = "Acked-by: Michael S. Tsirkin <mst@redhat.com>"
> >
> > [am "r"]
> >         signoff = "Reviewed-by: Michael S. Tsirkin <mst@redhat.com>"
> >
> > [am "t"]
> >         signoff = "Tested-by: Michael S. Tsirkin <mst@redhat.com>"
> >
> > and now:
> >         git am -s art
> > adds all 3 signatures when applying the patch.
> 
> This is probably not as simple as you would like but it works with
> something like:
> 
> $ git interpret-trailers --trailer "Acked-by: Michael S. Tsirkin
> <mst@redhat.com>" --trailer "Reviewed-by: Michael S. Tsirkin
> <mst@redhat.com>"  --trailer "Tested-by: Michael S. Tsirkin
> <mst@redhat.com>" 0001-foo.patch >to_apply/0001-foo.patch
> 
> and then:
> 
> $ git am to_apply/*.patch
> 
> Also by using something like:
> 
> $ git config trailer.a.key Acked-by
> $ git config trailer.r.key Reviewed-by
> $ git config trailer.t.key Tested-by

I would like multiple keys to match a specific
letter, e.g. as a maintainer I need
both reviewed by and signed off by when I
apply a patch, I like applying them with
a single "-s m".

> the first command could be simplified to:
> 
> $ git interpret-trailers --trailer "a: Michael S. Tsirkin
> <mst@redhat.com>" --trailer "r: Michael S. Tsirkin <mst@redhat.com>"
> --trailer "t: Michael S. Tsirkin <mst@redhat.com>" 0001-foo.patch
> >to_apply/0001-foo.patch
> 
> And if you use an env variable:
> 
> $ ME="Michael S. Tsirkin <mst@redhat.com>"
> $ git interpret-trailers --trailer "a: $ME" --trailer "r: $ME"
> --trailer "t: $ME" 0001-foo.patch >to_apply/0001-foo.patch
> 
> Maybe later we will integrate git interpret-trailers with git commit,
> git am and other commands, so that you can do directly:
> 
> git am --trailer "a: $ME" --trailer "r: $ME"  --trailer "t: $ME" 0001-foo.patch
> 
> Maybe we wil also assign a one letter shortcut to --trailer, for
> example "z", so that could be:
> 
> git am -z "a: $ME" -z "r: $ME"  -z "t: $ME" 0001-foo.patch

-s could apply here, right?
It doesn't have a parameter at the moment.

> We could also allow many separators in the same -z argument as long as
> they are separated by say "~",

I think -z a -z r -z t is enough.

> so you could have:
> 
> git am -z "a: $ME~r: $ME~t: $ME" 0001-foo.patch
> 
> And then we could also allow people to define default values for
> trailers with something like:
> 
> $ git config trailer.a.defaultvalue "Michael S. Tsirkin <mst@redhat.com>"
> $ git config trailer.r.defaultvalue "Michael S. Tsirkin <mst@redhat.com>"
> $ git config trailer.t.defaultvalue "Michael S. Tsirkin <mst@redhat.com>"

I'm kind of confused by the key/value concept.
Can't I define the whole 'Acked-by: Michael S. Tsirkin <mst@redhat.com>'
string as the key?


> So that in the end you could have:
> 
> git am -z a~r~t 0001-foo.patch
> 
> which is very close to "git am -s art".
> 
> Best,
> Christian.

If I figure out the defaultvalue thing, I might
find the time to work on git am integration.
