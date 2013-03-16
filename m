From: Jeff King <peff@peff.net>
Subject: Re: Tag peeling peculiarities
Date: Sat, 16 Mar 2013 05:34:41 -0400
Message-ID: <20130316093441.GA26260@sigill.intra.peff.net>
References: <51409439.5090001@alum.mit.edu>
 <7vwqtb2ood.fsf@alter.siamese.dyndns.org>
 <20130313215800.GA23838@sigill.intra.peff.net>
 <51415516.2070702@alum.mit.edu>
 <20130314052448.GA2300@sigill.intra.peff.net>
 <5141B475.1000707@alum.mit.edu>
 <20130314134032.GA9222@sigill.intra.peff.net>
 <514431EA.2050402@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Mar 16 10:35:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGnWE-0007em-Co
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 10:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402Ab3CPJeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 05:34:46 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53420 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753555Ab3CPJep (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 05:34:45 -0400
Received: (qmail 446 invoked by uid 107); 16 Mar 2013 09:36:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 16 Mar 2013 05:36:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Mar 2013 05:34:41 -0400
Content-Disposition: inline
In-Reply-To: <514431EA.2050402@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218292>

On Sat, Mar 16, 2013 at 09:48:42AM +0100, Michael Haggerty wrote:

> My patch series is nearly done.  I will need another day or two to
> review and make it submission-ready, but I wanted to give you an idea of
> what I'm up to and I could also use your feedback on some points.

I was just sending out my cleaned up patches to do do fully-peeled, too.
I think the duplication is OK, though, as your topic would be for
"master" and mine can go to "maint".

> * Implement fully-peeled packed-refs files, as discussed upthread: peel
>   references outside of refs/tags, and keep rigorous track of
>   which references have REF_KNOWS_PEELED.

Looks pretty similar to mine. We even added similar tests.

I notice that you do the "add REF_KNOWS_PEELED if we actually got a peel
line" optimization. I didn't bother, because this will never be
triggered by a git-written file (either we do not write the entry, or we
set fully-peeled). I wonder if any other implementation does peel every
ref, though.

> * Change pack-refs to use the peeled information from ref_entries if it
>   is available, rather than looking up the references again.

I don't know that it matters from a performance standpoint (we don't
really care how long pack-refs takes, as long as it is within reason,
because it is run as part of a gc).  But it would mean that any errors
in the file are propagated from one run of pack-refs to the next. I
don't know if we want to spend the extra time to be more robust.

> * repack_without_ref() writes peeled refs to the packed-refs file.
>   Use the old values if available; otherwise look them up.

Whereas here we probably _do_ want the performance optimization, because
we do care about the performance of a ref deletion.

> 1. There are multiple functions for peeling refs:
>    peel_ref() (and peel_object(), which was extracted from it);
>    peel_entry() (derived from pack-refs.c:pack_one_ref()).  It would be
>    nice to combine these into the One True Function.  But given the
>    problem that you mentioned above (which is rooted in parts of the
>    code that I don't know) I don't know what that version should do.

I'm not sure I understand the question. Just skimming your patches, it
looks like peel_entry could just call peel_object?

> 2. repack_without_ref() now writes peeled refs, peeling them if
>    necessary.  It does this *without* referring to the loose refs
>    to avoid having to load all of the loose references, which can be
>    time-consuming.  But this means that it might try to lookup SHA1s
>    that are not the current value of the corresponding reference any
>    more, and might even have been garbage collected.

Yuck. I really wonder if repack_without_ref should literally just be
writing out the exact same file, minus the lines for the deleted ref.
Is there a reason we need to do any processing at all? I guess the
answer is that you want to avoid re-parsing the current file, and just
write it out from memory. But don't we need to refresh the memory cache
from disk under the lock anyway? That was the pack-refs race that I
fixed recently.

> Is the code that
>    I use to do this, in peel_entry(), safe to call for nonexistent
>    SHA1s (I would like it to return 0 if the SHA1 is invalid)?:
> 
> 	o = parse_object(entry->u.value.sha1);
> 	if (o->type == OBJ_TAG) {
> 		o = deref_tag(o, entry->name, 0);
> 		if (o) {
> 			hashcpy(entry->u.value.peeled, o->sha1);
> 			entry->flag |= REF_KNOWS_PEELED;
> 			return 1;
> 		}
> 	}
> 	return 0;

I think this approach is safe, as parse_object will silently return NULL
for a missing object. You do need to check for "o != NULL" in your
conditional, though.

> 3. This same change to repack_with_ref() means that it could become
>    significantly slower to delete a packed ref if the packed-ref file
>    is not fully-peeled.  On the plus side, once this is done once, the
>    packed-refs files will be rewritten in fully-peeled form.  But if
>    two versions of Git are being used in a repository, this cost could
>    be incurred repeatedly.  Does anybody object?

I think it's OK in concept. But I still am wondering if it would be
simpler still to just pass the file through while locked.

> 4. Should I change the locking policy as discussed in this thread?:
> 
>        http://article.gmane.org/gmane.comp.version-control.git/212131

I think it's overall a sane direction. It does increase lock contention
slightly when two processes are deleting at the same time, but it would
fix the weird corner cases I described (mostly deleted refs reappearing
due to races). And the lock contention is already there in a
fully-packed repo anyway. I.e., right now we read the packed-refs file
and lock it if our to-delete ref is in there; with the proposed change,
we would lock before even reading it. So the increased contention is
only when two deleters race each other, _and_ one of them is not
deleting a packed ref.

-Peff
