From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] log -L: do not free parents lists we might need again
Date: Sat, 11 Sep 2010 23:10:57 +0200
Message-ID: <92a37c8a8d7157aa8bf4d654f4e5bd713c69382d.1284239099.git.trast@student.ethz.ch>
References: <20100830171007.GC21441@burratino>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 11 23:11:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuXM3-0003Xp-Eg
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 23:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503Ab0IKVLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Sep 2010 17:11:01 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:49194 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397Ab0IKVLA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Sep 2010 17:11:00 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 11 Sep
 2010 23:10:57 +0200
Received: from localhost.localdomain (217.162.250.31) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sat, 11 Sep
 2010 23:10:58 +0200
X-Mailer: git-send-email 1.7.3.rc1.333.gf62981
In-Reply-To: <20100830171007.GC21441@burratino>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156013>

The parent rewriting code of 'git log -L' was too aggressive in
freeing memory: assign_range_to_parent() will free the commit->parents
field when it sees that a parent cannot pass off any blame (is a root
commit in rewritten history).

Its caller assign_parents_range() however will, upon finding the first
parent that takes *full* blame for all ranges, rewind and reinstate
all previous parents' line ranges and parent lists.  This resurrects
pointers to ranges that were freed in assign_range_to_parent() under
some circumstances.

Furthermore, we must not empty the parent lists either: the same
rewind/reinstate code relies on them.

Do both only if the commit was an ordinary (not merge or root) commit,
in which case the merge code-path discussed here is never taken.

Reported-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
[sorry for the double post, forgot to cc the list]

After staring at it for some time, I think this is the problem.

Sadly I cannot come up with an independent test that reproduces it (or
at least generates a valgrind warning).  Based on my analysis I tried

 diff --git a/t/t4302-log-line-merge-history.sh b/t/t4302-log-line-merge-history.sh
 index 8634116..7c86903 100755
 --- a/t/t4302-log-line-merge-history.sh
 +++ b/t/t4302-log-line-merge-history.sh
 @@ -171,4 +171,17 @@ test_expect_success 'validate the graph output.' '
  	test_cmp current-graph expected-graph
  '
  
 +test_expect_success 'set up trivial side merge' '
 +	git checkout -b trivial-side &&
 +	echo new_line >> path0 &&
 +	git add path0 &&
 +	git commit -m new_line &&
 +	git checkout master &&
 +	git merge --no-ff trivial-side
 +'
 +
 +test_expect_success 'log -L on the trivial-merged file' '
 +	git log -L /new_line/,+1 path0
 +'
 +
  test_done

but that does not fail.  I am hesitant to add your original test
because it strays into the directory where git was built, to test with
git's own history.  It just feels wrong.


 line.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/line.c b/line.c
index 63dd19a..b0deafb 100644
--- a/line.c
+++ b/line.c
@@ -961,8 +961,10 @@ static int assign_range_to_parent(struct rev_info *rev, struct commit *c,
 		 * If there is no new ranges assigned to the parent,
 		 * we should mark it as a 'root' commit.
 		 */
-		free(c->parents);
-		c->parents = NULL;
+		if (c->parents && !c->parents->next) {
+			free(c->parents);
+			c->parents = NULL;
+		}
 	}
 
 	/* and the ranges of current commit c is updated */
-- 
1.7.3.rc1.333.gf62981
