From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/9] Handle errors when setting configs
Date: Fri, 29 Jan 2016 03:20:36 -0500
Message-ID: <20160129082036.GA8591@sigill.intra.peff.net>
References: <1453971637-22273-1-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Fri Jan 29 09:20:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aP4IO-0007DG-1v
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 09:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677AbcA2IUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2016 03:20:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:34188 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751944AbcA2IUj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 03:20:39 -0500
Received: (qmail 7307 invoked by uid 102); 29 Jan 2016 08:20:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jan 2016 03:20:39 -0500
Received: (qmail 28947 invoked by uid 107); 29 Jan 2016 08:21:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jan 2016 03:21:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jan 2016 03:20:36 -0500
Content-Disposition: inline
In-Reply-To: <1453971637-22273-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285070>

On Thu, Jan 28, 2016 at 10:00:28AM +0100, Patrick Steinhardt wrote:

> I've finally got around to producing version two of my previous
> patch to handle errors when setting configs. Back in September
> I've posted a single patch to handle errors when
> `install_branch_config` fails due to configuration failures [1].

Thanks for following up.

Having read through the series, I don't see anything _too_ wrong with
it. And certainly catching these errors and dying is better than letting
them go unnoticed.

Regarding this:

> Version two of this patch is somewhat more involved in that I
> tried to track down all relevant places where we set configs
> without checking for error conditions. My current approach to
> most of those cases is to just die with an error message, this
> remains up to discussion though for the individual cases.

I was a little surprised to see all of the effort in patch 2 to carry
the return value up the call stack, just to die a little later. Having
re-read our original thread, I did say that possibly "checkout -b"
should not directly die when failing to set the upstream. But looking at
the code again and thinking on it more, I don't really think that buys
us anything interesting (unless it is to roll back the branch creation,
but as before, I don't think it's really worth the effort).

So I wondered if patch 2 could simply use the "or_die" variant.

Which then made me wonder: doesn't basically everybody want to die if
setting config fails? The exception might be builtin/config.c, just
because it wants to return a custom exit code for some errors.

So would this series be a lot more pleasant if we went the other way?
That is, make git_config_set() die by default, and add a "_gently" form.

The end result is roughly the same, but it's a lot less churn, and it's
more likely for new callers to get it right, because they have to go the
extra mile to ignore the error. I say "roughly" because it treats cases
we missed as "die", whereas yours leaves them as "ignore". I find it
highly unlikely that any of them actually _want_ the ignore behavior,
though.

I'm just pondering, though. I don't find the "or_die" variant bad at
all, so if you really prefer it, I don't mind.

Just to get a sense of what the reverse would look like, I worked up the
patch below (which compiles but does not link, as I did not actually
implement the "gently" form). Some error-checking call-sites are
converted to the "die" form, because that's essentially what happens
anyway (and I'd venture to say that the config code can provide a much
better error message).

---
diff --git a/builtin/branch.c b/builtin/branch.c
index 3f6c825..4ab8b35 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -570,7 +570,6 @@ static const char edit_description[] = "BRANCH_DESCRIPTION";
 
 static int edit_branch_description(const char *branch_name)
 {
-	int status;
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf name = STRBUF_INIT;
 
@@ -595,11 +594,10 @@ static int edit_branch_description(const char *branch_name)
 	strbuf_stripspace(&buf, 1);
 
 	strbuf_addf(&name, "branch.%s.description", branch_name);
-	status = git_config_set(name.buf, buf.len ? buf.buf : NULL);
+	git_config_set(name.buf, buf.len ? buf.buf : NULL);
 	strbuf_release(&name);
 	strbuf_release(&buf);
-
-	return status;
+	return 0;
 }
 
 int cmd_branch(int argc, const char **argv, const char *prefix)
diff --git a/builtin/config.c b/builtin/config.c
index adc7727..2e6fd3c 100644
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
@@ -637,7 +637,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			return git_config_set_multivar_in_file(given_config_source.file,
 							       argv[0], NULL, argv[1], 0);
 		else
-			return git_config_set_in_file(given_config_source.file,
+			return git_config_set_in_file_gently(given_config_source.file,
 						      argv[0], NULL);
 	}
 	else if (actions == ACTION_UNSET_ALL) {
diff --git a/builtin/remote.c b/builtin/remote.c
index 2b2ff9b..0f69c30 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -197,8 +197,7 @@ static int add(int argc, const char **argv)
 		die(_("'%s' is not a valid remote name"), name);
 
 	strbuf_addf(&buf, "remote.%s.url", name);
-	if (git_config_set(buf.buf, url))
-		return 1;
+	git_config_set(buf.buf, url);
 
 	if (!mirror || mirror & MIRROR_FETCH) {
 		strbuf_reset(&buf);
@@ -215,16 +214,14 @@ static int add(int argc, const char **argv)
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
+		       fetch_tags == TAGS_SET ? "--tags" : "--no-tags");
 	}
 
 	if (fetch && fetch_remote(name))
@@ -689,9 +686,7 @@ static int mv(int argc, const char **argv)
 		if (info->remote_name && !strcmp(info->remote_name, rename.old)) {
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "branch.%s.remote", item->string);
-			if (git_config_set(buf.buf, rename.new)) {
-				return error(_("Could not set '%s'"), buf.buf);
-			}
+			git_config_set(buf.buf, rename.new);
 		}
 	}
 
@@ -789,10 +784,7 @@ static int rm(int argc, const char **argv)
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
diff --git a/cache.h b/cache.h
index dfc459c..a1c7782 100644
--- a/cache.h
+++ b/cache.h
@@ -1507,8 +1507,9 @@ extern int git_config_bool(const char *, const char *);
 extern int git_config_maybe_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_pathname(const char **, const char *, const char *);
-extern int git_config_set_in_file(const char *, const char *, const char *);
-extern int git_config_set(const char *, const char *);
+extern void git_config_set_in_file(const char *, const char *, const char *);
+extern int git_config_set_in_file_gently(const char *, const char *, const char *);
+extern void git_config_set(const char *, const char *);
 extern int git_config_parse_key(const char *, char **, int *);
 extern int git_config_key_is_valid(const char *key);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
diff --git a/config.c b/config.c
index 86a5eb2..54c3f30 100644
--- a/config.c
+++ b/config.c
@@ -1825,15 +1825,15 @@ contline:
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
+void git_config_set(const char *key, const char *value)
 {
-	return git_config_set_multivar(key, value, NULL, 0);
+	git_config_set_multivar(key, value, NULL, 0);
 }
 
 /*
diff --git a/submodule.c b/submodule.c
index b83939c..b3fc6ac 100644
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
+			       relative_path(real_work_tree, git_dir,
+					     &rel_path));
 
 	strbuf_release(&file_name);
 	strbuf_release(&rel_path);
