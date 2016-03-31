From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 3/4] bundle: don't leak an fd in case of early return
Date: Thu, 31 Mar 2016 11:04:05 -0700
Message-ID: <1459447446-32260-4-git-send-email-sbeller@google.com>
References: <1459447446-32260-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: peff@peff.net, sunshine@sunshineco.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 31 20:04:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1algxH-0001NJ-9V
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 20:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757972AbcCaSEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 14:04:21 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36089 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757960AbcCaSET (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 14:04:19 -0400
Received: by mail-pa0-f47.google.com with SMTP id tt10so71242937pab.3
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 11:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+l+Mlsqc9yt6wMbNc5DYN3UQ/NaBSXOUyIUgDRpVEv4=;
        b=pj/lpqPFgSvA9OxsDTPwJYPfTpuD3NXjYbxMMxE3YxfhmZoeHDYTsocuaD2sw9i0AJ
         1ocO5r7Du890C9/S26l9gO0zYEDjs9dbtaOEnDbzbnFWETvkmeH9ptJeKn2S2w8yOBP+
         6JYUpMhvuPEX3OzipHhEVsX4Mk4WdoiX9bb74XcYOrBTu6Pw6g7hLM/dkYRHL/3u7Cf9
         uR0vuamPgWQLnTn0dmBxJzBugqSVAcV90RrUg2MeqQwMB9GBTRn8kLMtznY4Tq2STvHe
         YaTqpdmd4PUhfUIBYjzmyHQloBa3u+NsYOqMnB1bRo85e8k668kwtLx+QO4ER1oAiClB
         eMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+l+Mlsqc9yt6wMbNc5DYN3UQ/NaBSXOUyIUgDRpVEv4=;
        b=LyLp6oN/x5pqa7gyqGd6RX2LLF3SkOK/9sWzx5eRN8wMw7rx881LEUNtw7PbN6M7gl
         rzYJKr/0y8dsQXHj8EsRIFKQODOKjAAUfgOtetEWNuCe92V9nQEGLprsvWSoKICu78kQ
         V0/cajZEdL0Id2ebEnu6cszeEgy2W8VgloA3irf7uYmwvML2IpRsES1on9RgjKH4/i3b
         pf+45Udbl/WV3BdkeHi3vkju3NoLlPuVM05M/mJlUUxbVemuJ1z7kdLslWSIXKeIxQqe
         j7Bz3rw/dk4mp+zYbJwsQHYeUKTqTu7rrV1mq6uVEsWAKD/do2eU6hUr3QvqP2Jlf4jI
         q94Q==
X-Gm-Message-State: AD7BkJJJBvqL8AlD7/Racf0xC1FU4V0HBhi9bKhl2ppnvfmVpR/Pr6f0PgXumYe1ENH903NU
X-Received: by 10.66.66.135 with SMTP id f7mr23934404pat.101.1459447457905;
        Thu, 31 Mar 2016 11:04:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:30b6:9b24:6e56:d07e])
        by smtp.gmail.com with ESMTPSA id 16sm14973294pfk.28.2016.03.31.11.04.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 31 Mar 2016 11:04:17 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g4004fdc.dirty
In-Reply-To: <1459447446-32260-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290438>

In successful operation `write_pack_data` will close the `bundle_fd`,
but when we exit early, we need to take care of the file descriptor
as well as the lock file ourselves. The lock file may be deleted at the
end of running the program, but we are in library code, so we should
not rely on that.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 bundle.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/bundle.c b/bundle.c
index 506ac49..31ae1da 100644
--- a/bundle.c
+++ b/bundle.c
@@ -435,12 +435,14 @@ int create_bundle(struct bundle_header *header, const char *path,
 
 	/* write prerequisites */
 	if (compute_and_write_prerequisites(bundle_fd, &revs, argc, argv))
-		return -1;
+		goto err;
 
 	argc = setup_revisions(argc, argv, &revs, NULL);
 
-	if (argc > 1)
-		return error(_("unrecognized argument: %s"), argv[1]);
+	if (argc > 1) {
+		error(_("unrecognized argument: %s"), argv[1]);
+		goto err;
+	}
 
 	object_array_remove_duplicates(&revs.pending);
 
@@ -448,17 +450,22 @@ int create_bundle(struct bundle_header *header, const char *path,
 	if (!ref_count)
 		die(_("Refusing to create empty bundle."));
 	else if (ref_count < 0)
-		return -1;
+		goto err;
 
 	/* write pack */
 	if (write_pack_data(bundle_fd, &revs))
-		return -1;
+		goto err;
 
 	if (!bundle_to_stdout) {
 		if (commit_lock_file(&lock))
 			die_errno(_("cannot create '%s'"), path);
 	}
 	return 0;
+err:
+	if (!bundle_to_stdout)
+		close(bundle_fd);
+	rollback_lock_file(&lock);
+	return -1;
 }
 
 int unbundle(struct bundle_header *header, int bundle_fd, int flags)
-- 
2.5.0.264.g4004fdc.dirty
