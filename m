From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3] config: make git_config_set die on failure
Date: Mon,  1 Feb 2016 11:59:54 +0100
Message-ID: <1454324394-854-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	ps@pks.im
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 01 12:00:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQCDM-00021o-DW
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 12:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbcBALAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 06:00:01 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60663 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753009AbcBAK77 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Feb 2016 05:59:59 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 7ACFF2F2C6
	for <git@vger.kernel.org>; Mon,  1 Feb 2016 05:59:58 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 01 Feb 2016 05:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=PB0Cnqe1f+B0SizrEyWlpNUSnc
	M=; b=qVBNBZ1MPTrQRCP2zXhoUazh4H5upl08Z63+rdDSaDEVpp/Fjx2Kbp3JOS
	lhGu8JXz5SorOOe/WaJ/oyhRdbhDDQ332wtevhHS+PkSdge+nKWzGTpBrSCqPeY6
	vlzjD8J8ThUo+yJUZw192gsR6JsUYRAmPdh2kPdkEAlZCCAh0=
X-Sasl-enc: IPTbSzFuCflgJDqGhLho8dIn8moi1LDldGAGylL3Plhb 1454324397
Received: from localhost (p57a9b049.dip0.t-ipconnect.de [87.169.176.73])
	by mail.messagingengine.com (Postfix) with ESMTPA id D060C6801A1;
	Mon,  1 Feb 2016 05:59:57 -0500 (EST)
X-Mailer: git-send-email 2.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285198>

Failure to write the configuration file may be caused by multiple
conditions, the most common one being the case where the
configuration is locked because of a leftover lock file or
because another process is currently writing to it. We used to
ignore those errors in many cases, possibly leading to
inconsistently configured repositories. More often than not git
even pretended that everything was fine and that the settings
have been applied when indeed they were not.

Handle these failures by dying by default whenever an error is
occured by the `git_config_set` family of functions. Introduce a
new set of functions `git_config_set_gently` that instead returns
an error code for the cases where we are required to explicitly
handle configuration errors.
---

In contrast to the old version ([1]) this version of the patch
introduces a set of functions `git_config_set_gently` instead of
`git_config_set_or_die`, thus going the other route of dying by
default.

It first seemed that going the default-die route instead of
or_die-wrappers might prove to be more contained and easier to
grasp. Seeing the result, though, I'm not convinced of this
anymore. This is a minimal compiling example without even caring
about test failures, which do occur now.

Previously in v2 we had a diffstat of +127/-55 lines where we now
have +88/-82, which amounts to roughly the same amount of lines
changed. The previous approach, though, was much easier to grasp
in my opinion as nearly all changes could be split up instead of
requiring one big change to make it compile. As said before, this
does not yet include the changes required for handling test
failures, thus the patch is expected to become bigger rather than
smaller.

Furthermore, I do think it's more explicit what the functions are
doing when there is a 'or_die' suffix. Without this suffix it may
be unexpected that the functions simply abort the program
whenever an error occurs.

I'd thus prefer to use the old style used in version 2. I could
try to make the second patch ([2]) a little bit smaller by
avoiding all the fuss about passing up the error code only to die
a little later.

Opinions?

Patrick

[1]: http://article.gmane.org/gmane.comp.version-control.git/285000
[2]: http://thread.gmane.org/gmane.comp.version-control.git/285002

 builtin/branch.c |  2 +-
 builtin/clone.c  |  2 +-
 builtin/config.c | 28 +++++++++++------------
 builtin/remote.c | 70 ++++++++++++++++++--------------------------------------
 cache.h          | 12 ++++++----
 config.c         | 46 ++++++++++++++++++++++++++++++-------
 submodule.c      | 10 ++++----
 7 files changed, 88 insertions(+), 82 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 3f6c825..461eebb 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -595,7 +595,7 @@ static int edit_branch_description(const char *branch_name)
 	strbuf_stripspace(&buf, 1);
 
 	strbuf_addf(&name, "branch.%s.description", branch_name);
