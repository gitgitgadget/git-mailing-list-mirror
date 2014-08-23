From: Jeff King <peff@peff.net>
Subject: [PATCH 0/5] fix pack-refs pruning of refs/foo
Date: Sat, 23 Aug 2014 01:23:34 -0400
Message-ID: <20140823052334.GA17813@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 07:27:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XL3qv-0006tk-0Q
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 07:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbaHWFXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2014 01:23:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:57230 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751996AbaHWFXg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2014 01:23:36 -0400
Received: (qmail 13250 invoked by uid 102); 23 Aug 2014 05:23:36 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 23 Aug 2014 00:23:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Aug 2014 01:23:34 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255729>

I noticed that "git pack-refs --all" will pack a top-level ref like
"refs/foo", but will not actually prune "$GIT_DIR/refs/foo". I do not
see the point in having a policy not to pack "refs/foo" if "--all" is
given. But even if we did have such a policy, this seems broken; we
should either pack and prune, or leave them untouched. I don't see any
indication that the existing behavior was intentional.

The problem is that pack-refs's prune_ref calls lock_ref_sha1, which
enforces this "no toplevel" behavior. I am not sure there is any real
point to this, given that most callers use lock_any_ref_for_update,
which is exactly equivalent but without the toplevel check.

The first two patches deal with this by switching pack-refs to use
lock_any_ref_for_update. This will conflict slightly with Ronnie's
ref-transaction work, as he gets rid of lock_ref_sha1 entirely, and
moves the code directly into prune_ref. This can be trivially resolved
in favor of my patch, I think.

The third patch is a cleanup I noticed while looking around, and I think
should not conflict with anyone (and is a good thing to do).

The last two are trickier. I wondered if we could get rid of
lock_ref_sha1 entirely. After pack-refs, there are two callers:
fast-import.c and walker.c. After converting the first, it occurred to
me that Ronnie might be touching the same areas, and I see that yes,
indeed, there's quite a bit of conflict (and he reaches the same end
goal of dropping it entirely).

So in that sense I do not mind dropping the final two patches. Ronnie's
endpoint is much better, moving to a ref_transaction. However, there is
actually a buffer overflow in the existing code. Ronnie's series fixes
it in a similar way (moving to a strbuf), and I'm fine with that
endpoint. But given that the ref transaction code is not yet merged (and
would certainly never be maint-track), I think it is worth applying the
buffer overflow fix separately.

I think the final patch can probably be dropped, then. It is a clean-up,
but one that we can just get when Ronnie's series is merged.

  [1/5]: git-prompt: do not look for refs/stash in $GIT_DIR
  [2/5]: pack-refs: prune top-level refs like "refs/foo"
  [3/5]: fast-import: clean up pack_data pointer in end_packfile
  [4/5]: fast-import: fix buffer overflow in dump_tags
  [5/5]: fast-import: stop using lock_ref_sha1

-Peff
