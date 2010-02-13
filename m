From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] for-each-ref --format='%(flag)'
Date: Sat, 13 Feb 2010 12:30:33 -0800
Message-ID: <1266093033-9526-5-git-send-email-gitster@pobox.com>
References: <1266093033-9526-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 21:30:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgOdi-00079m-3s
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 21:30:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757992Ab0BMUar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 15:30:47 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757991Ab0BMUap (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 15:30:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A85299AA3
	for <git@vger.kernel.org>; Sat, 13 Feb 2010 15:30:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=axVr
	NAK9C8WF+7oOEnQur6hcIx8=; b=U3DsJ/+39oZ5m85X7pf0a1/JGz6zrji58xee
	rVBBrnYHOa7hrxyxLLP9MSGkallQhdLh/+NjMuie0PH/cwfMQSjcdBLFtbEcmGif
	JePelFK60mxTCOZBjhLri1w8B8ntcnn0N48vCM2jNPsLDY6fM27xCwLrDAQiXdtl
	jHvl9gk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=O5v4ZB
	irnSl+vrlk36rhjqbQHAfZKrCziQOHZm+/QJiH3YumTaXX3lD5RybmMAS63ai+Lk
	DLEWd8LIZWxlZeghGoj42x7Dmbr1btEaHB1wJktgSJX7MkTcJAAWNtloxvC3948s
	rELOSIkx/EGNAej52Sb9UGiT8fa9iJWnCz3U8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5710099AA2
	for <git@vger.kernel.org>; Sat, 13 Feb 2010 15:30:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E097E99AA1 for
 <git@vger.kernel.org>; Sat, 13 Feb 2010 15:30:44 -0500 (EST)
X-Mailer: git-send-email 1.7.0.169.g57c99
In-Reply-To: <1266093033-9526-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A9B2C43E-18DE-11DF-8D09-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139827>

This expands to "symref" or "packed" or an empty string, exposing the
internal "flag" the for_each_ref() callback functions are called with.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-for-each-ref.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index b9b03e1..62be1bb 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -71,6 +71,7 @@ static struct {
 	{ "contents" },
 	{ "upstream" },
 	{ "symref" },
+	{ "flag" },
 };
 
 /*
@@ -558,6 +559,13 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, v
 	}
 }
 
+static inline char *copy_advance(char *dst, const char *src)
+{
+	while (*src)
+		*dst++ = *src++;
+	return dst;
+}
+
 /*
  * Parse the object referred by ref, and grab needed value.
  */
@@ -610,6 +618,20 @@ static void populate_value(struct refinfo *ref)
 				continue;
 			refname = branch->merge[0]->dst;
 		}
+		else if (!strcmp(name, "flag")) {
+			char buf[256], *cp = buf;
+			if (ref->flag & REF_ISSYMREF)
+				cp = copy_advance(cp, ",symref");
+			if (ref->flag & REF_ISPACKED)
+				cp = copy_advance(cp, ",packed");
+			if (cp == buf)
+				v->s = "";
+			else {
+				*cp = '\0';
+				v->s = xstrdup(buf + 1);
+			}
+			continue;
+		}
 		else
 			continue;
 
-- 
1.7.0.169.g57c99