-	status = git_config_set(name.buf, buf.len ? buf.buf : NULL);
+	git_config_set(name.buf, buf.len ? buf.buf : NULL);
 	strbuf_release(&name);
 	strbuf_release(&buf);
 
diff --git a/builtin/clone.c b/builtin/clone.c
index a7c8def..8c01975 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -735,7 +735,7 @@ static int checkout(void)
 
 static int write_one_config(const char *key, const char *value, void *data)
 {
-	return git_config_set_multivar(key, value ? value : "true", "^$", 0);
+	return git_config_set_multivar_gently(key, value ? value : "true", "^$", 0);
 }
 
 static void write_config(struct string_list *config)
diff --git a/builtin/config.c b/builtin/config.c
index adc7727..c26d6e7 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -582,7 +582,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_write();
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
-		ret = git_config_set_in_file(given_config_source.file, argv[0], value);
+		ret = git_config_set_in_file_gently(given_config_source.file, argv[0], value);
 		if (ret == CONFIG_NOTHING_SET)
 			error("cannot overwrite multiple values with a single value\n"
 			"       Use a regexp, --add or --replace-all to change %s.", argv[0]);
@@ -592,23 +592,23 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_write();
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1]);
-		return git_config_set_multivar_in_file(given_config_source.file,
-						       argv[0], value, argv[2], 0);
+		return git_config_set_multivar_in_file_gently(given_config_source.file,
+							      argv[0], value, argv[2], 0);
 	}
 	else if (actions == ACTION_ADD) {
 		check_write();
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
-		return git_config_set_multivar_in_file(given_config_source.file,
-						       argv[0], value,
-						       CONFIG_REGEX_NONE, 0);
+		return git_config_set_multivar_in_file_gently(given_config_source.file,
+							      argv[0], value,
+							      CONFIG_REGEX_NONE, 0);
 	}
 	else if (actions == ACTION_REPLACE_ALL) {
 		check_write();
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1]);
-		return git_config_set_multivar_in_file(given_config_source.file,
-						       argv[0], value, argv[2], 1);
+		return git_config_set_multivar_in_file_gently(given_config_source.file,
+							      argv[0], value, argv[2], 1);
 	}
 	else if (actions == ACTION_GET) {
 		check_argc(argc, 1, 2);
@@ -634,17 +634,17 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_write();
 		check_argc(argc, 1, 2);
 		if (argc == 2)
-			return git_config_set_multivar_in_file(given_config_source.file,
-							       argv[0], NULL, argv[1], 0);
+			return git_config_set_multivar_in_file_gently(given_config_source.file,
+								      argv[0], NULL, argv[1], 0);
 		else
-			return git_config_set_in_file(given_config_source.file,
-						      argv[0], NULL);
+			return git_config_set_in_file_gently(given_config_source.file,
+							     argv[0], NULL);
 	}
 	else if (actions == ACTION_UNSET_ALL) {
 		check_write();
 		check_argc(argc, 1, 2);
-		return git_config_set_multivar_in_file(given_config_source.file,
-						       argv[0], NULL, argv[1], 1);
+		return git_config_set_multivar_in_file_gently(given_config_source.file,
+							      argv[0], NULL, argv[1], 1);
 	}
 	else if (actions == ACTION_RENAME_SECTION) {
 		int ret;
diff --git a/builtin/remote.c b/builtin/remote.c
index 2b2ff9b..05d665f 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -108,7 +108,7 @@ enum {
 #define MIRROR_PUSH 2
 #define MIRROR_BOTH (MIRROR_FETCH|MIRROR_PUSH)
 
-static int add_branch(const char *key, const char *branchname,
+static void add_branch(const char *key, const char *branchname,
 		const char *remotename, int mirror, struct strbuf *tmp)
 {
 	strbuf_reset(tmp);
@@ -119,7 +119,7 @@ static int add_branch(const char *key, const char *branchname,
 	else
 		strbuf_addf(tmp, "refs/heads/%s:refs/remotes/%s/%s",
 				branchname, remotename, branchname);
-	return git_config_set_multivar(key, tmp->buf, "^$", 0);
+	git_config_set_multivar(key, tmp->buf, "^$", 0);
 }
 
 static const char mirror_advice[] =
@@ -197,8 +197,7 @@ static int add(int argc, const char **argv)
 		die(_("'%s' is not a valid remote name"), name);
 
 	strbuf_addf(&buf, "remote.%s.url", name);
-	if (git_config_set(buf.buf, url))
-		return 1;
+	git_config_set(buf.buf, url);
 
 	if (!mirror || mirror & MIRROR_FETCH) {
 		strbuf_reset(&buf);
@@ -206,25 +205,22 @@ static int add(int argc, const char **argv)
 		if (track.nr == 0)
 			string_list_append(&track, "*");
 		for (i = 0; i < track.nr; i++) {
-			if (add_branch(buf.buf, track.items[i].string,
-				       name, mirror, &buf2))
-				return 1;
+			add_branch(buf.buf, track.items[i].string,
+				   name, mirror, &buf2);
 		}
 	}
 
 	if (mirror & MIRROR_PUSH) {
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "remote.%s.mirror", name);
-		if (git_config_set(buf.buf, "true"))
-			return 1;
+		git_config_set(buf.buf, "true");
 	}
 
 	if (fetch_tags != TAGS_DEFAULT) {
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "remote.%s.tagopt", name);
-		if (git_config_set(buf.buf,
-			fetch_tags == TAGS_SET ? "--tags" : "--no-tags"))
-			return 1;
+		git_config_set(buf.buf,
+			       fetch_tags == TAGS_SET ? "--tags" : "--no-tags");
 	}
 
 	if (fetch && fetch_remote(name))
@@ -592,21 +588,15 @@ static int migrate_file(struct remote *remote)
 
 	strbuf_addf(&buf, "remote.%s.url", remote->name);
 	for (i = 0; i < remote->url_nr; i++)
-		if (git_config_set_multivar(buf.buf, remote->url[i], "^$", 0))
-			return error(_("Could not append '%s' to '%s'"),
-					remote->url[i], buf.buf);
+		git_config_set_multivar(buf.buf, remote->url[i], "^$", 0);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.push", remote->name);
 	for (i = 0; i < remote->push_refspec_nr; i++)
-		if (git_config_set_multivar(buf.buf, remote->push_refspec[i], "^$", 0))
-			return error(_("Could not append '%s' to '%s'"),
-					remote->push_refspec[i], buf.buf);
+		git_config_set_multivar(buf.buf, remote->push_refspec[i], "^$", 0);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", remote->name);
 	for (i = 0; i < remote->fetch_refspec_nr; i++)
-		if (git_config_set_multivar(buf.buf, remote->fetch_refspec[i], "^$", 0))
-			return error(_("Could not append '%s' to '%s'"),
-					remote->fetch_refspec[i], buf.buf);
+		git_config_set_multivar(buf.buf, remote->fetch_refspec[i], "^$", 0);
 	if (remote->origin == REMOTE_REMOTES)
 		unlink_or_warn(git_path("remotes/%s", remote->name));
 	else if (remote->origin == REMOTE_BRANCHES)
@@ -657,8 +647,7 @@ static int mv(int argc, const char **argv)
 
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", rename.new);
-	if (git_config_set_multivar(buf.buf, NULL, NULL, 1))
-		return error(_("Could not remove config section '%s'"), buf.buf);
+	git_config_set_multivar(buf.buf, NULL, NULL, 1);
 	strbuf_addf(&old_remote_context, ":refs/remotes/%s/", rename.old);
 	for (i = 0; i < oldremote->fetch_refspec_nr; i++) {
 		char *ptr;
@@ -678,8 +667,7 @@ static int mv(int argc, const char **argv)
 				  "\tPlease update the configuration manually if necessary."),
 				buf2.buf);
 
-		if (git_config_set_multivar(buf.buf, buf2.buf, "^$", 0))
-			return error(_("Could not append '%s'"), buf.buf);
+		git_config_set_multivar(buf.buf, buf2.buf, "^$", 0);
 	}
 
 	read_branches();
