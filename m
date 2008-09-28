From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Implement run_command_to_buf (spawn a process and reads its stdout)
Date: Sun, 28 Sep 2008 04:06:55 +0200
Message-ID: <1222567618-22156-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr>
 <1222567618-22156-2-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 04:10:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjlkM-0004Jm-2M
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 04:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbYI1CJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 22:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbYI1CJl
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 22:09:41 -0400
Received: from imag.imag.fr ([129.88.30.1]:60051 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942AbYI1CJk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 22:09:40 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m8S26wtg026008
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 28 Sep 2008 04:06:58 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KjlgY-0001dc-7c; Sun, 28 Sep 2008 04:06:58 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KjlgY-00060L-52; Sun, 28 Sep 2008 04:06:58 +0200
X-Mailer: git-send-email 1.6.0.2.312.g1ef81a
In-Reply-To: <1222567618-22156-2-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 28 Sep 2008 04:06:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96933>

---
 diff.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 1c8dd19..6917981 100644
--- a/diff.c
+++ b/diff.c
@@ -260,6 +260,10 @@ static struct diff_tempfile {
 	char tmp_path[PATH_MAX];
 } diff_temp[2];
 
+/* Forward declarations */
+static int run_command_to_buf(const char **argv, char **buf, size_t * size);
+/* End forward declarations */
+
 static int count_lines(const char *data, int size)
 {
 	int count, ch, completely_empty = 1, nl_just_seen = 0;
@@ -1487,6 +1491,26 @@ void diff_set_mnemonic_prefix(struct diff_options *options, const char *a, const
 		options->b_prefix = b;
 }
 
+static int run_command_to_buf(const char **argv, char **buf, size_t * size)
+{
+	struct child_process cmd;
+	struct strbuf buffer = STRBUF_INIT;
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.argv = argv;
+	cmd.out = -1;
+
+	if (start_command(&cmd))
+		return -1;
+	strbuf_read(&buffer, cmd.out, 1024);
+	close(cmd.out);
+
+	if (finish_command(&cmd))
+		return -1;
+
+	*buf = strbuf_detach(&buffer, size);
+	return 0;
+}
+
 static void builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_filespec *one,
-- 
1.6.0.2.312.g1ef81a
