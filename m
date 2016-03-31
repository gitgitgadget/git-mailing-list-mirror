From: Jeff King <peff@peff.net>
Subject: Re: RFC: New reference iteration paradigm
Date: Thu, 31 Mar 2016 15:31:51 -0400
Message-ID: <20160331193150.GC5013@sigill.intra.peff.net>
References: <56FD4CAD.3070100@alum.mit.edu>
 <xmqqlh4yo7av.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 21:31:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aliJy-0006mY-DI
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 21:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756277AbcCaTby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 15:31:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:41870 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754538AbcCaTby (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 15:31:54 -0400
Received: (qmail 8974 invoked by uid 102); 31 Mar 2016 19:31:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 15:31:53 -0400
Received: (qmail 16902 invoked by uid 107); 31 Mar 2016 19:31:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 15:31:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2016 15:31:51 -0400
Content-Disposition: inline
In-Reply-To: <xmqqlh4yo7av.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290455>

On Thu, Mar 31, 2016 at 11:01:44AM -0700, Junio C Hamano wrote:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
> > the backend now has to implement
> >
> >> struct ref_iterator *ref_iterator_begin_fn(const char *submodule,
> >>                                            const char *prefix,
> >>                                            unsigned int flags);
> >
> > The ref_iterator itself has to implement two main methods:
> >
> >> int iterator_advance_fn(struct ref_iterator *ref_iterator);
> >> void iterator_free_fn(struct ref_iterator *ref_iterator);
> >
> > A loop over references now looks something like
> >
> >> struct ref_iterator *iter = each_ref_in_iterator("refs/tags/");
> >> while (ref_iterator_advance(iter)) {
> >>         /* code using iter->refname, iter->oid, iter->flags */
> >> }
> 
> We'd want to take advantage of the tree-like organization of the
> refs (i.e. refs/tags/a and refs/tags/b sit next to each other and
> they are closer to each other than they are to refs/heads/a) so that
> a request "I want to iterate only over tags, even though I may have
> millions of other kinds of refs" can be done with cost that is
> proportional to how many tags you have.
> 
> The current implementation of for_each_tag_ref() that goes down to
> do_for_each_entry() in files-backend.c has that propertly, and the
> new iteration mechanism with the above design seems to keep it,
> which is very nice.

Actually, that is a slight fiction. :)

We traverse only the loose ref directories we need, but we populate the
entire packed-refs tree in one go. That's fine if you have a reasonable
number of refs and care about the cold-cache case (where you care a lot
about hitting directories you don't need to, but reading the entire
packed-refs file isn't a big deal). But it's really bad if you have an
800MB packed-refs file, as looking up one tiny subset of the entries
wastes a lot of RAM and CPU pulling that into our internal
representation[1].

At one point I wrote a patch to binary search the packed-refs file, find
the first "refs/tags/" entry, and then walk linearly through there. What
stopped me is that the current refs.c code (I guess file-backend.c these
days) was not happy with me partially filling in the ref_dir structs in
this "inside out" way.

That is, they assume we may have iterated "refs/", but not yet dove into
"refs/tags/" (because that's what makes sense for traversing loose
refs). But they are not happy if you already dove into "refs/tags/", but
don't know what else might be present in "refs/".

I wonder if, while Michael is fiddling with the iterator code, it might
be possible to fix that (it's not a fundamental problem, just one with
the way the ref-caching works right now).

-Peff

[1] As you probably guessed, I run into these giant packed-refs files as
    part of our "alternates" storage for multiple forks of the same
    repository. So all of the refs match the pattern
    "refs/remotes/$fork_id/*", and I really would like to be able to
    iterate the refs for just one fork at a time.
