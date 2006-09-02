From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Replace uses of strdup with xstrdup.
Date: Sat, 2 Sep 2006 00:16:31 -0400
Message-ID: <20060902041631.GA25093@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 10:21:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJQkM-0005OR-8I
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 10:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWIBIUz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 04:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWIBIUz
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 04:20:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:14477 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750835AbWIBIUx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 04:20:53 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GJQkD-0004mG-Vd; Sat, 02 Sep 2006 04:20:50 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4BE7720FB7F; Sat,  2 Sep 2006 00:16:32 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26323>

Like xmalloc and xrealloc xstrdup dies with a useful message if
the native strdup() implementation returns NULL rather than a
valid pointer.

I just tried to use xstrdup in new code and found it to be missing.
However I expected it to be present as xmalloc and xrealloc are
already commonly used throughout the code.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 blame.c                 |    2 +-
 builtin-apply.c         |    2 +-
 builtin-fmt-merge-msg.c |   22 +++++++++++-----------
 builtin-grep.c          |    2 +-
 builtin-name-rev.c      |    2 +-
 builtin-prune.c         |    2 +-
 builtin-push.c          |   10 +++++-----
 builtin-repo-config.c   |    6 +++---
 builtin-rev-list.c      |    4 ++--
 builtin-rm.c            |    2 +-
 builtin-show-branch.c   |    6 +++---
 builtin-symbolic-ref.c  |    4 ++--
 builtin-tar-tree.c      |    2 +-
 builtin-upload-tar.c    |    2 +-
 builtin-zip-tree.c      |    4 ++--
 commit.c                |    2 +-
 config.c                |    8 ++++----
 connect.c               |    6 +++---
 diff.c                  |    4 ++--
 environment.c           |    2 +-
 fetch.c                 |    4 ++--
 fsck-objects.c          |    2 +-
 git-compat-util.h       |    8 ++++++++
 git.c                   |    2 +-
 http-fetch.c            |    2 +-
 http-push.c             |    6 +++---
 imap-send.c             |   12 ++++++------
 merge-file.c            |    2 +-
 merge-recursive.c       |   14 +++++++-------
 merge-tree.c            |    4 ++--
 path-list.c             |    2 +-
 refs.c                  |    4 ++--
 server-info.c           |    2 +-
 sha1_file.c             |    8 ++++----
 sha1_name.c             |    4 ++--
 35 files changed, 89 insertions(+), 81 deletions(-)

