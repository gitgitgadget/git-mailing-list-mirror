From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 14/25] sha1_name.c: get_sha1_1() takes lookup flags
Date: Tue,  3 Jul 2012 14:37:04 -0700
Message-ID: <1341351435-31011-15-git-send-email-gitster@pobox.com>
References: <1341351435-31011-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 23:38:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmAo5-00061R-QU
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 23:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576Ab2GCViT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 17:38:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35111 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756534Ab2GCVhp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 17:37:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45EE48664
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=mpI0
	WUdXGGYFDIyY4CNVfHe6cFk=; b=ySw4CYAK3dbjv2QvCYm8QS99wfOngftvyP/l
	vkaNstSsqzwEfyqcJ7aldTi9KiJ4vNYnEPWTMQV02NT1IE+Usfu1UbaDn61RJKu6
	LtaZ3eV1zwSnIB4ePu+Z8YSteCAZMGy+je7vgaPFr+8bdC7O/oToOD9zp8vjKjw5
	375b8uw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=vYeH/4
	WJNi+XAdR6+kago4L84rtb4Y4Fpoj7L/Jmt3Al8OBpwdYioLkthBX4ewzO1aKB/S
	tpX4GrhZ/NlC/G0eIcQL1JfIetfPHybv4Jw82RjikCMmGztE9wfkFRFqYjFTUx6k
	pKCxBMCd+GwxnrhCAwY6ZCR48N1YN41uCrzm8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D7628663
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A75FE8662 for
 <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:44 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.229.g706c98f
In-Reply-To: <1341351435-31011-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5339DCF0-C557-11E1-A9AB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200961>

This is to pass the disambiguation hints from the caller down the
callchain.  Nothing is changed in this step, as everybody just
passes 0 in the flag.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index caef6e5..8feb9b5 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -333,7 +333,7 @@ static inline int upstream_mark(const char *string, int len)
 	return 0;
 }
 
-static int get_sha1_1(const char *name, int len, unsigned char *sha1);
+static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned lookup_flags);
 
 static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 {
@@ -370,7 +370,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		ret = interpret_branch_name(str+at, &buf);
 		if (ret > 0) {
 			/* substitute this branch name and restart */
-			return get_sha1_1(buf.buf, buf.len, sha1);
+			return get_sha1_1(buf.buf, buf.len, sha1, 0);
 		} else if (ret == 0) {
 			return -1;
 		}
@@ -440,7 +440,7 @@ static int get_parent(const char *name, int len,
 		      unsigned char *result, int idx)
 {
 	unsigned char sha1[20];
-	int ret = get_sha1_1(name, len, sha1);
+	int ret = get_sha1_1(name, len, sha1, 0);
 	struct commit *commit;
 	struct commit_list *p;
 
@@ -473,7 +473,7 @@ static int get_nth_ancestor(const char *name, int len,
 	struct commit *commit;
 	int ret;
 
-	ret = get_sha1_1(name, len, sha1);
+	ret = get_sha1_1(name, len, sha1, 0);
 	if (ret)
 		return ret;
 	commit = lookup_commit_reference(sha1);
@@ -554,7 +554,7 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 	else
 		return -1;
 
-	if (get_sha1_1(name, sp - name - 2, outer))
+	if (get_sha1_1(name, sp - name - 2, outer, 0))
 		return -1;
 
 	o = parse_object(outer);
@@ -621,7 +621,7 @@ static int get_describe_name(const char *name, int len, unsigned char *sha1)
 	return -1;
 }
 
-static int get_sha1_1(const char *name, int len, unsigned char *sha1)
+static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned lookup_flags)
 {
 	int ret, has_suffix;
 	const char *cp;
@@ -1098,7 +1098,7 @@ static int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 
 	memset(oc, 0, sizeof(*oc));
 	oc->mode = S_IFINVALID;
-	ret = get_sha1_1(name, namelen, sha1);
+	ret = get_sha1_1(name, namelen, sha1, 0);
 	if (!ret)
 		return ret;
 	/* sha1:path --> object name of path in ent sha1
@@ -1176,7 +1176,7 @@ static int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 			strncpy(object_name, name, cp-name);
 			object_name[cp-name] = '\0';
 		}
-		if (!get_sha1_1(name, cp-name, tree_sha1)) {
+		if (!get_sha1_1(name, cp-name, tree_sha1, 0)) {
 			const char *filename = cp+1;
 			char *new_filename = NULL;
 
-- 
1.7.11.1.229.g706c98f
