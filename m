From: Robin Stocker <robin@nibor.org>
Subject: [PATCH] cherry-pick: Append -x line on separate paragraph
Date: Tue, 4 Sep 2012 19:16:46 +0200 (CEST)
Message-ID: <1244407605.1231.1346779006295.JavaMail.root@bazinga.schuettel.ch>
References: <739367481.1229.1346778500787.JavaMail.root@bazinga.schuettel.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 04 19:23:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8wqQ-00007q-DA
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 19:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757462Ab2IDRXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 13:23:14 -0400
Received: from cust.static.212-90-207-187.cybernet.ch ([212.90.207.187]:46529
	"EHLO bazinga.schuettel.ch" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757458Ab2IDRXM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2012 13:23:12 -0400
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Sep 2012 13:23:12 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by bazinga.schuettel.ch (Postfix) with ESMTP id 00DD91C0436
	for <git@vger.kernel.org>; Tue,  4 Sep 2012 19:16:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at schuettel.ch
Received: from bazinga.schuettel.ch ([127.0.0.1])
	by localhost (bazinga.schuettel.ch [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TAJZG-gBdlLT for <git@vger.kernel.org>;
	Tue,  4 Sep 2012 19:16:46 +0200 (CEST)
Received: from bazinga.schuettel.ch (cust.static.212-90-207-187.cybernet.ch [212.90.207.187])
	by bazinga.schuettel.ch (Postfix) with ESMTP id 9912E1C03AD
	for <git@vger.kernel.org>; Tue,  4 Sep 2012 19:16:46 +0200 (CEST)
In-Reply-To: <739367481.1229.1346778500787.JavaMail.root@bazinga.schuettel.ch>
X-Originating-IP: [87.239.215.2]
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - FF3.0 (Linux)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204755>

Before this, git cherry-pick -x resulted in messages like this:

    Message of cherry-picked commit
    (cherry picked from commit 871e293c9acbeaacce59dcd98fab6028f552f5be)

Which is not the recommended way to write commit messages. When the
commit message ends with a Signed-off-by, it's less bad. But having it
on a line apart from the others also doesn't hurt there.

Now, care is taken that the line is appended as a separate paragraph:

    Message of cherry-picked commit

    (cherry picked from commit 871e293c9acbeaacce59dcd98fab6028f552f5be)

Because some Git implementations (JGit) don't always terminate the
commit message with a newline, this change also inserts a second newline
if necessary.

Signed-off-by: Robin Stocker <robin@nibor.org>
---
 sequencer.c                    |    4 ++++
 t/t3511-cherry-pick-message.sh |   26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100755 t/t3511-cherry-pick-message.sh

diff --git a/sequencer.c b/sequencer.c
index bf078f2..41852e6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -484,6 +484,10 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		}
 
 		if (opts->record_origin) {
+			/* Some implementations don't terminate message with final \n, so add it */
+			if (msg.message[strlen(msg.message)-1] != '\n')
+				strbuf_addch(&msgbuf, '\n');
+			strbuf_addch(&msgbuf, '\n');
 			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
diff --git a/t/t3511-cherry-pick-message.sh b/t/t3511-cherry-pick-message.sh
new file mode 100755
index 0000000..6aba8b2
--- /dev/null
+++ b/t/t3511-cherry-pick-message.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+test_description='Test cherry-pick commit message with -x'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	git config advice.detachedhead false &&
+	test_commit initial foo a &&
+	test_commit base foo b &&
+	git checkout initial
+'
+
+test_expect_success 'cherry-pick -x appends message on separate line' '
+	git cherry-pick -x base &&
+	cat >expect <<-\EOF &&
+	base
+
+	(cherry picked from commit 462a97d89aa55720c97984a3ce09665989193981)
+
+	EOF
+	git log --format=%B -n 1 >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.7.7.6
