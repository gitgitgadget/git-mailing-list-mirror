From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH 2/2] Ensure that objects shown in a core.autocrlf = true repo have CRLF EOLs
Date: Tue, 10 Jun 2008 09:55:09 +0200
Message-ID: <3478a0d599f41fad9d8509dc264cbe34772446e2.1213084587.git.marius@trolltech.com>
References: <cover.1213084587.git.marius@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 10:14:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5yzh-0006ET-DC
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 10:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbYFJINE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 04:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753284AbYFJIND
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 04:13:03 -0400
Received: from hoat.troll.no ([62.70.27.150]:34166 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753378AbYFJIMz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2008 04:12:55 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id AE87520AA6;
	Tue, 10 Jun 2008 10:12:49 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 92F5B203B2;
	Tue, 10 Jun 2008 10:12:49 +0200 (CEST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84482>

When you show an object, it should be shown with the EOLs which the repo
is configured for, and not how it's stored internally in the object store.

Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
---
 builtin-log.c         |   19 ++++++++++++++-----
 t/t6033-merge-crlf.sh |    6 +++---
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 9817d6f..94367f6 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -287,8 +287,8 @@ static void show_tagger(char *buf, int len, struct rev_info *rev)
 	       show_date(date, tz, rev->date_mode));
 }
 
-static int show_object(const unsigned char *sha1, int show_tag_object,
-	struct rev_info *rev)
+static int show_object(const unsigned char *sha1, const char *name,
+	int show_tag_object, struct rev_info *rev)
 {
 	unsigned long size;
 	enum object_type type;
@@ -309,8 +309,17 @@ static int show_object(const unsigned char *sha1, int show_tag_object,
 			offset = new_offset;
 		}
 
-	if (offset < size)
+	if (offset < size) {
+		struct strbuf strbuf;
+		strbuf_init(&strbuf, 0);
+		if (convert_to_working_tree(name, buf + offset, size - offset, &strbuf)) {
+			free(buf);
+			offset = 0;
+			size = strbuf.len;
+			buf = strbuf_detach(&strbuf, NULL);
+		}
 		fwrite(buf + offset, size - offset, 1, stdout);
+	}
 	free(buf);
 	return 0;
 }
@@ -350,7 +359,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 		const char *name = objects[i].name;
 		switch (o->type) {
 		case OBJ_BLOB:
-			ret = show_object(o->sha1, 0, NULL);
+			ret = show_object(o->sha1, name, 0, NULL);
 			break;
 		case OBJ_TAG: {
 			struct tag *t = (struct tag *)o;
@@ -359,7 +368,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 					diff_get_color_opt(&rev.diffopt, DIFF_COMMIT),
 					t->tag,
 					diff_get_color_opt(&rev.diffopt, DIFF_RESET));
-			ret = show_object(o->sha1, 1, &rev);
+			ret = show_object(o->sha1, name, 1, &rev);
 			objects[i].item = (struct object *)t->tagged;
 			i--;
 			break;
diff --git a/t/t6033-merge-crlf.sh b/t/t6033-merge-crlf.sh
index f161b40..d1d1dcb 100755
--- a/t/t6033-merge-crlf.sh
+++ b/t/t6033-merge-crlf.sh
@@ -49,19 +49,19 @@ test_expect_success 'Check that conflict file is CRLF' '
 	test_cmp file file.temp
 '
 
-test_expect_failure 'Check that staged file :1: is CRLF' '
+test_expect_success 'Check that staged file :1: is CRLF' '
 	git show :1:file >staged.temp1 &&
 	git show :1:file | remove_cr | append_cr >staged.temp2 &&
 	test_cmp staged.temp1 staged.temp2
 '
 
-test_expect_failure 'Check that staged file :2: is CRLF' '
+test_expect_success 'Check that staged file :2: is CRLF' '
 	git show :2:file >staged.temp1 &&
 	git show :2:file | remove_cr | append_cr >staged.temp2 &&
 	test_cmp staged.temp1 staged.temp2
 '
 
-test_expect_failure 'Check that staged file :3: is CRLF' '
+test_expect_success 'Check that staged file :3: is CRLF' '
 	git show :3:file >staged.temp1 &&
 	git show :3:file | remove_cr | append_cr >staged.temp2 &&
 	test_cmp staged.temp1 staged.temp2
-- 
1.5.6.rc2.158.g3478
