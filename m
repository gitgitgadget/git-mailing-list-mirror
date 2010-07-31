From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/16] subtree: rewriting outgoing commits
Date: Sat, 31 Jul 2010 23:18:21 +0700
Message-ID: <1280593105-22015-13-git-send-email-pclouds@gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 01 04:39:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfOSU-00037f-Iw
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 04:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755447Ab0HACjV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 22:39:21 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42790 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab0HACjU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 22:39:20 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so977126pwi.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 19:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=UpkdtR6gBl51Own+vCEfzrSjjI0LbEhj7UweD/EZPv4=;
        b=dhTK2SIYHVeu1IOjA/nnjKTmfQJRdzuxk8KhVoj5jLaNK2RcweylI+0ri9I1YWO8bI
         vQaASm5J+/IlHYzIQ69xN0inRbeRLUrwyk+CFAqLQ/Zb8wfqH+lWcRl6b5dN3upENZed
         I2KcOh5aHOiF9JrmKoU7vrlCV1lNy3LatILEk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=S7JVPztQDovmxltjpkk9697DbebodRqsxAkRLHFOb9s+VyIhve9o2Idn5mzHH27aB2
         vhwhT7wmdovTeYiG7dWIQHxsg1EPy4YOkDKkSKVrYiz1b4m4Lz987HU8US0FEfJN0WyM
         5JmFawm/a46t+bVdO1lvAhVLRGkoxrKvMONXc=
Received: by 10.114.66.5 with SMTP id o5mr4798443waa.219.1280630359985;
        Sat, 31 Jul 2010 19:39:19 -0700 (PDT)
Received: from dektop ([119.12.238.118])
        by mx.google.com with ESMTPS id d38sm7702311wam.20.2010.07.31.19.39.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 19:39:19 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 31 Jul 2010 23:20:11 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152359>

Which is exactly the opposite of rewriting incoming commits.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 subtree.c |  173 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 subtree.h |    1 +
 2 files changed, 174 insertions(+), 0 deletions(-)

diff --git a/subtree.c b/subtree.c
index 8c075be..739ff5f 100644
--- a/subtree.c
+++ b/subtree.c
@@ -359,3 +359,176 @@ void subtree_import()
 	if (revs.pending.nr)
 		free(revs.pending.objects);
 }
