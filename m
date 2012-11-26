From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 05/11] sequencer.c: always separate "(cherry picked from" from commit body
Date: Sun, 25 Nov 2012 17:45:53 -0800
Message-ID: <1353894359-6733-6-git-send-email-drafnel@gmail.com>
References: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Cc: pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 02:47:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcnnD-0007Ks-Pb
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 02:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822Ab2KZBrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 20:47:11 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39847 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767Ab2KZBrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 20:47:09 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so7623405pbc.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 17:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GnXUtwnlMSNWJ8giSLm+V6tD2q/T4I3Pg0DcjCHnZ3o=;
        b=0MK+ZjmZ9IawpNBTFX3Nn0jm80cnkt800yIf9Y/A66YVJ6LKWI2mO+Pw247/+k/4TW
         B/T7OWM26EF8xs8FRKjN2opDyn3t21wS8Rfr9KoHq+rZbItdZivKdBhhwQirWw4L+naF
         Ru941+HOZ4saaELf28WZ0ISYbUVFcmp6YLoxaTxDhd0sQbunWlNbJ3zvmxM/NywuaEUL
         bpqwAbaffsNUz72005XN3DIPDHtmQKVk7ddUyJ9PxO/Vf0CVQMYjsO9RpNek23TLnFzY
         +VYffoyxk3sirsFeauJnuBf+aSG6Mw/ZTjJdUFuAkD/LYjmMSQuHVZwj460/XU1SIMeO
         SlQQ==
Received: by 10.68.132.202 with SMTP id ow10mr32540436pbb.139.1353894429408;
        Sun, 25 Nov 2012 17:47:09 -0800 (PST)
Received: from charliebrown.sbx05686.santaca.wayport.net (dhcp64-134-221-228.hoic.dca.wayport.net. [64.134.221.228])
        by mx.google.com with ESMTPS id ot5sm7828428pbb.29.2012.11.25.17.47.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Nov 2012 17:47:08 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210395>

Start treating the "(cherry picked from" line added by cherry-pick -x
the same way that the s-o-b lines are treated.  Namely, separate them
from the main commit message body with an empty line.

Introduce tests to test this functionality.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 sequencer.c              | 106 +++++++++++++++++++++++++----------------------
 t/t3511-cherry-pick-x.sh |  53 ++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 50 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 19eaf11..7c0852a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -20,6 +20,60 @@
 const char sign_off_header[] = "Signed-off-by: ";
 static const char cherry_picked_prefix[] = "(cherry picked from commit ";
 
+static int is_rfc2822_line(const char *buf, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		int ch = buf[i];
+		if (ch == ':')
+			break;
+		if (isalnum(ch) || (ch == '-'))
+			continue;
+		return 0;
+	}
+
+	return 1;
+}
+
+static int is_cherry_pick_from_line(const char *buf, int len)
+{
+	return (strlen(cherry_picked_prefix) + 41) <= len &&
+		!prefixcmp(buf, cherry_picked_prefix);
+}
+
+static int has_conforming_footer(struct strbuf *sb, int ignore_footer)
+{
+	int hit = 0;
+	int i, k;
+	int len = sb->len - ignore_footer;
+	const char *buf = sb->buf;
+
+	for (i = len - 1; i > 0; i--) {
+		if (hit && buf[i] == '\n')
+			break;
+		hit = (buf[i] == '\n');
+	}
+
+	/* require at least one blank line */
+	if (!hit || buf[i] != '\n')
+		return 0;
+
+	while (i < len - 1 && buf[i] == '\n')
+		i++;
+
+	for (; i < len; i = k) {
+		for (k = i; k < len && buf[k] != '\n'; k++)
+			; /* do nothing */
+		k++;
+
+		if (!(is_rfc2822_line(buf+i, k-i) ||
+			is_cherry_pick_from_line(buf+i, k-i)))
+			return 0;
+	}
+	return 1;
+}
+
 static void remove_sequencer_state(void)
 {
 	struct strbuf seq_dir = STRBUF_INIT;
@@ -493,6 +547,8 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		}
 
 		if (opts->record_origin) {
+			if (!has_conforming_footer(&msgbuf, 0))
+				strbuf_addch(&msgbuf, '\n');
 			strbuf_addstr(&msgbuf, cherry_picked_prefix);
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
@@ -1018,56 +1074,6 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	return pick_commits(todo_list, opts);
 }
 
