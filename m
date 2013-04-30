From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 5/8] commit.c: refuse to write commits referring to external objects
Date: Tue, 30 Apr 2013 10:42:49 +0700
Message-ID: <1367293372-1958-6-git-send-email-pclouds@gmail.com>
References: <1367293372-1958-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 30 05:43:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX1TA-0006GR-9K
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 05:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758795Ab3D3DnE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Apr 2013 23:43:04 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:39791 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757179Ab3D3DnC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 23:43:02 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa10so105137pad.41
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 20:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=NLMXMcBCaC5K4JFwcjdugUixcPIHHVl6THBYKnZvLHM=;
        b=p0eDZhj6OPoYJdlVCG8EkE1kMKjRUo00KL7JcONYWCPaV08YvXEZ2464fp5acQ9KKO
         Dm+cgFgP784JwG9EpGGuACTMlcri4MVXBcLf58gjAap25jjWaozrMGbe9/z7tzlQ7JUj
         l8xBAu1sL04whYerJOzm+2OhBjO5a731N2BN7VsXh69GPcIb8q++lXqwIlC+picbVKaN
         1BjHyTLjj6jXzMxc3U3/AYquIlwWfazGfnEoE8ihmB9p2TFkZDMqtP40CSNeIcA6nqE5
         +kiOrYGO44JAR+gfXk9XOsCfCTiVKCQZ5QCFTeLy5aTVGK8GWdj+rS46i00aGmkItzWE
         DhrQ==
X-Received: by 10.68.218.8 with SMTP id pc8mr73082984pbc.115.1367293381443;
        Mon, 29 Apr 2013 20:43:01 -0700 (PDT)
Received: from lanh ([115.74.52.135])
        by mx.google.com with ESMTPSA id ba10sm26599132pbd.21.2013.04.29.20.42.58
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 20:43:00 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 30 Apr 2013 10:43:32 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1367293372-1958-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222899>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h     | 1 +
 commit.c    | 9 +++++++++
 sha1_file.c | 7 +++++++
 3 files changed, 17 insertions(+)

diff --git a/cache.h b/cache.h
index bc3ccd8..57b6d30 100644
--- a/cache.h
+++ b/cache.h
@@ -804,6 +804,7 @@ extern int move_temp_to_file(const char *tmpfile, c=
onst char *filename);
=20
 extern int has_sha1_pack(const unsigned char *sha1);
 extern int has_sha1_file(const unsigned char *sha1);
+extern int has_sha1_file_proper(const unsigned char *sha1);
 extern int has_loose_object_nonlocal(const unsigned char *sha1);
=20
 extern int has_pack_index(const unsigned char *sha1);
diff --git a/commit.c b/commit.c
index 888e02a..3edbe22 100644
--- a/commit.c
+++ b/commit.c
@@ -1343,6 +1343,10 @@ int commit_tree_extended(const struct strbuf *ms=
g, unsigned char *tree,
 	/* Not having i18n.commitencoding is the same as having utf-8 */
 	encoding_is_utf8 =3D is_encoding_utf8(git_commit_encoding);
=20
+	if (object_database_contaminated && !has_sha1_file_proper(tree))
+		return error(_("cannot create a commit with external tree %s"),
+			     sha1_to_hex(tree));
+
 	strbuf_init(&buffer, 8192); /* should avoid reallocs for the headers =
*/
 	strbuf_addf(&buffer, "tree %s\n", sha1_to_hex(tree));
=20
@@ -1355,6 +1359,11 @@ int commit_tree_extended(const struct strbuf *ms=
g, unsigned char *tree,
 		struct commit_list *next =3D parents->next;
 		struct commit *parent =3D parents->item;
=20
+		if (object_database_contaminated &&
+		    !has_sha1_file_proper(parent->object.sha1))
+			return error(_("cannot create a commit with external commit %s"),
+				     sha1_to_hex(parent->object.sha1));
+
 		strbuf_addf(&buffer, "parent %s\n",
 			    sha1_to_hex(parent->object.sha1));
 		free(parents);
diff --git a/sha1_file.c b/sha1_file.c
index 53f93ab..b8f2afe 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2935,6 +2935,13 @@ int has_sha1_file(const unsigned char *sha1)
 	return has_sha1_file_extended(sha1, odb_default);
 }
=20
+int has_sha1_file_proper(const unsigned char *sha1)
+{
+	if (find_cached_object(sha1, ODB_CACHED))
+		return 1;
+	return has_sha1_file_extended(sha1, ODB_LOCAL | ODB_ALT);
+}
+
 static void check_tree(const void *buf, size_t size)
 {
 	struct tree_desc desc;
--=20
1.8.2.83.gc99314b
