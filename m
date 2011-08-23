From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] clone: clone from a repository with relative alternates
Date: Mon, 22 Aug 2011 18:05:16 -0700
Message-ID: <1314061516-24964-3-git-send-email-gitster@pobox.com>
References: <7vliulun2a.fsf@alter.siamese.dyndns.org>
 <1314061516-24964-1-git-send-email-gitster@pobox.com>
Cc: Hui Wang <jason77.wang@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 03:05:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvfQu-0006WG-Ue
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 03:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754761Ab1HWBFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 21:05:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50567 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754695Ab1HWBFX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 21:05:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AF9C4AB3;
	Mon, 22 Aug 2011 21:05:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=vViG
	OKbGsPxdTKtvr8jpjxd2E1U=; b=v7zh/OXrwa8/eTMalNuiXu0L2QvdUXjNIGRe
	bWrPqXBlE1R/RW8/bI4qYYzi2zr3adz9Wv5bk5jJ69xvn7MKdygCg4OxqXjz36Z4
	bphnvTInzUhNVp4k7XTQ5ZAPVVmX6he7QqhGSBxKEOM8gvznA07YUbEo2/HoZsa0
	Mx5UwE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	P7UT6YP2jtyMV/euDszLQyUkvYwRNhfsQndnZHDUBdaZgZ/TEXi8skLEuIypZw+2
	l6WMvZgkQUV/OrMg6kM7fnSHBvpq+k0tCmU5pNV5ZNr7cqiVK+Fg1uhTHK5d0YLN
	In/CtznadZPKQGRpgNXbbJ/8ExkiOeoLLL8oDQjKGYI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92CFC4AB2;
	Mon, 22 Aug 2011 21:05:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E32144AB0; Mon, 22 Aug 2011
 21:05:21 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.557.gcee42
In-Reply-To: <1314061516-24964-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: F9C972F6-CD23-11E0-BC32-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179910>

Cloning from a local repository blindly copies or hardlinks all the files
under objects/ hierarchy. This results in two issues:

 - If the repository cloned has an "objects/info/alternates" file, and the
   command line of clone specifies --reference, the ones specified on the
   command line get overwritten by the copy from the original repository.

 - An entry in a "objects/info/alternates" file can specify the object
   stores it borrows objects from as a path relative to the "objects/"
   directory. When cloning a repository with such an alternates file, if
   the new repository is not sitting next to the original repository, such
   relative paths needs to be adjusted so that they can be used in the new
   repository.

This updates add_to_alternates_file() to take the path to the alternate
object store, including the "/objects" part at the end (earlier, it was
taking the path to $GIT_DIR and was adding "/objects" itself), as it is
technically possible to specify in objects/info/alternates file the path
of a directory whose name does not end with "/objects".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clone.c  |   52 ++++++++++++++++++++++++++++++++++++++++------------
 sha1_file.c      |    2 +-
 t/t5601-clone.sh |   10 +++++++++-
 3 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index ee5d651..2842707 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -210,8 +210,7 @@ static void strip_trailing_slashes(char *dir)
 static int add_one_reference(struct string_list_item *item, void *cb_data)
 {
 	const char *ref_git;
-	char *ref_git_copy;
-
+	struct strbuf alternate = STRBUF_INIT;
 	struct remote *remote;
 	struct transport *transport;
 	const struct ref *extra;
@@ -224,19 +223,17 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
 		die(_("reference repository '%s' is not a local directory."),
 		    item->string);
 
-	ref_git_copy = xstrdup(ref_git);
-
-	add_to_alternates_file(ref_git_copy);
+	strbuf_addf(&alternate, "%s/objects", ref_git);
+	add_to_alternates_file(alternate.buf);
+	strbuf_release(&alternate);
 
-	remote = remote_get(ref_git_copy);
-	transport = transport_get(remote, ref_git_copy);
+	remote = remote_get(ref_git);
+	transport = transport_get(remote, ref_git);
 	for (extra = transport_get_remote_refs(transport); extra;
 	     extra = extra->next)
 		add_extra_ref(extra->name, extra->old_sha1, 0);
 
 	transport_disconnect(transport);
-
-	free(ref_git_copy);
 	return 0;
 }
 