+
+/*
+ * The opposite of narrow_tree(). Put the subtree back to the original=
 tree.
+ */
+static int widen_tree(const unsigned char *sha1,
+		      unsigned char *newsha1,
+		      const unsigned char *subtree_sha1,
+		      const char *prefix)
+{
+	struct tree_desc desc;
+	struct name_entry entry;
+	struct strbuf buffer;
+	const char *slash;
+	int subtree_len;
+	enum object_type type;
+	unsigned long size;
+	char *tree;
+
+	slash =3D strchr(prefix, '/');
+	subtree_len =3D slash ? slash - prefix : strlen(prefix);
+
+	tree =3D read_sha1_file(sha1, &type, &size);
+	if (type !=3D OBJ_TREE)
+		die("%s is not a tree", sha1_to_hex(sha1));
+
+	init_tree_desc(&desc, tree, size);
+	strbuf_init(&buffer, 8192);
+	while (tree_entry(&desc, &entry)) {
+		strbuf_addf(&buffer, "%o %.*s%c", entry.mode, strlen(entry.path), en=
try.path, '\0');
+
+		if (S_ISDIR(entry.mode) &&
+		    subtree_len =3D=3D strlen(entry.path) &&
+		    !strncmp(entry.path, prefix, subtree_len)) {
+			unsigned char newtree_sha1[20];
+
+			if (slash && slash[1]) /* trailing slash does not count */
+				widen_tree(entry.sha1, newtree_sha1, subtree_sha1,
+					   prefix+subtree_len+1);
+			else
+				/* replace the tree */
+				memcpy(newtree_sha1, subtree_sha1, 20);
+
+			strbuf_add(&buffer, newtree_sha1, 20);
+		}
+		else
+			strbuf_add(&buffer, entry.sha1, 20);
+	}
+	free(tree);
+
+	if (write_sha1_file(buffer.buf, buffer.len, tree_type, newsha1)) {
+		error("Could not write replaced tree for %s", sha1_to_hex(sha1));
+		strbuf_release(&buffer);
+		return 1;
+	}
+	strbuf_release(&buffer);
+	return 0;
+}
+
+static int find_subtree(const unsigned char *sha1, unsigned char *news=
ha1, const char *prefix)
+{
+	struct tree_desc desc;
+	struct name_entry entry;
+	const char *slash;
+	enum object_type type;
+	unsigned long size;
+	int subtree_len;
+	char *tree;
+
+	slash =3D strchr(prefix, '/');
+	subtree_len =3D slash ? slash - prefix : strlen(prefix);
+
+	tree =3D read_sha1_file(sha1, &type, &size);
+	if (type !=3D OBJ_TREE)
+		die("%s is not a tree", sha1_to_hex(sha1));
+
+	init_tree_desc(&desc, tree, size);
+	while (tree_entry(&desc, &entry)) {
+		if (!S_ISDIR(entry.mode))
+			continue;
+
+		if (subtree_len =3D=3D strlen(entry.path) &&
+		    !strncmp(entry.path, prefix, subtree_len)) {
+
+			if (slash && slash[1]) { /* trailing slash does not count */
+				if (find_subtree(entry.sha1, newsha1, prefix+subtree_len+1))
+					return 1;
+			}
+			else
+				memcpy(newsha1, entry.sha1, 20);
+			free(tree);
+			return 0;
+		}
+	}
+	free(tree);
+
+	return 1;
+}
+
+/* The opposite of shadow_commit() */
+static int expose_commit(const unsigned char *sha1, unsigned char *new=
sha1,
+			 const unsigned char *basesha1,
+			 const char *prefix, FILE *fp)
+{
+	unsigned char treesha1[20], subtree_sha1[20];
+	enum object_type type;
+	unsigned long size, base_size;
+	void *base_buffer, *buffer;
+	int saved_read_replace_refs =3D read_replace_refs;
+
+	/* Get subtree from the new commit, sha1 */
+	read_replace_refs =3D 0;
+	buffer =3D read_sha1_file(sha1, &type, &size);
+	read_replace_refs =3D saved_read_replace_refs;
+	get_sha1_hex(buffer+5, treesha1);
+
+	if (!buffer || type !=3D OBJ_COMMIT ||
+	    find_subtree(treesha1, subtree_sha1, prefix)) {
+		free(buffer);
+		error("Failed to find subtree tree in base commit %s", sha1_to_hex(s=
ha1));
+		return 1;
+	}
+
+	/* Get the old base tree from basesha1 */
+	read_replace_refs =3D 0;
+	base_buffer =3D read_sha1_file(basesha1, &type, &base_size);
+	read_replace_refs =3D saved_read_replace_refs;
+	get_sha1_hex(base_buffer+5, treesha1);
+
+	if (!buffer || type !=3D OBJ_COMMIT ||
+	    widen_tree(treesha1, newsha1, subtree_sha1, prefix)) {
+		free(buffer);
+		error("Failed to widen tree for commit %s", sha1_to_hex(sha1));
+		return 1;
+	}
+	free(base_buffer);
+
+	/* replace new tree in */
+	memcpy((char*)buffer+5, sha1_to_hex(newsha1), 40);
+
+	if (write_sha1_file(buffer, size, commit_type, newsha1)) {
+		free(buffer);
+		error("Could not write replaced commit for %s", sha1_to_hex(sha1));
+		return 1;
+	}
+
+	if (fp) {
+		char buf[82];
+		memcpy(buf, sha1_to_hex(newsha1), 40);
+		buf[40] =3D ' ';
+		memcpy(buf+41, sha1_to_hex(sha1), 40);
+		buf[81] =3D '\n';
+		fwrite(buf, 82, 1, fp);
+	}
+	free(buffer);
+
+	return 0;
+}
+
+int subtree_export(unsigned char *sha1, unsigned char *basesha1, unsig=
ned char *newsha1)
+{
+	FILE *fp;
+
+	fp =3D fopen(git_path("subtree"), "a+");
+	if (expose_commit(sha1, newsha1, basesha1, core_subtree, fp))
+		die("Failed to rewrite commit %s", sha1_to_hex(sha1));
+	fclose(fp);
+
+	if (subtree_commit)
+		free(subtree_commit);
+	prepare_subtree_commit();
+
+	return 0;
+}
diff --git a/subtree.h b/subtree.h
index 3512e2a..081838f 100644
--- a/subtree.h
+++ b/subtree.h
@@ -1,3 +1,4 @@
 void prepare_subtree_commit();
 const unsigned char *subtree_lookup_object(const unsigned char *sha1);
 void subtree_import();
+int subtree_export(unsigned char *sha1, unsigned char *basesha1, unsig=
ned char *newsha1);
--=20
1.7.1.rc1.69.g24c2f7
