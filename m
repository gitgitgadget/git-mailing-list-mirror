From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] clone: find the current branch more explicitly
Date: Sun, 30 Nov 2008 01:57:30 -0800
Message-ID: <1228039053-31099-3-git-send-email-gitster@pobox.com>
References: <1228039053-31099-1-git-send-email-gitster@pobox.com>
 <1228039053-31099-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 10:59:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6j5R-00010i-1P
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 10:59:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbYK3J6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 04:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbYK3J6F
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 04:58:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60230 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbYK3J6D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 04:58:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 121BA17CB9
	for <git@vger.kernel.org>; Sun, 30 Nov 2008 04:58:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3C02A17CB7 for
 <git@vger.kernel.org>; Sun, 30 Nov 2008 04:57:55 -0500 (EST)
X-Mailer: git-send-email 1.6.0.4.850.g6bd829
In-Reply-To: <1228039053-31099-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 601220F0-BEC5-11DD-9A07-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101954>

This makes "git clone" use the symbolic-ref protocol extension to find the
ref the HEAD is pointing at (when available), so that it can point at the
current branch that is not 'master' but happens to point at the same
commit as 'master'.  IOW, immediately after doing the following:

    $ git checkout -b another master

a clone made out of that repository will check out 'another' branch, not
'master'.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-clone.c |   24 +++++++++++++++++++-----
 connect.c       |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 2feac9c..a8b8d56 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -299,13 +299,27 @@ static const struct ref *locate_head(const struct ref *refs,
 	const struct ref *remote_head = NULL;
 	const struct ref *remote_master = NULL;
 	const struct ref *r;
-	for (r = refs; r; r = r->next)
-		if (!strcmp(r->name, "HEAD"))
+
+	for (r = refs; r; r = r->next) {
+		if (!strcmp(r->name, "HEAD")) {
 			remote_head = r;
+			break;
+		}
+	}
 
-	for (r = mapped_refs; r; r = r->next)
-		if (!strcmp(r->name, "refs/heads/master"))
-			remote_master = r;
+	if (remote_head && remote_head->symref) {
+		for (r = mapped_refs; r; r = r->next)
+			if (!strcmp(r->name, remote_head->symref)) {
+				remote_master = r;
+				break;
+			}
+	}
+
+	if (!remote_master) {
+		for (r = mapped_refs; r; r = r->next)
+			if (!strcmp(r->name, "refs/heads/master"))
+				remote_master = r;
+	}
 
 	if (remote_head_p)
 		*remote_head_p = remote_head;
diff --git a/connect.c b/connect.c
index 402fbe6..40b43b4 100644
--- a/connect.c
+++ b/connect.c
@@ -48,6 +48,39 @@ static void add_extra_have(struct extra_have_objects *extra, unsigned char *sha1
 	extra->nr++;
 }
 
+static void receive_symref(int fd[2], struct ref *refs)
+{
+	char line[1024];
+	int len;
+
+	packet_write(fd[1], "symbolic-ref");
+	while ((len = packet_read_line(fd[0], line, sizeof(line)))) {
+		if (!prefixcmp(line, "symref ")) {
+			struct ref *sym;
+			char *symref = line + 7;
+			char *target = strchr(symref, ' ');
+			if (!target)
+				die("Malformed symref line %s", line);
+			*target++ = '\0';
+			sym = find_ref_by_name(refs, symref);
+			if (!sym) {
+				/*
+				 * NEEDSWORK: perhaps create the symref ref
+				 * that is still unborn and queue it?
+				 */
+				continue;
+			}
+			if (sym->symref)
+				die("symref line says %s points at %s "
+				    "but earlier it said it points at %s",
+				    symref, target, sym->symref);
+			sym->symref = xstrdup(target);
+			continue;
+		}
+		die("expected symref, got %s", line);
+	}
+}
+
 /*
  * Read all the refs from the other end
  */
@@ -56,6 +89,7 @@ struct ref **get_remote_heads(int fd[2], struct ref **list,
 			      unsigned int flags,
 			      struct extra_have_objects *extra_have)
 {
+	struct ref **original_list = list;
 	*list = NULL;
 	for (;;) {
 		struct ref *ref;
@@ -98,6 +132,8 @@ struct ref **get_remote_heads(int fd[2], struct ref **list,
 		*list = ref;
 		list = &ref->next;
 	}
+	if (server_supports("symbolic-ref"))
+		receive_symref(fd, *original_list);
 	return list;
 }
 
-- 
1.6.0.4.850.g6bd829
