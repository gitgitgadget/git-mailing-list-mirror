From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 09/19] rebase -i: commit only once when rewriting picks
Date: Fri, 1 Aug 2014 20:22:31 -0400
Message-ID: <20140802002231.GD20040@peff.net>
References: <53A258D2.7080806@gmail.com>
 <cover.1406589435.git.bafain@gmail.com>
 <235b55a0ec3db4a111fbb32e58e578ced6307d72.1406589435.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 02:22:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDN5u-0007ck-TX
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 02:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbaHBAWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 20:22:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:44566 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751008AbaHBAWi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 20:22:38 -0400
Received: (qmail 19526 invoked by uid 102); 2 Aug 2014 00:22:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Aug 2014 19:22:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Aug 2014 20:22:31 -0400
Content-Disposition: inline
In-Reply-To: <235b55a0ec3db4a111fbb32e58e578ced6307d72.1406589435.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254688>

On Tue, Jul 29, 2014 at 01:18:09AM +0200, Fabian Ruch wrote:

> The options passed to `do_pick` determine whether the picked commit
> will be rewritten or not. If the commit gets rewritten, because the
> user requested to edit the commit message for instance, let
> `pick_one` merely apply the changes introduced by the commit and do
> not commit the resulting tree yet. If the commit is replayed as is,
> leave it to `pick_one` to recreate the commit (possibly by
> fast-forwarding the head). This makes it easier to combine git-commit
> options like `--edit` and `--amend` in `do_pick` because
> git-cherry-pick does not support `--amend`.
> 
> In the case of `--edit`, do not `exit_with_patch` but assign
> `rewrite` to pick the changes with `-n`. If the pick conflicts, no
> commit is created which we would have to amend when continuing the
> rebase. To complete the pick after the conflicts are resolved the
> user just resumes with `git rebase --continue`.

Hmm. So does this mean the user will actually see a different state
during such a conflict?

E.g., if I have instructions like:

  pick A
  squash B
  squash C

and there is a conflict picking C, then what state do I see? Right now I
see a commit with the A+B squash prepared. But your description sounds
to me like we would avoid the squash for "B", and the user would see a
different state.

However, I couldn't trigger that behavior in a few experiments. Am I
misunderstanding, or is there some case where the user-visible state
will be different?

-Peff
