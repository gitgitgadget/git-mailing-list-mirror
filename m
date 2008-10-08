From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [PATCH v2 RFC] rebase-i-p: squashing and limiting todo
Date: Wed,  8 Oct 2008 01:41:50 -0500
Message-ID: <cover.1223445353.git.stephen@exigencecorp.com>
Cc: spearce@spearce.org, Stephen Haberman <stephen@exigencecorp.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 08:43:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnSlO-0006jp-Qt
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 08:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbYJHGmD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 02:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbYJHGmC
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 02:42:02 -0400
Received: from smtp132.sat.emailsrvr.com ([66.216.121.132]:60986 "EHLO
	smtp132.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbYJHGmA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 02:42:00 -0400
Received: from relay3.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay3.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 5792225342F;
	Wed,  8 Oct 2008 02:41:59 -0400 (EDT)
Received: by relay3.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id CE2D7253018;
	Wed,  8 Oct 2008 02:41:58 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97766>

This is v2 of my attempt at keeping commits with no-parents-being-rewritten off
the rebase-i-p todo list. This was prompted by Avi Kivity's request to squash
commits on either side of a merge, but is something I had wanted as well without
fully realizing it.

Stephan Beyer pointed out his git sequencer branch already does this, contrary
to my incorrect reading of it. His rewrite of rebase-i-p changed how todo was
generated to follow these semantics, and nicely, too, so I replaced my initial
hacky algorithm for "only include commits with rewritten parents" with his.

The better implementation aside, I found Stephan's matching semantics
encouraging as if Avi, myself, and Stephan (plus others/the list involved in
past git sequencer discussions) all expect rebase-i-p to drop non-rewritten
commits, then the semantics should be intuitive and what most users expect.

Also, even though git sequencer has these semantics (and more), I'd like to see
this patch reviewed and applied anyway as I think it is a nice solution to the
current rebase-i-p shortcomings. And, assuming its approved, it can be applied
now instead of waiting for git sequencer to be finished, reviewed, and applied.

This is also my first patch series. I started a new thread--I'm not sure if I
was supposed to use Avi's original message id or not. Also, I cheated and put
the tests in the first commit instead of starting them as test_expect_failure
and gradually changing them to test_expect_success.

Stephen Haberman (7):
  rebase-i-p: test to exclude commits from todo based on its parents
  rebase-i-p: use HEAD for updating the ref instead of mapping OLDHEAD
  rebase-i-p: delay saving current-commit to REWRITTEN if squashing
  rebase-i-p: fix 'no squashing merges' tripping up non-merges
  rebase-i-p: only list commits that require rewriting in todo
  rebase-i-p: do not include non-first-parent commits touching UPSTREAM
  rebase-i-p: if todo was reordered use HEAD as the rewritten parent

 git-rebase--interactive.sh               |   80 ++++++++++++------
 t/t3411-rebase-preserve-around-merges.sh |  136 ++++++++++++++++++++++++++++++
 2 files changed, 190 insertions(+), 26 deletions(-)
 create mode 100644 t/t3411-rebase-preserve-around-merges.sh
