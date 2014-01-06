From: Jeff King <peff@peff.net>
Subject: Re: Bug report: stash in upstream caused remote fetch to fail
Date: Mon, 6 Jan 2014 18:03:48 -0500
Message-ID: <20140106230348.GA7811@sigill.intra.peff.net>
References: <CAECVvXYD69Xrp85bVJg6XogvctUTwrFDae+3tawFgoCAUGhwGg@mail.gmail.com>
 <20140106152742.GA26221@sigill.intra.peff.net>
 <xmqqbnzpkrvk.fsf@gitster.dls.corp.google.com>
 <20140106193625.GA27062@sigill.intra.peff.net>
 <xmqq61pwj25q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matt Burke <spraints@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 00:04:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0JDS-0002Bg-EX
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 00:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757298AbaAFXEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 18:04:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:56181 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757279AbaAFXDu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 18:03:50 -0500
Received: (qmail 25428 invoked by uid 102); 6 Jan 2014 23:03:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Jan 2014 17:03:50 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Jan 2014 18:03:48 -0500
Content-Disposition: inline
In-Reply-To: <xmqq61pwj25q.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240079>

On Mon, Jan 06, 2014 at 12:17:21PM -0800, Junio C Hamano wrote:

> > I am fine with rejecting it with a warning, but we should not then
> > complain that the other side did not send us the object, since we should
> > not be asking for it at all. I also do not see us complaining about the
> > funny ref anywhere.  So there is definitely _a_ bug here. :)
> 
> Oh, no question about that.  I was just pointing somebody who
> already has volunteered to take a look in a direction I recall was
> where the issue was ;-)

Oh, crud, did I volunteer? :)

So I found the problem, but I'm really not sure what to make of it. We
do check the refname format when evaluating the refspecs, in:

    do_fetch
      get_ref_map
        get_fetch_map
          check_refname_format

Before calling it, we check that it starts with "refs/", and then pass
the _whole_ refname into check_refname_format. So the latter sees
"refs/stash". And that's acceptable, as it's not a single-level ref.
Thus we do not get the "funny ref" message.

The code looks like this:

  if (!starts_with((*rmp)->peer_ref->name, "refs/") ||
      check_refname_format((*rmp)->peer_ref->name, 0)) {
        /* print funny ref and ignore */

Then we ask fetch_refs_via_pack to get the actual objects for us. And
it checks our refs again, with this call chain:

  do_fetch
    fetch_refs
      transport_fetch_refs
        fetch_refs_via_pack
          fetch_pack
            do_fetch_pack
              everything_local
                filter_refs
                  check_refname_format

Here, the code looks like this:

  if (!memcmp(ref->name, "refs/", 5) &&
      check_refname_format(ref->name + 5, 0))
    ; /* trash */

At first I thought we are doing the same check (is it syntactically
valid, and is it in "refs/"), but we're not. We are actually checking
the format _only_ of stuff in "refs/", and ignoring the rest. Which
really makes no sense to me.

If it were "memcmp(...) || check_refname_format()", then it would be
roughly the same check. But it would still be wrong, because note that
we pass only the bits under "refs/" to check_refname_format. So it sees
only "stash", and then complains that it is single-level.

So the symptom we are seeing is because we are filtering with two
different rulesets in different places. But I'm really not sure how to
resolve it. The one in filter_refs seems nonsensical to me.

Checking _only_ things under refs/ doesn't make sense. And even if that
was sensible, feeding half a ref to check_refname_format does not work.
In addition to the single-level check, it has other rules that want
to see the whole ref (e.g., the ref "@" is not valid, but "refs/@" is
OK; it cannot distinguish them without seeing the prefix).

So I can see two options:

  1. Make the check in filter_refs look like the one in get_fetch_map.
     That at least makes them the same, which alleviates the symptom.
     But we still are running two checks, and if they ever get out of
     sync, it causes problems.

  2. Abolish the check in filter_refs. I think this makes the most sense
     from the perspective of fetch, because we will already have cleaned up
     the ref list. But we might need to leave the filtering in place for
     people who call fetch-pack as a bare plumbing command.

It's really not clear to me what the check in filter_refs was trying to
do. It dates all the way back to 1baaae5 (Make maximal use of the remote
refs, 2005-10-28), but there is not much explanation. I haven't dug into
the list around that time to see if there's any discussion.

-Peff
