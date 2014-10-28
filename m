From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] use child_process_init() to initialize struct child_process
 variables
Date: Tue, 28 Oct 2014 21:52:34 +0100
Message-ID: <54500212.7040603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 28 21:52:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjDl4-0002yQ-7a
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 21:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172AbaJ1Uwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2014 16:52:46 -0400
Received: from mout.web.de ([212.227.17.11]:56484 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753496AbaJ1Uwp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 16:52:45 -0400
Received: from [192.168.178.27] ([79.253.156.206]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MPYNR-1Xf79M14nh-004o2o; Tue, 28 Oct 2014 21:52:41
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-Provags-ID: V03:K0:a5JyCdexDubL3We70AFAs34HazbkS9r9W2vmYidKo1XkbhP1ilH
 8OWwq0v20hjhTfU+nm4gyJ5q1fwmAuaPcu0SUtrwzGlhPGh4qDAsM4aa7mq82hCd1/c2FT+
 MEbMeuL5XSvuP1DrmKq1kgl6crz3dzg+3L5k0xaqTR+6QbD1ncC1raN9MZcwoKmATa7KQ2d
 VvZbZoiB8tr7Z8Xv0ugyg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call child_process_init() instead of zeroing the memory of variables of
type struct child_process by hand before use because the former is both
clearer and shorter.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 bundle.c           | 2 +-
 column.c           | 2 +-
 trailer.c          | 2 +-
 transport-helper.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/bundle.c b/bundle.c
index fa67057..c846092 100644
--- a/bundle.c
+++ b/bundle.c
@@ -381,7 +381,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 	write_or_die(bundle_fd, "\n", 1);
 
 	/* write pack */
-	memset(&rls, 0, sizeof(rls));
+	child_process_init(&rls);
 	argv_array_pushl(&rls.args,
 			 "pack-objects", "--all-progress-implied",
 			 "--stdout", "--thin", "--delta-base-offset",
diff --git a/column.c b/column.c
index 8082a94..786abe6 100644
--- a/column.c
+++ b/column.c
@@ -374,7 +374,7 @@ int run_column_filter(int colopts, const struct column_options *opts)
 	if (fd_out != -1)
 		return -1;
 
-	memset(&column_process, 0, sizeof(column_process));
+	child_process_init(&column_process);
 	argv = &column_process.args;
 
 	argv_array_push(argv, "column");
diff --git a/trailer.c b/trailer.c
index 8514566..7ff036c 100644
--- a/trailer.c
+++ b/trailer.c
@@ -237,7 +237,7 @@ static const char *apply_command(const char *command, const char *arg)
 		strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
 
 	argv[0] = cmd.buf;
-	memset(&cp, 0, sizeof(cp));
+	child_process_init(&cp);
 	cp.argv = argv;
 	cp.env = local_repo_env;
 	cp.no_stdin = 1;
diff --git a/transport-helper.c b/transport-helper.c
index 6cd9dd1..0224687 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -414,7 +414,7 @@ static int get_exporter(struct transport *transport,
 	struct child_process *helper = get_helper(transport);
 	int i;
 
-	memset(fastexport, 0, sizeof(*fastexport));
+	child_process_init(fastexport);
 
 	/* we need to duplicate helper->in because we want to use it after
 	 * fastexport is done with it. */
-- 
2.1.2
