From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Misfeature] cloning without configuration fails and returns 0
Date: Sat, 08 Dec 2007 17:32:08 -0800
Message-ID: <7vzlwktzzb.fsf@gitster.siamese.dyndns.org>
References: <9438BB94-AE9C-4F4E-A4DA-8E2121642736@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Sun Dec 09 02:32:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1B2F-0003Ze-7m
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 02:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbXLIBcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 20:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbXLIBcY
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 20:32:24 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:64702 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbXLIBcX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 20:32:23 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BE254097;
	Sat,  8 Dec 2007 20:32:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 998C24095;
	Sat,  8 Dec 2007 20:32:11 -0500 (EST)
In-Reply-To: <9438BB94-AE9C-4F4E-A4DA-8E2121642736@lrde.epita.fr> (Benoit
	Sigoure's message of "Sat, 8 Dec 2007 23:21:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67580>

Benoit Sigoure <tsuna@lrde.epita.fr> writes:

> on a new machine I have access to, I fetched tonight's git master (git
> version 1.5.3.7.g9758e) and installed it on my account in order  to
> clone one of my projects.  I did not setup anything in my git config
> and stumbled on the following misfeature:

This is not a misfeature but an outright bug in an earlier fix to 
13208572fbe8838fd8835548d7502202d1f7b21d (builtin-commit: fix --signoff)

Can you try this and see if it works for you?

-- >8 --
Re-fix "builtin-commit: fix --signoff"

An earlier fix to the said commit was incomplete; it mixed up the
meaning of the flag parameter passed to the internal fmt_ident()
function, so this corrects it.

git_author_info() and git_committer_info() can be told to issue a
warning when no usable user information is found, and optionally can be
told to error out.  Operations that actually use the information to
record a new commit or a tag will still error out, but the caller to
leave reflog record will just silently use bogus user information.

Not warning on misconfigured user information while writing a reflog
entry is somewhat debatable, but it is probably nicer to the users to
silently let it pass, because the only information you are losing is who
checked out the branch.

 * git_author_info() and git_committer_info() used to take 1 (positive
   int) to error out with a warning on misconfiguration; this is now
   signalled with a symbolic constant IDENT_ERROR_ON_NO_NAME.

 * These functions used to take -1 (negative int) to warn but continue;
   this is now signalled with a symbolic constant IDENT_WARN_ON_NO_NAME.

 * fmt_ident() function implements the above error reporting behaviour
   common to git_author_info() and git_committer_info().  A symbolic
   constant IDENT_NO_DATE can be or'ed in to the flag parameter to make
   it return only the "Name <email@address.xz>".

 * fmt_name() is a thin wrapper around fmt_ident() that always passes
   IDENT_ERROR_ON_NO_NAME and IDENT_NO_DATE.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin-commit-tree.c |    4 ++--
 builtin-commit.c      |    4 ++--
 builtin-log.c         |    4 ++--
 builtin-tag.c         |    4 ++--
 cache.h               |    3 +++
 ident.c               |   30 ++++++++++++------------------
 refs.c                |    2 +-
 var.c                 |    4 ++--
 8 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 88b0ab3..6610d18 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -98,8 +98,8 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&buffer, "parent %s\n", sha1_to_hex(parent_sha1[i]));
 
 	/* Person/date information */
-	strbuf_addf(&buffer, "author %s\n", git_author_info(1));
-	strbuf_addf(&buffer, "committer %s\n", git_committer_info(1));
+	strbuf_addf(&buffer, "author %s\n", git_author_info(IDENT_ERROR_ON_NO_NAME));
+	strbuf_addf(&buffer, "committer %s\n", git_committer_info(IDENT_ERROR_ON_NO_NAME));
 	if (!encoding_is_utf8)
 		strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);
 	strbuf_addch(&buffer, '\n');
diff --git a/builtin-commit.c b/builtin-commit.c
index 19297ac..a7e8d4a 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -497,7 +497,7 @@ static void determine_author_info(struct strbuf *sb)
 		email = xstrndup(lb + 2, rb - (lb + 2));
 	}
 
-	strbuf_addf(sb, "author %s\n", fmt_ident(name, email, date, 1));
+	strbuf_addf(sb, "author %s\n", fmt_ident(name, email, date, IDENT_ERROR_ON_NO_NAME));
 }
 
 static int parse_and_validate_options(int argc, const char *argv[],
@@ -776,7 +776,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	}
 
 	determine_author_info(&sb);
-	strbuf_addf(&sb, "committer %s\n", git_committer_info(1));
+	strbuf_addf(&sb, "committer %s\n", git_committer_info(IDENT_ERROR_ON_NO_NAME));
 	if (!is_encoding_utf8(git_commit_encoding))
 		strbuf_addf(&sb, "encoding %s\n", git_commit_encoding);
 	strbuf_addch(&sb, '\n');