@@ -245,7 +242,32 @@ static void setup_reference(void)
 	for_each_string_list(&option_reference, add_one_reference, NULL);
 }
 
-static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest)
+static void copy_alternates(struct strbuf *src, struct strbuf *dst,
+			    const char *src_repo)
+{
+	/*
+	 * Read from the source objects/info/alternates file
+	 * and copy the entries to corresponding file in the
+	 * destination repository with add_to_alternates_file().
+	 * Both src and dst have "$path/objects/info/alternates".
+	 */
+	FILE *in = fopen(src->buf, "r");
+	struct strbuf line = STRBUF_INIT;
+
+	while (strbuf_getline(&line, in, '\n') != EOF) {
+		char *abs_path, abs_buf[PATH_MAX];
+		if (!line.len || line.buf[0] == '#')
+			continue;
+		abs_path = mkpath("%s/objects/%s", src_repo, line.buf);
+		normalize_path_copy(abs_buf, abs_path);
+		add_to_alternates_file(abs_buf);
+	}
+	strbuf_release(&line);
+	fclose(in);
+}
+
+static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
+				   const char *src_repo, int src_baselen)
 {
 	struct dirent *de;
 	struct stat buf;
@@ -281,7 +303,13 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest)
 		}
 		if (S_ISDIR(buf.st_mode)) {
 			if (de->d_name[0] != '.')
-				copy_or_link_directory(src, dest);
+				copy_or_link_directory(src, dest,
+						       src_repo, src_baselen);
+			continue;
+		}
+
+		if (!strcmp(src->buf + src_baselen, "/info/alternates")) {
+			copy_alternates(src, dest, src_repo);
 			continue;
 		}
 
@@ -314,7 +342,7 @@ static const struct ref *clone_local(const char *src_repo,
 	else {
 		strbuf_addf(&src, "%s/objects", src_repo);
 		strbuf_addf(&dest, "%s/objects", dest_repo);
-		copy_or_link_directory(&src, &dest);
+		copy_or_link_directory(&src, &dest, src_repo, src.len);
 		strbuf_release(&src);
 		strbuf_release(&dest);
 	}
diff --git a/sha1_file.c b/sha1_file.c
index 064a330..f7c3408 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -380,7 +380,7 @@ void add_to_alternates_file(const char *reference)
 {
 	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 	int fd = hold_lock_file_for_append(lock, git_path("objects/info/alternates"), LOCK_DIE_ON_ERROR);
-	char *alt = mkpath("%s/objects\n", reference);
+	char *alt = mkpath("%s\n", reference);
 	write_or_die(fd, alt, strlen(alt));
 	if (commit_lock_file(lock))
 		die("could not close alternates file");
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 0163ad1..d87214c 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -207,7 +207,7 @@ test_expect_success 'clone separate gitdir where target already exists' '
 	test_must_fail git clone --separate-git-dir realgitdir src dst
 '
 
-test_expect_failure 'clone --reference from original' '
+test_expect_success 'clone --reference from original' '
 	git clone --shared --bare src src-1 &&
 	git clone --bare src src-2 &&
 	git clone --reference=src-2 --bare src-1 target-8 &&
@@ -222,4 +222,12 @@ test_expect_success 'clone with more than one --reference' '
 	grep /src-4/ target-9/.git/objects/info/alternates
 '
 
+test_expect_success 'clone from original with relative alternate' '
+	mkdir nest &&
+	git clone --bare src nest/src-5 &&
+	echo ../../../src/.git/objects >nest/src-5/objects/info/alternates &&
+	git clone --bare nest/src-5 target-10 &&
+	grep /src/\\.git/objects target-10/objects/info/alternates
+'
+
 test_done
-- 
1.7.6.557.gcee42
