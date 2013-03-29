From: Miklos Vajna <vmiklos@suse.cz>
Subject: [PATCH] cherry-pick -x: improve handling of one-liner commit messages
Date: Fri, 29 Mar 2013 16:38:18 +0100
Message-ID: <20130329153818.GB27251@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 29 16:38:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULbOI-0004EV-44
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 16:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756131Ab3C2PiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 11:38:25 -0400
Received: from cantor2.suse.de ([195.135.220.15]:60620 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755628Ab3C2PiY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 11:38:24 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id C792EA3A49;
	Fri, 29 Mar 2013 16:38:20 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219503>

git cherry-pick -x normally just appends the "cherry picked from commit"
line at the end of the message, which is fine. However, in case the
original commit message had only one line, first append a newline,
otherwise the second line won't be empty, which is against
recommendations.
---
 sequencer.c                   | 10 ++++++++++
 t/t3501-revert-cherry-pick.sh |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index aef5e8a..1ae0e43 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -496,6 +496,16 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		}
 
 		if (opts->record_origin) {
+
+			/*
+			 * If this the message is a one-liner, append a
+			 * newline, so the second line will be empty, as
+			 * recommended.
+			 */
+			p = strstr(msgbuf.buf, "\n\n");
+			if (!p)
+				strbuf_addch(&msgbuf, '\n');
+
 			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 6f489e2..858c744 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -70,6 +70,14 @@ test_expect_success 'cherry-pick after renaming branch' '
 
 '
 
+test_expect_success 'cherry-pick -x of one-liner commit message' '
+
+	git checkout rename2 &&
+	git cherry-pick -x added &&
+	git show -s --pretty=format:%s | test_must_fail grep "cherry picked"
+
+'
+
 test_expect_success 'revert after renaming branch' '
 
 	git checkout rename1 &&
-- 
1.8.1.4
