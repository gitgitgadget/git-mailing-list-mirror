From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 10/16] vcs-svn: read instructions from deltas
Date: Sat, 19 Mar 2011 18:20:48 +1100
Message-ID: <1300519254-20201-11-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:21:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0qTz-0007ZM-4W
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755480Ab1CSHVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:21:47 -0400
Received: from [119.15.97.146] ([119.15.97.146]:63092 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754060Ab1CSHV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:21:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 59C83C04F;
	Sat, 19 Mar 2011 18:17:53 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WSSxTbmU6GUW; Sat, 19 Mar 2011 18:17:47 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 32456C056;
	Sat, 19 Mar 2011 18:17:43 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169402>

From: Jonathan Nieder <jrnieder@gmail.com>

Buffer the instruction section upon encountering it for later
interpretation.

An alternative design would involve parsing the instructions
at this point and buffering them in some processed form.  Using
the unprocessed form is simpler.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 t/t9011-svn-da.sh |    5 +++++
 vcs-svn/svndiff.c |    6 +++++-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/t/t9011-svn-da.sh b/t/t9011-svn-da.sh
index 4919fae..e909d92 100755
--- a/t/t9011-svn-da.sh
+++ b/t/t9011-svn-da.sh
@@ -135,4 +135,9 @@ test_expect_success 'reject truncated inline data' '
 	test_must_fail test-svn-fe -d preimage inline.trunc 10
 '
 
+test_expect_success 'reject truncated inline data (after instruction section)' '
+	printf "SVNQ%b%b%s" "QQ\001\001\003" "\0201" "b" | q_to_nul >insn.trunc &&
+	test_must_fail test-svn-fe -d preimage insn.trunc 11
+'
+
 test_done
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index 74e0401..a2dd9b6 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -25,13 +25,15 @@
 #define VLI_BITS_PER_DIGIT 7
 
 struct window {
+	struct strbuf instructions;
 	struct strbuf data;
 };
 
-#define WINDOW_INIT	{ STRBUF_INIT }
+#define WINDOW_INIT	{ STRBUF_INIT, STRBUF_INIT }
 
 static void window_release(struct window *ctx)
 {
+	strbuf_release(&ctx->instructions);
 	strbuf_release(&ctx->data);
 }
 
@@ -126,6 +128,8 @@ static int apply_one_window(struct line_buffer *delta, off_t *delta_len)
 	    read_length(delta, &instructions_len, delta_len) ||
 	    read_length(delta, &data_len, delta_len))
 		goto error_out;
+	if (read_chunk(delta, delta_len, &ctx.instructions, instructions_len))
+		goto error_out;
 	if (instructions_len) {
 		error("What do you think I am?  A delta applier?");
 		goto error_out;
-- 
1.7.3.2.846.gf4b062
