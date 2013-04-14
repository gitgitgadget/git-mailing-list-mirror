From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 3/3] transport-helper: add 'signed-tags' capability
Date: Sun, 14 Apr 2013 11:57:08 +0100
Message-ID: <5a121757b7fb1142e5b0a42a19c45e0431deda3b.1365936811.git.john@keeping.me.uk>
References: <CAGdFq_g+kk-Fy1fcV6D5x4kroRXX63T8wjKNUqqfu39wUkSO6A@mail.gmail.com>
 <cover.1365936811.git.john@keeping.me.uk>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 14 12:57:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URKdB-00034M-N6
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 12:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870Ab3DNK5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 06:57:53 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:48315 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab3DNK5w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 06:57:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 993E360650A;
	Sun, 14 Apr 2013 11:57:52 +0100 (BST)
X-Quarantine-ID: <vgJ0KUQE5X5L>
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
	with ESMTP id vgJ0KUQE5X5L; Sun, 14 Apr 2013 11:57:52 +0100 (BST)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id D166A6064E1;
	Sun, 14 Apr 2013 11:57:43 +0100 (BST)
X-Mailer: git-send-email 1.8.2.694.ga76e9c3.dirty
In-Reply-To: <cover.1365936811.git.john@keeping.me.uk>
In-Reply-To: <cover.1365936811.git.john@keeping.me.uk>
References: <cover.1365936811.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221095>

This allows a remote helper using the 'export' protocol to specify that
it supports signed tags, changing the handing from 'warn-strip' to
'verbatim'.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/gitremote-helpers.txt |  4 ++++
 git-remote-testgit                  |  1 +
 t/t5801-remote-helpers.sh           | 12 +++++++++++-
 transport-helper.c                  |  6 +++++-
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index f506031..da74641 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -202,6 +202,10 @@ capability then it should advertise `refspec *:*`.
 	marks specified in <file> before processing any input. For details,
 	read up on '--import-marks=<file>' in linkgit:git-fast-export[1].
 
+'signed-tags'::
+	This modifies the 'export' capability, instructing Git to pass
+	'--signed-tags=verbatim' to linkgit:git-fast-export[1].  In the
+	absence of this capability, Git will use '--signed-tags=warn-strip'.
 
 
 
diff --git a/git-remote-testgit b/git-remote-testgit
index b395c8d..e7ed3a3 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -38,6 +38,7 @@ do
 			echo "*import-marks $gitmarks"
 			echo "*export-marks $gitmarks"
 		fi
+		test -n "$GIT_REMOTE_TESTGIT_SIGNED_TAGS" && echo "signed-tags"
 		echo
 		;;
 	list)
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 9b287db..69212cd 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -173,7 +173,17 @@ test_expect_success GPG 'push signed tag' '
 	git tag -s -m signed-tag signed-tag &&
 	git push origin signed-tag
 	) &&
-	compare_refs local signed-tag^{} server signed-tag^{}
+	compare_refs local signed-tag^{} server signed-tag^{} &&
+	test_must_fail compare_refs local signed-tag server signed-tag
+'
+
+test_expect_success GPG 'push signed tag with signed-tags capability' '
+	(cd local &&
+	git checkout master &&
+	git tag -s -m signed-tag signed-tag-2 &&
+	GIT_REMOTE_TESTGIT_SIGNED_TAGS=1 git push origin signed-tag-2
+	) &&
+	compare_refs local signed-tag-2 server signed-tag-2
 '
 
 test_done
diff --git a/transport-helper.c b/transport-helper.c
index 3ce8259..5f8d075 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -25,6 +25,7 @@ struct helper_data {
 		option : 1,
 		push : 1,
 		connect : 1,
+		signed_tags : 1,
 		no_disconnect_req : 1;
 	char *export_marks;
 	char *import_marks;
@@ -191,6 +192,8 @@ static struct child_process *get_helper(struct transport *transport)
 			refspecs[refspec_nr++] = xstrdup(capname + strlen("refspec "));
 		} else if (!strcmp(capname, "connect")) {
 			data->connect = 1;
+		} else if (!strcmp(capname, "signed-tags")) {
+			data->signed_tags = 1;
 		} else if (!prefixcmp(capname, "export-marks ")) {
 			struct strbuf arg = STRBUF_INIT;
 			strbuf_addstr(&arg, "--export-marks=");
@@ -413,7 +416,8 @@ static int get_exporter(struct transport *transport,
 	fastexport->argv = xcalloc(6 + revlist_args->nr, sizeof(*fastexport->argv));
 	fastexport->argv[argc++] = "fast-export";
 	fastexport->argv[argc++] = "--use-done-feature";
-	fastexport->argv[argc++] = "--signed-tags=warn-strip";
+	fastexport->argv[argc++] = data->signed_tags ?
+		"--signed-tags=verbatim" : "--signed-tags=warn-strip";
 	if (data->export_marks)
 		fastexport->argv[argc++] = data->export_marks;
 	if (data->import_marks)
-- 
1.8.2.694.ga76e9c3.dirty
