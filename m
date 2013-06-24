From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/2] status: really ignore config with --porcelain
Date: Mon, 24 Jun 2013 18:15:11 +0530
Message-ID: <1372077912-18625-2-git-send-email-artagnon@gmail.com>
References: <1372077912-18625-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 24 14:48:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur6CK-0004MQ-RU
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 14:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029Ab3FXMsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 08:48:42 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36059 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab3FXMsl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 08:48:41 -0400
Received: by mail-pa0-f44.google.com with SMTP id lj1so10994996pab.3
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 05:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=E4OLlJfXg3zYFIKPL7zjxbQUYogwUOiIFqu6SVZ9nAc=;
        b=nsJy/1uRi/HtXI+xx9Aq5cnM6x9stEczONNxVdXon4Zv+UqWIuPewGpmzbRkw4oLtA
         McRWjJXXLjZDbvhZ95+CVBBe/4tur/A+61NEk2UYizWkzkovqHy2qaqs7+D+2gkp8DTO
         BwoBWAw7TiO4EfGrNVeDy3e6ZMoKzJzsbBOmjxNSSUGLTx0y52ZzBtHgk8gpOLY4ZzQg
         buJphD4VlHXHkmKGqJ8Dn2ATT+aH6iDXce92DXefaA0DUsVRGzlJXc7hgv1DlYUnKpNi
         KR5bWAs8oma2EVf2krvyFwksGs+jR4am9XrlIqV4nlqBHAGdH69DaRqAFA8QLqTnVbWB
         XyUQ==
X-Received: by 10.66.146.164 with SMTP id td4mr27469547pab.106.1372078120599;
        Mon, 24 Jun 2013 05:48:40 -0700 (PDT)
Received: from localhost.localdomain ([122.164.185.186])
        by mx.google.com with ESMTPSA id yj2sm18024267pbb.40.2013.06.24.05.48.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 05:48:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.550.gd96f26e.dirty
In-Reply-To: <1372077912-18625-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228809>

1a22bd3 (Merge branch 'jg/status-config', 2013-06-23) introduced a
serious regression in --porcelain by introducing the configuration
variables status.short and status.branch.  Contrary to its description,
the output of

  $ git status --porcelain

now depends on the configuration variables status.short and
status.branch.  As a result, callers that expect parsable output to be
returned are broken.  For instance, in a repository with submodules with
status.branch and status.short set,

  $ git status

always reports all submodules as containing modified content, even if
they are clean.

One solution to the problem is to turn off s->show_branch in
wt_porcelain_print() just like we turn off other s->* variables, but
that would break callers of --porcelain --branch (in fact, there is such
a caller in t/t7508-status.sh).  Besides, we never said that --porcelain
cannot be combined with other options.  The larger problem is that the
config parser and command-line option parser set the same variables,
making it impossible to determine who set them.

The correct solution is therefore to skip the config parser completely
when --porcelain is given.  Unfortunately, to determine that --porcelain
is given, we have to run the command-line option parser.  Running the
command-line option parser before the config parser is undesirable, as
configuration variables would override options on the command-line.  As
a fair compromise, check that argv[1] is equal to the string
"--porcelain" and skip the config parser in this case.  It is a
compromise, because we expect --porcelain to be specified as the first
argument to status.

On a related note, the command-line parser is not very robust.

  $ git status --short --long
  $ git status --long --long
  $ git status --porcelain --long
  $ git status --long --porcelain
  $ git status --porcelain --short
  $ git status --short --porcelain

all return different outputs.  This bug is left as an exercise for
future contributors to fix.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/commit.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index b589ce0..896f002 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1193,7 +1193,12 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	wt_status_prepare(&s);
 	gitmodules_config();
-	git_config(git_status_config, &s);
+
+	if (argc > 1 && !strcmp(argv[1], "--porcelain"))
+		; /* Do not read user configuration */
+	else
+		git_config(git_status_config, &s);
+
 	determine_whence(&s);
 	argc = parse_options(argc, argv, prefix,
 			     builtin_status_options,
-- 
1.8.3.1.550.gd96f26e.dirty
