From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/4] transport-helper: add dont-update-private capability
Date: Thu, 29 Aug 2013 20:58:22 +0200
Message-ID: <1377802704-30881-2-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqsixvfvdk.fsf@anie.imag.fr>
 <1377802704-30881-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 29 20:59:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF7R9-0007GY-Se
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756176Ab3H2S7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:59:15 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57197 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756041Ab3H2S7O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:59:14 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7TIwVis019027
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Aug 2013 20:58:31 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VF7QP-00039R-Sl; Thu, 29 Aug 2013 20:58:33 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VF7QP-000836-Iu; Thu, 29 Aug 2013 20:58:33 +0200
X-Mailer: git-send-email 1.8.4.12.g98a4f55.dirty
In-Reply-To: <1377802704-30881-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 29 Aug 2013 20:58:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7TIwVis019027
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1378407512.68499@wPheHdXgJeFvrbRoArHFzA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233338>

Since 664059fb62 (Felipe Contreras, Apr 17 2013, transport-helper: update
remote helper namespace), a 'push' operation on a remote helper updates
the private ref by default. This is often a good thing, but it can also
be desirable to disable this update to force the next 'pull' to re-import
the pushed revisions.

Allow remote-helpers to disable the automatic update by introducing a new
capability.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Essentially the same as the patch I sent earlier, with doc and test.

 Documentation/gitremote-helpers.txt |  6 ++++++
 git-remote-testgit.sh               |  1 +
 t/t5801-remote-helpers.sh           | 11 +++++++++++
 transport-helper.c                  |  7 +++++--
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 0827f69..3085823 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -120,6 +120,12 @@ connecting (see the 'connect' command under COMMANDS).
 When choosing between 'push' and 'export', Git prefers 'push'.
 Other frontends may have some other order of preference.
 
+'dont-update-private'::
+	When using the 'refspec' capability, git normally updates the
+	private ref on successful push. This update is disabled when
+	the remote-helper declares the capability
+	'dont-update-private'.
+
 
 Capabilities for Fetching
 ^^^^^^^^^^^^^^^^^^^^^^^^^
diff --git a/git-remote-testgit.sh b/git-remote-testgit.sh
index 2109070..a81aee8 100755
--- a/git-remote-testgit.sh
+++ b/git-remote-testgit.sh
@@ -38,6 +38,7 @@ do
 			echo "*export-marks $gitmarks"
 		fi
 		test -n "$GIT_REMOTE_TESTGIT_SIGNED_TAGS" && echo "signed-tags"
+		test -n "$GIT_REMOTE_TESTGIT_DONT_UPDATE_PRIVATE" && echo "dont-update-private"
 		echo
 		;;
 	list)
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 8c4c539..171cae3 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -182,6 +182,17 @@ test_expect_success 'push update refs' '
 	)
 '
 
+test_expect_success 'push update refs disabled by dont-update-private' '
+	(cd local &&
+	echo more-update >>file &&
+	git commit -a -m more-update &&
+	git rev-parse --verify testgit/origin/heads/update >expect &&
+	GIT_REMOTE_TESTGIT_DONT_UPDATE_PRIVATE=t git push origin update &&
+	git rev-parse --verify testgit/origin/heads/update >actual &&
+	test_cmp expect actual
+	)
+'
+
 test_expect_success 'push update refs failure' '
 	(cd local &&
 	git checkout update &&
diff --git a/transport-helper.c b/transport-helper.c
index 63cabc3..639b0e3 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -27,7 +27,8 @@ struct helper_data {
 		push : 1,
 		connect : 1,
 		signed_tags : 1,
-		no_disconnect_req : 1;
+		no_disconnect_req : 1,
+		dont_update_private : 1;
 	char *export_marks;
 	char *import_marks;
 	/* These go from remote name (as in "list") to private name */
@@ -205,6 +206,8 @@ static struct child_process *get_helper(struct transport *transport)
 			strbuf_addstr(&arg, "--import-marks=");
 			strbuf_addstr(&arg, capname + strlen("import-marks "));
 			data->import_marks = strbuf_detach(&arg, NULL);
+		} else if (!prefixcmp(capname, "dont-update-private")) {
+			data->dont_update_private = 1;
 		} else if (mandatory) {
 			die("Unknown mandatory capability %s. This remote "
 			    "helper probably needs newer version of Git.",
@@ -723,7 +726,7 @@ static void push_update_refs_status(struct helper_data *data,
 		if (push_update_ref_status(&buf, &ref, remote_refs))
 			continue;
 
-		if (!data->refspecs)
+		if (!data->refspecs || data->dont_update_private)
 			continue;
 
 		/* propagate back the update to the remote namespace */
-- 
1.8.4.12.g98a4f55.dirty
