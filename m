From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 05/11] revert: Catch incompatible command-line options early
Date: Sun, 10 Apr 2011 20:41:51 +0530
Message-ID: <1302448317-32387-6-git-send-email-artagnon@gmail.com>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 10 17:13:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8wKU-0008GQ-VR
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 17:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755259Ab1DJPNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 11:13:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58633 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970Ab1DJPN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 11:13:29 -0400
Received: by mail-iw0-f174.google.com with SMTP id 34so4864294iwn.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 08:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=OYAFwbVxAwgKKsiFR6kUYNzxAe2fXgfeMnMVZgfMVXY=;
        b=WLju7xXPE7mABr178zw9f+/khUDEEdqOqs82OprbDL2wbVb3M7KjosZfpucG8xmVDZ
         Wnb9cue4s4e/8y30yDWgpoCtJZipIiM0d7v7AWS4cmyGZcj1GWruyQ42huYqaI6RIWAf
         jzojH7d9c6zngycPbeyq4Ryn8LklOYyLF+aSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FHkl7/kmKKqxzPNatD1d+4flkdX2JScqmXXNHZtF7ixPNtJRqXOe/7EbspBqxg/B+j
         E19a08POlnuqRgnotDeALTLk0FFfYWnz+1gkeGm7jIwxGH2k6obbWroowsJMGbipOHyj
         PjUGErdSBdoeYly59CUN34VJb0h/4gTt0jBUg=
Received: by 10.42.74.194 with SMTP id x2mr6721157icj.113.1302448409133;
        Sun, 10 Apr 2011 08:13:29 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id f28sm3367928ibh.67.2011.04.10.08.13.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 08:13:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171259>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   36 +++++++++++++++++++++++++-----------
 1 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 9381541..facae24 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -77,6 +77,24 @@ static int option_parse_x(const struct option *opt,
 	return 0;
 }
 
+static void die_opt_incompatible(const char *me, const char *base_opt,
+				int nargs, int opt_bitarray[], ...)
+{
+	const char *this_opt = NULL;
+	va_list ap;
+	int i;
+
+	va_start(ap, opt_bitarray);
+	for (i = 0; i < nargs; i ++) {
+		this_opt = va_arg(ap, const char *);
+		if (opt_bitarray[i]) {
+			die(_("%s: %s cannot be used with %s"),
+				me, this_opt, base_opt);
+		}
+	}
+	va_end(ap);
+}
+
 static void parse_args(int argc, const char **argv)
 {
 	const char * const * usage_str = revert_or_cherry_pick_usage();
@@ -112,6 +130,13 @@ static void parse_args(int argc, const char **argv)
 	if (cmd_opts.commit_argc < 2)
 		usage_with_options(usage_str, options);
 
+	if (cmd_opts.allow_ff) {
+		int opt_bitarray[] = {cmd_opts.signoff, cmd_opts.no_commit,
+				      cmd_opts.no_replay, cmd_opts.edit};
+		die_opt_incompatible(me, "--ff", 4, opt_bitarray, "--signoff",
+				"--no-commit", "-x", "--edit");
+	}
+
 	cmd_opts.commit_argv = argv;
 }
 
@@ -584,17 +609,6 @@ static int pick_commits(void)
 	struct commit *commit;
 	int res;
 
-	if (cmd_opts.allow_ff) {
-		if (cmd_opts.signoff)
-			die(_("cherry-pick --ff cannot be used with --signoff"));
-		if (cmd_opts.no_commit)
-			die(_("cherry-pick --ff cannot be used with --no-commit"));
-		if (cmd_opts.no_replay)
-			die(_("cherry-pick --ff cannot be used with -x"));
-		if (cmd_opts.edit)
-			die(_("cherry-pick --ff cannot be used with --edit"));
-	}
-
 	if ((res = read_and_refresh_cache()) ||
 		(res = prepare_revs(&revs)))
 		return res;
-- 
1.7.4.rc1.7.g2cf08.dirty
