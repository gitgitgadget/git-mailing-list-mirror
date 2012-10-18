From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/6] format-patch --notes: show notes after three-dashes
Date: Wed, 17 Oct 2012 22:45:28 -0700
Message-ID: <1350539128-21577-7-git-send-email-gitster@pobox.com>
References: <1350539128-21577-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 07:46:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOivj-0005dI-2u
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 07:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201Ab2JRFpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 01:45:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60081 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754185Ab2JRFpn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 01:45:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56EE06D54
	for <git@vger.kernel.org>; Thu, 18 Oct 2012 01:45:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=sj7o
	xgvHiCvjrs8PW8ciQzA9GVI=; b=bUiIoRnLF8vJmB1c++vAObmOvDw9Cxkb2Okg
	ZhbtV+aFfGDuq0WrAbI0Yb2XtsXeXRO+pcFsCmXW5DrLzmwOK8tgrZg/MpUp1kHK
	52UXuRFJpWrEg+WoB2VhCBifRy+gVa/lv7JITIzgNdlh7Dz+ZsSvFmLptbEXQ6f2
	zeymnso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=atVWZN
	sM5Zp9dR46Mt5EsvQb8p9/xJdCsodcK4iO2Kv/Gw2pavzhgvTl/XdVV6v0nhkI1x
	8AqffUoDVgL1R6HBQuMQrQxSQxAwXbd228zSSKoOzgeHA1K9EDa+c8tjfcr6RRs5
	nVgf5i0yy0v8xkEVYdL+/uKmUHdrzpVVsYjXY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 442556D52
	for <git@vger.kernel.org>; Thu, 18 Oct 2012 01:45:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A12D56D50 for
 <git@vger.kernel.org>; Thu, 18 Oct 2012 01:45:42 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc3.112.gdb88a5e
In-Reply-To: <1350539128-21577-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0E0B4CF2-18E7-11E2-8175-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207966>

When inserting the note after the commit log message to format-patch
output, add three dashes before the note.  Record the fact that we
did so in the rev_info and omit showing duplicated three dashes in
the usual codepath that is used when notes are not being shown.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 log-tree.c              | 15 +++++++++++----
 revision.h              |  1 +
 t/t4014-format-patch.sh |  7 +++++--
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 4390b11..712a22b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -677,8 +677,13 @@ void show_log(struct rev_info *opt)
 		append_signoff(&msgbuf, opt->add_signoff);
 
 	if ((ctx.fmt != CMIT_FMT_USERFORMAT) &&
-	    ctx.notes_message && *ctx.notes_message)
+	    ctx.notes_message && *ctx.notes_message) {
+		if (ctx.fmt == CMIT_FMT_EMAIL) {
+			strbuf_addstr(&msgbuf, "---\n");
+			opt->shown_dashes = 1;
+		}
 		strbuf_addstr(&msgbuf, ctx.notes_message);
+	}
 
 	if (opt->show_log_size) {
 		printf("log size %i\n", (int)msgbuf.len);
@@ -710,6 +715,7 @@ void show_log(struct rev_info *opt)
 
 int log_tree_diff_flush(struct rev_info *opt)
 {
+	opt->shown_dashes = 0;
 	diffcore_std(&opt->diffopt);
 
 	if (diff_queue_is_empty()) {
@@ -737,10 +743,11 @@ int log_tree_diff_flush(struct rev_info *opt)
 					opt->diffopt.output_prefix_data);
 				fwrite(msg->buf, msg->len, 1, stdout);
 			}
-			if ((pch & opt->diffopt.output_format) == pch) {
-				printf("---");
+			if (!opt->shown_dashes) {
+				if ((pch & opt->diffopt.output_format) == pch)
+					printf("---");
+				putchar('\n');
 			}
-			putchar('\n');
 		}
 	}
 	diff_flush(&opt->diffopt);
diff --git a/revision.h b/revision.h
index a95bd0b..059bfff 100644
--- a/revision.h
+++ b/revision.h
@@ -111,6 +111,7 @@ struct rev_info {
 
 	/* Format info */
 	unsigned int	shown_one:1,
+			shown_dashes:1,
 			show_merge:1,
 			show_notes:1,
 			show_notes_given:1,
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index bea6381..9750ba6 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -623,9 +623,12 @@ test_expect_success 'format-patch --signoff' '
 test_expect_success 'format-patch --notes --signoff' '
 	git notes --ref test add -m "test message" HEAD &&
 	git format-patch -1 --signoff --stdout --notes=test >out &&
-	# Notes message must come after S-o-b
+	# Three dashes must come after S-o-b
 	! sed "/^Signed-off-by: /q" out | grep "test message" &&
-	sed "1,/^Signed-off-by: /d" out | grep "test message"
+	sed "1,/^Signed-off-by: /d" out | grep "test message" &&
+	# Notes message must come after three dashes
+	! sed "/^---$/q" out | grep "test message" &&
+	sed "1,/^---$/d" out | grep "test message"
 '
 
 echo "fatal: --name-only does not make sense" > expect.name-only
-- 
1.8.0.rc3.112.gdb88a5e
