From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 05/14] refs.c: add a function to append a reflog entry to a fd
Date: Mon, 16 Jun 2014 09:51:36 -0700
Message-ID: <1402937505-6091-6-git-send-email-sahlberg@google.com>
References: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 18:52:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwa8n-0002g5-TY
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 18:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbaFPQwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 12:52:11 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:61695 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209AbaFPQvv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 12:51:51 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so1132822iec.0
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AysL1FHLKcoOEo+ji0M5zCLW/NwLUli0gsETQGOAXp0=;
        b=NEAdSWhm4GKg+Bsb0wh6meX92N6x6lKAEasJhXJ+Jdtqx37UvARJdzgC9TjAeVeUo6
         Fn6SbLXTtR8BMw70y41yFM0XJleb8Flw3MThkheCdoJxz2S+YlfXC1Er7DtWmHnmxP8G
         FAROyQlOgaR9L/+qQm0YUk/vbRNDheAj7YGQXc4BqtYOzSskq0gbs6bdrK1wgZnbumVW
         HNhFIhI8My13hoK2JYbYs0mybGRKswcgf0jahRP/jqUGtx8m4mU1pvJzcoDyglJXBrvr
         /ZMz+Mi8qQLnggY6vnkK8TRT698UzmRPySVdr1zG6WtDXG1gv+VC6+yqtBG2YaGg+dA6
         PJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AysL1FHLKcoOEo+ji0M5zCLW/NwLUli0gsETQGOAXp0=;
        b=FBhs4wIe4a6RqqA1dstSS/t6Y7Lif9xFeHe59wf/m2gHj9w1yEO3CKbcifY+b3V2TX
         UqZxI0u2Ak4H+vSQfWYviT8Do7lcw9RQr/Hg2fI7Bh8YW4phGxJWobB+uu/sv4uPQktR
         lheNEKzPXwqWLcMaC1oKmuFavFjmt/Ehw5dg7UlnW78m6ktJIUaW1AEmVqZ6CNmY9cAQ
         AcJFF/dpNDhvk0N4V1+etcDm2kyg65gUoombGjloT3Xq23OhXU7ZGYcyxmn8i7c1kwiU
         Bpwv8MkJL+xxava8X+mv5C40dkFVZGG6P2848GVaaSpm0j0AoBl0ApmB4HnqIACI2bKu
         3CEg==
X-Gm-Message-State: ALoCoQncS8u81il+Nzt+4fKX1cvfNVXAZcK6OfxXxrXpy2KfGKHSObUs3aK9NrlsirWwDysbAYM4
X-Received: by 10.42.229.194 with SMTP id jj2mr546772icb.18.1402937509832;
        Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si982742yhp.6.2014.06.16.09.51.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id A6E6231C66E;
	Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 39656E124E; Mon, 16 Jun 2014 09:51:48 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.770.gd892650.dirty
In-Reply-To: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251722>

Break out the code to create the string and writing it to the file
descriptor from log_ref_write and into a dedicated function log_ref_write_fd.
For now this is only used from log_ref_write but later on we will call
this function from reflog transactions too which means that we will end
up with only a single place where we write a reflog entry to a file instead
of the current two places (log_ref_write and builtin/reflog.c).

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index ca924d7..e951f34 100644
--- a/refs.c
+++ b/refs.c
@@ -2884,16 +2884,38 @@ int log_ref_setup(const char *refname, struct strbuf *logfile)
 	return 0;
 }
 
+static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
+			    const unsigned char *new_sha1,
+			    const char *committer, const char *msg)
+{
+	int msglen, written;
+	unsigned maxlen, len;
+	char *logrec;
+
+	msglen = msg ? strlen(msg) : 0;
+	maxlen = strlen(committer) + msglen + 100;
+	logrec = xmalloc(maxlen);
+	len = sprintf(logrec, "%s %s %s\n",
+		      sha1_to_hex(old_sha1),
+		      sha1_to_hex(new_sha1),
+		      committer);
+	if (msglen)
+		len += copy_msg(logrec + len - 1, msg) - 1;
+
+	written = len <= maxlen ? write_in_full(fd, logrec, len) : -1;
+	free(logrec);
+	if (written != len)
+		return -1;
+
+	return 0;
+}
+
 static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 			 const unsigned char *new_sha1, const char *msg)
 {
-	int logfd, result, written, oflags = O_APPEND | O_WRONLY;
-	unsigned maxlen, len;
-	int msglen;
+	int logfd, result, oflags = O_APPEND | O_WRONLY;
 	struct strbuf sb_log_file = STRBUF_INIT;
 	const char *log_file;
-	char *logrec;
-	const char *committer;
 
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates = !is_bare_repository();
@@ -2906,19 +2928,9 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 	logfd = open(log_file, oflags);
 	if (logfd < 0)
 		goto done;
-	msglen = msg ? strlen(msg) : 0;
-	committer = git_committer_info(0);
-	maxlen = strlen(committer) + msglen + 100;
-	logrec = xmalloc(maxlen);
-	len = sprintf(logrec, "%s %s %s\n",
-		      sha1_to_hex(old_sha1),
-		      sha1_to_hex(new_sha1),
-		      committer);
-	if (msglen)
-		len += copy_msg(logrec + len - 1, msg) - 1;
-	written = len <= maxlen ? write_in_full(logfd, logrec, len) : -1;
-	free(logrec);
-	if (written != len) {
+	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
+				  git_committer_info(0), msg);
+	if (result) {
 		int save_errno = errno;
 		close(logfd);
 		error("Unable to append to %s", log_file);
-- 
2.0.0.770.gd892650.dirty
