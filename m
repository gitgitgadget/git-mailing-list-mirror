From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/6 (v2)] connect.c::read_extra_info(): find where HEAD
 points at
Date: Mon,  1 Dec 2008 06:12:52 -0800
Message-ID: <1228140775-29212-4-git-send-email-gitster@pobox.com>
References: <1228140775-29212-1-git-send-email-gitster@pobox.com>
 <1228140775-29212-2-git-send-email-gitster@pobox.com>
 <1228140775-29212-3-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 15:14:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L79Y4-0007sQ-HJ
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 15:14:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbYLAON3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 09:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752570AbYLAON3
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 09:13:29 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44598 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbYLAON2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 09:13:28 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4D4A083191
	for <git@vger.kernel.org>; Mon,  1 Dec 2008 09:13:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 76DC883190 for
 <git@vger.kernel.org>; Mon,  1 Dec 2008 09:13:20 -0500 (EST)
X-Mailer: git-send-email 1.6.1.rc1.23.g38649f
In-Reply-To: <1228140775-29212-3-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 39A2ECA4-BFB2-11DD-81C6-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102042>

This actually implements the protocol extension to receive the HEAD symref
information that is hidden after the server capabilities list.  Nobody
uses the information yet, though.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 connect.c |   27 +++++++++++++++++++++++++--
 1 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index 114d691..aa4757a 100644
--- a/connect.c
+++ b/connect.c
@@ -53,7 +53,7 @@ static void add_extra_have(struct extra_have_objects *extra, unsigned char *sha1
  * NUL".  "len" is the remaining number of bytes.  The caller knows
  * that the original packet contains more information than that.
  */
-static void read_extra_info(char *line, int len)
+static void read_extra_info(char *line, int len, char **hpa)
 {
 	/*
 	 * The first such "extra" piece of information is the list of
@@ -64,6 +64,20 @@ static void read_extra_info(char *line, int len)
 	free(server_capabilities);
 	server_capabilities = xmalloc(infolen);
 	memcpy(server_capabilities, line, infolen);
+	if (infolen == len)
+		return;
+	/*
+	 * The uploader can optionally tell us where the HEAD pointer
+	 * points at after that.
+	 */
+	line += infolen;
+	len -= infolen;
+
+	infolen = strlen(line) + 1;
+
+	free(*hpa);
+	*hpa = xmalloc(infolen);
+	memcpy(*hpa, line, infolen);
 }
 
 /*
@@ -74,6 +88,9 @@ struct ref **get_remote_heads(int in, struct ref **list,
 			      unsigned int flags,
 			      struct extra_have_objects *extra_have)
 {
+	struct ref **ref_list = list;
+	char *head_points_at = NULL;
+
 	*list = NULL;
 	for (;;) {
 		struct ref *ref;
@@ -97,7 +114,8 @@ struct ref **get_remote_heads(int in, struct ref **list,
 
 		name_len = strlen(name);
 		if (len != name_len + 41)
-			read_extra_info(name + name_len + 1, len - (name_len + 41));
+			read_extra_info(name + name_len + 1, len - (name_len + 41),
+					&head_points_at);
 
 		if (extra_have &&
 		    name_len == 5 && !memcmp(".have", name, 5)) {
@@ -114,6 +132,11 @@ struct ref **get_remote_heads(int in, struct ref **list,
 		*list = ref;
 		list = &ref->next;
 	}
+	if (head_points_at) {
+		struct ref *head = find_ref_by_name(*ref_list, "HEAD");
+		if (head)
+			head->symref = head_points_at;
+	}
 	return list;
 }
 
-- 
1.6.0.4.864.g0f47a
