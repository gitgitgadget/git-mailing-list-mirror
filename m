From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Use xrealloc instead of realloc
Date: Sat, 26 Aug 2006 16:16:18 +0200
Message-ID: <20060826141618.GB11601@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 26 16:16:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGyxn-00059j-Up
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 16:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWHZOQd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 10:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWHZOQd
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 10:16:33 -0400
Received: from [130.225.96.91] ([130.225.96.91]:16306 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751079AbWHZOQc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 10:16:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 035EA77008E
	for <git@vger.kernel.org>; Sat, 26 Aug 2006 16:16:20 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 13125-20 for <git@vger.kernel.org>; Sat, 26 Aug 2006 16:16:18 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 74259770005
	for <git@vger.kernel.org>; Sat, 26 Aug 2006 16:16:18 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 620636DF84F
	for <git@vger.kernel.org>; Sat, 26 Aug 2006 16:14:58 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 5A38062A02; Sat, 26 Aug 2006 16:16:18 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26048>

Change places that use realloc, without a proper error path, to instead use
xrealloc. Drop an erroneous error path in the daemon code that used errno
in the die message in favour of the simpler xrealloc.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

If this sort of cleanup is desired, I can make one for malloc -> xmalloc
too.

 builtin-fmt-merge-msg.c |    4 ++--
 builtin-log.c           |    4 ++--
 builtin-mv.c            |    6 +++---
 daemon.c                |    7 +------
 diff-delta.c            |    2 +-
 dir.c                   |    4 ++--
 git.c                   |    6 +++---
 sha1_file.c             |    2 +-
 xdiff-interface.c       |   12 ++++++------
 9 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 28b5dfd..a5ed8db 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -27,8 +27,8 @@ static void append_to_list(struct list *
 {
 	if (list->nr == list->alloc) {
 		list->alloc += 32;
-		list->list = realloc(list->list, sizeof(char *) * list->alloc);
-		list->payload = realloc(list->payload,
+		list->list = xrealloc(list->list, sizeof(char *) * list->alloc);
+		list->payload = xrealloc(list->payload,
 				sizeof(char *) * list->alloc);
 	}
 	list->payload[list->nr] = payload;
diff --git a/builtin-log.c b/builtin-log.c
index 691cf3a..fbc58bb 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -101,7 +101,7 @@ static int git_format_config(const char 
 	if (!strcmp(var, "format.headers")) {
 		int len = strlen(value);
 		extra_headers_size += len + 1;
-		extra_headers = realloc(extra_headers, extra_headers_size);
+		extra_headers = xrealloc(extra_headers, extra_headers_size);
 		extra_headers[extra_headers_size - len - 1] = 0;
 		strcat(extra_headers, value);
 		return 0;
@@ -381,7 +381,7 @@ int cmd_format_patch(int argc, const cha
 			continue;
 
 		nr++;
-		list = realloc(list, nr * sizeof(list[0]));
+		list = xrealloc(list, nr * sizeof(list[0]));
 		list[nr - 1] = commit;
 	}
 	total = nr;
diff --git a/builtin-mv.c b/builtin-mv.c
index fd1e520..4d21d88 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -168,13 +168,13 @@ int cmd_mv(int argc, const char **argv, 
 				int j, dst_len;
 
 				if (last - first > 0) {
-					source = realloc(source,
+					source = xrealloc(source,
 							(count + last - first)
 							* sizeof(char *));
-					destination = realloc(destination,
+					destination = xrealloc(destination,
 							(count + last - first)
 							* sizeof(char *));
-					modes = realloc(modes,
+					modes = xrealloc(modes,
 							(count + last - first)
 							* sizeof(enum update_mode));
 				}
diff --git a/daemon.c b/daemon.c
index dd3915a..66ec830 100644
--- a/daemon.c
+++ b/daemon.c
@@ -529,7 +529,6 @@ static int socksetup(int port, int **soc
 
 	for (ai = ai0; ai; ai = ai->ai_next) {
 		int sockfd;
-		int *newlist;
 
 		sockfd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
 		if (sockfd < 0)
@@ -563,11 +562,7 @@ #endif
 			continue;	/* not fatal */
 		}
 
-		newlist = realloc(socklist, sizeof(int) * (socknum + 1));
-		if (!newlist)
-			die("memory allocation failed: %s", strerror(errno));
-
-		socklist = newlist;
+		socklist = xrealloc(socklist, sizeof(int) * (socknum + 1));
 		socklist[socknum++] = sockfd;
 
 		if (maxfd < sockfd)
diff --git a/diff-delta.c b/diff-delta.c
index 51e2e56..fa16d06 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -392,7 +392,7 @@ create_delta(const struct delta_index *i
 				outsize = max_size + MAX_OP_SIZE + 1;
 			if (max_size && outpos > max_size)
 				break;
-			out = realloc(out, outsize);
+			out = xrealloc(out, outsize);
 			if (!out) {
 				free(tmp);
 				return NULL;
diff --git a/dir.c b/dir.c
index a686de6..d53d48f 100644
--- a/dir.c
+++ b/dir.c
@@ -101,8 +101,8 @@ void add_exclude(const char *string, con
 	x->baselen = baselen;
 	if (which->nr == which->alloc) {
 		which->alloc = alloc_nr(which->alloc);
-		which->excludes = realloc(which->excludes,
-					  which->alloc * sizeof(x));
+		which->excludes = xrealloc(which->excludes,
+					   which->alloc * sizeof(x));
 	}
 	which->excludes[which->nr++] = x;
 }
diff --git a/git.c b/git.c
index a01d195..3adf262 100644
--- a/git.c
+++ b/git.c
@@ -120,7 +120,7 @@ static int split_cmdline(char *cmdline, 
 				; /* skip */
 			if (count >= size) {
 				size += 16;
-				*argv = realloc(*argv, sizeof(char*) * size);
+				*argv = xrealloc(*argv, sizeof(char*) * size);
 			}
 			(*argv)[count++] = cmdline + dst;
 		} else if(!quoted && (c == '\'' || c == '"')) {
@@ -191,8 +191,8 @@ static int handle_alias(int *argcp, cons
 			fflush(stderr);
 		}
 
-		new_argv = realloc(new_argv, sizeof(char*) *
-				   (count + *argcp + 1));
+		new_argv = xrealloc(new_argv, sizeof(char*) *
+				    (count + *argcp + 1));
 		/* insert after command name */
 		memcpy(new_argv + count, *argv + 1, sizeof(char*) * *argcp);
 		new_argv[count+*argcp] = NULL;
diff --git a/sha1_file.c b/sha1_file.c
index 789deb7..879390a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1804,7 +1804,7 @@ int read_pipe(int fd, char** return_buf,
 			off += iret;
 			if (off == size) {
 				size *= 2;
-				buf = realloc(buf, size);
+				buf = xrealloc(buf, size);
 			}
 		}
 	} while (iret > 0);
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 6a82da7..08602f5 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -69,9 +69,9 @@ int xdiff_outf(void *priv_, mmbuffer_t *
 	for (i = 0; i < nbuf; i++) {
 		if (mb[i].ptr[mb[i].size-1] != '\n') {
 			/* Incomplete line */
-			priv->remainder = realloc(priv->remainder,
-						  priv->remainder_size +
-						  mb[i].size);
+			priv->remainder = xrealloc(priv->remainder,
+						   priv->remainder_size +
+						   mb[i].size);
 			memcpy(priv->remainder + priv->remainder_size,
 			       mb[i].ptr, mb[i].size);
 			priv->remainder_size += mb[i].size;
@@ -83,9 +83,9 @@ int xdiff_outf(void *priv_, mmbuffer_t *
 			consume_one(priv, mb[i].ptr, mb[i].size);
 			continue;
 		}
-		priv->remainder = realloc(priv->remainder,
-					  priv->remainder_size +
-					  mb[i].size);
+		priv->remainder = xrealloc(priv->remainder,
+					   priv->remainder_size +
+					   mb[i].size);
 		memcpy(priv->remainder + priv->remainder_size,
 		       mb[i].ptr, mb[i].size);
 		consume_one(priv, priv->remainder,
-- 
1.4.2.GIT

-- 
Jonas Fonseca
