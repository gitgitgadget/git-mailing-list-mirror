From: Jeff King <peff@peff.net>
Subject: Re: First/oldest entry in reflog dropped
Date: Sun, 21 Nov 2010 23:42:53 -0500
Message-ID: <20101122044252.GA7362@sigill.intra.peff.net>
References: <AANLkTiktGbeSmUB75kn3q=swnw=cHvivX21OkR3sJJDC@mail.gmail.com>
 <20101121053545.GA10520@sigill.intra.peff.net>
 <alpine.DEB.1.00.1011211233570.2948@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 22 05:46:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKOI6-00022k-Q5
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 05:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756591Ab0KVEnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Nov 2010 23:43:08 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:54036 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756545Ab0KVEnH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Nov 2010 23:43:07 -0500
Received: (qmail 14004 invoked by uid 111); 22 Nov 2010 04:43:02 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 22 Nov 2010 04:43:01 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 21 Nov 2010 23:42:53 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1011211233570.2948@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161880>

On Sun, Nov 21, 2010 at 12:36:21PM +0100, Johannes Schindelin wrote:

> On Sun, 21 Nov 2010, Jeff King wrote:
> 
> > This patch clears up your bug, and doesn't break any tests. But I'd 
> > really like to get a second opinion on the significance of those other 
> > flags, or why the flag clearing was at the bottom of the function in the 
> > first place.
> 
> The flag clearing was at the bottom because I had the impression that 
> something function one might want to call in that function in the future 
> could set the flags again. Maybe a goto would be appropriate here instead 
> of the early returns?

That makes sense. I did a quick skim of the called code and I'm not sure
any flags could be set, but even if I am right, I think it is better to
be defensive.

So let's do this, which is the equivalent behavior to your gotos, but
this structure makes more sense to me as a reader (and it doesn't
involve goto :) ).

-- >8 --
Subject: [PATCH] reflogs: clear flags properly in corner case

The reflog-walking mechanism is based on the regular
revision traversal. We just rewrite the parents of each
commit in fake_reflog_parent to point to the commit in the
next reflog entry instead of the real parents.

However, the regular revision traversal tries not to show
the same commit twice, and so sets the SHOWN flag on each
commit it shows. In a reflog, however, we may want to see
the same commit more than once if it appears in the reflog
multiple times (which easily happens, for example, if you do
a reset to a prior state).

The fake_reflog_parent function takes care of this by
clearing flags, including SHOWN. Unfortunately, it does so
at the very end of the function, and it is possible to
return early from the function if there is no fake parent to
set up (e.g., because we are at the very first reflog entry
on the branch). In such a case the flag is not cleared, and
the entry is skipped by the revision traversal machinery as
already shown.

You can see this by walking the log of a ref which is set to
its very first commit more than once (the test below shows
such a situation). In this case the reflog walk will fail to
show the entry for the initial creation of the ref.

We don't want to simply move the flag-clearing to the top of
the function; we want to make sure flags set during the
fake-parent installation are also cleared. Instead, let's
hoist the flag-clearing out of the fake_reflog_parent
function entirely. It's not really about fake parents
anyway, and the only caller is the get_revision machinery.

Reported-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 reflog-walk.c          |    1 -
 revision.c             |    4 +++-
 t/t1412-reflog-loop.sh |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 2 deletions(-)
 create mode 100755 t/t1412-reflog-loop.sh

diff --git a/reflog-walk.c b/reflog-walk.c
index 4879615..5d81d39 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -239,7 +239,6 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 
 	commit->parents = xcalloc(sizeof(struct commit_list), 1);
 	commit->parents->item = commit_info->commit;
-	commit->object.flags &= ~(ADDED | SEEN | SHOWN);
 }
 
 void get_reflog_selector(struct strbuf *sb,
diff --git a/revision.c b/revision.c
index b1c1890..ded8812 100644
--- a/revision.c
+++ b/revision.c
@@ -2030,8 +2030,10 @@ static struct commit *get_revision_1(struct rev_info *revs)
 		revs->commits = entry->next;
 		free(entry);
 
-		if (revs->reflog_info)
+		if (revs->reflog_info) {
 			fake_reflog_parent(revs->reflog_info, commit);
+			commit->object.flags &= ~(ADDED | SEEN | SHOWN);
+		}
 
 		/*
 		 * If we haven't done the list limiting, we need to look at
diff --git a/t/t1412-reflog-loop.sh b/t/t1412-reflog-loop.sh
new file mode 100755
index 0000000..7f519e5
--- /dev/null
+++ b/t/t1412-reflog-loop.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+test_description='reflog walk shows repeated commits again'
+. ./test-lib.sh
+
+test_expect_success 'setup commits' '
+	test_tick &&
+	echo content >file && git add file && git commit -m one &&
+	git tag one &&
+	echo content >>file && git add file && git commit -m two &&
+	git tag two
+'
+
+test_expect_success 'setup reflog with alternating commits' '
+	git checkout -b topic &&
+	git reset one &&
+	git reset two &&
+	git reset one &&
+	git reset two
+'
+
+test_expect_success 'reflog shows all entries' '
+	cat >expect <<-\EOF
+		topic@{0} two: updating HEAD
+		topic@{1} one: updating HEAD
+		topic@{2} two: updating HEAD
+		topic@{3} one: updating HEAD
+		topic@{4} branch: Created from HEAD
+	EOF
+	git log -g --format="%gd %gs" topic >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.7.3.2.509.g15259
