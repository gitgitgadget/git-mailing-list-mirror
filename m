From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] index-pack: --clone-bundle option
Date: Fri, 4 Mar 2016 10:51:52 -0500
Message-ID: <20160304155151.GA18482@sigill.intra.peff.net>
References: <xmqq1t7r2x21.fsf@gitster.mtv.corp.google.com>
 <xmqqsi071bw1.fsf@gitster.mtv.corp.google.com>
 <20160303222902.GB26712@sigill.intra.peff.net>
 <xmqqfuw7186z.fsf_-_@gitster.mtv.corp.google.com>
 <xmqqbn6v174b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 16:52:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abs1H-0007xC-TG
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 16:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763AbcCDPv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 10:51:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:54800 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751415AbcCDPvz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 10:51:55 -0500
Received: (qmail 10164 invoked by uid 102); 4 Mar 2016 15:51:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Mar 2016 10:51:54 -0500
Received: (qmail 2392 invoked by uid 107); 4 Mar 2016 15:52:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Mar 2016 10:52:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Mar 2016 10:51:52 -0500
Content-Disposition: inline
In-Reply-To: <xmqqbn6v174b.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288259>

On Thu, Mar 03, 2016 at 03:20:20PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Note that this name choice does not matter very much in the larger
> > picture.  As an initial clone that bootstraps from a clone-bundle is
> > expected to do a rough equivalent of:
> >
> >     # create a new repository
> >     git init new-repository &&
> >     git remote add origin $URL &&
> >
> >     # prime the object store and anchor the history to temporary
> >     # references
> >     git fetch $bundle 'refs/*:refs/temporary/*' &&
> >
> >     # fetch the more recent history from the true origin
> >     git fetch origin &&
> >     git checkout -f &&
> >
> >     # remove the temporary refs
> >     git for-each-ref -z --format=%(refname) refs/temporary/ |
> >     xargs -0 git update-ref -d
> >
> > the names recorded in the bundle will not really matter to the end
> > result.
> 
> Actually, the real implementation of "bootstrap with clone-bundle"
> is more likely to go like this:
> 
>     * The client gets redirected to $name.bndl file, and obtains a
>       fairly full $name.pack file by downloading them as static
>       files;
> 
>     * The client initializes an empty repository;
> 
>     * The pack file is stored at .git/objects/pack/pack-$sha1.pack;
> 
>     * When the client does a "git fetch origin" to fill the more
>       recent part, fetch-pack.c::find_common() would read from the
>       "git bundle list-heads $name.bndl" to learn the "reference"
>       objects.  These are thrown at rev_list_insert_ref() and are
>       advertised as "have"s, just like we advertise objects at the
>       tip of refs in alternate repository.
> 
> So there will be no refs/temporary/* hierarchy we would need to
> worry about cleaning up.

I don't think details like this matter much to the bundle-generation
side, so this is pretty academic at this point. But I think unless we
want to do a lot of surgery to git-clone, we'll end up more with
something like:

  1. init empty repository

  2. contact the other side; find out they can redirect us to an
     alternate url

  3. fetch the alternate url; it turns out to be a split bundle. Grab
     the header, and then spool the data into a temp packfile. When it's
     all there, we can "index-pack --fix-thin" it in-place.

The reason I think we'll end up with this approach is that it keeps the
details of split-bundle fetching inside remote-curl. That keeps clone
cleaner, and also means we can grab a split-bundle for a fetch, too.

> Another possible variant is to redirect the client directly to
> download pack-$sha1.pack; "index-pack" needs to be run on the client
> side anyway to create pack-$sha1.idx, so at that time it could do
> the equivalent of "--clone-bundle" processing (it is not strictly
> necessary to create a split bundle) to find the tips of histories,
> and use that information when running "git fetch origin".
> 
> So, even though I started working from "split bundle", we may not
> have to have such a feature after all to support CDN offloadable and
> resumable clone.

Yeah. And I think we'd support this in my step (3) by responding to what
we get at the URL. I.e., "it turns out to be..." can have many outcomes,
and one of them is "a packfile".

-Peff
