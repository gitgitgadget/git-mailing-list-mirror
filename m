From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] revision.c: update show_object_with_name() without using
 malloc()
Date: Wed, 17 Aug 2011 14:30:35 -0700
Message-ID: <1313616635-25331-4-git-send-email-gitster@pobox.com>
References: <1313616635-25331-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 23:30:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtnhQ-00080u-7K
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 23:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532Ab1HQVar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 17:30:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55748 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754329Ab1HQVan (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 17:30:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 408803B18
	for <git@vger.kernel.org>; Wed, 17 Aug 2011 17:30:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=lG9Y
	X8L9G3NecQcRQwyvfKAKM/Y=; b=SSB39jjxh7ozfaViLbYOD2DjoELYs7KhHBn8
	ZogLJfgUizwMA6CJIOwR7ldPdDwZO7TF3lawPKn0YJ+s8iEL/k0tor1MFqHwsPw9
	jhpsGPcqLj/EfZKoX5wNu5kRdTz+ZBAu78rW7m972/76Tcm5TMP9EF2wQwOeHukl
	1eITtjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=gRvHhY
	88AOuBPAK22HN1rUG3z1KRakMW0wgZ5bde3i5GweqxCwS9IbcLip0U6ZXutEPK4F
	B/Iwj8aykqarGStPrllK7MUiyACzn/fwJyDx7CRH3wVHlHky/A6LoqLdWBCl5U/l
	OcPCsidoGVGlAEctl8aNfXhCwrr80aizl7w9A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38CE43B17
	for <git@vger.kernel.org>; Wed, 17 Aug 2011 17:30:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC6C53B16 for
 <git@vger.kernel.org>; Wed, 17 Aug 2011 17:30:42 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.472.g4bfe7c
In-Reply-To: <1313616635-25331-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 291B2C62-C918-11E0-9F22-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179538>

Allocating and then immediately freeing temporary memory a million times
when listing a million objects is distasteful.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * It may also be an option to keep a single static strbuf in
   show_object_with_name() and reuse it.

 revision.c |   50 ++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/revision.c b/revision.c
index c5b38cc..072ddac 100644
--- a/revision.c
+++ b/revision.c
@@ -40,23 +40,45 @@ char *path_name(const struct name_path *path, const char *name)
 	return n;
 }
 
+static int show_path_component_truncated(FILE *out, const char *name, int len)
+{
+	int cnt;
+	for (cnt = 0; cnt < len; cnt++) {
+		int ch = name[cnt];
+		if (!ch || ch == '\n')
+			return -1;
+		fputc(ch, out);
+	}
+	return len;
+}
+
+static int show_path_truncated(FILE *out, const struct name_path *path)
+{
+	int emitted, ours;
+
+	if (!path)
+		return 0;
+	emitted = show_path_truncated(out, path->up);
+	if (emitted < 0)
+		return emitted;
+	if (emitted)
+		fputc('/', out);
+	ours = show_path_component_truncated(out, path->elem, path->elem_len);
+	if (ours < 0)
+		return ours;
+	return ours || emitted;
+}
+
 void show_object_with_name(FILE *out, struct object *obj, const struct name_path *path, const char *component)
 {
-	char *name = path_name(path, component);
-	const char *ep = strchr(name, '\n');
+	struct name_path leaf;
+	leaf.up = (struct name_path *)path;
+	leaf.elem = component;
+	leaf.elem_len = strlen(component);
 
-	/*
-	 * An object with name "foo\n0000000..." can be used to
-	 * confuse downstream "git pack-objects" very badly.
-	 */
-	if (ep) {
-		fprintf(out, "%s %.*s\n", sha1_to_hex(obj->sha1),
-			(int) (ep - name),
-			name);
-	}
-	else
-		fprintf(out, "%s %s\n", sha1_to_hex(obj->sha1), name);
-	free(name);
+	fprintf(out, "%s ", sha1_to_hex(obj->sha1));
+	show_path_truncated(out, &leaf);
+	fputc('\n', out);
 }
 
 void add_object(struct object *obj,
-- 
1.7.6.472.g4bfe7c
