From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 09/13] revert: Catch incompatible command-line options early
Date: Tue, 21 Jun 2011 13:04:45 +0000
Message-ID: <1308661489-20080-10-git-send-email-artagnon@gmail.com>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 15:05:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ0e8-00065X-BI
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 15:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756674Ab1FUNFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 09:05:16 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38726 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756639Ab1FUNFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 09:05:09 -0400
Received: by vws1 with SMTP id 1so1674375vws.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 06:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=YcjVUIH/QsuR2ITuA4b6LcrnzMYravP5MYKEsmY2UQk=;
        b=GNiKoG5JNeh7WgGAM4GMAEaz8jMoqDJNY4UAA94DL1Z8D1RScW7g3/wsZ9bqarJPTu
         B7ZhXWVW84FRLrnQm2psRf6dB/qBKcKPICTAB5i5FQ61B1FXzl4GubegrVXZVrH8C8q9
         ucUITgeKQLclL36pW7m8MeeCwRPzGU5o9Y9L0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=aTeq8xy2A3E0Ec8vTYRj/gHCIl6vSc3YmgwQ0oGCbVS5H2HC2gyRds6Kz+oFBqHm9G
         ADAONLNR/EtxcPhooLauBAw3p3zGvGypW/dWtUgrULqLkXMq024z+SDy+0LSZGpQwAFt
         3YobJdHrO0IALXyHhgvE/4uaKhRPiHLBxOUJg=
Received: by 10.52.73.34 with SMTP id i2mr1794925vdv.166.1308661508815;
        Tue, 21 Jun 2011 06:05:08 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id k9sm1575853vbn.0.2011.06.21.06.05.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 06:05:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176151>

Earlier, incompatible command-line options used to be caught in
pick_commits after parse_args has parsed the options and populated the
options structure.  Instead, hand over the responsibility of catching
incompatible command-line options to parse_args so that the program
can die early.  Also write a verify_opt_compatible function to handle
incompatible options in a general manner.

Inspired-by: Christian Couder <chiscool@tuxfamily.org>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   34 +++++++++++++++++++++++-----------
 1 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 93e0531..cfa898f 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -82,6 +82,22 @@ static int option_parse_x(const struct option *opt,
 	return 0;
 }
 
+static void verify_opt_compatible(const char *me, const char *base_opt, ...)
+{
+	const char *this_opt;
+	va_list ap;
+	int set;
+
+	va_start(ap, base_opt);
+	while ((this_opt = va_arg(ap, const char *))) {
+		set = va_arg(ap, int);
+		if (set)
+			die(_("%s: %s cannot be used with %s"),
+				me, this_opt, base_opt);
+	}
+	va_end(ap);
+}
+
 static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 {
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
@@ -118,6 +134,13 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	if (opts->commit_argc < 2)
 		usage_with_options(usage_str, options);
 
+	if (opts->allow_ff)
+		verify_opt_compatible(me, "--ff",
+				"--signoff", opts->signoff,
+				"--no-commit", opts->no_commit,
+				"-x", opts->record_origin,
+				"--edit", opts->edit,
+				NULL);
 	opts->commit_argv = argv;
 }
 
@@ -557,17 +580,6 @@ static int pick_commits(struct replay_opts *opts)
 	struct commit *commit;
 
 	setenv(GIT_REFLOG_ACTION, me, 0);
-	if (opts->allow_ff) {
-		if (opts->signoff)
-			die(_("cherry-pick --ff cannot be used with --signoff"));
-		if (opts->no_commit)
-			die(_("cherry-pick --ff cannot be used with --no-commit"));
-		if (opts->record_origin)
-			die(_("cherry-pick --ff cannot be used with -x"));
-		if (opts->edit)
-			die(_("cherry-pick --ff cannot be used with --edit"));
-	}
-
 	read_and_refresh_cache(me, opts);
 
 	prepare_revs(&revs, opts);
-- 
1.7.5.GIT
