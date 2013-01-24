From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] parse_object: clear "parsed" when freeing buffers
Date: Thu, 24 Jan 2013 01:33:00 -0500
Message-ID: <20130124063259.GA610@sigill.intra.peff.net>
References: <8988071A-1DF3-463E-8AF9-AE4EA200D786@me.com>
 <7vsj5rfspy.fsf@alter.siamese.dyndns.org>
 <1C90CE32-F559-4E76-915E-93642F614552@me.com>
 <7vfw1rfmw2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathon Mah <jmah@me.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 07:33:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyGNO-0002ty-GN
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 07:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919Ab3AXGdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 01:33:06 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45766 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856Ab3AXGdD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 01:33:03 -0500
Received: (qmail 12073 invoked by uid 107); 24 Jan 2013 06:34:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Jan 2013 01:34:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2013 01:33:00 -0500
Content-Disposition: inline
In-Reply-To: <7vfw1rfmw2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214396>

On Wed, Jan 23, 2013 at 04:25:01PM -0800, Junio C Hamano wrote:

> > With the object cache, isn't modifying the object unsafe in
> > general? Instead of auditing code paths, it's now necessary to
> > audit _all_ code that uses "struct object", which seems
> > infeasible.
> 
> The object layer was designed with "run one thing and one thing
> well, and then let the _exit(2) take care of the clean-up" model in
> mind; modifying the object, e.g. updating commit->parents list,
> in-core by revision traversal machinery is very much within the
> scope of its intended uses.

Yeah, although I think the "parsed" flag really is a bit overloaded for
commits.

Most code which uses "struct commit" will want the parents, timestamp,
and tree information filled in. And so they call parse_commit to make
sure that is the case. Afterwards, those fields are valid and the
"parsed" flag is set. The buffer field may or may not be valid
afterwards, depending on save_commit_buffer.

Some other code may also care about the rest of the commit information.
It also calls parse_commit, but with save_commit_buffer turned on.
However, that may or may not actually initialize the buffer, depending
on who has been using the object before us.

It works in practice most of the time because we only perform one "task"
per invocation, and that task either keeps the commit messages around
the first time, or doesn't. But it is a bit of a ticking time bomb
anytime we violate that assumption.

I think it would be saner for callers who only care about ancestry info
call to call parse_commit, and then anybody who is about to access the
buffer to call a new ensure_commit_buffer function, which would make
sure the buffer is accessible (even if save_commit_buffer is false).

Then save_commit_buffer becomes just an optimization: save it for later
during parsing, so we don't have to do it later. That would also let us
optimize better if we end up with a commit ancestry cache which can do
parse_commit much cheaper than accessing the full object.

For example, my commit cache patches hook into parse_commit, but they
can only do so safely when save_commit_buffer is false. So git-rev-list
benefits, but git-log does not. However, if we knew that log would
lazily load the commit data when needed, we could use the cache
there, too. It would not be a win if you are showing every commit
anyway, but if you have limiting that does not depend on the commit
object itself (e.g., path limiting in the tree), you could avoid loading
some commits entirely.

> > I'm just trying to fix the segfault demonstrated in the test
> > attached to the patch.
> 
> Can offending readers that dereference NULL without checking if
> buffer has been freed be updated so that they read_sha1_file(), read
> the contents from the result returned from the function (instead of
> reading from .buffer), and free the memory when they are done?

Looks like builtin/blame.c:get_commit_info does this already, although
it leaves the buffer attached to the commit and does not free it.

The ensure_commit_buffer function could look something like:

  int ensure_commit_buffer(struct commit *item)
  {
          enum object_type type;
          unsigned long size;

          if (!item)
                  return -1;
          if (!item->object.parsed)
                  return parse_commit(item);
          if (item->buffer)
                  return 0;

          item->buffer = read_sha1_file(item->object.sha1, &type, &size);
          if (!item->buffer)
                  return error("Could not read %s",
                               sha1_to_hex(item->object.sha1);
          return 0;
  }

and blame could replace its in-line processing with that. It does leave
open the question of whether callers should free() the result. But that
would be up to each user of the object (and it would be an optimization
issue, not a correctness issue, as long as each user called
ensure_commit_buffer before accessing it).

But the first step there would be to audit all of the accesses of
commit->buffer to make sure that they call ensure_commit_buffer
(presumably they already call parse_commit).

-Peff
