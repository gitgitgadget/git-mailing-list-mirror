From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] Remove useless if-before-free tests.
Date: Sun, 17 Feb 2008 22:58:49 +0100
Message-ID: <871w7bz1ly.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 17 22:59:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQrXl-0007PG-Re
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 22:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbYBQV6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 16:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753281AbYBQV6y
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 16:58:54 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:48902 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752674AbYBQV6w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 16:58:52 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 4C9F017B553
	for <git@vger.kernel.org>; Sun, 17 Feb 2008 22:58:50 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 1C1D117B54D
	for <git@vger.kernel.org>; Sun, 17 Feb 2008 22:58:50 +0100 (CET)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id AC5F0905A
	for <git@vger.kernel.org>; Sun, 17 Feb 2008 22:58:49 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74187>

This change removes all useless if-before-free tests.
E.g., it replace code like this

	if (some_expression)
		free (some_expression);

with the now-equivalent

	free (some_expression);

It is equivalent not just because POSIX has required free(NULL)
to work for a long time, but simply because it has worked for
so long that no reasonable porting target fails the test.
Here's some evidence from nearly 1.5 years ago:

    http://www.winehq.org/pipermail/wine-patches/2006-October/031544.html

FYI, the change below was prepared by running the following:

  git ls-files -z | xargs -0 \
  perl -0x3b -pi -e \
    's/\bif\s*\(\s*(\S+?)(?:\s*!=\s*NULL)?\s*\)\s+(free\s*\(\s*\1\s*\))/$2/s'

Note however, that it doesn't handle brace-enclosed blocks like
"if (x) { free (x); }".  But that's ok, since there were none like
that in git sources.

Beware: if you do use the above snippet, note that it can
produce syntactically invalid C code.  That happens when the
affected "if"-statement has a matching "else".
E.g., it would transform this

  if (x)
    free (x);
  else
    foo ();

into this:

  free (x);
  else
    foo ();

There were none of those here, either.

If you're interested in automating detection of the useless
tests, you might like the useless-if-before-free script in gnulib:
[it *does* detect brace-enclosed free statements, and has a --name=S
 option to make it detect free-like functions with different names]

  http://git.sv.gnu.org/gitweb/?p=gnulib.git;a=blob;f=build-aux/useless-if-before-free

I confirmed that "make test" passes with this change.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 builtin-blame.c        |    3 +--
 builtin-branch.c       |    9 +++------
 builtin-fast-export.c  |    3 +--
 builtin-http-fetch.c   |    3 +--
 builtin-pack-objects.c |    3 +--
 builtin-revert.c       |    3 +--
 connect.c              |    3 +--
 diff.c                 |    9 +++------
 dir.c                  |    3 +--
 http-push.c            |   18 ++++++------------
 imap-send.c            |    3 +--
 interpolate.c          |    3 +--
 pretty.c               |    3 +--
 remote.c               |    3 +--
 setup.c                |    3 +--
 sha1_name.c            |    6 ++----
 xdiff-interface.c      |    3 +--
 17 files changed, 27 insertions(+), 54 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 9b4c02e..cd12a84 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -123,8 +123,7 @@ static inline struct origin *origin_incref(struct origin *o)
 static void origin_decref(struct origin *o)
 {
 	if (o && --o->refcnt <= 0) {
-		if (o->file.ptr)
-			free(o->file.ptr);
+		free(o->file.ptr);
 		free(o);
 	}
 }
diff --git a/builtin-branch.c b/builtin-branch.c
index 089cae5..e75a425 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -123,8 +123,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 			continue;
 		}

-		if (name)
-			free(name);
+		free(name);

 		name = xstrdup(mkpath(fmt, argv[i]));
 		if (!resolve_ref(name, sha1, 1, NULL)) {
@@ -169,8 +168,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 		}
 	}

-	if (name)
-		free(name);
+	free(name);

 	return(ret);
 }
@@ -487,8 +485,7 @@ static void create_branch(const char *name, const char *start_name,
 	if (write_ref_sha1(lock, sha1, msg) < 0)
 		die("Failed to write ref: %s.", strerror(errno));

-	if (real_ref)
-		free(real_ref);
+	free(real_ref);
 }

 static void rename_branch(const char *oldname, const char *newname, int force)
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index ef27eee..94ab967 100755
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -196,8 +196,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 			  ? strlen(reencoded) : message
 			  ? strlen(message) : 0),
 	       reencoded ? reencoded : message ? message : "");
