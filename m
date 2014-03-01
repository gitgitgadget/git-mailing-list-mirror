From: Jeff King <peff@peff.net>
Subject: Re: RFC GSoC idea: new "git config" features
Date: Sat, 1 Mar 2014 02:52:47 -0500
Message-ID: <20140301075247.GF20397@sigill.intra.peff.net>
References: <53108650.2020708@alum.mit.edu>
 <xmqqwqgft3bj.fsf@gitster.dls.corp.google.com>
 <53112794.2070007@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Mar 01 08:52:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJej8-0005pF-Lm
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 08:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504AbaCAHwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 02:52:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:59242 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752423AbaCAHwt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 02:52:49 -0500
Received: (qmail 25982 invoked by uid 102); 1 Mar 2014 07:52:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 01 Mar 2014 01:52:49 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Mar 2014 02:52:47 -0500
Content-Disposition: inline
In-Reply-To: <53112794.2070007@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243052>

On Sat, Mar 01, 2014 at 01:19:32AM +0100, Michael Haggerty wrote:

> I absolutely understand that changing all of the config parsers is not
> feasible.  But I had imagined a third route:
> 
> (3) parse the config once, storing the raw values to records in
>     memory.  When an "unset" is seen, delete any previous records that
>     have accumulated for that key.  After the whole config has been
>     read, iterate through the records, feeding the surviving values
>     into the callback in the order they were originally read (minus
>     deletions).
> 
> Do you see any problems with this way of implementing the functionality
> (aside from slightly increased overhead)?

Yeah, this is something I have considered many times. It does have some
overhead, but the existing system is not great either. As you noted, we
often read the config several times for a given program invocation.

But moreover, we linearly strcmp each config key we find against each
one we know about. In some cases we return early if a sub-function is
looking for `starts_with(key, "foo.")`, but in most cases we just look
for "foo.bar", "foo.baz", and so on.

If we had the keys in-memory, we could reverse this: config code asks
for keys it cares about, and we can do an optimized lookup (binary
search, hash, etc).

That also makes many constructs easier to express. Recently we had a
problem where the parsing order of "remote.pushdefault" and
"branch.*.pushremote" mattered, because they were read into the same
variable. The solution is to use two variables and reconcile them after
all config is read. But if you can just query the config subsystem
directly, the boilerplate of reading them into strings goes away, and
you can just do:

  x = config_string_getf("branch.%s.pushremote", current_branch);
  if (!x)
          x = config_string_get("remote.pushdefault");
  if (!x)
          x = config_string_getf("branch.%s.remote", current_branch);
  if (!x)
          x = "origin";

As it is now, the code that does this has a lot more boilerplate, and is
split across several functions.

Another example is the way we have to manage "deferred" config in
git-status (see 84b4202). This might be more clear if we could simply
`config_get_bool("status.branch")` at the right moment.

The talk of efficiency is probably a red-herring here. I do not think
config-reading is a significant source of slow-down in the current code.
But I'd be in favor of something that reduced boilerplate and made the
code easier to read.

> > But the side effects these callbacks may cause are not limited to
> > setting a simple scaler variable (like 'frotz' in the illustration)
> > but would include things that are hard to undo once done
> > (e.g. calling a set-up function with a lot of side effects).

Most callbacks would convert to a query system in a pretty
straightforward way, but some that have side effects might be tricky.
Converting them all may be too large for a GSoC project, but I think you
could do it gradually:

  1. Convert the parser to read into an in-memory representation, but
     leave git_config() as a wrapper which iterates over it.

  2. Add query functions like config_string_get() above.

  3. Convert callbacks to query functions one by one.

  4. Eventually drop git_config().

A GSoC project could take us partway through (3).

-Peff
