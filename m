From: Jeff King <peff@peff.net>
Subject: Re: [GSoC14][RFC] Proposal Draft: Refactor tempfile handling
Date: Mon, 3 Mar 2014 17:42:38 -0500
Message-ID: <20140303224238.GA2699@sigill.intra.peff.net>
References: <CAN7MxmVQuk96dmXfxZ5kRZPTXNwpz2RY=y8HyqX4mZzrZUVbNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 23:42:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbZN-0000bJ-Qj
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 23:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270AbaCCWml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 17:42:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:60658 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755009AbaCCWmk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 17:42:40 -0500
Received: (qmail 14845 invoked by uid 102); 3 Mar 2014 22:42:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 03 Mar 2014 16:42:40 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Mar 2014 17:42:38 -0500
Content-Disposition: inline
In-Reply-To: <CAN7MxmVQuk96dmXfxZ5kRZPTXNwpz2RY=y8HyqX4mZzrZUVbNg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243294>

On Sun, Mar 02, 2014 at 06:04:39AM +0900, Brian Gesiak wrote:

> My name is Brian Gesiak. I'm a research student at the University of
> Tokyo, and I'm hoping to participate in this year's Google Summer of
> Code by contributing to Git. I'm a longtime user, first-time
> contributor--some of you may have noticed my "microproject"
> patches.[1][2]

Yes, we did notice them. Thanks, and welcome. :)

> The ideas page points out that while lock files are closed and
> unlinked[3] when the program exits[4], object pack files implement
> their own brand of temp file creation and deletion. This
> implementation doesn't share the same guarantees as lock files--it is
> possible that the program terminates before the temp file is
> unlinked.[5]
> 
> Lock file references are stored in a linked list. When the program
> exits, this list is traversed and each file is closed and unlinked. It
> seems to me that this mechanism is appropriate for temp files in
> general, not just lock files. Thus, my proposal would be to extract
> this logic into a separate module--tempfile.h, perhaps. Lock and
> object files would share the tempfile implementation.
> 
> That is, both object and lock temp files would be stored in a linked
> list, and all of these would be deleted at program exit.

Yes, I think this is definitely the right way to go. We should be able
to unify the tempfile handling for all of git. Once the logic is
extracted into a nice API, there are several other places that can use
it, too:

  - the external diff code creates tempfiles and uses its own cleanup
    routines

  - the shallow_XXXXXX tempfiles (these are not cleaned right now,
    though I sent a patch recently for them to do their own cleanup)

Those are just off the top of my head. There may be other spots, too.

It is worth thinking in your proposal about some of the things that the
API will want to handle. What are the mismatches in how lockfiles and
object files are handled? E.g., how do we finalize them into place?
How should the API be designed to minimize race conditions (e.g., if we
get a signal delivered while we are committing or cleaning up a file)?

> Please let me know if this seems like it would make for an interesting
> proposal, or if perhaps there is something I am overlooking. Any
> feedback at all would be appreciated. Thank you!

You definitely have a grasp of what the project is aiming for, and which
areas need to be touched.

-Peff