diff --git a/blame.c b/blame.c
index 8968046..8cfd5d9 100644
--- a/blame.c
+++ b/blame.c
@@ -617,7 +617,7 @@ static void simplify_commit(struct rev_i
 				if (new_name) {
 					struct util_info* putil = get_util(p);
 					if (!putil->pathname)
-						putil->pathname = strdup(new_name);
+						putil->pathname = xstrdup(new_name);
 				} else {
 					*pp = parent->next;
 					continue;
diff --git a/builtin-apply.c b/builtin-apply.c
index 1a1deaf..872c800 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2449,7 +2449,7 @@ static int apply_patch(int fd, const cha
 static int git_apply_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "apply.whitespace")) {
-		apply_default_whitespace = strdup(value);
+		apply_default_whitespace = xstrdup(value);
 		return 0;
 	}
 	return git_default_config(var, value);
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index ed59e77..b946b7d 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -111,29 +111,29 @@ static int handle_line(char *line)
 	i = find_in_list(&srcs, src);
 	if (i < 0) {
 		i = srcs.nr;
-		append_to_list(&srcs, strdup(src),
+		append_to_list(&srcs, xstrdup(src),
 				xcalloc(1, sizeof(struct src_data)));
 	}
 	src_data = srcs.payload[i];
 
 	if (pulling_head) {
-		origin = strdup(src);
+		origin = xstrdup(src);
 		src_data->head_status |= 1;
 	} else if (!strncmp(line, "branch ", 7)) {
-		origin = strdup(line + 7);
+		origin = xstrdup(line + 7);
 		append_to_list(&src_data->branch, origin, NULL);
 		src_data->head_status |= 2;
 	} else if (!strncmp(line, "tag ", 4)) {
 		origin = line;
-		append_to_list(&src_data->tag, strdup(origin + 4), NULL);
+		append_to_list(&src_data->tag, xstrdup(origin + 4), NULL);
 		src_data->head_status |= 2;
 	} else if (!strncmp(line, "remote branch ", 14)) {
-		origin = strdup(line + 14);
+		origin = xstrdup(line + 14);
 		append_to_list(&src_data->r_branch, origin, NULL);
 		src_data->head_status |= 2;
 	} else {
-		origin = strdup(src);
-		append_to_list(&src_data->generic, strdup(line), NULL);
+		origin = xstrdup(src);
+		append_to_list(&src_data->generic, xstrdup(line), NULL);
 		src_data->head_status |= 2;
 	}
 
@@ -145,7 +145,7 @@ static int handle_line(char *line)
 			new_origin[len - 1] = 0;
 			origin = new_origin;
 		} else
-			origin = strdup(origin);
+			origin = xstrdup(origin);
 	} else {
 		char *new_origin = xmalloc(strlen(origin) + strlen(src) + 5);
 		sprintf(new_origin, "%s of %s", origin, src);
@@ -203,7 +203,7 @@ static void shortlog(const char *name, u
 
 		bol = strstr(commit->buffer, "\n\n");
 		if (!bol) {
-			append_to_list(&subjects, strdup(sha1_to_hex(
+			append_to_list(&subjects, xstrdup(sha1_to_hex(
 							commit->object.sha1)),
 					NULL);
 			continue;
@@ -218,7 +218,7 @@ static void shortlog(const char *name, u
 			memcpy(oneline, bol, len);
 			oneline[len] = 0;
 		} else
-			oneline = strdup(bol);
+			oneline = xstrdup(bol);
 		append_to_list(&subjects, oneline, NULL);
 	}
 
@@ -277,7 +277,7 @@ int cmd_fmt_merge_msg(int argc, const ch
 		usage(fmt_merge_msg_usage);
 
 	/* get current branch */
-	head = strdup(git_path("HEAD"));
+	head = xstrdup(git_path("HEAD"));
 	current_branch = resolve_ref(head, head_sha1, 1);
 	current_branch += strlen(head) - 4;
 	free((char *)head);
diff --git a/builtin-grep.c b/builtin-grep.c
index 8213ce2..6430f6d 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -1048,7 +1048,7 @@ int cmd_grep(int argc, const char **argv
 				/* ignore empty line like grep does */
 				if (!buf[0])
 					continue;
-				add_pattern(&opt, strdup(buf), argv[1], ++lno,
+				add_pattern(&opt, xstrdup(buf), argv[1], ++lno,
 					    GREP_PATTERN);
 			}
 			fclose(patterns);
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index d44e782..52886b6 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -100,7 +100,7 @@ static int name_ref(const char *path, co
 		else if (!strncmp(path, "refs/", 5))
 			path = path + 5;
 
-		name_rev(commit, strdup(path), 0, 0, deref);
+		name_rev(commit, xstrdup(path), 0, 0, deref);
 	}
 	return 0;
 }
diff --git a/builtin-prune.c b/builtin-prune.c
index fc885ce..6228c79 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -106,7 +106,7 @@ static void process_tree(struct tree *tr
 	obj->flags |= SEEN;
 	if (parse_tree(tree) < 0)
 		die("bad tree object %s", sha1_to_hex(obj->sha1));
-	name = strdup(name);
+	name = xstrdup(name);
 	add_object(obj, p, path, name);
 	me.up = path;
 	me.elem = name;
diff --git a/builtin-push.c b/builtin-push.c
index ada8338..c43f256 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -33,7 +33,7 @@ static int expand_one_ref(const char *re
 	ref += 5;
 
 	if (!strncmp(ref, "tags/", 5))
-		add_refspec(strdup(ref));
+		add_refspec(xstrdup(ref));
 	return 0;
 }
 
@@ -100,12 +100,12 @@ static int get_remotes_uri(const char *r
 
 		if (!is_refspec) {
 			if (n < MAX_URI)
-				uri[n++] = strdup(s);
+				uri[n++] = xstrdup(s);
 			else
 				error("more than %d URL's specified, ignoring the rest", MAX_URI);
 		}
 		else if (is_refspec && !has_explicit_refspec)
-			add_refspec(strdup(s));
+			add_refspec(xstrdup(s));
 	}
 	fclose(f);
 	if (!n)
@@ -125,13 +125,13 @@ static int get_remote_config(const char*
 	    !strncmp(key + 7, config_repo, config_repo_len)) {
 		if (!strcmp(key + 7 + config_repo_len, ".url")) {
 			if (config_current_uri < MAX_URI)
-				config_uri[config_current_uri++] = strdup(value);
+				config_uri[config_current_uri++] = xstrdup(value);
 			else
 				error("more than %d URL's specified, ignoring the rest", MAX_URI);
 		}
 		else if (config_get_refspecs &&
 			 !strcmp(key + 7 + config_repo_len, ".push"))
-			add_refspec(strdup(value));
+			add_refspec(xstrdup(value));
 	}
 	return 0;
 }
diff --git a/builtin-repo-config.c b/builtin-repo-config.c
index d19f7dc..f60cee1 100644
--- a/builtin-repo-config.c
+++ b/builtin-repo-config.c
@@ -72,12 +72,12 @@ static int get_value(const char* key_, c
 		const char *home = getenv("HOME");
 		local = getenv("GIT_CONFIG_LOCAL");
 		if (!local)
-			local = repo_config = strdup(git_path("config"));
+			local = repo_config = xstrdup(git_path("config"));
 		if (home)
-			global = strdup(mkpath("%s/.gitconfig", home));
+			global = xstrdup(mkpath("%s/.gitconfig", home));
 	}
 
-	key = strdup(key_);
+	key = xstrdup(key_);
 	for (tl=key+strlen(key)-1; tl >= key && *tl != '.'; --tl)
 		*tl = tolower(*tl);
 	for (tl=key; *tl && *tl != '.'; ++tl)
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 402af8e..8437454 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -109,7 +109,7 @@ static void process_blob(struct blob *bl
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
 	obj->flags |= SEEN;
-	name = strdup(name);
+	name = xstrdup(name);
 	add_object(obj, p, path, name);
 }
 
@@ -130,7 +130,7 @@ static void process_tree(struct tree *tr
 	if (parse_tree(tree) < 0)
 		die("bad tree object %s", sha1_to_hex(obj->sha1));
 	obj->flags |= SEEN;
-	name = strdup(name);
+	name = xstrdup(name);
 	add_object(obj, p, path, name);
 	me.up = path;
 	me.elem = name;
diff --git a/builtin-rm.c b/builtin-rm.c
index 593d867..33d04bd 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -32,7 +32,7 @@ static int remove_file(const char *name)
 
 	ret = unlink(name);
 	if (!ret && (slash = strrchr(name, '/'))) {
-		char *n = strdup(name);
+		char *n = xstrdup(name);
 		do {
 			n[slash - name] = 0;
 			name = n;
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index d7de18e..578c9fa 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -163,7 +163,7 @@ static void name_commits(struct commit_l
 					en += sprintf(en, "^");
 				else
 					en += sprintf(en, "^%d", nth);
-				name_commit(p, strdup(newname), 0);
+				name_commit(p, xstrdup(newname), 0);
 				i++;
 				name_first_parent_chain(p);
 			}
@@ -364,7 +364,7 @@ static int append_ref(const char *refnam
 			refname, MAX_REVS);
 		return 0;
 	}
-	ref_name[ref_name_cnt++] = strdup(refname);
+	ref_name[ref_name_cnt++] = xstrdup(refname);
 	ref_name[ref_name_cnt] = NULL;
 	return 0;
 }
@@ -521,7 +521,7 @@ static int git_show_branch_config(const 
 			default_alloc = default_alloc * 3 / 2 + 20;
 			default_arg = xrealloc(default_arg, sizeof *default_arg * default_alloc);
 		}
-		default_arg[default_num++] = strdup(value);
+		default_arg[default_num++] = xstrdup(value);
 		default_arg[default_num] = NULL;
 		return 0;
 	}
diff --git a/builtin-symbolic-ref.c b/builtin-symbolic-ref.c
index b4ec6f2..1d3a5e2 100644
--- a/builtin-symbolic-ref.c
+++ b/builtin-symbolic-ref.c
@@ -7,7 +7,7 @@ static const char git_symbolic_ref_usage
 static void check_symref(const char *HEAD)
 {
 	unsigned char sha1[20];
-	const char *git_HEAD = strdup(git_path("%s", HEAD));
+	const char *git_HEAD = xstrdup(git_path("%s", HEAD));
 	const char *git_refs_heads_master = resolve_ref(git_HEAD, sha1, 0);
 	if (git_refs_heads_master) {
 		/* we want to strip the .git/ part */
@@ -26,7 +26,7 @@ int cmd_symbolic_ref(int argc, const cha
 		check_symref(argv[1]);
 		break;
 	case 3:
-		create_symref(strdup(git_path("%s", argv[1])), argv[2]);
+		create_symref(xstrdup(git_path("%s", argv[1])), argv[2]);
 		break;
 	default:
 		usage(git_symbolic_ref_usage);
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 61a4135..fa666f7 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -351,7 +351,7 @@ static int remote_tar(int argc, const ch
 		usage(tar_tree_usage);
 
 	/* --remote=<repo> */
-	url = strdup(argv[1]+9);
+	url = xstrdup(argv[1]+9);
 	pid = git_connect(fd, url, exec);
 	if (pid < 0)
 		return 1;
diff --git a/builtin-upload-tar.c b/builtin-upload-tar.c
index 7b401bb..06a945a 100644
--- a/builtin-upload-tar.c
+++ b/builtin-upload-tar.c
@@ -53,7 +53,7 @@ int cmd_upload_tar(int argc, const char 
 			return nak("expected (optional) base");
 		if (buf[len-1] == '\n')
 			buf[--len] = 0;
-		base = strdup(buf + 5);
+		base = xstrdup(buf + 5);
 		len = packet_read_line(0, buf, sizeof(buf));
 	}
 	if (len)
diff --git a/builtin-zip-tree.c b/builtin-zip-tree.c
index a5b834d..1c1f683 100644
--- a/builtin-zip-tree.c
+++ b/builtin-zip-tree.c
@@ -311,11 +311,11 @@ int cmd_zip_tree(int argc, const char **
 
 	switch (argc) {
 	case 3:
-		base = strdup(argv[2]);
+		base = xstrdup(argv[2]);
 		baselen = strlen(base);
 		break;
 	case 2:
-		base = strdup("");
+		base = xstrdup("");
 		baselen = 0;
 		break;
 	default:
diff --git a/commit.c b/commit.c
index 3f4bc31..e5aa22e 100644
--- a/commit.c
+++ b/commit.c
@@ -233,7 +233,7 @@ static void prepare_commit_graft(void)
 	}
 	if (last_graft_file)
 		free(last_graft_file);
-	last_graft_file = strdup(graft_file);
+	last_graft_file = xstrdup(graft_file);
 
 	read_graft_file(graft_file);
 	commit_graft_prepared = 1;
diff --git a/config.c b/config.c
index c0897cc..e8f0caf 100644
--- a/config.c
+++ b/config.c
@@ -350,11 +350,11 @@ int git_config(config_fn_t fn)
 		home = getenv("HOME");
 		filename = getenv("GIT_CONFIG_LOCAL");
 		if (!filename)
-			filename = repo_config = strdup(git_path("config"));
+			filename = repo_config = xstrdup(git_path("config"));
 	}
 
 	if (home) {
-		char *user_config = strdup(mkpath("%s/.gitconfig", home));
+		char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
 		if (!access(user_config, R_OK))
 			ret = git_config_from_file(fn, user_config);
 		free(user_config);
@@ -545,8 +545,8 @@ int git_config_set_multivar(const char* 
 		if (!config_filename)
 			config_filename  = git_path("config");
 	}
-	config_filename = strdup(config_filename);
-	lock_file = strdup(mkpath("%s.lock", config_filename));
+	config_filename = xstrdup(config_filename);
+	lock_file = xstrdup(mkpath("%s.lock", config_filename));
 
 	/*
 	 * Since "key" actually contains the section name and the real
diff --git a/connect.c b/connect.c
index e501ccc..06ef387 100644
--- a/connect.c
+++ b/connect.c
@@ -69,7 +69,7 @@ struct ref **get_remote_heads(int in, st
 		if (len != name_len + 41) {
 			if (server_capabilities)
 				free(server_capabilities);
-			server_capabilities = strdup(name + name_len + 1);
+			server_capabilities = xstrdup(name + name_len + 1);
 		}
 
 		if (!check_ref(name, name_len, flags))
@@ -661,7 +661,7 @@ int git_connect(int fd[2], char *url, co
 		if (path[1] == '~')
 			path++;
 		else {
-			path = strdup(ptr);
+			path = xstrdup(ptr);
 			free_path = 1;
 		}
 
@@ -672,7 +672,7 @@ int git_connect(int fd[2], char *url, co
 		/* These underlying connection commands die() if they
 		 * cannot connect.
 		 */
-		char *target_host = strdup(host);
+		char *target_host = xstrdup(host);
 		if (git_use_proxy(host))
 			git_proxy_connect(fd, host);
 		else
diff --git a/diff.c b/diff.c
index 70699fd..9dcbda3 100644
--- a/diff.c
+++ b/diff.c
@@ -216,7 +216,7 @@ static char *quote_one(const char *str)
 		return NULL;
 	needlen = quote_c_style(str, NULL, NULL, 0);
 	if (!needlen)
-		return strdup(str);
+		return xstrdup(str);
 	xp = xmalloc(needlen + 1);
 	quote_c_style(str, xp, NULL, 0);
 	return xp;
@@ -658,7 +658,7 @@ static struct diffstat_file *diffstat_ad
 		x->is_renamed = 1;
 	}
 	else
-		x->name = strdup(name_a);
+		x->name = xstrdup(name_a);
 	return x;
 }
 
diff --git a/environment.c b/environment.c
index cd276b0..0ab3385 100644
--- a/environment.c
+++ b/environment.c
@@ -67,7 +67,7 @@ void setup_git(char *new_git_dir, char *
 		free(git_graft_file);
 	git_graft_file = new_git_graft_file;
 	if (!git_graft_file) {
-		git_graft_file = strdup(git_path("info/grafts"));
+		git_graft_file = xstrdup(git_path("info/grafts"));
 		dyn_git_graft_file = 1;
 	} else {
 		dyn_git_graft_file = 0;
diff --git a/fetch.c b/fetch.c
index 7d3812c..34df8d3 100644
--- a/fetch.c
+++ b/fetch.c
@@ -234,8 +234,8 @@ int pull_targets_stdin(char ***target, c
 			*target = xrealloc(*target, targets_alloc * sizeof(**target));
 			*write_ref = xrealloc(*write_ref, targets_alloc * sizeof(**write_ref));
 		}
-		(*target)[targets] = strdup(tg_one);
-		(*write_ref)[targets] = rf_one ? strdup(rf_one) : NULL;
+		(*target)[targets] = xstrdup(tg_one);
+		(*write_ref)[targets] = rf_one ? xstrdup(rf_one) : NULL;
 		targets++;
 	}
 	return targets;
diff --git a/fsck-objects.c b/fsck-objects.c
index 24286de..4d994f3 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -458,7 +458,7 @@ static void fsck_object_dir(const char *
 static int fsck_head_link(void)
 {
 	unsigned char sha1[20];
-	const char *git_HEAD = strdup(git_path("HEAD"));
+	const char *git_HEAD = xstrdup(git_path("HEAD"));
 	const char *git_refs_heads_master = resolve_ref(git_HEAD, sha1, 1);
 	int pfxlen = strlen(git_HEAD) - 4; /* strip .../.git/ part */
 
diff --git a/git-compat-util.h b/git-compat-util.h
index 91f2b0d..552b8ec 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -84,6 +84,14 @@ #define strlcpy gitstrlcpy
 extern size_t gitstrlcpy(char *, const char *, size_t);
 #endif
 
+static inline char* xstrdup(const char *str)
+{
+	char *ret = strdup(str);
+	if (!ret)
+		die("Out of memory, strdup failed");
+	return ret;
+}
+
 static inline void *xmalloc(size_t size)
 {
 	void *ret = malloc(size);
diff --git a/git.c b/git.c
index 403fb3a..1d00111 100644
--- a/git.c
+++ b/git.c
@@ -97,7 +97,7 @@ static char *alias_string;
 static int git_alias_config(const char *var, const char *value)
 {
 	if (!strncmp(var, "alias.", 6) && !strcmp(var + 6, alias_command)) {
-		alias_string = strdup(value);
+		alias_string = xstrdup(value);
 	}
 	return 0;
 }
diff --git a/http-fetch.c b/http-fetch.c
index 6806f36..fac1760 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -787,7 +787,7 @@ static int remote_ls(struct alt_base *re
 
 	ls.flags = flags;
 	ls.repo = repo;
-	ls.path = strdup(path);
+	ls.path = xstrdup(path);
 	ls.dentry_name = NULL;
 	ls.dentry_flags = 0;
 	ls.userData = userData;
diff --git a/http-push.c b/http-push.c
index 7814666..670ff00 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1539,7 +1539,7 @@ static void remote_ls(const char *path, 
 	struct remote_ls_ctx ls;
 
 	ls.flags = flags;
-	ls.path = strdup(path);
+	ls.path = xstrdup(path);
 	ls.dentry_name = NULL;
 	ls.dentry_flags = 0;
 	ls.userData = userData;
@@ -1738,7 +1738,7 @@ static struct object_list **process_tree
 		die("bad tree object %s", sha1_to_hex(obj->sha1));
 
 	obj->flags |= SEEN;
-	name = strdup(name);
+	name = xstrdup(name);
 	p = add_one_object(obj, p);
 	me.up = path;
 	me.elem = name;
@@ -2467,7 +2467,7 @@ int main(int argc, char **argv)
 
 		/* Set up revision info for this refspec */
 		commit_argc = 3;
-		new_sha1_hex = strdup(sha1_to_hex(ref->new_sha1));
+		new_sha1_hex = xstrdup(sha1_to_hex(ref->new_sha1));
 		old_sha1_hex = NULL;
 		commit_argv[1] = "--objects";
 		commit_argv[2] = new_sha1_hex;
diff --git a/imap-send.c b/imap-send.c
index 6a52dbd..362e474 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1007,7 +1007,7 @@ imap_open_store( imap_server_conf_t *srv
 			 * getpass() returns a pointer to a static buffer.  make a copy
 			 * for long term storage.
 			 */
-			srvc->pass = strdup( arg );
+			srvc->pass = xstrdup( arg );
 		}
 		if (CAP(NOLOGIN)) {
 			fprintf( stderr, "Skipping account %s@%s, server forbids LOGIN\n", srvc->user, srvc->host );
@@ -1263,7 +1263,7 @@ git_imap_config(const char *key, const c
 	key += sizeof imap_key - 1;
 
 	if (!strcmp( "folder", key )) {
-		imap_folder = strdup( val );
+		imap_folder = xstrdup( val );
 	} else if (!strcmp( "host", key )) {
 		{
 			if (!strncmp( "imap:", val, 5 ))
@@ -1273,16 +1273,16 @@ git_imap_config(const char *key, const c
 		}
 		if (!strncmp( "//", val, 2 ))
 			val += 2;
-		server.host = strdup( val );
+		server.host = xstrdup( val );
 	}
 	else if (!strcmp( "user", key ))
-		server.user = strdup( val );
+		server.user = xstrdup( val );
 	else if (!strcmp( "pass", key ))
-		server.pass = strdup( val );
+		server.pass = xstrdup( val );
 	else if (!strcmp( "port", key ))
 		server.port = git_config_int( key, val );
 	else if (!strcmp( "tunnel", key ))
-		server.tunnel = strdup( val );
+		server.tunnel = xstrdup( val );
 	return 0;
 }
 
diff --git a/merge-file.c b/merge-file.c
index f32c653..fc9b148 100644
--- a/merge-file.c
+++ b/merge-file.c
@@ -21,7 +21,7 @@ static const char *write_temp_file(mmfil
 	fd = mkstemp(filename);
 	if (fd < 0)
 		return NULL;
-	filename = strdup(filename);
+	filename = xstrdup(filename);
 	if (f->size != xwrite(fd, f->ptr, f->size)) {
 		rm_temp_file(filename);
 		return NULL;
diff --git a/merge-recursive.c b/merge-recursive.c
index 48b2763..611cd95 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -513,8 +513,8 @@ static char *unique_path(const char *pat
 
 static int mkdir_p(const char *path, unsigned long mode)
 {
-	/* path points to cache entries, so strdup before messing with it */
-	char *buf = strdup(path);
+	/* path points to cache entries, so xstrdup before messing with it */
+	char *buf = xstrdup(path);
 	int result = safe_create_leading_directories(buf);
 	free(buf);
 	return result;
@@ -668,9 +668,9 @@ static struct merge_file_info merge_file
 			git_unpack_file(a->sha1, src1);
 			git_unpack_file(b->sha1, src2);
 
-			argv[2] = la = strdup(mkpath("%s/%s", branch1, a->path));
-			argv[6] = lb = strdup(mkpath("%s/%s", branch2, b->path));
-			argv[4] = lo = strdup(mkpath("orig/%s", o->path));
+			argv[2] = la = xstrdup(mkpath("%s/%s", branch1, a->path));
+			argv[6] = lb = xstrdup(mkpath("%s/%s", branch2, b->path));
+			argv[4] = lo = xstrdup(mkpath("orig/%s", o->path));
 			argv[7] = src1;
 			argv[8] = orig;
 			argv[9] = src2,
@@ -1314,9 +1314,9 @@ int main(int argc, char *argv[])
 	original_index_file = getenv("GIT_INDEX_FILE");
 
 	if (!original_index_file)
-		original_index_file = strdup(git_path("index"));
+		original_index_file = xstrdup(git_path("index"));
 
-	temporary_index_file = strdup(git_path("mrg-rcrsv-tmp-idx"));
+	temporary_index_file = xstrdup(git_path("mrg-rcrsv-tmp-idx"));
 
 	if (argc < 4)
 		die("Usage: %s <base>... -- <head> <remote> ...\n", argv[0]);
diff --git a/merge-tree.c b/merge-tree.c
index c2e9a86..60df758 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -177,7 +177,7 @@ static void resolve(const char *base, st
 	if (!branch1)
 		return;
 
-	path = strdup(mkpath("%s%s", base, result->path));
+	path = xstrdup(mkpath("%s%s", base, result->path));
 	orig = create_entry(2, branch1->mode, branch1->sha1, path);
 	final = create_entry(0, result->mode, result->sha1, path);
 
@@ -233,7 +233,7 @@ static struct merge_list *link_entry(uns
 	if (entry)
 		path = entry->path;
 	else
-		path = strdup(mkpath("%s%s", base, n->path));
+		path = xstrdup(mkpath("%s%s", base, n->path));
 	link = create_entry(stage, n->mode, n->sha1, path);
 	link->link = entry;
 	return link;
diff --git a/path-list.c b/path-list.c
index b1ee72d..0c332dc 100644
--- a/path-list.c
+++ b/path-list.c
@@ -45,7 +45,7 @@ static int add_entry(struct path_list *l
 				(list->nr - index)
 				* sizeof(struct path_list_item));
 	list->items[index].path = list->strdup_paths ?
-		strdup(path) : (char *)path;
+		xstrdup(path) : (char *)path;
 	list->items[index].util = NULL;
 	list->nr++;
 
diff --git a/refs.c b/refs.c
index aab14fc..5e65314 100644
--- a/refs.c
+++ b/refs.c
@@ -313,8 +313,8 @@ static struct ref_lock *lock_ref_sha1_ba
 	}
 	lock->lk = xcalloc(1, sizeof(struct lock_file));
 
-	lock->ref_file = strdup(path);
-	lock->log_file = strdup(git_path("logs/%s", lock->ref_file + plen));
+	lock->ref_file = xstrdup(path);
+	lock->log_file = xstrdup(git_path("logs/%s", lock->ref_file + plen));
 	lock->force_write = lstat(lock->ref_file, &st) && errno == ENOENT;
 
 	if (safe_create_leading_directories(lock->ref_file))
diff --git a/server-info.c b/server-info.c
index 7df628f..2fb8f57 100644
--- a/server-info.c
+++ b/server-info.c
@@ -23,7 +23,7 @@ static int add_info_ref(const char *path
 
 static int update_info_refs(int force)
 {
-	char *path0 = strdup(git_path("info/refs"));
+	char *path0 = xstrdup(git_path("info/refs"));
 	int len = strlen(path0);
 	char *path1 = xmalloc(len + 2);
 
diff --git a/sha1_file.c b/sha1_file.c
index fe9176a..feb55c6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -115,7 +115,7 @@ static void fill_sha1_path(char *pathbuf
 
 /*
  * NOTE! This returns a statically allocated buffer, so you have to be
- * careful about using it. Do a "strdup()" if you need to save the
+ * careful about using it. Do a "xstrdup()" if you need to save the
  * filename.
  *
  * Also note that this returns the location for creating.  Reading
@@ -141,7 +141,7 @@ char *sha1_file_name(const unsigned char
 		name = base + len + 1;
 		if (last_objdir)
 			free((char *) last_objdir);
-		last_objdir = strdup(sha1_file_directory);
+		last_objdir = xstrdup(sha1_file_directory);
 	}
 	fill_sha1_path(name, sha1);
 	return base;
@@ -164,7 +164,7 @@ char *sha1_pack_name(const unsigned char
 		name = base + len + 11;
 		if (last_objdir)
 			free((char *) last_objdir);
-		last_objdir = strdup(sha1_file_directory);
+		last_objdir = xstrdup(sha1_file_directory);
 	}
 
 	buf = name;
@@ -195,7 +195,7 @@ char *sha1_pack_index_name(const unsigne
 		name = base + len + 11;
 		if (last_objdir)
 			free((char *) last_objdir);
-		last_objdir = strdup(sha1_file_directory);
+		last_objdir = xstrdup(sha1_file_directory);
 	}
 
 	buf = name;
diff --git a/sha1_name.c b/sha1_name.c
index 60a2c0b..8fcc271 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -26,7 +26,7 @@ static int find_short_object_filename(in
 		fakeent->name[-1] = '/';
 		if (last_objdir)
 			free((char *) last_objdir);
-		last_objdir = strdup(objdir);
+		last_objdir = xstrdup(objdir);
 	}
 	fakeent->next = alt_odb_list;
 
@@ -285,7 +285,7 @@ static int get_sha1_basic(const char *st
 		pathname = resolve_ref(git_path(*p, len, str), this_result, 1);
 		if (pathname) {
 			if (!refs_found++)
-				real_path = strdup(pathname);
+				real_path = xstrdup(pathname);
 			if (!warn_ambiguous_refs)
 				break;
 		}
-- 
1.4.2.ga2654


-- 
VGER BF report: U 0.5
