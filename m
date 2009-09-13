From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] use write_str_in_full helper to avoid literal string lengths
Date: Sun, 13 Sep 2009 09:32:46 +0200
Message-ID: <87ljkjz4dd.fsf@meyering.net>
References: <87skes35mf.fsf@meyering.net>
	<7veiqbbttg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 09:33:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmjaL-0001LU-PQ
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 09:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbZIMHcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 03:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbZIMHcv
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 03:32:51 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:51484 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690AbZIMHcu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 03:32:50 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 7BC0181810F
	for <git@vger.kernel.org>; Sun, 13 Sep 2009 09:32:48 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 91FB9818076
	for <git@vger.kernel.org>; Sun, 13 Sep 2009 09:32:46 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 27E1C2F3C5; Sun, 13 Sep 2009 09:32:46 +0200 (CEST)
In-Reply-To: <7veiqbbttg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 12 Sep 2009 16:56:59 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128343>

Junio C Hamano wrote:
...
> Thanks.  I agree with the reasoning you wrote outside the proposed log
> message.
>
> We usually do not write these bullet points (iow, we are not GNU) in our
> log message.  The names of the functions, call sites and files that are
> involved are something anybody can see from the patch text,
>
> I think the GNU convention was useful back when we were trapped in a
> system with non-atomic commits, where it was very hard to see what files
> were affected in a single logical changeset (i.e. CVS).
>
> Luckily, we graduated those dark ages.
>
> Instead, we prefer to have justifications (and methods), like what you
> wrote at the beginning of your message.  These are not something people
> can find in the patch text and they deserve to be recorded in the commit.

Heh ;-)
Old habits...
Here's that same commit with a better log message:

>From 7edbf0141c9e2ae2999f8b7919c938b9384240e2 Mon Sep 17 00:00:00 2001
From: Jim Meyering <meyering@redhat.com>
Date: Sat, 12 Sep 2009 09:56:13 +0200
Subject: [PATCH] use write_str_in_full helper to avoid literal string lengths

In 2d14d65ce7b136b0fb18dcf27e5caff67829f658,
I noticed two changes like this:

-	write_in_full(helper->in, "list\n", 5);
+
+	strbuf_addstr(&buf, "list\n");
+	write_in_full(helper->in, buf.buf, buf.len);
+	strbuf_reset(&buf);

Instead, let's define a new function, in cache.h:

    static inline ssize_t write_str_in_full(int fd, const char *str)
    {
           return write_in_full(fd, str, strlen(str));
    }

and then use it like this:

-       strbuf_addstr(&buf, "list\n");
-       write_in_full(helper->in, buf.buf, buf.len);
-       strbuf_reset(&buf);
+       write_str_in_full(helper->in, "list\n");

Thus not requiring the added allocation, and still avoiding
the maintenance risk of literal string lengths.
These days, compilers are good enough that strlen("literal")
imposes no run-time cost.

