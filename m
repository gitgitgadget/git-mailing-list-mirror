From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/6 (v2)] get_remote_heads(): refactor code to read "server
 capabilities"
Date: Mon,  1 Dec 2008 06:12:50 -0800
Message-ID: <1228140775-29212-2-git-send-email-gitster@pobox.com>
References: <1228140775-29212-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 15:14:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L79Xq-0007ng-Nk
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 15:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbYLAONN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 09:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752381AbYLAONM
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 09:13:12 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44538 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbYLAONL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 09:13:11 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 08EA88318C
	for <git@vger.kernel.org>; Mon,  1 Dec 2008 09:13:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 52E828318A for
 <git@vger.kernel.org>; Mon,  1 Dec 2008 09:13:06 -0500 (EST)
X-Mailer: git-send-email 1.6.1.rc1.23.g38649f
In-Reply-To: <1228140775-29212-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2F56435E-BFB2-11DD-B845-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102041>

This just moves the code to read the server capability list that is hidden
after "40-byte hex object name, SP, refname, NUL" on the information the
uploading end initially sends.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 connect.c |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/connect.c b/connect.c
index 584e04c..932c503 100644
--- a/connect.c
+++ b/connect.c
@@ -49,6 +49,21 @@ static void add_extra_have(struct extra_have_objects *extra, unsigned char *sha1
 }
 
 /*
+ * "line" points at the byte just after "40-byte hex, SP, refname,
+ * NUL".  "len" is the remaining number of bytes.  The caller knows
+ * that the original packet contains more information than that.
+ */
+static void read_extra_info(char *line, int len)
+{
+	/*
+	 * The first such "extra" piece of information is the list of
+	 * server capabilities.
+	 */
+	free(server_capabilities);
+	server_capabilities = xstrdup(line);
+}
+
+/*
  * Read all the refs from the other end
  */
 struct ref **get_remote_heads(int in, struct ref **list,
@@ -78,10 +93,8 @@ struct ref **get_remote_heads(int in, struct ref **list,
 		name = buffer + 41;
 
 		name_len = strlen(name);
-		if (len != name_len + 41) {
-			free(server_capabilities);
-			server_capabilities = xstrdup(name + name_len + 1);
-		}
+		if (len != name_len + 41)
+			read_extra_info(name + name_len + 1, len - (name_len + 41));
 
 		if (extra_have &&
 		    name_len == 5 && !memcmp(".have", name, 5)) {
-- 
1.6.0.4.864.g0f47a
