From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] commit: search author pattern against mailmap
Date: Sat, 24 Aug 2013 16:07:47 +0200
Message-ID: <1377353267-3886-1-git-send-email-apelisse@gmail.com>
References: <xmqqsiy0nnlr.fsf@gitster.dls.corp.google.com>
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 24 16:08:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDEW0-00028O-Vr
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 16:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754294Ab3HXOI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 10:08:28 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:56575 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162Ab3HXOI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 10:08:27 -0400
Received: by mail-wi0-f173.google.com with SMTP id ey16so1679023wid.6
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 07:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b1udd1pHSaeEPx/+tr7X0sQ+eaoNH9LALqrkV0B6Ol0=;
        b=Jq9rHD4PqBkc6fxg3bxe2kKDSsBZBAWMv7kIEokQTYdNbagt+dh3jAQ9tHJQALrT8w
         C8SbDOtN+iwoTVxzfFKaPj1E36Rhu0YThZIDP9Y8idBnAInCTckov4Xom2YQXxZ0TwVc
         ybWAQGRPYt6Nwcq20oTRd/tLVg4qe1ejPYm46Z4qVzFPMRClvOYdW+KG3n5M5rlGs6M7
         SlhFAodwTCIwjXnLZgWdU+e7KPvcFhz45JQdwD8NJE5gBcsUpVtlKIVTzoePZYXpnXsu
         NcJ0tLPIx997y/3sgE+moGZ9csxxckwnsMd6HTDKJkI8E3ZIHUJbN4m0RGYDrRpf+Nvy
         o54Q==
X-Received: by 10.194.95.10 with SMTP id dg10mr17926wjb.36.1377353304428;
        Sat, 24 Aug 2013 07:08:24 -0700 (PDT)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPSA id jf2sm4377611wic.2.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 07:08:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.2.g8483dfa
In-Reply-To: <xmqqsiy0nnlr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232884>

"git commit --author=$name" sets the author to one whose name
matches the given string from existing commits, when $name is not in
the "Name <e-mail>" format. However, it does not honor the mailmap
to use the canonical name for the author found this way.

Fix it by telling the logic to find a matching existing author to
honor the mailmap, and use the name and email after applying the
mailmap.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 builtin/commit.c   |  7 ++++++-
 t/t4203-mailmap.sh | 11 +++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 10acc53..21e0f95 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -30,6 +30,7 @@
 #include "column.h"
 #include "sequencer.h"
 #include "notes-utils.h"
+#include "mailmap.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [options] [--] <pathspec>..."),
@@ -935,6 +936,7 @@ static const char *find_author_by_nickname(const char *name)
 	struct rev_info revs;
 	struct commit *commit;
 	struct strbuf buf = STRBUF_INIT;
+	struct string_list mailmap = STRING_LIST_INIT_NODUP;
 	const char *av[20];
 	int ac = 0;
 
@@ -945,13 +947,16 @@ static const char *find_author_by_nickname(const char *name)
 	av[++ac] = buf.buf;
 	av[++ac] = NULL;
 	setup_revisions(ac, av, &revs, NULL);
+	revs.mailmap = &mailmap;
+	read_mailmap(revs.mailmap, NULL);
+
 	prepare_revision_walk(&revs);
 	commit = get_revision(&revs);
 	if (commit) {
 		struct pretty_print_context ctx = {0};
 		ctx.date_mode = DATE_NORMAL;
 		strbuf_release(&buf);
-		format_commit_message(commit, "%an <%ae>", &buf, &ctx);
+		format_commit_message(commit, "%aN <%aE>", &buf, &ctx);
 		return strbuf_detach(&buf, NULL);
 	}
 	die(_("No existing author found with '%s'"), name);
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index baa4685..4d715f0 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -470,4 +470,15 @@ test_expect_success 'Blame output (complex mapping)' '
 	test_cmp expect actual.fuzz
 '
 
+cat >expect <<\EOF
+Some Dude <some@dude.xx>
+EOF
+
+test_expect_success 'commit --author honors mailmap' '
+	test_must_fail git commit --author "nick" --allow-empty -meight &&
+	git commit --author "Some Dude" --allow-empty -meight &&
+	git show --pretty=format:"%an <%ae>%n" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.4.rc4.2.g8483dfa
