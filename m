From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/9] sha1_name.c: teach find_short_object_filename() a
 commit-only option
Date: Mon, 18 Jun 2012 15:05:35 -0700
Message-ID: <1340057139-8311-7-git-send-email-gitster@pobox.com>
References: <1340057139-8311-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 00:08:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sgk7E-0004ax-JP
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 00:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495Ab2FRWID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 18:08:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57423 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751462Ab2FRWFw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 18:05:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A93BE97F4
	for <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=OMTj
	97o6MyVMdiipg31Dklm5yO8=; b=ngyCUzSU/jS3/0R2Bg+aOkJU6z3t8v0hJr0q
	dbT+nZanRJCovyTw8KPS0xUAoeY9F70s8s7552WlBt5V7/hitLoWQ7QEcFzknLeD
	gCihijYSW0+rYOYsZ+/rkdub4RNUFxuX+v08NyiQhCrL+3HCCXAb1dIwKpvlXmpo
	2EOhd3g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=QHpcIQ
	PRoJvFqGQkx2ljCp4cwKtPxGD5cWjjpYDvIikz4ud72iKVBq/vJYujTiUAqhYUQS
	Kzfz+zu+1bgSIOzw8Nr518SoI5IxF7WTukNhdhaF8oQ+VJx06MqcfXLk+crihfBf
	+tj5/PM+db0fsIBYXZwhM7JFrvAojRcraia9A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A158597F2
	for <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3090397F1 for
 <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:51 -0400 (EDT)
X-Mailer: git-send-email 1.7.11
In-Reply-To: <1340057139-8311-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C4451A26-B991-11E1-8F44-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200173>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index e03992c..a283c85 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -9,7 +9,14 @@
 
 static int get_sha1_oneline(const char *, unsigned char *, struct commit_list *);
 
-static int find_short_object_filename(int len, const char *name, unsigned char *sha1)
+static int is_commit_object(const unsigned char *sha1)
+{
+	int kind = sha1_object_info(sha1, NULL);
+	return (kind == OBJ_COMMIT);
+}
+
+static int find_short_object_filename(int len, const char *name, unsigned char *sha1,
+				      int commit_only)
 {
 	struct alternate_object_database *alt;
 	char hex[40];
@@ -47,6 +54,14 @@ static int find_short_object_filename(int len, const char *name, unsigned char *
 				continue;
 			if (memcmp(de->d_name, name + 2, len - 2))
 				continue;
+			if (commit_only) {
+				char found_name[40];
+				unsigned char found_bin[20];
+				sprintf(found_name, "%.2s%s", name, de->d_name);
+				if (get_sha1_hex(found_name, found_bin) ||
+				    !is_commit_object(found_bin))
+					continue; /* not a commit object name */
+			}
 			if (!found) {
 				memcpy(hex + 2, de->d_name, 38);
 				found++;
@@ -156,7 +171,7 @@ static int find_unique_short_object(int len, char *canonical,
 	unsigned char unpacked_sha1[20], packed_sha1[20];
 
 	prepare_alt_odb();
-	has_unpacked = find_short_object_filename(len, canonical, unpacked_sha1);
+	has_unpacked = find_short_object_filename(len, canonical, unpacked_sha1, 0);
 	has_packed = find_short_packed_object(len, res, packed_sha1);
 	if (!has_unpacked && !has_packed)
 		return SHORT_NAME_NOT_FOUND;
-- 
1.7.11
