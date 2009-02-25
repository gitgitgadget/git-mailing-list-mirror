From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] Make sure objects/pack exists before creating a new pack
Date: Tue, 24 Feb 2009 23:11:29 -0800
Message-ID: <7vocwrc7oe.fsf_-_@gitster.siamese.dyndns.org>
References: <49A428B7.4000003@spiralti.com>
 <7v7i3fivx2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Todd Zullinger <tmz@pobox.com>,
	Rafael Darder Calvo <rdarder@spiralti.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 08:13:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcDx5-0002ed-TU
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 08:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981AbZBYHLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 02:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752336AbZBYHLj
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 02:11:39 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58734 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbZBYHLi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 02:11:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F2A651113;
	Thu, 26 Feb 2009 02:11:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D99181111; Thu,
 26 Feb 2009 02:11:29 -0500 (EST)
In-Reply-To: <7v7i3fivx2.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 24 Feb 2009 09:31:21 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B3A91792-03D4-11DE-9E11-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111381>

In a repository created with git older than f49fb35 (git-init-db: create
"pack" subdirectory under objects, 2005-06-27), objects/pack/ directory is
not created upon initialization.  It was Ok because subdirectories are
created as needed inside directories init-db creates, and back then,
packfiles were recent invention.

After the said commit, new codepaths started relying on the presense of
objects/pack/ directory in the repository.  This was exacerbated with
8b4eb6b (Do not perform cross-directory renames when creating packs,
2008-09-22) that moved the location temporary pack files are created from
objects/ directory to objects/pack/ directory, because moving temporary to
the final location was done carefully with lazy leading directory creation.

Many packfile related operations in such an old repository can fail
mysteriously because of this.

This commit introduces two helper functions to make things work better.

 - odb_mkstemp() is a specialized version of mkstemp() to refactor the
   code and teach it to create leading directories as needed;

 - odb_pack_keep() refactors the code to create a ".keep" file while
   create leading directories as needed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is a re-roll of the earlier patch in response to Fedora bugzilla
   entry https://bugzilla.redhat.com/show_bug.cgi?id=483546

   The earlier one didn't cover the objects/pack/pack-*.keep codepaths, and
   wouldn't have been sufficient to fix the breakage reported by
   $gmane/111316.

   This is meant to apply cleanly to the v1.6.0.X maintenance track and
   upwards.

 builtin-pack-objects.c |    5 ++---
 fast-import.c          |   14 +++++---------
 git-compat-util.h      |    2 ++
 index-pack.c           |   23 ++++++++++++-----------
 pack-write.c           |    6 ++----
 t/t5300-pack-object.sh |   17 +++++++++++++++++
 wrapper.c              |   32 ++++++++++++++++++++++++++++++++
 7 files changed, 72 insertions(+), 27 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index fb5e14d..7518d53 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -473,9 +473,8 @@ static void write_pack_file(void)
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
index 5bc9ce2..3f92194 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -815,9 +815,8 @@ static void start_packfile(void)
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
@@ -877,9 +876,8 @@ static char *create_index(void)
 		c = next;
 	}
 
-	snprintf(tmpfile, sizeof(tmpfile),
-		"%s/pack/tmp_idx_XXXXXX", get_object_directory());
-	idx_fd = xmkstemp(tmpfile);
+	idx_fd = odb_mkstemp(tmpfile, sizeof(tmpfile),
+			     "pack/tmp_idx_XXXXXX");
 	f = sha1fd(idx_fd, tmpfile);
 	sha1write(f, array, 256 * sizeof(int));
 	SHA1_Init(&ctx);
@@ -905,9 +903,7 @@ static char *keep_pack(char *curr_index_name)
 	chmod(pack_data->pack_name, 0444);
 	chmod(curr_index_name, 0444);
 
-	snprintf(name, sizeof(name), "%s/pack/pack-%s.keep",
-		 get_object_directory(), sha1_to_hex(pack_data->sha1));
-	keep_fd = open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
+	keep_fd = odb_pack_keep(name, sizeof(name), pack_data->sha1);
 	if (keep_fd < 0)
 		die("cannot create keep file");
 	write_or_die(keep_fd, keep_msg, strlen(keep_msg));