diff --git a/builtin-log.c b/builtin-log.c
index e1f1cf6..b6a1122 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -557,7 +557,7 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids, const cha
 
 static void gen_message_id(char *dest, unsigned int length, char *base)
 {
-	const char *committer = git_committer_info(-1);
+	const char *committer = git_committer_info(IDENT_WARN_ON_NO_NAME);
 	const char *email_start = strrchr(committer, '<');
 	const char *email_end = strrchr(committer, '>');
 	if(!email_start || !email_end || email_start > email_end - 1)
@@ -665,7 +665,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			 !strcmp(argv[i], "-s")) {
 			const char *committer;
 			const char *endpos;
-			committer = git_committer_info(1);
+			committer = git_committer_info(IDENT_ERROR_ON_NO_NAME);
 			endpos = strchr(committer, '>');
 			if (!endpos)
 				die("bogos committer info %s\n", committer);
diff --git a/builtin-tag.c b/builtin-tag.c
index 729389b..36a5e9d 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -186,7 +186,7 @@ static int do_sign(struct strbuf *buffer)
 	int len;
 
 	if (!*signingkey) {
-		if (strlcpy(signingkey, git_committer_info(1),
+		if (strlcpy(signingkey, git_committer_info(IDENT_ERROR_ON_NO_NAME),
 				sizeof(signingkey)) > sizeof(signingkey) - 1)
 			return error("committer info too long.");
 		bracket = strchr(signingkey, '>');
@@ -296,7 +296,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 			  sha1_to_hex(object),
 			  typename(type),
 			  tag,
-			  git_committer_info(1));
+			  git_committer_info(IDENT_ERROR_ON_NO_NAME));
 
 	if (header_len > sizeof(header_buf) - 1)
 		die("tag header too big.");
diff --git a/cache.h b/cache.h
index 406befb..c6142e9 100644
--- a/cache.h
+++ b/cache.h
@@ -453,6 +453,9 @@ void datestamp(char *buf, int bufsize);
 unsigned long approxidate(const char *);
 enum date_mode parse_date_format(const char *format);
 
+#define IDENT_WARN_ON_NO_NAME  1
+#define IDENT_ERROR_ON_NO_NAME 2
+#define IDENT_NO_DATE	       4
 extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
 extern const char *fmt_ident(const char *name, const char *email, const char *date_str, int);
diff --git a/ident.c b/ident.c
index 7631698..892d77a 100644
--- a/ident.c
+++ b/ident.c
@@ -182,14 +182,15 @@ static const char *env_hint =
 "Omit --global to set the identity only in this repository.\n"
 "\n";
 
-static const char *fmt_ident_1(const char *name, const char *email,
-			       const char *date_str, int flag)
+const char *fmt_ident(const char *name, const char *email,
+		      const char *date_str, int flag)
 {
 	static char buffer[1000];
 	char date[50];
 	int i;
-	int error_on_no_name = !!(flag & 01);
-	int name_addr_only = !!(flag & 02);
+	int error_on_no_name = (flag & IDENT_ERROR_ON_NO_NAME);
+	int warn_on_no_name = (flag & IDENT_WARN_ON_NO_NAME);
+	int name_addr_only = (flag & IDENT_NO_DATE);
 
 	setup_ident();
 	if (!name)
@@ -200,12 +201,12 @@ static const char *fmt_ident_1(const char *name, const char *email,
 	if (!*name) {
 		struct passwd *pw;
 
-		if (0 <= error_on_no_name &&
+		if ((warn_on_no_name || error_on_no_name) &&
 		    name == git_default_name && env_hint) {
 			fprintf(stderr, env_hint, au_env, co_env);
 			env_hint = NULL; /* warn only once, for "git-var -l" */
 		}
-		if (0 < error_on_no_name)
+		if (error_on_no_name)
 			die("empty ident %s <%s> not allowed", name, email);
 		pw = getpwuid(getuid());
 		if (!pw)
@@ -234,30 +235,23 @@ static const char *fmt_ident_1(const char *name, const char *email,
 	return buffer;
 }
 
-const char *fmt_ident(const char *name, const char *email,
-		      const char *date_str, int error_on_no_name)
-{
-	int flag = (error_on_no_name ? 01 : 0);
-	return fmt_ident_1(name, email, date_str, flag);
-}
-
 const char *fmt_name(const char *name, const char *email)
 {
-	return fmt_ident_1(name, email, NULL, 03);
+	return fmt_ident(name, email, NULL, IDENT_ERROR_ON_NO_NAME | IDENT_NO_DATE);
 }
 
-const char *git_author_info(int error_on_no_name)
+const char *git_author_info(int flag)
 {
 	return fmt_ident(getenv("GIT_AUTHOR_NAME"),
 			 getenv("GIT_AUTHOR_EMAIL"),
 			 getenv("GIT_AUTHOR_DATE"),
-			 error_on_no_name);
+			 flag);
 }
 
-const char *git_committer_info(int error_on_no_name)
+const char *git_committer_info(int flag)
 {
 	return fmt_ident(getenv("GIT_COMMITTER_NAME"),
 			 getenv("GIT_COMMITTER_EMAIL"),
 			 getenv("GIT_COMMITTER_DATE"),
-			 error_on_no_name);
+			 flag);
 }
diff --git a/refs.c b/refs.c
index 3e6e98c..759924d 100644
--- a/refs.c
+++ b/refs.c
@@ -1094,7 +1094,7 @@ static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
 	adjust_shared_perm(log_file);
 
 	msglen = msg ? strlen(msg) : 0;
-	committer = git_committer_info(-1);
+	committer = git_committer_info(0);
 	maxlen = strlen(committer) + msglen + 100;
 	logrec = xmalloc(maxlen);
 	len = sprintf(logrec, "%s %s %s\n",
diff --git a/var.c b/var.c
index 4127031..0de0efa 100644
--- a/var.c
+++ b/var.c
@@ -21,7 +21,7 @@ static void list_vars(void)
 {
 	struct git_var *ptr;
 	for(ptr = git_vars; ptr->read; ptr++) {
-		printf("%s=%s\n", ptr->name, ptr->read(0));
+		printf("%s=%s\n", ptr->name, ptr->read(IDENT_WARN_ON_NO_NAME));
 	}
 }
 
@@ -32,7 +32,7 @@ static const char *read_var(const char *var)
 	val = NULL;
 	for(ptr = git_vars; ptr->read; ptr++) {
 		if (strcmp(var, ptr->name) == 0) {
-			val = ptr->read(1);
+			val = ptr->read(IDENT_ERROR_ON_NO_NAME);
 			break;
 		}
 	}
