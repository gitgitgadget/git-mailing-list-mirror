From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Wed, 8 Oct 2014 00:33:29 +0300
Message-ID: <20141007213329.GB14632@redhat.com>
References: <xmqqy4x03ecm.fsf@gitster.dls.corp.google.com>
 <20140615102736.GA11798@redhat.com>
 <xmqqy4wwraoz.fsf@gitster.dls.corp.google.com>
 <20140618030903.GA19593@redhat.com>
 <CAPc5daVTZynCKMubZmreAjBh3i51wPaAA+8vSRwB9dGrrJb6FA@mail.gmail.com>
 <xmqq38f2jed3.fsf@gitster.dls.corp.google.com>
 <20140922140144.GA9769@redhat.com>
 <CAP8UFD2W1r9859FgpBXqvdNLAfXoCwjpEFpTKXU6fGuC_8uvBg@mail.gmail.com>
 <20140923080700.GA16527@redhat.com>
 <CAP8UFD2FV2pvR4+N0fDLtentA_oWwYGRZ6rPtshi=TOAvXaRLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 23:30:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbcKg-0003DY-94
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 23:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755092AbaJGVaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 17:30:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7639 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753306AbaJGVaC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 17:30:02 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s97LTvjp017996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Oct 2014 17:29:57 -0400
Received: from redhat.com (ovpn-116-74.ams2.redhat.com [10.36.116.74])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s97LTtg6029909;
	Tue, 7 Oct 2014 17:29:56 -0400
Content-Disposition: inline
In-Reply-To: <CAP8UFD2FV2pvR4+N0fDLtentA_oWwYGRZ6rPtshi=TOAvXaRLA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 24, 2014 at 12:00:40PM +0200, Christian Couder wrote:
> On Tue, Sep 23, 2014 at 10:07 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Tue, Sep 23, 2014 at 09:45:50AM +0200, Christian Couder wrote:
> >> This is probably not as simple as you would like but it works with
> >> something like:
> >>
> >> $ git interpret-trailers --trailer "Acked-by: Michael S. Tsirkin
> >> <mst@redhat.com>" --trailer "Reviewed-by: Michael S. Tsirkin
> >> <mst@redhat.com>"  --trailer "Tested-by: Michael S. Tsirkin
> >> <mst@redhat.com>" 0001-foo.patch >to_apply/0001-foo.patch
> >>
> >> and then:
> >>
> >> $ git am to_apply/*.patch
> >>
> >> Also by using something like:
> >>
> >> $ git config trailer.a.key Acked-by
> >> $ git config trailer.r.key Reviewed-by
> >> $ git config trailer.t.key Tested-by
> >
> > I would like multiple keys to match a specific
> > letter, e.g. as a maintainer I need
> > both reviewed by and signed off by when I
> > apply a patch, I like applying them with
> > a single "-s m".
> 
> That's different from what you implemented in your patch.
> And franckly I think that for this kind of specific use cases, you
> could create your own aliases, either Git aliases or just shell
> aliases.
> 
> For example if we implement default values and make git am call git
> interpret-trailers, a shell alias could simply be:
> 
> alias gamsm='git am --trailer r --trailer s'
> 
> I use "git log --oneline --decorate --graph" very often, so I made my
> own alias for it, and I suppose a lot of other people have done so.
> 
> The number of people who will use trailers will probably be much
> smaller than the number of people using git log, so if we don't make
> shortcuts for "git log --oneline --decorate --graph", I see no ground
> to ask for a specific shortcut that adds both a reviewed by and a
> signed off by.

I've been thinking: how about a generic ability to add option shortcuts
for commands in .config?
For example:

[am "-z"]
	command = "--trailer foobar"

would replace any -z in git am command line with --trailer foobar.


Does this sound useful?


> >> the first command could be simplified to:
> >>
> >> $ git interpret-trailers --trailer "a: Michael S. Tsirkin
> >> <mst@redhat.com>" --trailer "r: Michael S. Tsirkin <mst@redhat.com>"
> >> --trailer "t: Michael S. Tsirkin <mst@redhat.com>" 0001-foo.patch
> >> >to_apply/0001-foo.patch
> >>
> >> And if you use an env variable:
> >>
> >> $ ME="Michael S. Tsirkin <mst@redhat.com>"
> >> $ git interpret-trailers --trailer "a: $ME" --trailer "r: $ME"
> >> --trailer "t: $ME" 0001-foo.patch >to_apply/0001-foo.patch
> >>
> >> Maybe later we will integrate git interpret-trailers with git commit,
> >> git am and other commands, so that you can do directly:
> >>
> >> git am --trailer "a: $ME" --trailer "r: $ME"  --trailer "t: $ME" 0001-foo.patch
> >>
> >> Maybe we wil also assign a one letter shortcut to --trailer, for
> >> example "z", so that could be:
> >>
> >> git am -z "a: $ME" -z "r: $ME"  -z "t: $ME" 0001-foo.patch
> >
> > -s could apply here, right?
> 
> I don't know what we will do with -s. Maybe if we use -z, we don't need -s.
> 
> > It doesn't have a parameter at the moment.
> 
> We will have to discuss that kind of thing when we make it possible
> for git commit, git am and maybe other commands to accept trailers
> arguments and pass them to git interpret-trailers.
> 
> In his email Junio seems to say that we don't need a shortcut like -z,
> we could only have --trailer.
> And I think that it is indeed sound to at least wait a little before
> using up one shortcut like -z in many commands.
> 
> >> We could also allow many separators in the same -z argument as long as
> >> they are separated by say "~",
> >
> > I think -z a -z r -z t is enough.
> 
> Great! I think you will likely have at least "--trailer a --trailer r
> --trailer t", but I don't think it is too bad as you can use aliases
> to make it shorter to type.
> 
> >> so you could have:
> >>
> >> git am -z "a: $ME~r: $ME~t: $ME" 0001-foo.patch
> >>
> >> And then we could also allow people to define default values for
> >> trailers with something like:
> >>
> >> $ git config trailer.a.defaultvalue "Michael S. Tsirkin <mst@redhat.com>"
> >> $ git config trailer.r.defaultvalue "Michael S. Tsirkin <mst@redhat.com>"
> >> $ git config trailer.t.defaultvalue "Michael S. Tsirkin <mst@redhat.com>"
> >
> > I'm kind of confused by the key/value concept.
> 
> A "defaultvalue" would be the value used when no value is passed.
> The "key" is just what we will use in the first part of the trailer
> (the part before the separator).
> 
> For example with the above "defaultvalue" and "key", "--trailer a:
> Junio <gitster@pobox.com>" would add:
> 
> Acked-by: Junio <gitster@pobox.com>
> 
> while "--trailer a" would add:
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> > Can't I define the whole 'Acked-by: Michael S. Tsirkin <mst@redhat.com>'
> > string as the key?
> 
> The whole 'Acked-by: Michael S. Tsirkin <mst@redhat.com>' is a full
> trailer, not a "key".
> 
> And it is not possible right now to define a full trailer. Maybe we
> could find a way to make it possible, but a default value and a way to
> have a small nickname for the token (like "a" for "Acked-by") should
> get people quite far. And then for very specific use cases, it may be
> better to use aliases anyway.
> 
> >> So that in the end you could have:
> >>
> >> git am -z a~r~t 0001-foo.patch
> >>
> >> which is very close to "git am -s art".
> >
> > If I figure out the defaultvalue thing, I might
> > find the time to work on git am integration.
> 
> That would be great!
> 
> Thanks,
> Christian.
