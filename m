From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] bundle v3: the beginning
Date: Tue, 7 Jun 2016 16:23:51 -0400
Message-ID: <20160607202351.GA5726@sigill.intra.peff.net>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com>
 <1456950761-19759-1-git-send-email-gitster@pobox.com>
 <1456950761-19759-5-git-send-email-gitster@pobox.com>
 <CAP8UFD1xqRMFE2Wzntu=XevCyj+acGLEO-cTq1fqn+NMe3x0vg@mail.gmail.com>
 <CACsJy8Dr_Z886Jb-O8gbAv_vzBLicNH6bPPpKwb9HWZTKQ9muw@mail.gmail.com>
 <CAP8UFD3jPQFk2deSk5JXC3PTz5yWcvXJ4=Qjam5Qw6P9SrLzFQ@mail.gmail.com>
 <CACsJy8DB_17DZ7REBzicyA_GZCnvNkoYEzftjfyM72QVmEb_Vg@mail.gmail.com>
 <CAP8UFD2t=2wJ=1U1ctMYNuMSejBYLh2yeLU7ZfP5Q6KLxUApjQ@mail.gmail.com>
 <xmqqinxkpzur.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 22:24:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bANXb-0006ZT-83
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 22:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161627AbcFGUXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 16:23:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:50730 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161315AbcFGUXy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 16:23:54 -0400
Received: (qmail 6294 invoked by uid 102); 7 Jun 2016 20:23:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jun 2016 16:23:53 -0400
Received: (qmail 877 invoked by uid 107); 7 Jun 2016 20:24:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jun 2016 16:24:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2016 16:23:51 -0400
Content-Disposition: inline
In-Reply-To: <xmqqinxkpzur.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296715>

On Tue, Jun 07, 2016 at 12:23:40PM -0700, Junio C Hamano wrote:

> Christian Couder <christian.couder@gmail.com> writes:
> 
> > Git can store its objects only in the form of loose objects in
> > separate files or packed objects in a pack file.
> > To be able to better handle some kind of objects, for example big
> > blobs, it would be nice if Git could store its objects in other object
> > databases (ODB).
> >
> > To do that, this patch series makes it possible to register commands,
> > using "odb.<odbname>.command" config variables, to access external
> > ODBs. Each specified command will then be called the following ways:
> 
> Hopefully it is done via a cheap RPC instead of forking/execing the
> command for each and every object lookup.

This interface comes from my earlier patches, so I'll try to shed a
little light on the decisions I made there.

Because this "external odb" essentially acts as a git alternate, we
would hit it only when we couldn't find an object through regular means.
Git would then make the object available in the usual on-disk format
(probably as a loose object).

So in most processes, we would not need to consult the odb command at
all. And when we do, the first thing would be to get its "have" list,
which would at most run once per process.

So the per-object cost is really calling "get", and my assumption there
was that the cost of actually retrieving the object over the network
would dwarf the fork/exec cost.

I also waffled on having git cache the output of "<command> have" in
some fast-lookup format to save even the single fork/exec. But I figured
that was something that could be added later if needed.

You'll note that this is sort of a "fault-in" model. Another model would
be to treat external odb updates similar to fetches. I.e., we touch the
network only during a special update operation, and then try to work
locally with whatever the external odb has. IMHO this policy could
actually be up to the external odb itself (i.e., its "have" command
could serve from a local cache if it likes).

> >   - "<command> have": the command should output the sha1, size and
> > type of all the objects the external ODB contains, one object per
> > line.
> 
> Why size and type at this point is needed by the clients?  That is
> more expensive to compute than just a bare list of object names.

Yes, but it lets get avoid doing a lot of "get" operations. For example,
in a regular diff without binary-diffs enabled, we can automatically
determine that a diff will be considered binary based purely on the size
of the objects (related to core.bigfilethreshold). So if we know the
sizes, we can run "git log -p" without faulting-in each of the objects
just to say "woah, that looks binary".

One can accomplish this with .gitattributes, too, of course, but the
size thing just works out of the box.

There are other places where it will come in handy, too. E.g., fscking a
tree object you have, you want to make sure that the object referred to
with mode 100644 is actually a blob.

I also don't think the cost to compute size and type on the server is
all that important. Yes, if you're backing your external odb with a git
repository that runs "git cat-file" on the fly, it is more expensive.
But in practice, I'd expect the server side to create a static manifest
and serve it over HTTP (this also gives the benefit of things like
ETags).

> >   - "<command> get <sha1>": the command should then read from the
> > external ODB the content of the object corresponding to <sha1> and
> > output it on stdout.
> 
> The type and size should be given at this point.

I don't think there's a reason not to; I didn't here because it would be
redundant with what Git already knows from the "have" manifest it
receives above.

> >   - "<command> put <sha1> <size> <type>": the command should then read
> > from stdin an object and store it in the external ODB.
> 
> Is ODB required to sanity check that <sha1> matches what the data
> hashes down to?

I think that would be up to the ODB, but it does seem like a good idea.

Likewise, I'm not sure if "get" should be allowed to return contents
that don't match the sha1. That would be fine for things like "diff",
but would probably make "fsck" unhappy.

> If this thing is primarily to offload large blobs, you might also
> want not "get" but "checkout <sha1> <path>" to bypass Git entirely,
> but I haven't thought it through.

My mental model is that the external odb gets the object into the local
odb, and then you can use the regular streaming-checkout code path. And
the local odb serves as your cache.

That does mean you might have two copies of each object (one in the odb,
and one in the working tree), as opposed to a true cacheless system,
which can get away with one.

I think you could do that cacheless thing with the interface here,
though; the "get" operation can stream, and you can stream directly to
the working tree.

-Peff
