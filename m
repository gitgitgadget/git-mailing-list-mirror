From: Jeff King <peff@peff.net>
Subject: [PATCH 0/7] cat-file --batch-check performance improvements
Date: Fri, 12 Jul 2013 02:15:34 -0400
Message-ID: <20130712061533.GA11297@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 08:15:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxWdq-0004AV-7l
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 08:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554Ab3GLGPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 02:15:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:36458 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751480Ab3GLGPh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 02:15:37 -0400
Received: (qmail 16171 invoked by uid 102); 12 Jul 2013 06:16:55 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Jul 2013 01:16:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jul 2013 02:15:34 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230165>

In my earlier series introducing "git cat-file --batch-check=<format>",
found here:

  http://thread.gmane.org/gmane.comp.version-control.git/229761/focus=230041

I spent a little time optimizing revindex generation, and measured by
requesting information on a single object from a large repository. This
series takes the next logical step: requesting a large number of objects
from a large repository.

There are two major optimizations here:

  1. Avoiding extra ref lookups due to the warning in 798c35f (get_sha1:
     warn about full or short object names that look like refs,
     2013-05-29).

  2. Avoiding extra work for delta type resolution when the user has not
     asked for %(objecttype).

I prepared the series on top of jk/in-pack-size-measurement, and
certainly optimization 2 is pointless without it (before that topic,
--batch-check always printed the type).

However, the first optimization affects regular --batch-check, and
represents a much more serious performance regression. It looks like
798c35f is in master, but hasn't been released yet, so assuming these
topics graduate before the next release, it should be OK. But if not, we
should consider pulling the first patch out and applying it (or
something like it) separately.

The results for running (in linux.git):

  $ git rev-list --objects --all >objects
  $ git cat-file --batch-check='%(objectsize:disk)' <objects >/dev/null

are:

        before     after
  real  1m17.143s  0m7.205s
  user  0m27.684s  0m6.580s
  sys   0m49.320s  0m0.608s

Now, _most_ of that speedup is coming from the first patch, and it's
quite trivial. The rest of the patches involve a lot of refactoring, and
only manage to eke out one more second of performance, so it may not be
worth it (though I think the result actually cleans up the
sha1_object_info_extended interface a bit, and is worth it). Individual
timings are in the commit messages.

The patches are:

  [1/7]: cat-file: disable object/refname ambiguity check for batch mode

Optimization 1.

  [2/7]: sha1_object_info_extended: rename "status" to "type"
  [3/7]: sha1_loose_object_info: make type lookup optional
  [4/7]: packed_object_info: hoist delta type resolution to helper
  [5/7]: packed_object_info: make type lookup optional
  [6/7]: sha1_object_info_extended: make type calculation optional

Optimization 2.

  [7/7]: sha1_object_info_extended: pass object_info to helpers

Optional cleanup.

-Peff
