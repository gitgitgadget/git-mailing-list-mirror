From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/3] transport-helper: pass --signed-tags=warn-strip to fast-export
Date: Sun, 14 Apr 2013 11:57:07 +0100
Message-ID: <1d7cbf61d07f1f0490806f7516c622087ebed05d.1365936811.git.john@keeping.me.uk>
References: <CAGdFq_g+kk-Fy1fcV6D5x4kroRXX63T8wjKNUqqfu39wUkSO6A@mail.gmail.com>
 <cover.1365936811.git.john@keeping.me.uk>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 14 12:57:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URKd2-0002sq-TL
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 12:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845Ab3DNK5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 06:57:44 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:48263 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab3DNK5n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 06:57:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 92A686064DD;
	Sun, 14 Apr 2013 11:57:43 +0100 (BST)
X-Quarantine-ID: <OupbVZ8AU9B8>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OupbVZ8AU9B8; Sun, 14 Apr 2013 11:57:43 +0100 (BST)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 0D5936064C8;
	Sun, 14 Apr 2013 11:57:34 +0100 (BST)
X-Mailer: git-send-email 1.8.2.694.ga76e9c3.dirty
In-Reply-To: <cover.1365936811.git.john@keeping.me.uk>
In-Reply-To: <cover.1365936811.git.john@keeping.me.uk>
References: <cover.1365936811.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221094>

Currently, attempting to push a signed tag to a remote helper which uses
fast-export results in the remote helper failing because the default
fast-export action for signed tags is "abort".  This is not helpful for
users because there is no way to pass additional arguments to
fast-export here, either from the remote helper or from the command
line.

In general, the signature will be invalidated by whatever transformation
a remote helper performs on a tag to push it to a repository in a
different format so the correct behaviour is to strip the tag.  Doing
this silently may surprise people, so use "warn-strip" to issue a
warning when a signed tag is encountered.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/t5801-remote-helpers.sh | 10 ++++++++++
 transport-helper.c        |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index f387027..9b287db 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -6,6 +6,7 @@
 test_description='Test remote-helper import and export commands'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-gpg.sh
 
 if ! type "${BASH-bash}" >/dev/null 2>&1; then
 	skip_all='skipping remote-testgit tests, bash not available'
@@ -166,4 +167,13 @@ test_expect_success 'push ref with existing object' '
 	compare_refs local dup server dup
 '
 
+test_expect_success GPG 'push signed tag' '
+	(cd local &&
+	git checkout master &&
+	git tag -s -m signed-tag signed-tag &&
+	git push origin signed-tag
+	) &&
+	compare_refs local signed-tag^{} server signed-tag^{}
+'
+
 test_done
diff --git a/transport-helper.c b/transport-helper.c
index dcd8d97..3ce8259 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -410,9 +410,10 @@ static int get_exporter(struct transport *transport,
 	/* we need to duplicate helper->in because we want to use it after
 	 * fastexport is done with it. */
 	fastexport->out = dup(helper->in);
-	fastexport->argv = xcalloc(5 + revlist_args->nr, sizeof(*fastexport->argv));
+	fastexport->argv = xcalloc(6 + revlist_args->nr, sizeof(*fastexport->argv));
 	fastexport->argv[argc++] = "fast-export";
 	fastexport->argv[argc++] = "--use-done-feature";
+	fastexport->argv[argc++] = "--signed-tags=warn-strip";
 	if (data->export_marks)
 		fastexport->argv[argc++] = data->export_marks;
 	if (data->import_marks)
-- 
1.8.2.694.ga76e9c3.dirty
