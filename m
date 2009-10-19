From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 0/5] Pretty formats for reflog data
Date: Mon, 19 Oct 2009 17:48:07 +0200
Message-ID: <cover.1255966426.git.trast@student.ethz.ch>
References: <7vaazonwtr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 17:49:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzuUD-0000tw-3K
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 17:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756771AbZJSPsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 11:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756765AbZJSPso
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 11:48:44 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:28915 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755934AbZJSPso (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 11:48:44 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Mon, 19 Oct
 2009 17:48:47 +0200
Received: from localhost.localdomain (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Mon, 19 Oct
 2009 17:48:46 +0200
X-Mailer: git-send-email 1.6.5.1.137.gefbc6
In-Reply-To: <7vaazonwtr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130710>

Junio C Hamano wrote:
> 
> One solution to help the compiler catch this kind of semantic crash upon
> merging or applying code based on the old format_commit_message() would
> have been to change its function signature (or even the name), so that it
> would not go unnoticed that DATE_NORMAL that happens to be "0" is silently
> interpreted as (void *)0 == NULL.

Indeed, that would have been a good idea.  (I still don't fully see
the use of allowing an enum value as a pointer, but apparently the
standard's that way.)

I fixed the calls to format_commit_message(), but without changing the
function signature compared to the last patch.  I also decided not to
put in the test case; the easiest I could come up with was the
following:

-- 8< --
diff --git i/t/t5001-archive-attr.sh w/t/t5001-archive-attr.sh
index 426b319..0950527 100755
--- i/t/t5001-archive-attr.sh
+++ w/t/t5001-archive-attr.sh
@@ -4,7 +4,7 @@ test_description='git archive attribute tests'
 
 . ./test-lib.sh
 
-SUBSTFORMAT=%H%n
+SUBSTFORMAT=%H%ad%n
 
 test_expect_exists() {
 	test_expect_success " $1 exists" "test -e $1"
-- >8 --

which immediately fails most tests in the file because of segfaults
with the buggy series.  However, it still wouldn't catch other broken
callers, if there were any, so I left it out.

Compared to v3, I also rebased the series on current master, which
conflicted with 7f98ebc (format_commit_message(): fix function
signature, 2009-10-15) so you now need that commit to apply it.

Finally, I squashed a revert of 0a0c342 (git-stash documentation:
mention default options for 'list', 2009-10-12) into 5/5 since there
are no more default options after my patch.


Thomas Rast (5):
  Refactor pretty_print_commit arguments into a struct
  reflog-walk: refactor the branch@{num} formatting
  Introduce new pretty formats %g[sdD] for reflog information
  stash list: use new %g formats instead of sed
  stash list: drop the default limit of 10 stashes

 Documentation/git-stash.txt      |    3 +-
 Documentation/pretty-formats.txt |    9 ++++
 archive.c                        |    4 +-
 builtin-branch.c                 |    3 +-
 builtin-checkout.c               |    3 +-
 builtin-commit.c                 |    8 +++-
 builtin-log.c                    |    3 +-
 builtin-merge.c                  |    7 ++-
 builtin-rev-list.c               |    7 ++-
 builtin-shortlog.c               |    9 +++-
 builtin-show-branch.c            |    4 +-
 commit.h                         |   20 ++++++---
 git-stash.sh                     |    8 +---
 log-tree.c                       |   25 ++++++-----
 pretty.c                         |   44 ++++++++++++++------
 reflog-walk.c                    |   83 ++++++++++++++++++++++++++++----------
 reflog-walk.h                    |    8 ++++
 t/t6006-rev-list-format.sh       |   18 ++++++++
 18 files changed, 189 insertions(+), 77 deletions(-)
