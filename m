From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 10/10] revert: Implement --abort processing
Date: Wed, 25 May 2011 14:17:05 +0000
Message-ID: <1306333025-29893-11-git-send-email-artagnon@gmail.com>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 16:17:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPEtt-0003Uq-WD
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 16:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670Ab1EYORZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 10:17:25 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:36798 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932600Ab1EYORX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 10:17:23 -0400
Received: by mail-qy0-f174.google.com with SMTP id 7so2121342qyk.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=TzTrE7GJhsdykIiQcimx5KwVLcrkyqQbhvLadqIXj5Q=;
        b=s/to8N2c2oMYpUguCKXBkwo9W2PW4V0mShW4/FhkREaozQzwFyAXTDoujuLYjea0Ne
         x0Th8eapKoMl6CT4i74XR0OUmvuzoKL9OpqlWeZa5R6B7IVZSIheG/SvaeBU0rtg4w+o
         HZy1TpJLxl7fFBqAGwZik7xx+bNr5tuFWzP50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JUI8Ikl2R6vaISMHS3ackVOEKwyvBeJowPndsdXF1e8g0GauwqugMaiOBPgAI7THRw
         DK68nzQjIteEWdXmqLtjzVS7gkFRLT8tSLB39c2c3oOezs06dzs93YPG2cdwxbFiEIEI
         flTh2FIyvtbz7hWnO0fAnvWtLJJj2IpJuoo4E=
Received: by 10.224.63.218 with SMTP id c26mr3930145qai.43.1306333043433;
        Wed, 25 May 2011 07:17:23 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id t17sm5285636qcs.35.2011.05.25.07.17.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 07:17:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174398>

To abort, perform a "rerere clear" and "reset --hard" to the ref
specified by the HEAD file introduced earlier in the series.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   46 ++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 4607676..6a93175 100644
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
@@ -742,6 +740,46 @@ static int pick_commits(struct replay_opts *opts)
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
 	int res = 0;
@@ -754,7 +792,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	me = "revert";
 	parse_args(argc, argv, &opts);
-	res = pick_commits(&opts);
+	res = process_continuation(&opts);
 	if (res > 0)
 		/* Exit status from conflict */
 		return res;
@@ -774,7 +812,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
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
