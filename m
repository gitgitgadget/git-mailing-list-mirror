From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Make sure objects/pack exists before creating a new pack
Date: Wed, 18 Feb 2009 20:48:07 -0800
Message-ID: <7vr61vnibc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 05:49:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La0r0-0008GD-KG
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 05:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287AbZBSEsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 23:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752193AbZBSEsN
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 23:48:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbZBSEsN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 23:48:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5B3802B706;
	Wed, 18 Feb 2009 23:48:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6483F2B701; Wed,
 18 Feb 2009 23:48:09 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 829B94A2-FE40-11DD-8E39-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110621>

In a repository created with git older than f49fb35 (git-init-db: create
"pack" subdirectory under objects, 2005-06-27), objects/pack/ directory is
not created upon initialization.  It was Ok because subdirectories are
created as needed inside directories init-db creates.

8b4eb6b (Do not perform cross-directory renames when creating packs,
2008-09-22) moved the location temporary pack files are created from
objects/ directory to objects/pack/ directory; this move broke many
operations in such a repository, because it was not careful enough to make
sure leading directories exist.

Introduce odb_mkstemp() which is a specialized version of mkstemp() to
refactor the code and teach it to create a leading directories properly
to fix this buglet.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I don't know why, but I somehow found doing this patch highly amusing.

 builtin-pack-objects.c |    5 ++---
 fast-import.c          |   10 ++++------
 git-compat-util.h      |    1 +
 index-pack.c           |    5 ++---
 pack-write.c           |    4 +---
 wrapper.c              |   17 +++++++++++++++++
 6 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index cb51916..bcefa52 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -488,9 +488,8 @@ static void write_pack_file(void)
 		} else {
 			char tmpname[PATH_MAX];
 			int fd;
-			snprintf(tmpname, sizeof(tmpname),
-				 "%s/pack/tmp_pack_XXXXXX", get_object_directory());
-			fd = xmkstemp(tmpname);
+			fd = odb_mkstemp(tmpname, sizeof(tmpname),
+					 "pack/tmp_pack_XXXXXX");
 			pack_tmp_name = xstrdup(tmpname);
 			f = sha1fd(fd, pack_tmp_name);
 		}
diff --git a/fast-import.c b/fast-import.c
index 3ef3413..99e4df4 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -817,9 +817,8 @@ static void start_packfile(void)
 	struct pack_header hdr;
 	int pack_fd;
 
-	snprintf(tmpfile, sizeof(tmpfile),
-		"%s/pack/tmp_pack_XXXXXX", get_object_directory());
-	pack_fd = xmkstemp(tmpfile);
+	pack_fd = odb_mkstemp(tmpfile, sizeof(tmpfile),
+			      "pack/tmp_pack_XXXXXX");
 	p = xcalloc(1, sizeof(*p) + strlen(tmpfile) + 2);
 	strcpy(p->pack_name, tmpfile);
 	p->pack_fd = pack_fd;
@@ -879,9 +878,8 @@ static char *create_index(void)
 		c = next;
 	}
 
-	snprintf(tmpfile, sizeof(tmpfile),
-		"%s/pack/tmp_idx_XXXXXX", get_object_directory());
-	idx_fd = xmkstemp(tmpfile);
+	idx_fd = odb_mkstemp(tmpfile, sizeof(tmpfile),
+			     "pack/tmp_idx_XXXXXX");
 	f = sha1fd(idx_fd, tmpfile);
 	sha1write(f, array, 256 * sizeof(int));
 	git_SHA1_Init(&ctx);
diff --git a/git-compat-util.h b/git-compat-util.h
index 079cbe9..c1744b9 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -303,6 +303,7 @@ extern ssize_t xwrite(int fd, const void *buf, size_t len);
 extern int xdup(int fd);
 extern FILE *xfdopen(int fd, const char *mode);
 extern int xmkstemp(char *template);
+extern int odb_mkstemp(char *template, size_t limit, const char *pattern);
 
 static inline size_t xsize_t(off_t len)
 {
diff --git a/index-pack.c b/index-pack.c
index f7a3807..0350c29 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -172,9 +172,8 @@ static char *open_pack_file(char *pack_name)
 		input_fd = 0;
 		if (!pack_name) {
 			static char tmpfile[PATH_MAX];
-			snprintf(tmpfile, sizeof(tmpfile),
-				 "%s/pack/tmp_pack_XXXXXX", get_object_directory());
-			output_fd = xmkstemp(tmpfile);
+			output_fd = odb_mkstemp(tmpfile, sizeof(tmpfile),
+						"pack/tmp_pack_XXXXXX");
 			pack_name = xstrdup(tmpfile);
 		} else
 			output_fd = open(pack_name, O_CREAT|O_EXCL|O_RDWR, 0600);
diff --git a/pack-write.c b/pack-write.c
index b426006..3ab55b9 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -44,9 +44,7 @@ char *write_idx_file(char *index_name, struct pack_idx_entry **objects,
 
 	if (!index_name) {
 		static char tmpfile[PATH_MAX];
-		snprintf(tmpfile, sizeof(tmpfile),
-			 "%s/pack/tmp_idx_XXXXXX", get_object_directory());
-		fd = xmkstemp(tmpfile);
+		fd = odb_mkstemp(tmpfile, sizeof(tmpfile), "pack/tmp_idx_XXXXXX");
 		index_name = xstrdup(tmpfile);
 	} else {
 		unlink(index_name);
diff --git a/wrapper.c b/wrapper.c
index c85ca52..371cee1 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -197,6 +197,23 @@ int xmkstemp(char *template)
 	return fd;
 }
 
+int odb_mkstemp(char *template, size_t limit, const char *pattern)
+{
+	int fd;
+
+	snprintf(template, limit, "%s/%s",
+		 get_object_directory(), pattern);
+	fd = mkstemp(template);
+	if (0 <= fd)
+		return fd;
+
+	/* slow path */
+	safe_create_leading_directories(template);
+	snprintf(template, limit, "%s/%s",
+		 get_object_directory(), pattern);
+	return xmkstemp(template);
+}
+
 /*
  * zlib wrappers to make sure we don't silently miss errors
  * at init time.