-	if (reencoded)
-		free(reencoded);
+	free(reencoded);

 	for (i = 0, p = commit->parents; p; p = p->next) {
 		int mark = get_object_mark(&p->item->object);
diff --git a/builtin-http-fetch.c b/builtin-http-fetch.c
index 7f450c6..299093f 100644
--- a/builtin-http-fetch.c
+++ b/builtin-http-fetch.c
@@ -80,8 +80,7 @@ int cmd_http_fetch(int argc, const char **argv, const char *prefix)

 	walker_free(walker);

-	if (rewritten_url)
-		free(rewritten_url);
+	free(rewritten_url);

 	return rc;
 }
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 692a761..3f49205 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1428,8 +1428,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	 * accounting lock.  Compiler will optimize the strangeness
 	 * away when THREADED_DELTA_SEARCH is not defined.
 	 */
-	if (trg_entry->delta_data)
-		free(trg_entry->delta_data);
+	free(trg_entry->delta_data);
 	cache_lock();
 	if (trg_entry->delta_data) {
 		delta_cache_size -= trg_entry->delta_size;
diff --git a/builtin-revert.c b/builtin-revert.c
index 358af53..59b3c30 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -396,8 +396,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		else
 			return execl_git_cmd("commit", "-n", "-F", defmsg, NULL);
 	}
-	if (reencoded_message)
-		free(reencoded_message);
+	free(reencoded_message);

 	return 0;
 }
diff --git a/connect.c b/connect.c
index 3aefd4a..29c74d4 100644
--- a/connect.c
+++ b/connect.c
@@ -68,8 +68,7 @@ struct ref **get_remote_heads(int in, struct ref **list,

 		name_len = strlen(name);
 		if (len != name_len + 41) {
-			if (server_capabilities)
-				free(server_capabilities);
+			free(server_capabilities);
 			server_capabilities = xstrdup(name + name_len + 1);
 		}

diff --git a/diff.c b/diff.c
index 5b8afdc..6349eb1 100644
--- a/diff.c
+++ b/diff.c
@@ -121,8 +121,7 @@ static int parse_funcname_pattern(const char *var, const char *ep, const char *v
 		pp->next = funcname_pattern_list;
 		funcname_pattern_list = pp;
 	}
-	if (pp->pattern)
-		free(pp->pattern);
+	free(pp->pattern);
 	pp->pattern = xstrdup(value);
 	return 0;
 }
@@ -490,10 +489,8 @@ static void free_diff_words_data(struct emit_callback *ecbdata)
 				ecbdata->diff_words->plus.text.size)
 			diff_words_show(ecbdata->diff_words);

-		if (ecbdata->diff_words->minus.text.ptr)
-			free (ecbdata->diff_words->minus.text.ptr);
-		if (ecbdata->diff_words->plus.text.ptr)
-			free (ecbdata->diff_words->plus.text.ptr);
+		free (ecbdata->diff_words->minus.text.ptr);
+		free (ecbdata->diff_words->plus.text.ptr);
 		free(ecbdata->diff_words);
 		ecbdata->diff_words = NULL;
 	}
diff --git a/dir.c b/dir.c
index 3e345c2..1514502 100644
--- a/dir.c
+++ b/dir.c
@@ -677,8 +677,7 @@ static struct path_simplify *create_simplify(const char **pathspec)

 static void free_simplify(struct path_simplify *simplify)
 {
-	if (simplify)
-		free(simplify);
+	free(simplify);
 }

 int read_directory(struct dir_struct *dir, const char *path, const char *base, int baselen, const char **pathspec)
diff --git a/http-push.c b/http-push.c
index b2b410d..5889f2e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -664,8 +664,7 @@ static void release_request(struct transfer_request *request)
 		close(request->local_fileno);
 	if (request->local_stream)
 		fclose(request->local_stream);
-	if (request->url != NULL)
-		free(request->url);
+	free(request->url);
 	free(request);
 }

@@ -1283,10 +1282,8 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 	strbuf_release(&in_buffer);

 	if (lock->token == NULL || lock->timeout <= 0) {
-		if (lock->token != NULL)
-			free(lock->token);
-		if (lock->owner != NULL)
-			free(lock->owner);
+		free(lock->token);
+		free(lock->owner);
 		free(url);
 		free(lock);
 		lock = NULL;
@@ -1344,8 +1341,7 @@ static int unlock_remote(struct remote_lock *lock)
 			prev->next = prev->next->next;
 	}

