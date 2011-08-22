From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH 1/2] clone: allow to clone from .git file
Date: Mon, 22 Aug 2011 14:01:30 -0700
Message-ID: <7vty99upn9.fsf_-_@alter.siamese.dyndns.org>
References: <1313927890-21227-1-git-send-email-pclouds@gmail.com>
 <7v7h66y4s5.fsf@alter.siamese.dyndns.org>
 <CACsJy8BaCwT+fd-KORsqXqQEtWZUpTDwgoSGU9+pMfNdero5=Q@mail.gmail.com>
 <7vbovhw9pb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 23:01:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvbcp-0000kN-01
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 23:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528Ab1HVVBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 17:01:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40580 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086Ab1HVVBd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 17:01:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CD9C4552;
	Mon, 22 Aug 2011 17:01:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fSqXAdQ9CyvIQixVulPAxMs5rhk=; b=dTL3dA
	HWvWgmBis7TpugNuL/15ZFKH/nJec9daqqFPkepjSNDekEjXSh8CCIWaaAwt2NIX
	wzoEs0sSvMlmrXr5EdAsG8LQjcycEBW0Ftu1GH6lO3T3M0ayjiRZ/wnC2D47CN8p
	X1eCcWz6E/ZvQ/0Ml7Fkzj3tschiLSoQkZYnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lK6MxSHabxFBVzLVkH9MMfn5AGtCP2nh
	ltmU0TyS1BJr1QrSrvi/yegATvhAFhVeHNINma0uIGNUvtYOcbxYUXppBb0aKEvz
	oksAjopPkDws7RIEqb9VVXPGe0HQBMVrRuSM3fUJgNcDMrXXC89F8MVwsadDt7js
	bq1BWZWUpkU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74AD14551;
	Mon, 22 Aug 2011 17:01:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6EE0B4550; Mon, 22 Aug 2011
 17:01:31 -0400 (EDT)
In-Reply-To: <7vbovhw9pb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 22 Aug 2011 12:02:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E95829E8-CD01-11E0-A731-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179890>

Junio C Hamano <gitster@pobox.com> writes:

> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>>> Didn't somebody add "is this '.git' thing a valid git metadirectory?" API
>>> quite recently for exactly this?
>>
>> You mean resolve_gitdir() in abc0682 (rev-parse: add option
>> --resolve-git-dir <path> - 2011-08-15)? That function would barf on a
>> bundle file.
>
> Well, then it has to be fixed, perhaps to return NULL instead as other
> failure cases, as read_gitfile_GENTLY() should be gentle to the callers so
> that they can notice error cases and deal with them themselves.

The attached patch would be such a fix. While I think it is a necessary
thing to do independently from the issue you are trying to solve, I do not
think it is appropriate, as it tries to _read_ the whole thing before
deciding if it is a valid gitfile. You need a way to cheaply probe if it
is a bundle or a gitfile without reading the whole thing for your topic.

-- >8 --
Subject: [PATCH] fix misnamed read_gitfile_gently()

The function was not gentle at all to the callers and died without giving
them a chance to deal with possible errors. Rename it to read_gitfile(),
update all the callers, and add "gently" variant.

As nobody needs gently variant right now, it may be a good idea to just
rename the function without any other change for now, though...

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin/init-db.c |    2 +-
 cache.h           |    9 +++++++-
 environment.c     |    2 +-
 path.c            |    2 +-
 refs.c            |    2 +-
 setup.c           |   59 ++++++++++++++++++++++++++++++++++++++++------------
 submodule.c       |    6 ++--
 7 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 025aa47..d07554c 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -347,7 +347,7 @@ static void separate_git_dir(const char *git_dir)
 		const char *src;
 
 		if (S_ISREG(st.st_mode))
-			src = read_gitfile_gently(git_link);
+			src = read_gitfile(git_link);
 		else if (S_ISDIR(st.st_mode))
 			src = git_link;
 		else
