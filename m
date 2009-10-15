From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 0/5] Pretty formats for reflog data
Date: Fri, 16 Oct 2009 00:41:43 +0200
Message-ID: <cover.1255645570.git.trast@student.ethz.ch>
References: <20091014050645.GD31810@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 00:46:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyZ4s-0006Yh-Td
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 00:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763173AbZJOWnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 18:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763171AbZJOWnM
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 18:43:12 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:27224 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763169AbZJOWnL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 18:43:11 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 16 Oct
 2009 00:42:23 +0200
Received: from localhost.localdomain (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 16 Oct
 2009 00:42:23 +0200
X-Mailer: git-send-email 1.6.5.116.gfe4b9
In-Reply-To: <20091014050645.GD31810@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130435>

Jeff King wrote:
> Maybe a better solution would be a "short name" variant for pretty
> format specifiers. We already have %(refname) and %(refname:short) [...]
> The tricky part would be deciding on a syntax. This seems to come up a
> fair bit.

Ok, I settled for %g[dDs] for now to save on letters.  I'm saving the
syntax question for a later series while we discuss this one ;-)

I think going for %(...) wouldn't be too bad since we already have
that in for-each-ref, and it can be backwards compatible.  So we would
have different sets of short and long specifiers, e.g.

  %ae = %(authoremail)
  %aE = %(authoremail:mailmap)

We can then pass arguments via some yet-to-be decided syntax, say,
%(body:indent(10)).

Other changes in this version include:

* I followed your struct suggestion, which is the new 1/5.

* Since the shortening can be handled by %gd, the old 5/5 (change from
  refs/stash to only stash) is no longer needed.

* I fixed the warning that Junio found (and finally found the right
  combination of -W flags, though I cannot compile with -Werror myself
  because of *other* warnings...)

I also added tests and docs to the main patch (now 3/5).

Thomas Rast (5):
  Refactor pretty_print_commit arguments into a struct
  reflog-walk: refactor the branch@{num} formatting
  Introduce new pretty formats %g[sdD] for reflog information
  stash list: use new %g formats instead of sed
  stash list: drop the default limit of 10 stashes

 Documentation/pretty-formats.txt |    3 +
 builtin-branch.c                 |    3 +-
 builtin-checkout.c               |    3 +-
 builtin-log.c                    |    3 +-
 builtin-merge.c                  |    7 ++-
 builtin-rev-list.c               |    7 ++-
 builtin-shortlog.c               |    9 +++-
 builtin-show-branch.c            |    4 +-
 commit.h                         |   20 ++++++---
 git-stash.sh                     |    8 +---
 log-tree.c                       |   21 +++++----
 pretty.c                         |   44 ++++++++++++++------
 reflog-walk.c                    |   85 ++++++++++++++++++++++++++++----------
 reflog-walk.h                    |    8 ++++
 t/t1411-reflog-show.sh           |   12 +++++
 15 files changed, 166 insertions(+), 71 deletions(-)
