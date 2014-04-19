From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] transport-helper: fix sync issue on crashes
Date: Sat, 19 Apr 2014 00:00:43 -0700
Message-ID: <1397890843-27035-6-git-send-email-gitster@pobox.com>
References: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
 <1397890843-27035-1-git-send-email-gitster@pobox.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 08:59:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbPFO-0007Nz-NF
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 08:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbaDSG73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 02:59:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46667 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191AbaDSG7X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2014 02:59:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26F6D6E617;
	Sat, 19 Apr 2014 02:59:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=QDm9
	YWJtKweAoarHyx6toFV9srk=; b=c4nTnlytW4+hG43liNVZzxrenatHdsFbKnAt
	nu9eDMnn/UI79qJWeN+CfuHFeB14GRIm8NNP5vd6dmE45TTbpnLW8QLGtchuXfA+
	/4i76KPf9NySTw7aFjShLRHFq++Anw9/EytRt9dEYBZXhlg2FykaXvURGt5IQ8qy
	WtS3dxo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	O3P/AoZWIjtx8IP4E5j9padl36S1Y5OT79U6JuvPPLBdJsyt/tjYbB60Uec3hX3y
	WpoSIrNyzyAUfYN9d+Ld5/D0U9+D3UMfblgtPVqkFbG6poZ6vGAdu46qzFWx+ixz
	2/M1F1kGCkAZVWoz0ZR6wNKpGL/pvlOaomBWGGKuvnY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D45F6E616;
	Sat, 19 Apr 2014 02:59:23 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0EE5B6E615;
	Sat, 19 Apr 2014 02:59:20 -0400 (EDT)
X-Mailer: git-send-email 1.9.2-459-g68773ac
In-Reply-To: <1397890843-27035-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 21FFF6D2-C790-11E3-88D8-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246506>

From: Felipe Contreras <felipe.contreras@gmail.com>

When a remote helper crashes while pushing we should revert back to the
state before the push, however, it's possible that `git fast-export`
already finished its job, and therefore has exported the marks already.

This creates a synchronization problem because from that moment on
`git fast-{import,export}` will have marks that the remote helper is not
aware of and all further commands fail (if those marks are referenced).

The fix is to tell `git fast-export` to export to a temporary file, and
only after the remote helper has finishes successfully, move to the
final destination.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5801-remote-helpers.sh | 20 +++++++++++++++++++-
 transport-helper.c        | 13 +++++++++++--
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 25fd2e7..aa3e223 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -220,6 +220,20 @@ test_expect_success 'push update refs failure' '
 	)
 '
 
+clean_mark () {
+	cut -f 2 -d ' ' "$1" |
+	git cat-file --batch-check |
+	grep commit |
+	sort >$(basename "$1")
+}
+
+cmp_marks () {
+	test_when_finished "rm -rf git.marks testgit.marks" &&
+	clean_mark ".git/testgit/$1/git.marks" &&
+	clean_mark ".git/testgit/$1/testgit.marks" &&
+	test_cmp git.marks testgit.marks
+}
+
 test_expect_success 'proper failure checks for fetching' '
 	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
 	export GIT_REMOTE_TESTGIT_FAILURE &&
@@ -232,7 +246,11 @@ test_expect_success 'proper failure checks for fetching' '
 
 test_expect_success 'proper failure checks for pushing' '
 	(cd local &&
-	test_must_fail env GIT_REMOTE_TESTGIT_FAILURE=1 git push --all
+	git checkout -b crash master &&
+	echo crash >>file &&
+	git commit -a -m crash &&
+	test_must_fail env GIT_REMOTE_TESTGIT_FAILURE=1 git push --all &&
+	cmp_marks origin
 	)
 '
 
diff --git a/transport-helper.c b/transport-helper.c
index c890db6..b468e4f 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -435,7 +435,7 @@ static int get_exporter(struct transport *transport,
 	fastexport->argv[argc++] = data->signed_tags ?
 		"--signed-tags=verbatim" : "--signed-tags=warn-strip";
 	if (data->export_marks) {
-		strbuf_addf(&tmp, "--export-marks=%s", data->export_marks);
+		strbuf_addf(&tmp, "--export-marks=%s.tmp", data->export_marks);
 		fastexport->argv[argc++] = strbuf_detach(&tmp, NULL);
 	}
 	if (data->import_marks) {
@@ -911,7 +911,16 @@ static int push_refs_with_export(struct transport *transport,
 
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
-	return push_update_refs_status(data, remote_refs, flags);
+	if (push_update_refs_status(data, remote_refs, flags))
+		return 1;
+
+	if (data->export_marks) {
+		strbuf_addf(&buf, "%s.tmp", data->export_marks);
+		rename(buf.buf, data->export_marks);
+		strbuf_release(&buf);
+	}
+
+	return 0;
 }
 
 static int push_refs(struct transport *transport,
-- 
1.9.2-459-g68773ac
