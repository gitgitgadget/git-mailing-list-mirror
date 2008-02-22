From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Remove useless if-before-free tests.
Date: Fri, 22 Feb 2008 23:08:00 +0100
Message-ID: <87tzk0tzjz.fsf@rho.meyering.net>
References: <871w7bz1ly.fsf@rho.meyering.net> <47B995CC.2000809@gmx.ch>
	<87skznhqk6.fsf@rho.meyering.net>
	<7vzlts9ag8.fsf@gitster.siamese.dyndns.org>
	<87ir0gx5bn.fsf@rho.meyering.net>
	<7vskzk99fd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jean-Luc Herren <jlh@gmx.ch>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 23:08:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSg4V-0006Na-6K
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 23:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654AbYBVWIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 17:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752429AbYBVWII
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 17:08:08 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:54091 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753654AbYBVWIE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 17:08:04 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 1DC4617B572
	for <git@vger.kernel.org>; Fri, 22 Feb 2008 23:08:01 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id CE7F517B536
	for <git@vger.kernel.org>; Fri, 22 Feb 2008 23:08:00 +0100 (CET)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 5208A1A88;
	Fri, 22 Feb 2008 23:08:00 +0100 (CET)
In-Reply-To: <7vskzk99fd.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 22 Feb 2008 09:40:22 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74762>

Junio C Hamano <gitster@pobox.com> wrote:

> Jim Meyering <jim@meyering.net> writes:
>
>>> Thanks.  I'll queue this probably in 'next' for now, but we
>>> would want a conditional workaround for git-compat-util.h before
>>> we push it out to 'master'.

Here you go.
The only changed bits (other than rebase-induced) are the
additions to Makefile, git-compat-util.h, and the log text.

>From b4ad1fc0325d0b9e2905f6fac1cda88be2a28ddf Mon Sep 17 00:00:00 2001
From: Jim Meyering <meyering@redhat.com>
Date: Thu, 31 Jan 2008 18:26:32 +0100
Subject: [PATCH] Avoid unnecessary "if-before-free" tests.

This change removes all obvious useless if-before-free tests.
E.g., it replaces code like this:

        if (some_expression)
                free (some_expression);

with the now-equivalent:

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

Addendum:
  Remove one more, slightly different, (in imap-send.c),
    spotted by Jean-Luc Herren <jlh@gmx.ch>.
  Provide a portability crutch, in case we ever find a system
    on which free(NULL) misbehaves:
    * git-compat-util.c (gitfree) [FREE_NULL_CRASHES]: Define function.
    And #define free gitfree.
    Suggested by Johannes Schindelin.
    * Makefile [FREE_NULL_CRASHES]: Define via COMPAT_CFLAGS.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 Makefile               |    7 +++++++
 builtin-blame.c        |    3 +--
 builtin-branch.c       |    9 +++------
 builtin-fast-export.c  |    3 +--
 builtin-http-fetch.c   |    3 +--
 builtin-pack-objects.c |    3 +--
 builtin-revert.c       |    3 +--
 connect.c              |    3 +--
 diff.c                 |    9 +++------
 dir.c                  |    3 +--
 git-compat-util.h      |    9 +++++++++
 http-push.c            |   18 ++++++------------
 imap-send.c            |    5 ++---
 interpolate.c          |    3 +--
 pretty.c               |    3 +--
 remote.c               |    3 +--
 setup.c                |    3 +--
 sha1_name.c            |    6 ++----
 xdiff-interface.c      |    3 +--
 19 files changed, 44 insertions(+), 55 deletions(-)

diff --git a/Makefile b/Makefile
index d33a556..3caf5b8 100644
--- a/Makefile
+++ b/Makefile
@@ -144,6 +144,9 @@ all::
 # is a simplified version of the merge sort used in glibc. This is
 # recommended if Git triggers O(n^2) behavior in your platform's qsort().
 #
+# Define FREE_NULL_CRASHES if your are on a system (e.g., SunOS4)
+# for which free(NULL) segfaults.
+#

 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -743,6 +746,10 @@ ifdef THREADED_DELTA_SEARCH
 	EXTLIBS += -lpthread
 endif

+ifdef FREE_NULL_CRASHES
+	COMPAT_CFLAGS += -DFREE_NULL_CRASHES
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK=NoThanks
 endif
diff --git a/builtin-blame.c b/builtin-blame.c
index 59d7237..bfd562d 100644
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
index 9edf2eb..7917700 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -126,8 +126,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 			continue;
 		}

-		if (name)
-			free(name);
+		free(name);

 		name = xstrdup(mkpath(fmt, argv[i]));
 		if (!resolve_ref(name, sha1, 1, NULL)) {
@@ -172,8 +171,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 		}
 	}

