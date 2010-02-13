From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] for-each-ref --format='%(symref) %(symref:short)'
Date: Sat, 13 Feb 2010 12:30:32 -0800
Message-ID: <1266093033-9526-4-git-send-email-gitster@pobox.com>
References: <1266093033-9526-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 21:30:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgOdh-00079m-Ij
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 21:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757975Ab0BMUap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 15:30:45 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58072 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755680Ab0BMUao (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 15:30:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E47299AA0
	for <git@vger.kernel.org>; Sat, 13 Feb 2010 15:30:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=YyHT
	s505zoM2ZPSt78UhnhAQIEM=; b=HJppl2ec/E0xeRQb9Mr8B33WsteyrK+qIsGi
	llL2/y2IA8je1kHASt315l7+2c4NOBerY77E6uf0Vztu1RZpFhSS+eGtofHWDe2W
	GRIxv0j1L/rGDqIiulMMVfEKlYLsXgvz2WITDcbKxjGHHxhniI0POEdqP8WSazyY
	gvBTj/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=v3KxKS
	FUaKWzMsOWfUplOZa1uQ7hwKoURuGxgj9w1zsXuWb6mIQvY2apDx09pgaD4jJwYQ
	KBxOLQIKwos3GJnBN8K9hY3kn1DVKxeQTFJMZmMIvwX7SKEIZRSUWYJ4N3FROHvR
	z11nqQ7ooDEcG05zIdnvhQs+l2IkBA5q6TNis=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 89CB699A9F
	for <git@vger.kernel.org>; Sat, 13 Feb 2010 15:30:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC37999A9C for
 <git@vger.kernel.org>; Sat, 13 Feb 2010 15:30:42 -0500 (EST)
X-Mailer: git-send-email 1.7.0.169.g57c99
In-Reply-To: <1266093033-9526-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A8A13B8E-18DE-11DF-A0A0-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139826>

New %(symref) output atom expands to the name of the ref a symbolic ref
points at, or an empty string if the ref being shown is not a symref.

This may help scripted Porcelain writers.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-for-each-ref.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index d68977e..b9b03e1 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -33,6 +33,8 @@ struct ref_sort {
 struct refinfo {
 	char *refname;
 	unsigned char objectname[20];
+	int flag;
+	const char *symref;
 	struct atom_value *value;
 };
 
@@ -68,6 +70,7 @@ static struct {
 	{ "body" },
 	{ "contents" },
 	{ "upstream" },
+	{ "symref" },
 };
 
 /*
@@ -82,7 +85,7 @@ static struct {
  */
 static const char **used_atom;
 static cmp_type *used_atom_type;
-static int used_atom_cnt, sort_atom_limit, need_tagged;
+static int used_atom_cnt, sort_atom_limit, need_tagged, need_symref;
 
 /*
  * Used to parse format string and sort specifiers
@@ -135,6 +138,8 @@ static int parse_atom(const char *atom, const char *ep)
 	used_atom_type[at] = valid_atom[i].cmp_type;
 	if (*atom == '*')
 		need_tagged = 1;
+	if (!strcmp(used_atom[at], "symref"))
+		need_symref = 1;
 	return at;
 }
 
@@ -566,6 +571,16 @@ static void populate_value(struct refinfo *ref)
 
 	ref->value = xcalloc(sizeof(struct atom_value), used_atom_cnt);
 
+	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
+		unsigned char unused1[20];
+		const char *symref;
+		symref = resolve_ref(ref->refname, unused1, 1, NULL);
+		if (symref)
+			ref->symref = xstrdup(symref);
+		else
+			ref->symref = "";
+	}
+
 	/* Fill in specials first */
 	for (i = 0; i < used_atom_cnt; i++) {
 		const char *name = used_atom[i];
@@ -581,6 +596,8 @@ static void populate_value(struct refinfo *ref)
 
 		if (!prefixcmp(name, "refname"))
 			refname = ref->refname;
+		else if (!prefixcmp(name, "symref"))
+			refname = ref->symref ? ref->symref : "";
 		else if (!prefixcmp(name, "upstream")) {
 			struct branch *branch;
 			/* only local branches may have an upstream */
@@ -726,6 +743,7 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 	ref = xcalloc(1, sizeof(*ref));
 	ref->refname = xstrdup(refname);
 	hashcpy(ref->objectname, sha1);
+	ref->flag = flag;
 
 	cnt = cb->grab_cnt;
 	cb->grab_array = xrealloc(cb->grab_array,
-- 
1.7.0.169.g57c99
