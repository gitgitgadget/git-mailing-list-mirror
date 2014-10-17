From: Jeff King <peff@peff.net>
Subject: git-bundle rev handling and de-duping
Date: Thu, 16 Oct 2014 20:33:56 -0400
Message-ID: <20141017003356.GC7848@peff.net>
References: <20141015223244.GA25368@peff.net>
 <20141015223419.GC25630@peff.net>
 <xmqqr3y7ud5h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 02:34:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XevUj-0006qg-4t
	for gcvg-git-2@plane.gmane.org; Fri, 17 Oct 2014 02:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbaJQAd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 20:33:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:59460 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751116AbaJQAd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 20:33:59 -0400
Received: (qmail 4445 invoked by uid 102); 17 Oct 2014 00:33:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Oct 2014 19:33:58 -0500
Received: (qmail 4035 invoked by uid 107); 17 Oct 2014 00:33:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Oct 2014 20:33:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Oct 2014 20:33:56 -0400
Content-Disposition: inline
In-Reply-To: <xmqqr3y7ud5h.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[subject tweaked as we have veered quite far off the original, and
 this might get more attention from interested people]

On Thu, Oct 16, 2014 at 10:39:54AM -0700, Junio C Hamano wrote:

>  2.  We use object_array_remove_duplicates() to de-dup "git bundle
>      create x master master", which came from b2a6d1c6 (bundle:
>      allow the same ref to be given more than once, 2009-01-17),
>      which is still the sole caller of the function, and I think
>      this is bogus.  Comparing .name would not de-dup "git bundle
>      create x master refs/heads/master".

Hmm. We also doesn't respect the UNINTERESTING flag, so it will dedup
"foo" and "^foo" into a single entry. I _think_ this doesn't have any
bad side effects, because they are equivalent (i.e., the flag is carried
on the object, not the pending entry). I would expect this:

  git bundle create ... foo ^foo

to barf (and it does) because the bundle is empty. But with this:

  git bundle create ... another-ref foo ^foo

I would expect the resulting bundle to contain the objects from
another-ref, but still mention "foo" as an update (we didn't need to
send any objects, since presumably the other side already had them). It
doesn't, but that is not because of the dedup. It is because we generate
the list of refs to send based on the pending list, and we skip all
UNINTERESTING objects (we must, because otherwise "^foo" would make an
entry). I.e., it is the same "the flag is on the object, not the pending
entry" that saved us above now causing its own bug. Obviously the
example above is sort of silly, but if you have:

  # two branches point at the same object
  git branch foo master

  # the other side already has master. Let's send them foo.
  # this will fail because the bundle is empty. That's mildly
  # annoying because we really want to tell them "hey, update
  # your foo branch". But at least we get an error.
  git bundle create tmp.bundle foo ^master

  # now the same thing, but we're sending them some other objects.
  # This one succeeds, but silently omits foo from the bundle!
  git bundle create tmp.bundle foo another-ref ^master

I have a feeling that the list needs to be generated from revs.cmdline,
not revs.pending, and the de-duplication needs to happen there (with the
ref resolution that you mention).

I also have the feeling that fast-export had to deal with this exact
same issue. It looks like we use revs.cmdline there. I seem to recall
there was some ongoing work in that area, but I stopped paying close
attention due to some personality conflicts, and I don't know if all of
the issues were ever resolved.

> I think the right way to fix these two and a half problems is to do
> the following:
> 
>  - object_array_remove_duplicates() (and contains_name() helper it
>    uses) should be removed from object.c;
> 
>  - create_bundle() in bundle.c should implement a helper that is
>    similar to contains_name() but knows about ref dwimming and use
>    it to call object_array_filter() to replace its call to
>    object_array_remove_duplicates().

Agreed. The loop in create_bundle right after the de-dup does the
dwimming. Probably it would be simple to just skip duplicates there
using a hashmap or sorted list.

> I am not doing this myself, and I do not expect either you or
> Michael to do so, either.  I am just writing this down to point out
> a low hanging fruit to aspiring new contributors (hint, hint).

I am also not planning on working on it soon, but now we have hopefully
fed plenty of possibilities to anybody who wants to. :)

-Peff
