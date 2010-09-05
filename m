From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 12/15] Pass extra (rev-list) args on, at least in some cases
Date: Sat,  4 Sep 2010 18:14:04 -0600
Message-ID: <1283645647-1891-13-git-send-email-newren@gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
Cc: pclouds@gmail.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 02:13:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os2rh-0008IQ-Vz
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 02:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601Ab0IEAN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 20:13:27 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:60884 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754593Ab0IEANY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 20:13:24 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so579626pxi.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 17:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6u904RPSwx7cRv/2QZhem6mN1/rqFK4C3OqjSt8g1tY=;
        b=VB6Buy/usvpDjyRWreGFGiC2+jgS/L2kqB+CSq/VehpfHxiqVlnHPjLWMMVN7kDMen
         ZFml8oxQB2s0yWStDgRIOMyQa89JbqzPc82TkYjPjUGCu0/1mnCJ6+iW9wT2Z30QwLuO
         aT4kuBJXS47RRg4q0Rqn6QoNBeCUwgt+dwllY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZOylcYw3JbpzorNSW85iXN4ioe5I1K/GUzhLuumLxVKcWTU1BVZVkNyB9OWzrbwAhb
         IL+FdNTSiy9ncPpVIoLN+T7uPs3NEm39rj2Ta3V0TAvxzJdpmLTJ68D8Lsr5VF9c2mzc
         gKUm9TNBJpkNW+u6cSIh+8jfMDD7dchKAVQtA=
Received: by 10.114.39.4 with SMTP id m4mr1384968wam.98.1283645604594;
        Sat, 04 Sep 2010 17:13:24 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 33sm7341833wad.18.2010.09.04.17.13.22
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 17:13:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.140.gd06af
In-Reply-To: <1283645647-1891-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155397>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/archive.c    |    2 +-
 builtin/clone.c      |    2 +-
 builtin/fetch-pack.c |    3 ++-
 builtin/send-pack.c  |    3 ++-
 cache.h              |    2 +-
 connect.c            |    9 ++++++++-
 transport-helper.c   |    5 ++++-
 transport.c          |   13 +++++++++----
 transport.h          |    8 +++++---
 9 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index 6a887f5..018d2b6 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -35,7 +35,7 @@ static int run_remote_archiver(int argc, const char **argv,
 	if (!_remote->url[0])
 		die("git archive: Remote with no URL");
 	transport = transport_get(_remote, _remote->url[0]);
-	transport_connect(transport, "git-upload-archive", exec, fd);
+	transport_connect(transport, "git-upload-archive", exec, NULL, fd);
 
 	for (i = 1; i < argc; i++)
 		packet_write(fd[1], "argument %s\n", argv[i]);
diff --git a/builtin/clone.c b/builtin/clone.c
index de0fb66..5c0f594 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -545,7 +545,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			int ret;
 
 			sq_quote_argv(&buf, &argv[rest_argc], 0);
-			ret = transport_set_option(transport, TRANS_OPT_SPARSE,
+			ret = transport_set_option(transport, TRANS_OPT_REVLIST_ARGS,
 						   strbuf_detach(&buf, NULL));
 			if (ret)
 				warning ("Sparse clone not supported!\n");
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index dbd8b7b..e550f3d 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -875,7 +875,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		fd[0] = 0;
 		fd[1] = 1;
 	} else {
-		conn = git_connect(fd, (char *)dest, args.uploadpack,
+		error("Should pass extra_args to git_connect!");
+		conn = git_connect(fd, (char *)dest, args.uploadpack, NULL,
 				   args.verbose ? CONNECT_VERBOSE : 0);
 	}
 
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 481602d..c3ae328 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -478,7 +478,8 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		fd[0] = 0;
 		fd[1] = 1;
 	} else {
-		conn = git_connect(fd, dest, receivepack,
+		error("Should pass extra_args to git_connect!");
+		conn = git_connect(fd, dest, receivepack, NULL,
 			args.verbose ? CONNECT_VERBOSE : 0);
 	}
 
diff --git a/cache.h b/cache.h
index 6f88dbb..84c0969 100644
--- a/cache.h
+++ b/cache.h
@@ -937,7 +937,7 @@ extern struct ref *find_ref_by_name(const struct ref *list, const char *name);
 
 #define CONNECT_VERBOSE       (1u << 0)
 extern char *git_getpass(const char *prompt);
-extern struct child_process *git_connect(int fd[2], const char *url, const char *prog, int flags);
+extern struct child_process *git_connect(int fd[2], const char *url, const char *prog, const char *extra_args, int flags);
 extern int finish_connect(struct child_process *conn);
 extern int path_match(const char *path, int nr, char **match);
 struct extra_have_objects {
diff --git a/connect.c b/connect.c
index 3450cab..42135c8 100644
--- a/connect.c
+++ b/connect.c
@@ -449,7 +449,8 @@ static struct child_process no_fork;
  * the connection failed).
  */
 struct child_process *git_connect(int fd[2], const char *url_orig,
-				  const char *prog, int flags)
+				  const char *prog, const char *extra_args,
+				  int flags)
 {
 	char *url;
 	char *host, *path;
@@ -550,6 +551,8 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 		 * Note: Do not add any other headers here!  Doing so
 		 * will cause older git-daemon servers to crash.
 		 */
+		if (extra_args)
+			error("What to do with extra_args?!?\n");
 		packet_write(fd[1],
 			     "%s %s%chost=%s%c",
 			     prog, path, 0,
@@ -567,6 +570,10 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 	strbuf_addstr(&cmd, prog);
 	strbuf_addch(&cmd, ' ');
 	sq_quote_buf(&cmd, path);
+	if (extra_args) {
+		strbuf_addch(&cmd, ' ');
+		strbuf_addstr(&cmd, extra_args);
+	}
 	if (cmd.len >= MAX_CMD_LEN)
 		die("command line too long");
 
diff --git a/transport-helper.c b/transport-helper.c
index af81fe1..c2b6db3 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -509,7 +509,7 @@ static int process_connect(struct transport *transport,
 }
 
 static int connect_helper(struct transport *transport, const char *name,
-		   const char *exec, int fd[2])
+			  const char *exec, const char *extra_args, int fd[2])
 {
 	struct helper_data *data = transport->data;
 
@@ -518,6 +518,9 @@ static int connect_helper(struct transport *transport, const char *name,
 	if (!data->connect)
 		die("Operation not supported by protocol.");
 
+	if (extra_args)
+		die("extra_args not handled!!!!  OH NOES!!!");
+
 	if (!process_connect_service(transport, name, exec))
 		die("Can't connect to subservice %s.", name);
 
diff --git a/transport.c b/transport.c
index 4dba6f8..1d3cab3 100644
--- a/transport.c
+++ b/transport.c
@@ -475,6 +475,9 @@ static int set_git_option(struct git_transport_options *opts,
 		else
 			opts->depth = atoi(value);
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_REVLIST_ARGS)) {
+		opts->revlist_args = value;
+		return 0;
 	}
 	return 1;
 }
@@ -489,6 +492,7 @@ static int connect_setup(struct transport *transport, int for_push, int verbose)
 	data->conn = git_connect(data->fd, transport->url,
 				 for_push ? data->options.receivepack :
 				 data->options.uploadpack,
+				 data->options.revlist_args,
 				 verbose ? CONNECT_VERBOSE : 0);
 
 	return 0;
@@ -805,11 +809,12 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 }
 
 static int connect_git(struct transport *transport, const char *name,
-		       const char *executable, int fd[2])
+		       const char *executable, const char *extra_args,
+		       int fd[2])
 {
 	struct git_transport_data *data = transport->data;
 	data->conn = git_connect(data->fd, transport->url,
-				 executable, 0);
+				 executable, extra_args, 0);
 	fd[0] = data->fd[0];
 	fd[1] = data->fd[1];
 	return 0;
