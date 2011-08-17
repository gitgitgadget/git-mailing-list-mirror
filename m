From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] revision.c: add show_object_with_name() helper function
Date: Wed, 17 Aug 2011 14:30:34 -0700
Message-ID: <1313616635-25331-3-git-send-email-gitster@pobox.com>
References: <1313616635-25331-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 23:31:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtnhP-00080u-N5
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 23:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525Ab1HQVap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 17:30:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55730 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754143Ab1HQVal (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 17:30:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67C363B15
	for <git@vger.kernel.org>; Wed, 17 Aug 2011 17:30:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=pd/x
	eLTQfrqKHBdkra7h/epE3Zw=; b=t46tuMUSUzcTuVdnnQSGO9eA01/FZ8HftQmx
	R4wGrBA1gWBiqnp3e0CIaBXR9faG8ZLD6ehAGu3xJYoMN3LC1ZumwzJGI6f8wkIr
	jb1I+KXI20i/OaxPWdEFB6cee7b+1QnSBiJS0S5VivNVyz6fuZ/FHF86GXM2zE2N
	0TCbjt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=qx7JxH
	V68BCwHp/t2faz+4IF4QxRR+QdfpQ4L1bf3fpO50pTeNGYDI4XdztiM9OuwJzxEr
	WFL4luDHNtbJYB/b0IfJQ++jIEF6Wt73O4Lpds8VdZ+Ot+cocqTINw1x34ilcI/2
	DyC59iX3yoR+qHTwcfomasTqfoNim5CChN9Pc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FB8E3B14
	for <git@vger.kernel.org>; Wed, 17 Aug 2011 17:30:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8A903B13 for
 <git@vger.kernel.org>; Wed, 17 Aug 2011 17:30:40 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.472.g4bfe7c
In-Reply-To: <1313616635-25331-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 27FBAFE6-C918-11E0-A6DA-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179541>

There are two copies of traverse_commit_list callback that show the object
name followed by pathname the object was found, to produce output similar
to "rev-list --objects".

Unify them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/rev-list.c |   15 +--------------
 revision.c         |   19 +++++++++++++++++++
 revision.h         |    2 ++
 upload-pack.c      |   15 +--------------
 4 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index d789279..f5ce487 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -176,21 +176,8 @@ static void finish_object(struct object *obj, const struct name_path *path, cons
 
 static void show_object(struct object *obj, const struct name_path *path, const char *component)
 {
-	char *name = path_name(path, component);
-	/* An object with name "foo\n0000000..." can be used to
-	 * confuse downstream "git pack-objects" very badly.
-	 */
-	const char *ep = strchr(name, '\n');
-
 	finish_object(obj, path, component);
-	if (ep) {
-		printf("%s %.*s\n", sha1_to_hex(obj->sha1),
-		       (int) (ep - name),
-		       name);
-	}
-	else
-		printf("%s %s\n", sha1_to_hex(obj->sha1), name);
-	free(name);
+	show_object_with_name(stdout, obj, path, component);
 }
 
 static void show_edge(struct commit *commit)
diff --git a/revision.c b/revision.c
index c46cfaa..c5b38cc 100644
--- a/revision.c
+++ b/revision.c
@@ -40,6 +40,25 @@ char *path_name(const struct name_path *path, const char *name)
 	return n;
 }
 
+void show_object_with_name(FILE *out, struct object *obj, const struct name_path *path, const char *component)
+{
+	char *name = path_name(path, component);
+	const char *ep = strchr(name, '\n');
+
+	/*
+	 * An object with name "foo\n0000000..." can be used to
+	 * confuse downstream "git pack-objects" very badly.
+	 */
+	if (ep) {
+		fprintf(out, "%s %.*s\n", sha1_to_hex(obj->sha1),
+			(int) (ep - name),
+			name);
+	}
+	else
+		fprintf(out, "%s %s\n", sha1_to_hex(obj->sha1), name);
+	free(name);
+}
+
 void add_object(struct object *obj,
 		struct object_array *p,
 		struct name_path *path,
diff --git a/revision.h b/revision.h
index 3d64ada..da00a58 100644
--- a/revision.h
+++ b/revision.h
@@ -185,6 +185,8 @@ struct name_path {
 
 char *path_name(const struct name_path *path, const char *name);
 
+extern void show_object_with_name(FILE *, struct object *, const struct name_path *, const char *);
+
 extern void add_object(struct object *obj,
 		       struct object_array *p,
 		       struct name_path *path,
diff --git a/upload-pack.c b/upload-pack.c
index ce5cbbe..970a1eb 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -85,20 +85,7 @@ static void show_commit(struct commit *commit, void *data)
 
 static void show_object(struct object *obj, const struct name_path *path, const char *component)
 {
-	/* An object with name "foo\n0000000..." can be used to
-	 * confuse downstream git-pack-objects very badly.
-	 */
-	const char *name = path_name(path, component);
-	const char *ep = strchr(name, '\n');
-	if (ep) {
-		fprintf(pack_pipe, "%s %.*s\n", sha1_to_hex(obj->sha1),
-		       (int) (ep - name),
-		       name);
-	}
-	else
-		fprintf(pack_pipe, "%s %s\n",
-				sha1_to_hex(obj->sha1), name);
-	free((char *)name);
+	show_object_with_name(pack_pipe, obj, path, component);
 }
 
 static void show_edge(struct commit *commit)
-- 
1.7.6.472.g4bfe7c
