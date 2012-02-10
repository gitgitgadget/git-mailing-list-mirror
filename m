From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 28/51] refs.c: rename ref_array -> ref_dir
Date: Fri, 10 Feb 2012 15:44:57 -0500
Message-ID: <20120210204457.GD5504@sigill.intra.peff.net>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
 <1323668338-1764-29-git-send-email-mhagger@alum.mit.edu>
 <7v7h21xps9.fsf@alter.siamese.dyndns.org>
 <4EE6E61F.8080405@alum.mit.edu>
 <7vk461vuy9.fsf@alter.siamese.dyndns.org>
 <4EE7A387.3070400@alum.mit.edu>
 <4EE7CDF2.3040408@alum.mit.edu>
 <7vzkewt5qu.fsf@alter.siamese.dyndns.org>
 <4F158E99.2020906@alum.mit.edu>
 <4F352F03.2030104@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 10 21:45:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvxL9-000526-0Y
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 21:45:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760058Ab2BJUpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 15:45:00 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33534
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755209Ab2BJUo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 15:44:59 -0500
Received: (qmail 7600 invoked by uid 107); 10 Feb 2012 20:52:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 Feb 2012 15:52:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Feb 2012 15:44:57 -0500
Content-Disposition: inline
In-Reply-To: <4F352F03.2030104@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190452>

On Fri, Feb 10, 2012 at 03:51:47PM +0100, Michael Haggerty wrote:

> First problem: everything_local() seems to be either broken or used
> incorrectly.  I can't decide which because I don't know what its
> semantics are *supposed* to be.
> 
> If everything_local() is trying to check that the references are all in
> the local repository itself, then it is incorrect for clone to enter
> alternates into extra_refs because everything_local() then mistakes them
> for local.
> 
> If everything_local() is trying to check that the references are in the
> local repository plus alternates, then it is incorrect that
> everything_local() doesn't consider alternate references in its
> determination.  My guess is that this is the case, and that something
> like the following might be the fix:

Junio could answer more authoritatively than I, but I am pretty sure it
is the latter. The point is to skip the expensive find_common
negotiation if we know that there are no objects to fetch. Thus the
"local" here is "do we have them on this side of the git-protocol
connection", not "do we have them in our non-alternates repository".

> > ----------------------------- builtin/fetch-pack.c -----------------------------
> > index 9500f35..4257a8d 100644
> > @@ -581,6 +581,11 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
> >  	*refs = newlist;
> >  }
> >  
> > +static void mark_alternate_complete(const struct ref *ref, void *unused)
> > +{
> > +	mark_complete(NULL, ref->old_sha1, 0, NULL);
> > +}
> > +
> >  static int everything_local(struct ref **refs, int nr_match, char **match)
> >  {
> >  	struct ref *ref;
> > @@ -609,6 +614,7 @@ static int everything_local(struct ref **refs, int nr_match, char **match)
> >  
> >  	if (!args.depth) {
> >  		for_each_ref(mark_complete, NULL);
> > +		for_each_alternate_ref(mark_alternate_complete, NULL);
> >  		if (cutoff)
> >  			mark_recent_complete_commits(cutoff);
> >  	}
> 
> With this patch, then the full test suite passes even if I take out the
> code that adds the alternate refs to extra_refs.

That looks sane to me.

> Specifically: (without the above patch) I commented out the call to
> add_extra_ref() in clone.c:add_one_reference(), then ran t5700 through
> step 8 then aborted.  insert_one_alternate_ref() was called four times:
> 
> insert_one_alternate_ref(ccc25a1f9655742174c93f48f616bea8ad0bc6ff)
> insert_one_alternate_ref(ccc25a1f9655742174c93f48f616bea8ad0bc6ff)
> insert_one_alternate_ref(5355551c5a927a2b6349505ada2da4bb702c0a49)
> insert_one_alternate_ref(5355551c5a927a2b6349505ada2da4bb702c0a49)
> 
> (The duplication here seems strange.)

I think the duplication can be explained. The alternate-refs mechanism
gets the list of refs by running "git ls-remote" on each alternate.
The symbolic refs appear as refs in that list. So in t5700, for example,
I get:

  $ git ls-remote B
  56a2e291e54b1a92180fe2072152e6aa0919fc5f        HEAD
  56a2e291e54b1a92180fe2072152e6aa0919fc5f        refs/heads/master
  3ee812e8486c2474e2b03be5c0b42e33092da069        refs/remotes/origin/HEAD
  3ee812e8486c2474e2b03be5c0b42e33092da069        refs/remotes/origin/master

Because you don't actually care about the alternate refs themselves, but
only about their sha1 values, you could eliminate duplicates early. The
code in receive-pack already does this; fetch-pack should probably do
the same (it's not _wrong_ not to, but in some pathological cases, the
duplicates can make performance worse).

> want 5355551c5a927a2b6349505ada2da4bb702c0a49 multi_ack_detailed
> side-band-64k thin-pack ofs-delta
> want 5355551c5a927a2b6349505ada2da4bb702c0a49
> #E
> 
> The "5355551c" object corresponds to refs/remotes/origin/master in the
> alternate object store:
> 
> $ (cd B; git for-each-ref)
> ccc25a1f9655742174c93f48f616bea8ad0bc6ff commit	refs/heads/master
> 5355551c5a927a2b6349505ada2da4bb702c0a49 commit	refs/remotes/origin/HEAD
> 5355551c5a927a2b6349505ada2da4bb702c0a49 commit	refs/remotes/origin/master
> 
> It seems to me that even in the absence of short-circuiting due to
> everything_local() returning true, the presence of the alternate refs
> should be suppressing the "want" lines for those references.

Yeah, that definitely seems like a bug in find_common.

-Peff