diff --git a/cache.h b/cache.h
index e11cf6a..9ce04a5 100644
--- a/cache.h
+++ b/cache.h
@@ -420,7 +420,14 @@ extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
 extern const char *get_git_work_tree(void);
-extern const char *read_gitfile_gently(const char *path);
+extern const char *read_gitfile(const char *path);
+enum {
+	ERROR_READ_GITFILE_CANTOPEN = 1,
+	ERROR_READ_GITFILE_READFAIL,
+	ERROR_READ_GITFILE_FORMAT,
+	ERROR_READ_GITFILE_BADDIR
+};
+extern const char *read_gitfile_gently(const char *path, int *status);
 extern void set_git_work_tree(const char *tree);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
diff --git a/environment.c b/environment.c
index 94d58fd..2228c4e 100644
--- a/environment.c
+++ b/environment.c
@@ -91,7 +91,7 @@ static void setup_git_env(void)
 	git_dir = getenv(GIT_DIR_ENVIRONMENT);
 	git_dir = git_dir ? xstrdup(git_dir) : NULL;
 	if (!git_dir) {
-		git_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
+		git_dir = read_gitfile(DEFAULT_GIT_DIR_ENVIRONMENT);
 		git_dir = git_dir ? xstrdup(git_dir) : NULL;
 	}
 	if (!git_dir)
diff --git a/path.c b/path.c
index 4d73cc9..6f3f5d5 100644
--- a/path.c
+++ b/path.c
@@ -139,7 +139,7 @@ char *git_path_submodule(const char *path, const char *fmt, ...)
 		strbuf_addch(&buf, '/');
 	strbuf_addstr(&buf, ".git");
 
