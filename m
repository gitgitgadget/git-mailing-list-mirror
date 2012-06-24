From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 8/9] sha1_name.c: teach get_short_sha1() a commit-only
 option
Date: Sat, 23 Jun 2012 17:11:30 -0700
Message-ID: <1340496691-12258-9-git-send-email-gitster@pobox.com>
References: <1340496691-12258-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 24 02:12:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiaRV-0001fP-VR
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 02:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756759Ab2FXAMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jun 2012 20:12:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43865 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756639Ab2FXALt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2012 20:11:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E06558F3A
	for <git@vger.kernel.org>; Sat, 23 Jun 2012 20:11:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=3/5+
	Ak2kBsTKgpnhLPOewTBEihE=; b=i3dAFlK5ElkjY8vic2DDufHUvZLyROPtlDS0
	y1dHGCnNTqeeBJ85KUc3QNeZkc0iNPE+J58LRAH//o0NFvYg/V6i3g7tTXha3x70
	775iOZDYMVsT8//LyiD0WhRI441D1cvjdpfW/vY89sd3y/NKQ17r4hdPjmwf5E+9
	ucZCqHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=IndeeC
	ylDPf4gjguLqIijja/mkIeiwVjDEN8te8W8zoGoWMZvOHbQuW709nyJnztrXvy5l
	tbxdIvBmxQQIm8SMmOEsfI/mOZV8WxIorLe7GJe8GbYMW7eMbhi0RDXWo6MRYREj
	zrj6mb1H/hzAv2UgyfvCV1/u9smuZFs7A1V3k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D86DF8F39
	for <git@vger.kernel.org>; Sat, 23 Jun 2012 20:11:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 713F78F38 for
 <git@vger.kernel.org>; Sat, 23 Jun 2012 20:11:48 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.29.gf71be5c
In-Reply-To: <1340496691-12258-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 30D100EE-BD91-11E1-8F0C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200514>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sha1_name.c b/sha1_name.c
index 7cca7d9..58dbbe2 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -219,6 +219,13 @@ static int finish_object_disambiguation(struct disambiguate_state *ds,
 }
 
 #define GET_SHORT_QUIETLY 01
+#define GET_SHORT_COMMIT_ONLY 02
+
+static int disambiguate_commit_only(const unsigned char *sha1, void *cb_data_unused)
+{
+	int kind = sha1_object_info(sha1, NULL);
+	return kind == OBJ_COMMIT;
+}
 
 static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 			  unsigned flags)
@@ -255,6 +262,9 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 	prepare_alt_odb();
 
 	memset(&ds, 0, sizeof(ds));
+	if (flags & GET_SHORT_COMMIT_ONLY)
+		ds.fn = disambiguate_commit_only;
+
 	find_short_object_filename(len, hex_pfx, &ds);
 	find_short_packed_object(len, bin_pfx, &ds);
 	status = finish_object_disambiguation(&ds, sha1);
-- 
1.7.11.1.29.gf71be5c
