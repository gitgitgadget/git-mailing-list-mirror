From: Brad King <brad.king@kitware.com>
Subject: [PATCH/RFC 0/7] Multiple simultaneously locked ref updates
Date: Thu, 29 Aug 2013 10:11:48 -0400
Message-ID: <cover.1377784597.git.brad.king@kitware.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 16:22:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF37J-0000xR-Rr
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 16:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755070Ab3H2OWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 10:22:17 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:48742 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754891Ab3H2OWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 10:22:16 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 685729FB87; Thu, 29 Aug 2013 10:11:55 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233260>

Hi Folks,

While thinking about some how some server-side branch management
services might work, I came across a need to update multiple refs
locked with verified old values simultaneously.  For example, to
transfer ownership of some commits by rewinding a branch and creating
a new branch at the original head, one must lock both refs.
Otherwise, depending on the order of updates another process could
create the new branch after we've rewound the original, or add commits
to the original after we've created the new branch.

This series teaches update-ref a new --stdin option to read update and
delete instructions from lines of standard input, lock all refs up
front with verified old values, and then perform the modifications.
This is still work in progress, but it is ready for comments and
feedback.  The series is based on master as of v1.8.4.

Notable unfinished work:

* I propose a format for stdin lines in the last commit of the series
  as a proof-of-concept but I invite suggestions of better formats.
  The format must be able to specify updates and deletes with optional
  old values and optional no-deref.

* No tests for new features, though existing tests pass for me.

* No check for duplicate refs in input.  Currently a duplicate ref
  will result in a failure message like:

   fatal: Unable to create '....lock': File exists.
   If no other git process is currently running, this probably means a
   git process crashed in this repository earlier. Make sure no other git
   process is running and remove the file manually to continue.

  Instead we should reject duplicate ref names up front.  I would
  appreciate suggestions about an efficient data structure already
  available in Git to perform this lookup.

I welcome feedback on the approach, interface, and implementation.

Thanks,
-Brad

Brad King (7):
  reset: rename update_refs to reset_refs
  refs: report ref type from lock_any_ref_for_update
  refs: factor update_ref steps into helpers
  refs: factor delete_ref loose ref step into a helper
  refs: add function to repack without multiple refs
  refs: add update_refs for multiple simultaneous updates
  update-ref: support multiple simultaneous updates

 Documentation/git-update-ref.txt |   19 ++++-
 branch.c                         |    2 +-
 builtin/commit.c                 |    2 +-
 builtin/fetch.c                  |    2 +-
 builtin/receive-pack.c           |    2 +-
 builtin/reflog.c                 |    2 +-
 builtin/replace.c                |    2 +-
 builtin/reset.c                  |    4 +-
 builtin/tag.c                    |    2 +-
 builtin/update-ref.c             |   93 ++++++++++++++++++++++-
 fast-import.c                    |    2 +-
 refs.c                           |  150 ++++++++++++++++++++++++++++++++------
 refs.h                           |   13 +++-
 sequencer.c                      |    2 +-
 14 files changed, 262 insertions(+), 35 deletions(-)

-- 
1.7.10.4