diff --git a/git-compat-util.h b/git-compat-util.h
index cf89cdf..758a880 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -294,6 +294,8 @@ extern ssize_t xwrite(int fd, const void *buf, size_t len);
 extern int xdup(int fd);
 extern FILE *xfdopen(int fd, const char *mode);
 extern int xmkstemp(char *template);
+extern int odb_mkstemp(char *template, size_t limit, const char *pattern);
+extern int odb_pack_keep(char *name, size_t namesz, unsigned char *sha1);
 
 static inline size_t xsize_t(off_t len)
 {
diff --git a/index-pack.c b/index-pack.c
index c99a1a1..745ac0b 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -171,9 +171,8 @@ static char *open_pack_file(char *pack_name)
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
@@ -795,22 +794,24 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 
 	if (keep_msg) {
 		int keep_fd, keep_msg_len = strlen(keep_msg);
-		if (!keep_name) {
-			snprintf(name, sizeof(name), "%s/pack/pack-%s.keep",
-				 get_object_directory(), sha1_to_hex(sha1));
-			keep_name = name;
-		}
-		keep_fd = open(keep_name, O_RDWR|O_CREAT|O_EXCL, 0600);
+
+		if (!keep_name)
+			keep_fd = odb_pack_keep(name, sizeof(name), sha1);
+		else
+			keep_fd = open(keep_name, O_RDWR|O_CREAT|O_EXCL, 0600);
+
 		if (keep_fd < 0) {
 			if (errno != EEXIST)
-				die("cannot write keep file");
+				die("cannot write keep file '%s' (%s)",
+				    keep_name, strerror(errno));
 		} else {
 			if (keep_msg_len > 0) {
 				write_or_die(keep_fd, keep_msg, keep_msg_len);
 				write_or_die(keep_fd, "\n", 1);
 			}
 			if (close(keep_fd) != 0)
-				die("cannot write keep file");
+				die("cannot close written keep file '%s' (%s)",
+				    keep_name, strerror(errno));
 			report = "keep";
 		}
 	}
diff --git a/pack-write.c b/pack-write.c
index 3621f1d..e82c025 100644
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
@@ -239,7 +237,7 @@ char *index_pack_lockfile(int ip_out)
 	char packname[46];
 
 	/*
-	 * The first thing we expects from index-pack's output
+	 * The first thing we expect from index-pack's output
 	 * is "pack\t%40s\n" or "keep\t%40s\n" (46 bytes) where
 	 * %40s is the newly created pack SHA1 name.  In the "keep"
 	 * case, we need it to remove the corresponding .keep file
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 2852a03..73d871c 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -180,6 +180,23 @@ test_expect_success \
 
 unset GIT_OBJECT_DIRECTORY
 
+test_expect_success 'survive missing objects/pack directory' '
+	(
+		rm -fr missing-pack &&
+		mkdir missing-pack &&
+		cd missing-pack &&
+		git init &&
+		GOP=.git/objects/pack
+		rm -fr $GOP &&
+		git index-pack --stdin --keep=test <../test-3-${packname_3}.pack &&
+		test -f $GOP/pack-${packname_3}.pack &&
+		test_cmp $GOP/pack-${packname_3}.pack ../test-3-${packname_3}.pack &&
+		test -f $GOP/pack-${packname_3}.idx &&
+		test_cmp $GOP/pack-${packname_3}.idx ../test-3-${packname_3}.idx &&
+		test -f $GOP/pack-${packname_3}.keep
+	)
+'
+
 test_expect_success \
     'verify pack' \
     'git verify-pack	test-1-${packname_1}.idx \
diff --git a/wrapper.c b/wrapper.c
index 93562f0..231a58f 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -196,3 +196,35 @@ int xmkstemp(char *template)
 		die("Unable to create temporary file: %s", strerror(errno));
 	return fd;
 }
+
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
+int odb_pack_keep(char *name, size_t namesz, unsigned char *sha1)
+{
+	int fd;
+
+	snprintf(name, namesz, "%s/pack/pack-%s.keep",
+		 get_object_directory(), sha1_to_hex(sha1));
+	fd = open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
+	if (0 <= fd)
+		return fd;
+
+	/* slow path */
+	safe_create_leading_directories(name);
+	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
+}
-- 
1.6.2.rc1.113.ga620b
