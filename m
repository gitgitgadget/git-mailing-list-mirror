From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] bundle: use internal argv_array of struct child_process in
 create_bundle()
Date: Fri, 18 Jul 2014 01:27:41 +0200
Message-ID: <53C85BED.9060207@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 18 01:28:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7v5l-0005C1-86
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 01:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758356AbaGQX15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2014 19:27:57 -0400
Received: from mout.web.de ([212.227.15.4]:51530 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758309AbaGQX14 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 19:27:56 -0400
Received: from [192.168.178.27] ([79.250.176.74]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MI6JC-1X7Mam3op4-003rwz; Fri, 18 Jul 2014 01:27:50
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:kuqoojHklfOMv6qFUGrLrlVFl6KVhTCS95kVFDNvZ0GiGHeyNhJ
 hLhN2gy5MMYRh1ydQTuoupnDiT2pCoNfHeq6TgO3yt+6gwqCdxfusEY2zdmI91cWKoZdDAH
 F28qCQF9ZdWHmFlZPVnWDSz3S0oTSvbS/fKYTgQ7Hr7L8gi7jl6hyFraM3+z/fElKV+c/mg
 NmrhVso9RdaKjps/tQ1/A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253788>

Use the existing argv_array member instead of providing our own.  This
way the argv_array is cleared after use automatically for us; it was
leaking before.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 bundle.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/bundle.c b/bundle.c
index 1222952..71a21a6 100644
--- a/bundle.c
+++ b/bundle.c
@@ -237,8 +237,6 @@ int create_bundle(struct bundle_header *header, const char *path,
 	static struct lock_file lock;
 	int bundle_fd = -1;
 	int bundle_to_stdout;
-	struct argv_array argv_boundary = ARGV_ARRAY_INIT;
-	struct argv_array argv_pack = ARGV_ARRAY_INIT;
 	int i, ref_count = 0;
 	struct strbuf buf = STRBUF_INIT;
 	struct rev_info revs;
@@ -260,14 +258,12 @@ int create_bundle(struct bundle_header *header, const char *path,
 	init_revisions(&revs, NULL);
 
 	/* write prerequisites */
-	argv_array_pushl(&argv_boundary,
+	memset(&rls, 0, sizeof(rls));
+	argv_array_pushl(&rls.args,
 			 "rev-list", "--boundary", "--pretty=oneline",
 			 NULL);
 	for (i = 1; i < argc; i++)
-		argv_array_push(&argv_boundary, argv[i]);
-
-	memset(&rls, 0, sizeof(rls));
-	rls.argv = argv_boundary.argv;
+		argv_array_push(&rls.args, argv[i]);
 	rls.out = -1;
 	rls.git_cmd = 1;
 	if (start_command(&rls))
@@ -382,12 +378,11 @@ int create_bundle(struct bundle_header *header, const char *path,
 	write_or_die(bundle_fd, "\n", 1);
 
 	/* write pack */
-	argv_array_pushl(&argv_pack,
+	memset(&rls, 0, sizeof(rls));
+	argv_array_pushl(&rls.args,
 			 "pack-objects", "--all-progress-implied",
 			 "--stdout", "--thin", "--delta-base-offset",
 			 NULL);
-	memset(&rls, 0, sizeof(rls));
-	rls.argv = argv_pack.argv;
 	rls.in = -1;
 	rls.out = bundle_fd;
 	rls.git_cmd = 1;
-- 
2.0.0