@@ -689,9 +677,7 @@ static int mv(int argc, const char **argv)
 		if (info->remote_name && !strcmp(info->remote_name, rename.old)) {
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "branch.%s.remote", item->string);
-			if (git_config_set(buf.buf, rename.new)) {
-				return error(_("Could not set '%s'"), buf.buf);
-			}
+			git_config_set(buf.buf, rename.new);
 		}
 	}
 
@@ -789,10 +775,7 @@ static int rm(int argc, const char **argv)
 				strbuf_reset(&buf);
 				strbuf_addf(&buf, "branch.%s.%s",
 						item->string, *k);
-				if (git_config_set(buf.buf, NULL)) {
-					strbuf_release(&buf);
-					return -1;
-				}
+				git_config_set(buf.buf, NULL);
 			}
 		}
 	}
@@ -1411,12 +1394,12 @@ static int update(int argc, const char **argv)
 	return retval;
 }
 
-static int remove_all_fetch_refspecs(const char *remote, const char *key)
+static void remove_all_fetch_refspecs(const char *remote, const char *key)
 {
-	return git_config_set_multivar(key, NULL, NULL, 1);
+	git_config_set_multivar(key, NULL, NULL, 1);
 }
 
-static int add_branches(struct remote *remote, const char **branches,
+static void add_branches(struct remote *remote, const char **branches,
 			const char *key)
 {
 	const char *remotename = remote->name;
@@ -1424,13 +1407,9 @@ static int add_branches(struct remote *remote, const char **branches,
 	struct strbuf refspec = STRBUF_INIT;
 
 	for (; *branches; branches++)
-		if (add_branch(key, *branches, remotename, mirror, &refspec)) {
-			strbuf_release(&refspec);
-			return 1;
-		}
+		add_branch(key, *branches, remotename, mirror, &refspec);
 
 	strbuf_release(&refspec);
-	return 0;
 }
 
 static int set_remote_branches(const char *remotename, const char **branches,
@@ -1445,14 +1424,9 @@ static int set_remote_branches(const char *remotename, const char **branches,
 		die(_("No such remote '%s'"), remotename);
 	remote = remote_get(remotename);
 
-	if (!add_mode && remove_all_fetch_refspecs(remotename, key.buf)) {
-		strbuf_release(&key);
-		return 1;
-	}
-	if (add_branches(remote, branches, key.buf)) {
-		strbuf_release(&key);
-		return 1;
-	}
+	if (!add_mode)
+		remove_all_fetch_refspecs(remotename, key.buf);
+	add_branches(remote, branches, key.buf);
 
 	strbuf_release(&key);
 	return 0;
diff --git a/cache.h b/cache.h
index dfc459c..4841f2c 100644
--- a/cache.h
+++ b/cache.h
@@ -1507,12 +1507,16 @@ extern int git_config_bool(const char *, const char *);
 extern int git_config_maybe_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_pathname(const char **, const char *, const char *);
-extern int git_config_set_in_file(const char *, const char *, const char *);
-extern int git_config_set(const char *, const char *);
+extern void git_config_set_in_file(const char *, const char *, const char *);
+extern int git_config_set_in_file_gently(const char *, const char *, const char *);
+extern void git_config_set(const char *, const char *);
+extern int git_config_set_gently(const char *, const char *);
 extern int git_config_parse_key(const char *, char **, int *);
 extern int git_config_key_is_valid(const char *key);
-extern int git_config_set_multivar(const char *, const char *, const char *, int);
-extern int git_config_set_multivar_in_file(const char *, const char *, const char *, const char *, int);
+extern void git_config_set_multivar(const char *, const char *, const char *, int);
+extern int git_config_set_multivar_gently(const char *, const char *, const char *, int);
+extern void git_config_set_multivar_in_file(const char *, const char *, const char *, const char *, int);
+extern int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
 extern int git_config_rename_section_in_file(const char *, const char *, const char *);
 extern const char *git_etc_gitconfig(void);
diff --git a/config.c b/config.c
index 86a5eb2..b7dbd2b 100644
--- a/config.c
+++ b/config.c
@@ -1825,15 +1825,27 @@ contline:
 	return offset;
 }
 
-int git_config_set_in_file(const char *config_filename,
+void git_config_set_in_file(const char *config_filename,
 			const char *key, const char *value)
 {
-	return git_config_set_multivar_in_file(config_filename, key, value, NULL, 0);
+	git_config_set_multivar_in_file(config_filename, key, value, NULL, 0);
 }
 
-int git_config_set(const char *key, const char *value)
+int git_config_set_in_file_gently(const char *config_filename,
+			const char *key, const char *value)
+{
+	return git_config_set_multivar_in_file_gently(config_filename,
+						      key, value, NULL, 0);
+}
+
+void git_config_set(const char *key, const char *value)
+{
+	git_config_set_multivar(key, value, NULL, 0);
+}
+
+int git_config_set_gently(const char *key, const char *value)
 {
-	return git_config_set_multivar(key, value, NULL, 0);
+	return git_config_set_multivar_gently(key, value, NULL, 0);
 }
 
 /*
@@ -1925,6 +1937,17 @@ int git_config_key_is_valid(const char *key)
 	return !git_config_parse_key_1(key, NULL, NULL, 1);
 }
 
+void git_config_set_multivar_in_file(const char *config_filename,
+				const char *key, const char *value,
+				const char *value_regex, int multi_replace)
+{
+	if (git_config_set_multivar_in_file_gently(config_filename,
+						   key, value,
+						   value_regex, multi_replace))
+		die(_("Could not set configuration key '%s' to '%s'"),
+		    key, value);
+}
+
 /*
  * If value==NULL, unset in (remove from) config,
  * if value_regex!=NULL, disregard key/value pairs where value does not match.
@@ -1950,7 +1973,7 @@ int git_config_key_is_valid(const char *key)
  * - the config file is removed and the lock file rename()d to it.
  *
  */
-int git_config_set_multivar_in_file(const char *config_filename,
+int git_config_set_multivar_in_file_gently(const char *config_filename,
 				const char *key, const char *value,
 				const char *value_regex, int multi_replace)
 {
@@ -2179,11 +2202,18 @@ write_err_out:
 
 }
 
-int git_config_set_multivar(const char *key, const char *value,
+void git_config_set_multivar(const char *key, const char *value,
 			const char *value_regex, int multi_replace)
 {
-	return git_config_set_multivar_in_file(NULL, key, value, value_regex,
-					       multi_replace);
+	git_config_set_multivar_in_file(NULL, key, value, value_regex,
+					multi_replace);
+}
+
+int git_config_set_multivar_gently(const char *key, const char *value,
+			const char *value_regex, int multi_replace)
+{
+	return git_config_set_multivar_in_file_gently(NULL, key, value,
+						      value_regex, multi_replace);
 }
 
 static int section_name_match (const char *buf, const char *name)
diff --git a/submodule.c b/submodule.c
index b83939c..bc977d1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -69,7 +69,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	strbuf_addstr(&entry, "submodule.");
 	strbuf_addstr(&entry, submodule->name);
 	strbuf_addstr(&entry, ".path");
-	if (git_config_set_in_file(".gitmodules", entry.buf, newpath) < 0) {
+	if (git_config_set_in_file_gently(".gitmodules", entry.buf, newpath) < 0) {
 		/* Maybe the user already did that, don't error out here */
 		warning(_("Could not update .gitmodules entry %s"), entry.buf);
 		strbuf_release(&entry);
@@ -1087,11 +1087,9 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 	/* Update core.worktree setting */
 	strbuf_reset(&file_name);
 	strbuf_addf(&file_name, "%s/config", git_dir);
-	if (git_config_set_in_file(file_name.buf, "core.worktree",
-				   relative_path(real_work_tree, git_dir,
-						 &rel_path)))
-		die(_("Could not set core.worktree in %s"),
-		    file_name.buf);
+	git_config_set_in_file(file_name.buf, "core.worktree",
+			        relative_path(real_work_tree, git_dir,
+					      &rel_path));
 
 	strbuf_release(&file_name);
 	strbuf_release(&rel_path);
-- 
2.7.0