Update the two uses in transport-helper.c manually,
and transform the other uses via this:

    perl -pi -e \
        's/write_in_full\((.*?), (".*?"), \d+\)/write_str_in_full($1, $2)/'\
      $(git grep -l 'write_in_full.*"')

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 builtin-fetch.c    |    2 +-
 builtin-reflog.c   |    2 +-
 cache.h            |    9 +++++++--
 commit.c           |    2 +-
 config.c           |    2 +-
 rerere.c           |    2 +-
 transport-helper.c |   10 +++-------
 upload-pack.c      |    4 ++--
 8 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 817dd6b..cb48c57 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -454,7 +454,7 @@ static int quickfetch(struct ref *ref_map)

 	for (ref = ref_map; ref; ref = ref->next) {
 		if (write_in_full(revlist.in, sha1_to_hex(ref->old_sha1), 40) < 0 ||
-		    write_in_full(revlist.in, "\n", 1) < 0) {
+		    write_str_in_full(revlist.in, "\n") < 0) {
 			if (errno != EPIPE && errno != EINVAL)
 				error("failed write to rev-list: %s", strerror(errno));
 			err = -1;
diff --git a/builtin-reflog.c b/builtin-reflog.c
index 95198c5..e23b5ef 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -362,7 +362,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 		} else if (cmd->updateref &&
 			(write_in_full(lock->lock_fd,
 				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
-			 write_in_full(lock->lock_fd, "\n", 1) != 1 ||
+			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
 			 close_ref(lock) < 0)) {
 			status |= error("Couldn't write %s",
 				lock->lk->filename);
diff --git a/cache.h b/cache.h
index 30a7a16..90bf127 100644
--- a/cache.h
+++ b/cache.h
@@ -924,13 +924,18 @@ extern const char *git_mailmap_file;
 extern void maybe_flush_or_die(FILE *, const char *);
 extern int copy_fd(int ifd, int ofd);
 extern int copy_file(const char *dst, const char *src, int mode);
-extern ssize_t read_in_full(int fd, void *buf, size_t count);
-extern ssize_t write_in_full(int fd, const void *buf, size_t count);
 extern void write_or_die(int fd, const void *buf, size_t count);
 extern int write_or_whine(int fd, const void *buf, size_t count, const char *msg);
 extern int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg);
 extern void fsync_or_die(int fd, const char *);

+extern ssize_t read_in_full(int fd, void *buf, size_t count);
+extern ssize_t write_in_full(int fd, const void *buf, size_t count);
+static inline ssize_t write_str_in_full(int fd, const char *str)
+{
+	return write_in_full(fd, str, strlen(str));
+}
+
 /* pager.c */
 extern void setup_pager(void);
 extern const char *pager_program;
diff --git a/commit.c b/commit.c
index a6c6f70..fedbd5e 100644
--- a/commit.c
+++ b/commit.c
@@ -212,7 +212,7 @@ int write_shallow_commits(int fd, int use_pack_protocol)
 			else {
 				if (write_in_full(fd, hex,  40) != 40)
 					break;
-				if (write_in_full(fd, "\n", 1) != 1)
+				if (write_str_in_full(fd, "\n") != 1)
 					break;
 			}
 		}
diff --git a/config.c b/config.c
index f21530c..c644061 100644
--- a/config.c
+++ b/config.c
@@ -1119,7 +1119,7 @@ int git_config_set_multivar(const char *key, const char *value,
 				    copy_end - copy_begin)
 					goto write_err_out;
 				if (new_line &&
-				    write_in_full(fd, "\n", 1) != 1)
+				    write_str_in_full(fd, "\n") != 1)
 					goto write_err_out;
 			}
 			copy_begin = store.offset[i];
diff --git a/rerere.c b/rerere.c
index 87360dc..29f95f6 100644
--- a/rerere.c
+++ b/rerere.c
@@ -61,7 +61,7 @@ static int write_rr(struct string_list *rr, int out_fd)
 		path = rr->items[i].string;
 		length = strlen(path) + 1;
 		if (write_in_full(out_fd, rr->items[i].util, 40) != 40 ||
-		    write_in_full(out_fd, "\t", 1) != 1 ||
+		    write_str_in_full(out_fd, "\t") != 1 ||
 		    write_in_full(out_fd, path, length) != length)
 			die("unable to write rerere record");
 	}
diff --git a/transport-helper.c b/transport-helper.c
index b1ea7e6..832d81f 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -37,9 +37,7 @@ static struct child_process *get_helper(struct transport *transport)
 		die("Unable to run helper: git %s", helper->argv[0]);
 	data->helper = helper;

-	strbuf_addstr(&buf, "capabilities\n");
-	write_in_full(helper->in, buf.buf, buf.len);
-	strbuf_reset(&buf);
+	write_str_in_full(helper->in, "capabilities\n");

 	file = fdopen(helper->out, "r");
 	while (1) {
@@ -58,7 +56,7 @@ static int disconnect_helper(struct transport *transport)
 {
 	struct helper_data *data = transport->data;
 	if (data->helper) {
-		write_in_full(data->helper->in, "\n", 1);
+		write_str_in_full(data->helper->in, "\n");
 		close(data->helper->in);
 		finish_command(data->helper);
 		free((char *)data->helper->argv[0]);
@@ -124,9 +122,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)

 	helper = get_helper(transport);

-	strbuf_addstr(&buf, "list\n");
-	write_in_full(helper->in, buf.buf, buf.len);
-	strbuf_reset(&buf);
+	write_str_in_full(helper->in, "list\n");

 	file = fdopen(helper->out, "r");
 	while (1) {
diff --git a/upload-pack.c b/upload-pack.c
index c77ab71..b3471e4 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -553,7 +553,7 @@ static void receive_needs(void)

 	shallow_nr = 0;
 	if (debug_fd)
-		write_in_full(debug_fd, "#S\n", 3);
+		write_str_in_full(debug_fd, "#S\n");
 	for (;;) {
 		struct object *o;
 		unsigned char sha1_buf[20];
@@ -619,7 +619,7 @@ static void receive_needs(void)
 		}
 	}
 	if (debug_fd)
-		write_in_full(debug_fd, "#E\n", 3);
+		write_str_in_full(debug_fd, "#E\n");

 	if (!use_sideband && daemon_mode)
 		no_progress = 1;
--
1.6.5.rc0.190.g15871
