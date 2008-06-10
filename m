From: Olivier Marin <dkr+ml.git@free.fr>
Subject: [PATCH 4/4] remote show: list tracked remote branches with -n
Date: Tue, 10 Jun 2008 16:51:49 +0200
Message-ID: <1213109509-7013-1-git-send-email-dkr+ml.git@free.fr>
References: <1213109413-6842-1-git-send-email-dkr+ml.git@free.fr>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 16:52:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K65DE-0004Mo-I7
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 16:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150AbYFJOvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 10:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753115AbYFJOvq
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 10:51:46 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:50907 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753106AbYFJOvq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 10:51:46 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 5B68312B754;
	Tue, 10 Jun 2008 16:51:45 +0200 (CEST)
Received: from localhost.localdomain (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 60C7A12B732;
	Tue, 10 Jun 2008 16:51:43 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc2.160.gd660c
In-Reply-To: <1213109413-6842-1-git-send-email-dkr+ml.git@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84508>

From: Olivier Marin <dkr@freesurf.fr>

Signed-off-by: Olivier Marin <dkr@freesurf.fr>
---
 builtin-remote.c  |   25 +++++++++++++++++++++++--
 t/t5505-remote.sh |    3 ++-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 851bdde..de4a4f2 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -444,6 +444,25 @@ static int get_remote_ref_states(const char *name,
 	return 0;
 }
 
+static int append_ref_to_tracked_list(const char *refname,
+	const unsigned char *sha1, int flags, void *cb_data)
+{
+	struct ref_states *states = cb_data;
+	struct strbuf buf;
+
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "%s/", states->remote->name);
+	if (strncmp(buf.buf, refname, buf.len)) {
+		strbuf_release(&buf);
+		return 0;
+	}
+
+	path_list_append(skip_prefix(refname, strbuf_detach(&buf, NULL)),
+		&states->tracked);
+
+	return 0;
+}
+
 static int show(int argc, const char **argv)
 {
 	int no_query = 0, result = 0;
@@ -494,10 +513,12 @@ static int show(int argc, const char **argv)
 			strbuf_release(&buf);
 			show_list("  Stale tracking branch%s (use 'git remote "
 				"prune')", &states.stale);
-			show_list("  Tracked remote branch%s",
-				&states.tracked);
 		}
 
+		if (no_query)
+			for_each_remote_ref(append_ref_to_tracked_list, &states);
+		show_list("  Tracked remote branch%s", &states.tracked);
+
 		if (states.remote->push_refspec_nr) {
 			printf("  Local branch%s pushed with 'git push'\n   ",
 				states.remote->push_refspec_nr > 1 ?
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index c27cfad..ec5ea54 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -137,12 +137,13 @@ test_expect_success 'show' '
 	 git remote show origin > output &&
 	 test_cmp expect output)
 '
-
 cat > test/expect << EOF
 * remote origin
   URL: $(pwd)/one/.git
   Remote branch merged with 'git pull' while on branch master
     master
+  Tracked remote branch
+    side
   Local branches pushed with 'git push'
     master:upstream +refs/tags/lastbackup
 EOF
-- 
1.5.6.rc2.160.gd660c