-static int is_rfc2822_line(const char *buf, int len)
-{
-	int i;
-
-	for (i = 0; i < len; i++) {
-		int ch = buf[i];
-		if (ch == ':')
-			break;
-		if (isalnum(ch) || (ch == '-'))
-			continue;
-		return 0;
-	}
-
-	return 1;
-}
-
-static int is_cherry_pick_from_line(const char *buf, int len)
-{
-	return (strlen(cherry_picked_prefix) + 41) <= len &&
-		!prefixcmp(buf, cherry_picked_prefix);
-}
-
-static int has_conforming_footer(struct strbuf *sb, int ignore_footer)
-{
-	int hit = 0;
-	int i, k;
-	int len = sb->len - ignore_footer;
-	const char *buf = sb->buf;
-
-	for (i = len - 1; i > 0; i--) {
-		if (hit && buf[i] == '\n')
-			break;
-		hit = (buf[i] == '\n');
-	}
-
-	while (i < len - 1 && buf[i] == '\n')
-		i++;
-
-	for (; i < len; i = k) {
-		for (k = i; k < len && buf[k] != '\n'; k++)
-			; /* do nothing */
-		k++;
-
-		if (!(is_rfc2822_line(buf+i, k-i) ||
-			is_cherry_pick_from_line(buf+i, k-i)))
-			return 0;
-	}
-	return 1;
-}
-
 void append_signoff(struct strbuf *msgbuf, int ignore_footer)
 {
 	struct strbuf sob = STRBUF_INIT;
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index 32c0bb1..9dd6d5d 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -57,6 +57,19 @@ test_expect_success setup '
 	test_commit conflicting unrelated
 '
 
+test_expect_success 'cherry-pick -x inserts blank line after one line subject' '
+	pristine_detach initial &&
+	sha1=`git rev-parse mesg-one-line^0` &&
+	git cherry-pick -x mesg-one-line &&
+	cat <<-EOF >expect &&
+		$mesg_one_line
+
+		(cherry picked from commit $sha1)
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'cherry-pick -s inserts blank line after one line subject' '
 	pristine_detach initial &&
 	git cherry-pick -s mesg-one-line &&
@@ -81,6 +94,19 @@ test_expect_failure 'cherry-pick -s inserts blank line after non-conforming foot
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-pick -x inserts blank line when conforming footer not found' '
+	pristine_detach initial &&
+	sha1=`git rev-parse mesg-no-footer^0` &&
+	git cherry-pick -x mesg-no-footer &&
+	cat <<-EOF >expect &&
+		$mesg_no_footer
+
+		(cherry picked from commit $sha1)
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'cherry-pick -s inserts blank line when conforming footer not found' '
 	pristine_detach initial &&
 	git cherry-pick -s mesg-no-footer &&
@@ -93,6 +119,20 @@ test_expect_success 'cherry-pick -s inserts blank line when conforming footer no
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-pick -x -s inserts blank line when conforming footer not found' '
+	pristine_detach initial &&
+	sha1=`git rev-parse mesg-no-footer^0` &&
+	git cherry-pick -x -s mesg-no-footer &&
+	cat <<-EOF >expect &&
+		$mesg_no_footer
+
+		(cherry picked from commit $sha1)
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'cherry-pick -s adds sob when last sob doesnt match committer' '
 	pristine_detach initial &&
 	git cherry-pick -s mesg-with-footer &&
@@ -163,4 +203,17 @@ test_expect_success 'cherry-pick -s treats "(cherry picked from..." line as part
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-pick -x -s treats "(cherry picked from..." line as part of footer' '
+	pristine_detach initial &&
+	sha1=`git rev-parse mesg-with-cherry-footer^0` &&
+	git cherry-pick -x -s mesg-with-cherry-footer &&
+	cat <<-EOF >expect &&
+		$mesg_with_cherry_footer
+		(cherry picked from commit $sha1)
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.0.284.g959048a
