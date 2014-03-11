From: Jeff King <peff@peff.net>
Subject: Re: [GSoC14][RFC] Proposal Draft: Refactor tempfile handling
Date: Mon, 10 Mar 2014 21:33:17 -0400
Message-ID: <20140311013316.GA11524@sigill.intra.peff.net>
References: <CAN7MxmVQuk96dmXfxZ5kRZPTXNwpz2RY=y8HyqX4mZzrZUVbNg@mail.gmail.com>
 <20140303224238.GA2699@sigill.intra.peff.net>
 <CAN7MxmW-aWgTQpTMuEx=kzyHVUf5E7unZR-LmLQrY-AmmrZxjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 02:33:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNBZL-00088f-O2
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 02:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787AbaCKBdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 21:33:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:36967 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751812AbaCKBdT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 21:33:19 -0400
Received: (qmail 3135 invoked by uid 102); 11 Mar 2014 01:33:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Mar 2014 20:33:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Mar 2014 21:33:17 -0400
Content-Disposition: inline
In-Reply-To: <CAN7MxmW-aWgTQpTMuEx=kzyHVUf5E7unZR-LmLQrY-AmmrZxjA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243830>

On Sun, Mar 09, 2014 at 02:04:16AM +0900, Brian Gesiak wrote:

> > Once the logic is extracted into a nice API, there are
> > several other places that can use it, too: ...
> 
> I've found the following four areas so far:
> 
> 1. lockfile.lock_file
> 2. git-compat-util.odb_mkstemp
> 3. git-compat-util.odb_pack_keep
> 4. diff.prepare_temp_file
> 
> Tons of files use (1) and (2). (3) is less common, and (4) is only
> used for external diffs.

Yeah, I would expect (1) and (2) to be the most frequent. (3) gets
written on every push and fetch, but only for a short period. (4) is
also used for diff's textconv, though like external diffs, they are
relatively rare.

In my experience, most of the cruft that gets left is from (2), since a
push or fetch will spool to a tmpfile, then verify the results via "git
index-pack". Any failure there leaves the file in place.

There are a few other potential candidates we can find by grepping for
mkstemp. Not all of those might want cleanup, but it's a starting point
for investigation.

> > the shallow_XXXXXX tempfiles
> 
> I'm not sure I was able to find this one. Are you referring to the
> lock files used when fetching, such as in fetch-pack.c?

I mean the xmkstemp from setup_temporary_shallow in shallow.c.

> I'd say the biggest difference between lockfiles and object files is
> that tempfile methods like odb_mkstemp need to know the location of
> the object directory. Aside from that, lockfiles and the external diff
> files appear to be cleaned up at exit, while temporary object files
> tend to have a more finely controlled lifecycle. I'm still
> investigating this aspect of the proposal, though.

The diff tempfiles are true tempfiles; they always go away in the end
(though of course we want to clean them up as we finish with them,
rather than doing it all at the end). Lockfiles may get committed into
place (i.e., via atomic rename) or rolled back (deleted).

Object files should generally be hard-linked into place, but there is
some extra magic in move_temp_to_file to fallback to renames.  Some of
that we may be able to get rid of (e.g., we try to avoid doing
cross-directory renames at all these days, so the comment there may be
out of date).

> One question, though: the idea on the ideas page specifies that
> temporary pack and object files may "optionally" be cleaned up in case
> of error during program execution. How will users specify their
> preference? I think the API for creating temporary files should allow
> cleanup options to be specified on a per-file basis. That way each
> part of the program that creates tempfiles can specify a different
> config value to determine the cleanup policy.

That probably makes sense. I certainly had a config option in mind. I
mentioned above that the most common cruft is leftover packfiles from
pushes and fetches. We haven't deleted those historically because the
same person often controls both the client and the server, and they
would want to possibly do forensics on the packfile sent to the remote,
or even rescue objects out of it. But the remote end may simply have
rejected the pack by some policy, and has no interest in forensics.

Having a config option for each type of file may be cool, but I don't
know how useful it would be in practice. Still, it's certainly worth
thinking about and looking into.

-Peff