-	if (lock->owner != NULL)
-		free(lock->owner);
+	free(lock->owner);
 	free(lock->url);
 	free(lock->token);
 	free(lock);
@@ -2028,8 +2024,7 @@ static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
 	}
 	free(url);

-	if (*symref != NULL)
-		free(*symref);
+	free(*symref);
 	*symref = NULL;
 	hashclr(sha1);

@@ -2425,8 +2420,7 @@ int main(int argc, char **argv)
 	}

  cleanup:
-	if (rewritten_url)
-		free(rewritten_url);
+	free(rewritten_url);
 	if (info_ref_lock)
 		unlock_remote(info_ref_lock);
 	free(remote);
diff --git a/imap-send.c b/imap-send.c
index a429a76..fb919ad 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -858,8 +858,7 @@ get_cmd_result( imap_store_t *ctx, struct imap_cmd *tcmd )
 		  normal:
 			if (cmdp->cb.done)
 				cmdp->cb.done( ctx, cmdp, resp );
-			if (cmdp->cb.data)
-				free( cmdp->cb.data );
+			free( cmdp->cb.data );
 			free( cmdp->cmd );
 			free( cmdp );
 			if (!tcmd || tcmd == cmdp)
diff --git a/interpolate.c b/interpolate.c
index 6ef53f2..7f03bd9 100644
--- a/interpolate.c
+++ b/interpolate.c
@@ -11,8 +11,7 @@ void interp_set_entry(struct interp *table, int slot, const char *value)
 	char *oldval = table[slot].value;
 	char *newval = NULL;

-	if (oldval)
-		free(oldval);
+	free(oldval);

 	if (value)
 		newval = xstrdup(value);
diff --git a/pretty.c b/pretty.c
index b987ff2..eca3ce1 100644
--- a/pretty.c
+++ b/pretty.c
@@ -30,8 +30,7 @@ enum cmit_fmt get_commit_format(const char *arg)
 	if (*arg == '=')
 		arg++;
 	if (!prefixcmp(arg, "format:")) {
-		if (user_format)
-			free(user_format);
+		free(user_format);
 		user_format = xstrdup(arg + 7);
 		return CMIT_FMT_USERFORMAT;
 	}
diff --git a/remote.c b/remote.c
index 0e00680..b4cbed8 100644
--- a/remote.c
+++ b/remote.c
@@ -493,8 +493,7 @@ void free_refs(struct ref *ref)
 	struct ref *next;
 	while (ref) {
 		next = ref->next;
-		if (ref->peer_ref)
-			free(ref->peer_ref);
+		free(ref->peer_ref);
 		free(ref);
 		ref = next;
 	}
diff --git a/setup.c b/setup.c
index adede16..24c30d1 100644
--- a/setup.c
+++ b/setup.c
@@ -372,8 +372,7 @@ int check_repository_format_version(const char *var, const char *value)
 		if (is_bare_repository_cfg == 1)
 			inside_work_tree = -1;
 	} else if (strcmp(var, "core.worktree") == 0) {
-		if (git_work_tree_cfg)
-			free(git_work_tree_cfg);
+		free(git_work_tree_cfg);
 		git_work_tree_cfg = xstrdup(value);
 		inside_work_tree = -1;
 	}
diff --git a/sha1_name.c b/sha1_name.c
index 13e1164..5c3e60f 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -618,8 +618,7 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)

 		commit = pop_most_recent_commit(&list, ONELINE_SEEN);
 		parse_object(commit->object.sha1);
-		if (temp_commit_buffer)
-			free(temp_commit_buffer);
+		free(temp_commit_buffer);
 		if (commit->buffer)
 			p = commit->buffer;
 		else {
@@ -636,8 +635,7 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 			break;
 		}
 	}
-	if (temp_commit_buffer)
-		free(temp_commit_buffer);
+	free(temp_commit_buffer);
 	free_commit_list(list);
 	for (l = backup; l; l = l->next)
 		clear_commit_marks(l->item, ONELINE_SEEN);
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 4b8e5cc..bba2364 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -233,8 +233,7 @@ void xdiff_set_find_func(xdemitconf_t *xecfg, const char *value)
 			expression = value;
 		if (regcomp(&reg->re, expression, 0))
 			die("Invalid regexp to look for hunk header: %s", expression);
-		if (buffer)
-			free(buffer);
+		free(buffer);
 		value = ep + 1;
 	}
 }
--
1.5.4.1.144.gc2249