-	git_dir = read_gitfile_gently(buf.buf);
+	git_dir = read_gitfile(buf.buf);
 	if (git_dir) {
 		strbuf_reset(&buf);
 		strbuf_addstr(&buf, git_dir);
diff --git a/refs.c b/refs.c
index b10419a..c98c006 100644
--- a/refs.c
+++ b/refs.c
@@ -451,7 +451,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *re
 	memcpy(gitdir + len, "/.git", 6);
 	len += 5;
 
-	tmp = read_gitfile_gently(gitdir);
+	tmp = read_gitfile(gitdir);
 	if (tmp) {
 		free(gitdir);
 		len = strlen(tmp);
diff --git a/setup.c b/setup.c
index ce87900..1f4d8dd 100644
--- a/setup.c
+++ b/setup.c
@@ -373,9 +373,11 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
 
 /*
  * Try to read the location of the git directory from the .git file,
- * return path to git directory if found.
+ * return path to git directory if found. Pass a pointer to an int
+ * to receive error code and handle error yourself, or NULL to get
+ * this function die for you on errors.
  */
-const char *read_gitfile_gently(const char *path)
+const char *read_gitfile_gently(const char *path, int *status)
 {
 	char *buf;
 	char *dir;
@@ -389,20 +391,39 @@ const char *read_gitfile_gently(const char *path)
 	if (!S_ISREG(st.st_mode))
 		return NULL;
 	fd = open(path, O_RDONLY);
-	if (fd < 0)
-		die_errno("Error opening '%s'", path);
+	if (fd < 0) {
+		if (!status)
+			die_errno("Error opening '%s'", path);
+		*status = ERROR_READ_GITFILE_CANTOPEN;
+		return NULL;
+	}
 	buf = xmalloc(st.st_size + 1);
 	len = read_in_full(fd, buf, st.st_size);
 	close(fd);
-	if (len != st.st_size)
-		die("Error reading %s", path);
+	if (len != st.st_size) {
+		if (!status)
+			die("Error reading %s", path);
+		*status = ERROR_READ_GITFILE_READFAIL;
+		free(buf);
+		return NULL;
+	}
 	buf[len] = '\0';
-	if (prefixcmp(buf, "gitdir: "))
-		die("Invalid gitfile format: %s", path);
+	if (prefixcmp(buf, "gitdir: ")) {
+		if (!status)
+			die("Invalid gitfile format: %s", path);
+		*status = ERROR_READ_GITFILE_FORMAT;
+		free(buf);
+		return NULL;
+	}
 	while (buf[len - 1] == '\n' || buf[len - 1] == '\r')
 		len--;
-	if (len < 9)
-		die("No path in gitfile: %s", path);
+	if (len < 9) {
+		if (!status)
+			die("No path in gitfile: %s", path);
+		*status = ERROR_READ_GITFILE_FORMAT;
+		free(buf);
+		return NULL;
+	}
 	buf[len] = '\0';
 	dir = buf + 8;
 
@@ -417,14 +438,24 @@ const char *read_gitfile_gently(const char *path)
 		buf = dir;
 	}
 
-	if (!is_git_directory(dir))
-		die("Not a git repository: %s", dir);
+	if (!is_git_directory(dir)) {
+		if (!status)
+			die("Not a git repository: %s", dir);
+		*status = ERROR_READ_GITFILE_BADDIR;
+		free(buf);
+		return NULL;
+	}
 	path = real_path(dir);
 
 	free(buf);
 	return path;
 }
 
+const char *read_gitfile(const char *path)
+{
+	return read_gitfile_gently(path, NULL);
+}
+
 static const char *setup_explicit_git_dir(const char *gitdirenv,
 					  char *cwd, int len,
 					  int *nongit_ok)
@@ -437,7 +468,7 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 	if (PATH_MAX - 40 < strlen(gitdirenv))
 		die("'$%s' too big", GIT_DIR_ENVIRONMENT);
 
-	gitfile = (char*)read_gitfile_gently(gitdirenv);
+	gitfile = (char*)read_gitfile(gitdirenv);
 	if (gitfile) {
 		gitfile = xstrdup(gitfile);
 		gitdirenv = gitfile;
@@ -661,7 +692,7 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 	if (one_filesystem)
 		current_device = get_device_or_die(".", NULL);
 	for (;;) {
-		gitfile = (char*)read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
+		gitfile = (char*)read_gitfile(DEFAULT_GIT_DIR_ENVIRONMENT);
 		if (gitfile)
 			gitdirenv = gitfile = xstrdup(gitfile);
 		else {
diff --git a/submodule.c b/submodule.c
index b6dec70..b8b0326 100644
--- a/submodule.c
+++ b/submodule.c
@@ -32,7 +32,7 @@ static int add_submodule_odb(const char *path)
 	const char *git_dir;
 
 	strbuf_addf(&objects_directory, "%s/.git", path);
-	git_dir = read_gitfile_gently(objects_directory.buf);
+	git_dir = read_gitfile(objects_directory.buf);
 	if (git_dir) {
 		strbuf_reset(&objects_directory);
 		strbuf_addstr(&objects_directory, git_dir);
@@ -478,7 +478,7 @@ int fetch_populated_submodules(int num_options, const char **options,
 		strbuf_addf(&submodule_path, "%s/%s", work_tree, ce->name);
 		strbuf_addf(&submodule_git_dir, "%s/.git", submodule_path.buf);
 		strbuf_addf(&submodule_prefix, "%s%s/", prefix, ce->name);
-		git_dir = read_gitfile_gently(submodule_git_dir.buf);
+		git_dir = read_gitfile(submodule_git_dir.buf);
 		if (!git_dir)
 			git_dir = submodule_git_dir.buf;
 		if (is_directory(git_dir)) {
@@ -516,7 +516,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	const char *git_dir;
 
 	strbuf_addf(&buf, "%s/.git", path);
-	git_dir = read_gitfile_gently(buf.buf);
+	git_dir = read_gitfile(buf.buf);
 	if (!git_dir)
 		git_dir = buf.buf;
 	if (!is_directory(git_dir)) {
