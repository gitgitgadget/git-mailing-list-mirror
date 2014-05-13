From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 8/8] read-cache: inform the daemon that the index has been updated
Date: Tue, 13 May 2014 18:15:37 +0700
Message-ID: <1399979737-8577-11-git-send-email-pclouds@gmail.com>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
 <1399979737-8577-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 13 13:16:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkAhR-0000xW-9g
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 13:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759945AbaEMLQi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2014 07:16:38 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:58473 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760209AbaEMLQh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 07:16:37 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so161329pbb.39
        for <git@vger.kernel.org>; Tue, 13 May 2014 04:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xHnk7zvBvPn22F4ZaTV3JMruRb88NlHD94LVck1jDRA=;
        b=LbWaQchax7I8zxo5VpiK6KwozFwA4PoTTVwQcGEX9SAkadXel8Ksio/aixax9Cxiau
         lYvNPcdxw6UfJz7xSG8HatX+YxfNBAZP6eH0lGZsjYh1a1g+ey7J0AZtVteDsf2lcTIC
         6wyQ44p+TG10Ox85NUtQOL4ZdWbKbsOEeZRTvPuppXmONx3VOD90CC5KhG0SxLaDC2pk
         Xa8PbUr3YS7MEbLuAVb/6BVQdwhYs0R5YnqpA2ZhYCvA6ZraN21JX+StxuJIJOyCc9SL
         rRwNt3lTHZggRMvj61zdt5Qsc7a5ZeqkLMzNyewCnxUBE0nryUt0m1hSmZdMbw1Pp6M4
         GO3Q==
X-Received: by 10.68.240.68 with SMTP id vy4mr4412945pbc.127.1399979796854;
        Tue, 13 May 2014 04:16:36 -0700 (PDT)
Received: from lanh ([115.73.238.182])
        by mx.google.com with ESMTPSA id ec2sm27709538pbc.63.2014.05.13.04.16.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 04:16:36 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 13 May 2014 18:16:42 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399979737-8577-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248770>

The daemon would immediately load the new index in memory in
background. Next time Git needs to read the index again, everything is
ready.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h      |  1 +
 read-cache.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++----=
-
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index fb29c7e..3115b86 100644
--- a/cache.h
+++ b/cache.h
@@ -483,6 +483,7 @@ extern int is_index_unborn(struct index_state *);
 extern int read_index_unmerged(struct index_state *);
 #define COMMIT_LOCK		(1 << 0)
 #define CLOSE_LOCK		(1 << 1)
+#define REFRESH_DAEMON		(1 << 2)
 extern int write_locked_index(struct index_state *, struct lock_file *=
lock, unsigned flags);
 extern int discard_index(struct index_state *);
 extern int unmerged_index(const struct index_state *);
diff --git a/read-cache.c b/read-cache.c
index e98521f..d5c9247 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -16,6 +16,9 @@
 #include "varint.h"
 #include "split-index.h"
 #include "sigchain.h"
+#include "unix-socket.h"
+#include "pkt-line.h"
+#include "run-command.h"
=20
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
 					       unsigned int options);
@@ -2030,6 +2033,32 @@ void set_alternate_index_output(const char *name=
)
 	alternate_index_output =3D name;
 }
=20
+static void refresh_daemon(struct index_state *istate)
+{
+	int fd;
+	fd =3D unix_stream_connect(git_path("daemon/index"));
+	if (fd < 0) {
+		struct child_process cp;
+		const char *av[] =3D {"read-cache--daemon", "--detach", NULL };
+		memset(&cp, 0, sizeof(cp));
+		cp.argv =3D av;
+		cp.git_cmd =3D 1;
+		cp.no_stdin =3D 1;
+		if (run_command(&cp))
+			warning(_("failed to start read-cache--daemon: %s"),
+				strerror(errno));
+		return;
+	}
+	/*
+	 * packet_write() could die() but unless this is from
+	 * update_index_if_able(), we're about to exit anyway,
+	 * probably ok to die (for now). Blocking mode is another
+	 * problem to deal with later.
+	 */
+	packet_write(fd, "refresh");
+	close(fd);
+}
+
 static int commit_locked_index(struct lock_file *lk)
 {
 	if (alternate_index_output) {
@@ -2052,9 +2081,22 @@ static int do_write_locked_index(struct index_st=
ate *istate, struct lock_file *l
 		return ret;
 	assert((flags & (COMMIT_LOCK | CLOSE_LOCK)) !=3D
 	       (COMMIT_LOCK | CLOSE_LOCK));
-	if (flags & COMMIT_LOCK)
-		return commit_locked_index(lock);
-	else if (flags & CLOSE_LOCK)
+	if (flags & COMMIT_LOCK) {
+		int ret;
+		int len =3D strlen(lock->filename) - 5; /* .lock */
+		if (!use_read_cache_daemon || len < 6 ||
+		    /*
+		     * do not wake the daemon when we update a temporary
+		     * index. This is not a perfect test for this, but good
+		     * enough.
+		     */
+		    strncmp(lock->filename + len - 6, "/index", 6))
+			flags &=3D ~REFRESH_DAEMON;
+		ret =3D commit_locked_index(lock);
+		if (!ret && use_read_cache_daemon)
+			refresh_daemon(istate);
+		return ret;
+	} else if (flags & CLOSE_LOCK)
 		return close_lock_file(lock);
 	else
 		return ret;
@@ -2066,7 +2108,7 @@ static int write_split_index(struct index_state *=
istate,
 {
 	int ret;
 	prepare_to_write_split_index(istate);
-	ret =3D do_write_locked_index(istate, lock, flags);
+	ret =3D do_write_locked_index(istate, lock, flags | REFRESH_DAEMON);
 	finish_writing_split_index(istate);
 	return ret;
 }
@@ -2133,7 +2175,8 @@ int write_locked_index(struct index_state *istate=
, struct lock_file *lock,
 	    (istate->cache_changed & ~EXTMASK)) {
 		if (si)
 			hashclr(si->base_sha1);
-		return do_write_locked_index(istate, lock, flags);
+		return do_write_locked_index(istate, lock,
+					     flags | REFRESH_DAEMON);
 	}
=20
 	if (getenv("GIT_TEST_SPLIT_INDEX")) {
--=20
1.9.1.346.ga2b5940
