From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/6] format-patch: append --signature after notes
Date: Wed, 17 Oct 2012 22:45:27 -0700
Message-ID: <1350539128-21577-6-git-send-email-gitster@pobox.com>
References: <1350539128-21577-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 07:46:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOivi-0005dI-KB
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 07:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197Ab2JRFpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 01:45:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60038 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754185Ab2JRFpl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 01:45:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47F6E6D4D
	for <git@vger.kernel.org>; Thu, 18 Oct 2012 01:45:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=nnh2
	tJmG4Eg2/zhMTy/Txy6rIcs=; b=R9ZtfayTmsH8sRs/NIRHXiJJ06HEOA4PJnrF
	HkLWG3PbDbc8Jn4HUXH3cMG1jpGkrEvONAzJ0Kx0E5tjqcaO7HkgyK7jamnYYKiE
	VU6OqZ+X48ArgeFzcoGs4F1nJ4Sfn9pyAgJOFO+HBtUu8lWl+wwWb+/hTF/RJxTd
	AJbWZ8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=NUBo0f
	zfmIaWzRzRfpAeUZUSHRnTVzmWlSCNtcNX+a7L23b/Fz4cK7tjXBvEI2KamFX3Jd
	j/5DqU3XQNqUX7T9LejKyNhkh+r3FDCZ5yJD6qxM+//RZR2Kf0SEXDJ/m62IGwgm
	s6BfNY/uTtShYiJo+HIxPhvYi70yblLzY0UBg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 363A76D4B
	for <git@vger.kernel.org>; Thu, 18 Oct 2012 01:45:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD33C6D48 for
 <git@vger.kernel.org>; Thu, 18 Oct 2012 01:45:40 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc3.112.gdb88a5e
In-Reply-To: <1350539128-21577-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0CE1897C-18E7-11E2-AA40-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207967>

When appending a new signature with "format-patch --signature", if
the "--notes" option is also in effect, the location of the new
signature (and if the signature should be added in the first place)
should be decided using the contents of the original commit log
message, before the message from the notes is added.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 log-tree.c              |  6 ++++--
 t/t4014-format-patch.sh | 12 ++++++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index e7e08f4..4390b11 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -672,12 +672,14 @@ void show_log(struct rev_info *opt)
 	ctx.reflog_info = opt->reflog_info;
 	ctx.fmt = opt->commit_format;
 	pretty_print_commit(&ctx, commit, &msgbuf);
+
+	if (opt->add_signoff)
+		append_signoff(&msgbuf, opt->add_signoff);
+
 	if ((ctx.fmt != CMIT_FMT_USERFORMAT) &&
 	    ctx.notes_message && *ctx.notes_message)
 		strbuf_addstr(&msgbuf, ctx.notes_message);
 
-	if (opt->add_signoff)
-		append_signoff(&msgbuf, opt->add_signoff);
 	if (opt->show_log_size) {
 		printf("log size %i\n", (int)msgbuf.len);
 		graph_show_oneline(opt->graph);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 959aa26..bea6381 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -616,8 +616,16 @@ test_expect_success 'format-patch --in-reply-to' '
 '
 
 test_expect_success 'format-patch --signoff' '
-	git format-patch -1 --signoff --stdout |
-	grep "^Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
+	git format-patch -1 --signoff --stdout >out &&
+	grep "^Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" out
+'
+
+test_expect_success 'format-patch --notes --signoff' '
+	git notes --ref test add -m "test message" HEAD &&
+	git format-patch -1 --signoff --stdout --notes=test >out &&
+	# Notes message must come after S-o-b
+	! sed "/^Signed-off-by: /q" out | grep "test message" &&
+	sed "1,/^Signed-off-by: /d" out | grep "test message"
 '
 
 echo "fatal: --name-only does not make sense" > expect.name-only
-- 
1.8.0.rc3.112.gdb88a5e
