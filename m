From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 10/10] revert: Implement --abort processing
Date: Thu, 26 May 2011 15:53:53 +0000
Message-ID: <1306425233-504-11-git-send-email-artagnon@gmail.com>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
 <1306425233-504-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 17:54:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPctA-0001N6-VR
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 17:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758012Ab1EZPyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 11:54:16 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43880 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017Ab1EZPyO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 11:54:14 -0400
Received: by mail-qw0-f46.google.com with SMTP id 3so441227qwk.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 08:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=vhXAPNZfwGws8Zo48iWzt83Y3UXN9vnhqpWuJ5l1d/g=;
        b=Hl2D9e9rNQtBPe4Q7rfMUvihdIAyg15MU3D8aTe8x5EUj9tt0PksIWpU/J0GIvTI2c
         6CnaI34eO9gvZMyz3Qy/ajtg9LIwOP/29BqWDzG7AzqjOy+faZDBrNa6CASjoAKC57pc
         FGVI8d8EOOHrYG0h1qo48Z9/h05CACp9LXntc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZHbhokIxHiHmY9jlE2gxDjVVGNTvZ7+4ETCpps+U+55Xz00X3nSZCDld15SGu3f9Gw
         98++JRvl41D/wErTkLs59SLymaZnNIwY2MUPMoeNlWwkPP4dv1kFfIjuy8qbvyxWRH2t
         9TnkijOhYfrrMEJMSapFHzrG16U2rhBI4p6II=
Received: by 10.229.34.75 with SMTP id k11mr351417qcd.18.1306425253667;
        Thu, 26 May 2011 08:54:13 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id j18sm513435qck.27.2011.05.26.08.54.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 May 2011 08:54:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306425233-504-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174531>

To abort, perform a "rerere clear" and "reset --hard" to the ref
specified by the HEAD file introduced earlier in the series.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   46 ++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index f33d40a..be63aee 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -208,8 +208,6 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 				NULL);
 
 	/* Remove these when the options are actually implemented */
-	if (opts->abort_oper)
-		die("--abort is not implemented yet");
 	if (opts->skip_oper)
 		die("--skip is not implemented yet");
 	if (opts->continue_oper)
@@ -732,6 +730,46 @@ static int pick_commits(struct replay_opts *opts)
 	return 0;
 }
 
+static int process_continuation(struct replay_opts *opts)
+{
+	if (opts->abort_oper) {
+		char head[DEFAULT_ABBREV];
+		unsigned char sha1[20];
+		int fd;
+		rerere_clear(0);
+
+		if (!file_exists(HEAD_FILE))
+			goto error;
+		fd = open(HEAD_FILE, O_RDONLY, 0666);
+		if (fd < 0)
+			return error(_("Could not open '%s' for reading: %s"),
+				HEAD_FILE, strerror(errno));
+		if (xread(fd, head, DEFAULT_ABBREV) < DEFAULT_ABBREV) {
+			close(fd);
+			return error(_("Corrupt '%s': %s"), HEAD_FILE, strerror(errno));
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
 	int res;
@@ -744,7 +782,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	me = "revert";
 	parse_args(argc, argv, &opts);
-	res = pick_commits(&opts);
+	res = process_continuation(&opts);
 	if (res > 0)
 		/* Exit status from conflict */
 		return res;
@@ -764,7 +802,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	me = "cherry-pick";
 	parse_args(argc, argv, &opts);
-	res = pick_commits(&opts);
+	res = process_continuation(&opts);
 	if (res > 0)
 		return res;
 	if (res < 0)
-- 
1.7.5.GIT
