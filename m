From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] parse_object: check if buffer is non-NULL before freeing it
Date: Sun, 27 Aug 2006 21:20:16 -0700
Message-ID: <7vsljhtrsv.fsf@assigned-by-dhcp.cox.net>
References: <20060828003129.GE20904@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 28 06:20:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHYbS-0001EK-KD
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 06:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWH1ETo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 00:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWH1ETo
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 00:19:44 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:17865 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750753AbWH1ETn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Aug 2006 00:19:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060828041942.IPXQ18458.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Mon, 28 Aug 2006 00:19:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id FGKg1V0054Noztg0000000
	Mon, 28 Aug 2006 00:19:40 -0400
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20060828003129.GE20904@diku.dk> (Jonas Fonseca's message of
	"Mon, 28 Aug 2006 02:31:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26136>

Jonas Fonseca <fonseca@diku.dk> writes:

> Two code paths may cause this and other places in the source have the
> courtesy to do the check.

Eh, free(NULL) should work just fine.  It is "other places" that
is misguided and needs to be fixed.

- >8 -
[PATCH] free(NULL) is perfectly valid.

Jonas noticed some places say "if (X) free(X)" which is totally
unnecessary.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-apply.c         |    6 ++----
 builtin-fmt-merge-msg.c |    3 +--
 builtin-repo-config.c   |    6 ++----
 builtin-rev-list.c      |    6 ++----
 config.c                |    6 ++----
 fetch.c                 |    3 +--
 http-fetch.c            |   13 ++++---------
 http-push.c             |   13 ++++---------
 path-list.c             |    3 +--
 refs.c                  |    6 ++----
 10 files changed, 21 insertions(+), 44 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index b47ccac..1a1deaf 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1131,8 +1131,7 @@ static struct fragment *parse_binary_hun
 	return frag;
 
  corrupt:
-	if (data)
-		free(data);
+	free(data);
 	*status_p = -1;
 	error("corrupt binary patch at line %d: %.*s",
 	      linenr-1, llen-1, buffer);
@@ -1329,8 +1328,7 @@ static void show_stats(struct patch *pat
 		printf(" %s%-*s |%5d %.*s%.*s\n", prefix,
 		       len, name, patch->lines_added + patch->lines_deleted,
 		       add, pluses, del, minuses);
-	if (qname)
-		free(qname);
+	free(qname);
 }
 
 static int read_old_data(struct stat *st, const char *path, void *buf, unsigned long size)
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index a5ed8db..76d22b4 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -55,8 +55,7 @@ static void free_list(struct list *list)
 
 	for (i = 0; i < list->nr; i++) {
 		free(list->list[i]);
-		if (list->payload[i])
-			free(list->payload[i]);
+		free(list->payload[i]);
 	}
 	free(list->list);
 	free(list->payload);
diff --git a/builtin-repo-config.c b/builtin-repo-config.c
index c416480..6560cf1 100644
--- a/builtin-repo-config.c
+++ b/builtin-repo-config.c
@@ -122,10 +122,8 @@ static int get_value(const char* key_, c
 		ret =  (seen == 1) ? 0 : 1;
 
 free_strings:
-	if (repo_config)
-		free(repo_config);
-	if (global)
-		free(global);
+	free(repo_config);
+	free(global);
 	return ret;
 }
 
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index bc48a3e..7f3e1fc 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -93,10 +93,8 @@ static void show_commit(struct commit *c
 		free_commit_list(commit->parents);
 		commit->parents = NULL;
 	}
-	if (commit->buffer) {
-		free(commit->buffer);
-		commit->buffer = NULL;
-	}
+	free(commit->buffer);
+	commit->buffer = NULL;
 }
 
 static void process_blob(struct blob *blob,
diff --git a/config.c b/config.c
index 82b3562..d9f2b78 100644
--- a/config.c
+++ b/config.c
@@ -361,8 +361,7 @@ int git_config(config_fn_t fn)
 	}
 
 	ret += git_config_from_file(fn, filename);
-	if (repo_config)
-		free(repo_config);
+	free(repo_config);
 	return ret;
 }
 