@@ -1124,10 +1129,10 @@ void transport_unlock_pack(struct transport *transport)
 }
 
 int transport_connect(struct transport *transport, const char *name,
-		      const char *exec, int fd[2])
+		      const char *exec, const char *extra_args, int fd[2])
 {
 	if (transport->connect)
-		return transport->connect(transport, name, exec, fd);
+		return transport->connect(transport, name, exec, extra_args, fd);
 	else
 		die("Operation not supported by protocol");
 }
diff --git a/transport.h b/transport.h
index 41e347a..2669e84 100644
--- a/transport.h
+++ b/transport.h
@@ -11,6 +11,7 @@ struct git_transport_options {
 	int depth;
 	const char *uploadpack;
 	const char *receivepack;
+	const char *revlist_args;
 };
 
 struct transport {
@@ -71,7 +72,8 @@ struct transport {
 	int (*push_refs)(struct transport *transport, struct ref *refs, int flags);
 	int (*push)(struct transport *connection, int refspec_nr, const char **refspec, int flags);
 	int (*connect)(struct transport *connection, const char *name,
-		       const char *executable, int fd[2]);
+		       const char *executable, const char *extra_args,
+		       int fd[2]);
 
 	/** get_refs_list(), fetch(), and push_refs() can keep
 	 * resources (such as a connection) reserved for futher
@@ -128,7 +130,7 @@ struct transport *transport_get(struct remote *, const char *);
 #define TRANS_OPT_FOLLOWTAGS "followtags"
 
 /* Fetch only certain paths */
-#define TRANS_OPT_SPARSE "sparse"
+#define TRANS_OPT_REVLIST_ARGS "revlist_args"
 
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
@@ -153,7 +155,7 @@ void transport_take_over(struct transport *transport,
 			 struct child_process *child);
 
 int transport_connect(struct transport *transport, const char *name,
-		      const char *exec, int fd[2]);
+		      const char *exec, const char *extra_args, int fd[2]);
 
 /* Transport methods defined outside transport.c */
 int transport_helper_init(struct transport *transport, const char *name);
-- 
1.7.2.2.140.gd06af
