From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 8/8] revert: Implement --abort processing
Date: Wed, 11 May 2011 13:30:22 +0530
Message-ID: <1305100822-20470-9-git-send-email-artagnon@gmail.com>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 11 18:32:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKCKo-0002c6-7w
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 18:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756125Ab1EKQ3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 12:29:04 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:14401 "EHLO
	smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757653Ab1EKQ3A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 12:29:00 -0400
X-IronPort-AV: E=Sophos;i="4.64,351,1301875200"; 
   d="scan'208";a="697932560"
Received: from smtp-in-0105.sea3.amazon.com ([10.224.19.45])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 May 2011 08:02:56 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-0105.sea3.amazon.com (8.13.8/8.13.8) with ESMTP id p4B82sSE003792;
	Wed, 11 May 2011 08:02:55 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id AD15A754839; Wed, 11 May 2011 13:30:22 +0530 (IST)
X-Mailer: git-send-email 1.7.5.GIT
In-Reply-To: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173409>

To abort, perform a "rerere clear" and "reset --hard" to the ref
specified by the "head" file introduced earlier in the series.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 This code is dependent on the rerere_clear public API (which I've
 posted in another thread).  Have the essential parts of the "reset
 --hard" been copied over correctly?  Should reset get a public API as
 well?

 builtin/revert.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index ccfc295..50c36e9 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -799,6 +799,54 @@ static int pick_commits(struct replay_opts *opts)
 	return persist_todo_done(res, revs.commits, done_list, opts);
 }
 
+static int process_args(int argc, const char **argv, struct replay_opts *opts)
+{
+	const char *me;
+	int fd;
+
+	parse_args(argc, argv, opts);
+	me = (opts->action == REVERT ? "revert" : "cherry-pick");
+	if (opts->abort_oper) {
+		char head[DEFAULT_ABBREV];
+		unsigned char sha1[20];
+		rerere_clear(0);
+
+		if (!file_exists(HEAD_FILE))
+			goto error;
+		if ((fd = open(HEAD_FILE, O_RDONLY, 0666)) < 0) {
+			int err = errno;
+			error(_("Could not open '%s' for reading: %s"),
+				HEAD_FILE, strerror(err));
+			return -err;
+		}
+		if (xread(fd, head, DEFAULT_ABBREV) < DEFAULT_ABBREV) {
+			int err = errno;
+			close(fd);
+			error(_("Corrupt '%s': %s"), HEAD_FILE, strerror(err));
+			return -err;
+		}
+		close(fd);
+
+		if (get_sha1(head, sha1))
+			return error(_("Failed to resolve '%s' as a valid ref."), head);
+		update_ref(NULL, "HEAD", sha1, NULL, 0, MSG_ON_ERR);
+	}
+	else if (opts->skip_oper) {
+		if (!file_exists(TODO_FILE))
+			goto error;
+		return 0;
+	}
+	else if (opts->continue_oper) {
+		if (!file_exists(TODO_FILE))
+			goto error;
+		return 0;
+	}
+
+	return pick_commits(opts);
+error:
+	return error(_("No %s in progress"), me);
+}
+
 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts;
@@ -810,9 +858,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 
 	opts.action = REVERT;
 	setenv(GIT_REFLOG_ACTION, "revert", 0);
-	parse_args(argc, argv, &opts);
-
-	return pick_commits(&opts);
+	return process_args(argc, argv, &opts);
 }
 
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
@@ -823,7 +869,5 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(struct replay_opts));
 	opts.action = CHERRY_PICK;
 	setenv(GIT_REFLOG_ACTION, "cherry-pick", 0);
-	parse_args(argc, argv, &opts);
-
-	return pick_commits(&opts);
+	return process_args(argc, argv, &opts);
 }
-- 
1.7.5.GIT
