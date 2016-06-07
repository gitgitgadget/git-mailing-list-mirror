From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] bundle v3: the beginning
Date: Tue, 7 Jun 2016 16:35:57 -0400
Message-ID: <20160607203557.GB5726@sigill.intra.peff.net>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com>
 <1456950761-19759-1-git-send-email-gitster@pobox.com>
 <1456950761-19759-5-git-send-email-gitster@pobox.com>
 <CAP8UFD1xqRMFE2Wzntu=XevCyj+acGLEO-cTq1fqn+NMe3x0vg@mail.gmail.com>
 <20160531223118.GD3824@sigill.intra.peff.net>
 <CAP8UFD3mGKTONzh1fxCJAJBrmc=OcCHeRqBQi-xTzHvcnAJ_sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 22:36:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bANjK-0006TF-9p
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 22:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756518AbcFGUgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 16:36:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:50742 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756513AbcFGUgA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 16:36:00 -0400
Received: (qmail 6824 invoked by uid 102); 7 Jun 2016 20:35:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jun 2016 16:35:59 -0400
Received: (qmail 1009 invoked by uid 107); 7 Jun 2016 20:36:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jun 2016 16:36:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2016 16:35:57 -0400
Content-Disposition: inline
In-Reply-To: <CAP8UFD3mGKTONzh1fxCJAJBrmc=OcCHeRqBQi-xTzHvcnAJ_sw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296716>

On Tue, Jun 07, 2016 at 03:19:46PM +0200, Christian Couder wrote:

> >      But there are lots of cases where the server might want to tell
> >      the client that don't involve bundles at all.
> 
> The idea is also that anytime the server needs to send external ODB
> data to the client, it would ask its own external ODB to prepare a
> kind of bundle with that data and use the bundle v3 mechanism to send
> it.
> That may need the bundle v3 mechanism to be extended, but I don't see
> in which cases it would not work.

Ah, I see we do not have the same underlying mental model.

I think the external odb is purely the _client's_ business. The server
does not have to have an external odb at all, and does not need to know
about the client's. The client is responsible for telling the server
during the git protocol anything it would need to know (like "do not
bother sending objects over 50MB; I can get them elsewhere").

This makes the problem much more complicated, but it is more flexible
and decentralized.

> >        a. The receiving side of a connection (e.g., a fetch client)
> >           somehow has out-of-band access to some objects. How does it
> >           tell the other side "do not bother sending me these objects; I
> >           can get them in another way"?
> 
> I don't see a difference with regular objects that the fetch client
> already has. If it already has some regular objects, a way to tell the
> server "don't bother sending me these objects" is useful already and
> it should be possible to use it to tell the server that there is no
> need to send some objects stored in the external ODB too.

The way to do that with normal objects is by finding shared commit tips,
and assuming the normal git repository property of "if you have X, you
have all of the objects reachable from X".

This whole idea is essentially creating "holes" in that property. You
can enumerate all of the holes, but I am not sure that scales well. We
get a lot of efficiency by communicating only ref tips during the
negotiation, and not individual object names.

> Also something like this is needed for shallow clones and narrow
> clones anyway.

Yes, and I don't think it scales well there, either. A single shallow
cutoff works OK. But if you repeatedly shallow-fetch into a repository,
you end up with a patchwork of disconnected "islands" of history. The
CPU required on the server side to serve those fetch requests is much
greater than what would normally be needed. You can't use things like
reachability bitmaps, and you have to open up the trees for each island
to see which objects the other side actually has.

> >        b. The receiving side of a connection has out-of-band access to
> >           some objects. Some of these will be expensive to get (e.g.,
> >           requiring a large download), and some may be fast (e.g.,
> >           they've already been fetched to a local cache). How do we tell
> >           the sending side not to assume we have cheap access to these
> >           objects (e.g., for use as a delta base)?
> 
> I don't think we need to tell the sending side we have cheap access or
> not to some objects.
> If the objects are managed by the external ODB, it's the external ODB
> on the server and on the client that will manage these objects. They
> should not be used as delta bases.
> Perhaps there is no mechanism to say that some objects (basically all
> external ODB managed objects) should not be used as delta bases, but
> that could be added.

Yes, I agree that _if_ the server can access the list of objects
available in the external odb, this becomes much easier. I'm just not
convinced that level of coupling is a good idea.

Note that the server would also want to take this into account during
repacking, as otherwise you end up with fetches that are very expensive
to serve (you want to send X which is a delta based on Y, but you know
that Y is available via the external odb, and therefore should not be
used as a base. So you have to throw out the delta for X and either send
it whole or compute a new one. That's much more expensive than blitting
the delta from disk, which is what a normal clone would do).

-Peff