-	if (name)
-		free(name);
+	free(name);

 	return(ret);
 }
@@ -490,8 +488,7 @@ static void create_branch(const char *name, const char *start_name,
 	if (write_ref_sha1(lock, sha1, msg) < 0)
 		die("Failed to write ref: %s.", strerror(errno));

-	if (real_ref)
-		free(real_ref);
+	free(real_ref);
 }

 static void rename_branch(const char *oldname, const char *newname, int force)
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index f741df5..49b54de 100755
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
index d2bb12e..7dff653 100644
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
index e219859..b6dee6a 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -397,8 +397,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		else
 			return execl_git_cmd("commit", "-n", "-F", defmsg, NULL);
 	}
-	if (reencoded_message)
-		free(reencoded_message);
+	free(reencoded_message);

 	return 0;
 }
diff --git a/connect.c b/connect.c
index 5ac3572..d12b105 100644
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
index c30c252..68a1a99 100644
--- a/diff.c
+++ b/diff.c
@@ -118,8 +118,7 @@ static int parse_funcname_pattern(const char *var, const char *ep, const char *v
 		pp->next = funcname_pattern_list;
 		funcname_pattern_list = pp;
 	}
-	if (pp->pattern)
-		free(pp->pattern);
+	free(pp->pattern);
 	pp->pattern = xstrdup(value);
 	return 0;
 }
@@ -492,10 +491,8 @@ static void free_diff_words_data(struct emit_callback *ecbdata)
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
index 1f507da..edc458e 100644
--- a/dir.c
+++ b/dir.c
@@ -704,8 +704,7 @@ static struct path_simplify *create_simplify(const char **pathspec)

 static void free_simplify(struct path_simplify *simplify)
 {
-	if (simplify)
-		free(simplify);
+	free(simplify);
 }

 int read_directory(struct dir_struct *dir, const char *path, const char *base, int baselen, const char **pathspec)
diff --git a/git-compat-util.h b/git-compat-util.h
index 2a40703..911fdec 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -225,6 +225,15 @@ static inline char *gitstrchrnul(const char *s, int c)
 }
 #endif

+#ifdef FREE_NULL_CRASHES
+inline void gitfree(void *ptr)
+{
+	if (ptr)
+		free(ptr);
+}
+#define free gitfree
+#endif
+
 extern void release_pack_memory(size_t, int);

 static inline char* xstrdup(const char *str)
diff --git a/http-push.c b/http-push.c
index 0beb740..406270f 100644
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
@@ -2035,8 +2031,7 @@ static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
 	}
 	free(url);

-	if (*symref != NULL)
-		free(*symref);
+	free(*symref);
 	*symref = NULL;
 	hashclr(sha1);

@@ -2435,8 +2430,7 @@ int main(int argc, char **argv)
 	}

  cleanup:
-	if (rewritten_url)
-		free(rewritten_url);
+	free(rewritten_url);
 	if (info_ref_lock)
 		unlock_remote(info_ref_lock);
 	free(remote);
diff --git a/imap-send.c b/imap-send.c
index 9025d9a..10cce15 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -472,7 +472,7 @@ v_issue_imap_cmd( imap_store_t *ctx, struct imap_cmd_cb *cb,
 	if (socket_write( &imap->buf.sock, buf, bufl ) != bufl) {
 		free( cmd->cmd );
 		free( cmd );
-		if (cb && cb->data)
+		if (cb)
 			free( cb->data );
 		return NULL;
 	}
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
index 997f583..4bf3be2 100644
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
index 6b56473..ae1ef57 100644
--- a/remote.c
+++ b/remote.c
@@ -506,8 +506,7 @@ void free_refs(struct ref *ref)
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
index bc80301..6c96ae8 100644
--- a/setup.c
+++ b/setup.c
@@ -448,8 +448,7 @@ int check_repository_format_version(const char *var, const char *value)
 	} else if (strcmp(var, "core.worktree") == 0) {
 		if (!value)
 			return config_error_nonbool(var);
-		if (git_work_tree_cfg)
-			free(git_work_tree_cfg);
+		free(git_work_tree_cfg);
 		git_work_tree_cfg = xstrdup(value);
 		inside_work_tree = -1;
 	}
diff --git a/sha1_name.c b/sha1_name.c
index c2805e7..9d088cc 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -625,8 +625,7 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 		commit = pop_most_recent_commit(&list, ONELINE_SEEN);
 		if (!parse_object(commit->object.sha1))
 			continue;
-		if (temp_commit_buffer)
-			free(temp_commit_buffer);
+		free(temp_commit_buffer);
 		if (commit->buffer)
 			p = commit->buffer;
 		else {
@@ -643,8 +642,7 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
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
1.5.4.2.185.gf5f8