@@ -734,8 +733,7 @@ int git_config_set_multivar(const char* 
 out_free:
 	if (0 <= fd)
 		close(fd);
-	if (config_filename)
-		free(config_filename);
+	free(config_filename);
 	if (lock_file) {
 		unlink(lock_file);
 		free(lock_file);
diff --git a/fetch.c b/fetch.c
index ef60b04..7d3812c 100644
--- a/fetch.c
+++ b/fetch.c
@@ -302,8 +302,7 @@ int pull(int targets, char **target, con
 		if (ret)
 			goto unlock_and_fail;
 	}
-	if (msg)
-		free(msg);
+	free(msg);
 
 	return 0;
 
diff --git a/http-fetch.c b/http-fetch.c
index 7619b33..6806f36 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -696,10 +696,8 @@ xml_start_tag(void *userData, const char
 	strcat(ctx->name, ".");
 	strcat(ctx->name, c);
 
-	if (ctx->cdata) {
-		free(ctx->cdata);
-		ctx->cdata = NULL;
-	}
+	free(ctx->cdata);
+	ctx->cdata = NULL;
 
 	ctx->userFunc(ctx, 0);
 }
@@ -726,8 +724,7 @@ static void
 xml_cdata(void *userData, const XML_Char *s, int len)
 {
 	struct xml_ctx *ctx = (struct xml_ctx *)userData;
-	if (ctx->cdata)
-		free(ctx->cdata);
+	free(ctx->cdata);
 	ctx->cdata = xmalloc(len + 1);
 	strlcpy(ctx->cdata, s, len + 1);
 }
@@ -765,9 +762,7 @@ static void handle_remote_ls_ctx(struct 
 			ls->dentry_flags |= IS_DIR;
 		}
 	} else if (!strcmp(ctx->name, DAV_PROPFIND_RESP)) {
-		if (ls->dentry_name) {
-			free(ls->dentry_name);
-		}
+		free(ls->dentry_name);
 		ls->dentry_name = NULL;
 		ls->dentry_flags = 0;
 	}
diff --git a/http-push.c b/http-push.c
index 04cb238..7814666 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1238,10 +1238,8 @@ xml_start_tag(void *userData, const char
 	strcat(ctx->name, ".");
 	strcat(ctx->name, c);
 
-	if (ctx->cdata) {
-		free(ctx->cdata);
-		ctx->cdata = NULL;
-	}
+	free(ctx->cdata);
+	ctx->cdata = NULL;
 
 	ctx->userFunc(ctx, 0);
 }
@@ -1268,8 +1266,7 @@ static void
 xml_cdata(void *userData, const XML_Char *s, int len)
 {
 	struct xml_ctx *ctx = (struct xml_ctx *)userData;
-	if (ctx->cdata)
-		free(ctx->cdata);
+	free(ctx->cdata);
 	ctx->cdata = xmalloc(len + 1);
 	strlcpy(ctx->cdata, s, len + 1);
 }
@@ -1518,9 +1515,7 @@ static void handle_remote_ls_ctx(struct 
 			ls->dentry_flags |= IS_DIR;
 		}
 	} else if (!strcmp(ctx->name, DAV_PROPFIND_RESP)) {
-		if (ls->dentry_name) {
-			free(ls->dentry_name);
-		}
+		free(ls->dentry_name);
 		ls->dentry_name = NULL;
 		ls->dentry_flags = 0;
 	}
diff --git a/path-list.c b/path-list.c
index f15a10d..b1ee72d 100644
--- a/path-list.c
+++ b/path-list.c
@@ -85,8 +85,7 @@ void path_list_clear(struct path_list *l
 			for (i = 0; i < list->nr; i++) {
 				if (list->strdup_paths)
 					free(list->items[i].path);
-				if (list->items[i].util)
-					free(list->items[i].util);
+				free(list->items[i].util);
 			}
 		free(list->items);
 	}
diff --git a/refs.c b/refs.c
index e70ef0a..aab14fc 100644
--- a/refs.c
+++ b/refs.c
@@ -348,10 +348,8 @@ void unlock_ref(struct ref_lock *lock)
 		if (lock->lk)
 			rollback_lock_file(lock->lk);
 	}
-	if (lock->ref_file)
-		free(lock->ref_file);
-	if (lock->log_file)
-		free(lock->log_file);
+	free(lock->ref_file);
+	free(lock->log_file);
 	free(lock);
 }
 
-- 
1.4.2.g2f76
