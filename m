From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v4 2/4] transport-helper: add no-private-update capability
Date: Tue,  3 Sep 2013 17:45:14 +0200
Message-ID: <1378223114-12523-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1378107677-28741-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 03 17:46:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGsoU-0006Uy-Ja
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 17:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756625Ab3ICPqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 11:46:39 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36619 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756372Ab3ICPqi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 11:46:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r83FjEBC002493
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 3 Sep 2013 17:45:14 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VGsn6-0004lh-3X; Tue, 03 Sep 2013 17:45:16 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VGsn5-0003Gy-Pn; Tue, 03 Sep 2013 17:45:15 +0200
X-Mailer: git-send-email 1.8.4.12.g98a4f55.dirty
In-Reply-To: <1378107677-28741-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 03 Sep 2013 17:45:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r83FjEBC002493
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1378827916.85526@iadAnfKQH/3tllJFoBvE0Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233732>

Since 664059fb62 (Felipe Contreras, Apr 17 2013, transport-helper: update
remote helper namespace), a 'push' operation on a remote helper updates
the private ref by default. This is often a good thing, but it can also
be desirable to disable this update to force the next 'pull' to re-import
the pushed revisions.

Allow remote-helpers to disable the automatic update by introducing a new
capability.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---

I feel really stupid for sending so many versions now :-(. v3 was
fixing a whitespace issue, but forgot to re-apply the change I did
manually while sending v2, hence the commit message was wrong
(dont-update-private -> no-private-update).

Not terribly important, but if it's still time, this one should be
correct.

 Documentation/gitremote-helpers.txt |  5 +++++
 git-remote-testgit.sh               |  1 +
 t/t5801-remote-helpers.sh           | 11 +++++++++++
 transport-helper.c                  |  7 +++++--
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 0827f69..ee9e134 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -120,6 +120,11 @@ connecting (see the 'connect' command under COMMANDS).
 When choosing between 'push' and 'export', Git prefers 'push'.
 Other frontends may have some other order of preference.
 
+'no-private-update'::
+	When using the 'refspec' capability, git normally updates the
+	private ref on successful push. This update is disabled when
+	the remote-helper declares the capability 'no-private-update'.
+
 
 Capabilities for Fetching
 ^^^^^^^^^^^^^^^^^^^^^^^^^
diff --git a/git-remote-testgit.sh b/git-remote-testgit.sh
index 2109070..6d2f282 100755
--- a/git-remote-testgit.sh
+++ b/git-remote-testgit.sh
@@ -38,6 +38,7 @@ do
 			echo "*export-marks $gitmarks"
 		fi
 		test -n "$GIT_REMOTE_TESTGIT_SIGNED_TAGS" && echo "signed-tags"
+		test -n "$GIT_REMOTE_TESTGIT_NO_PRIVATE_UPDATE" && echo "no-private-update"
 		echo
 		;;
 	list)
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 8c4c539..613f69a 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -182,6 +182,17 @@ test_expect_success 'push update refs' '
 	)
 '
 
+test_expect_success 'push update refs disabled by no-private-update' '
+	(cd local &&
+	echo more-update >>file &&
+	git commit -a -m more-update &&
+	git rev-parse --verify testgit/origin/heads/update >expect &&
+	GIT_REMOTE_TESTGIT_NO_PRIVATE_UPDATE=t git push origin update &&
+	git rev-parse --verify testgit/origin/heads/update >actual &&
+	test_cmp expect actual
+	)
+'
+
 test_expect_success 'push update refs failure' '
 	(cd local &&
 	git checkout update &&
diff --git a/transport-helper.c b/transport-helper.c
index 63cabc3..3328394 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -27,7 +27,8 @@ struct helper_data {
 		push : 1,
 		connect : 1,
 		signed_tags : 1,
-		no_disconnect_req : 1;
+		no_disconnect_req : 1,
+		no_private_update : 1;
 	char *export_marks;
 	char *import_marks;
 	/* These go from remote name (as in "list") to private name */
@@ -205,6 +206,8 @@ static struct child_process *get_helper(struct transport *transport)
 			strbuf_addstr(&arg, "--import-marks=");
 			strbuf_addstr(&arg, capname + strlen("import-marks "));
 			data->import_marks = strbuf_detach(&arg, NULL);
+		} else if (!prefixcmp(capname, "no-private-update")) {
+			data->no_private_update = 1;
 		} else if (mandatory) {
 			die("Unknown mandatory capability %s. This remote "
 			    "helper probably needs newer version of Git.",
@@ -723,7 +726,7 @@ static void push_update_refs_status(struct helper_data *data,
 		if (push_update_ref_status(&buf, &ref, remote_refs))
 			continue;
 
-		if (!data->refspecs)
+		if (!data->refspecs || data->no_private_update)
 			continue;
 
 		/* propagate back the update to the remote namespace */
-- 
1.8.4.12.g98a4f55.dirty
