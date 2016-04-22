From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v2 1/4] rev-parse: fix some options when executed from subpath of main tree
Date: Fri, 22 Apr 2016 17:53:09 -0400
Message-ID: <1461361992-91918-2-git-send-email-rappazzo@gmail.com>
References: <1461361992-91918-1-git-send-email-rappazzo@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com, pclouds@gmail.com,
	Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 23:53:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atj0f-0001j5-C1
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 23:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616AbcDVVxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 17:53:05 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35599 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbcDVVxC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 17:53:02 -0400
Received: by mail-yw0-f194.google.com with SMTP id v81so16133739ywa.2
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 14:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j3C02oIjMpqzq5oCLOq2tqaFSOelCXqDgkUR4doIoIk=;
        b=mxIiJfzJkSyEJGbBFQ1RYAMVYVLmmV5JbHhisEkxXoTpYL7mg+ML7hF1F+cz+GFA58
         DXbExH1/OCT6dedX2KDKYU3KL34z8eXPatOu+2LtoGwpiyifMKJ2zoSpLUM49n7uNt1P
         e5NgAsbM+iGGALtO54AhuW3qBzQHk9/QDTI4X/o4zrSvIYYfQplnvUQYClwGec0dYMAf
         ichSYHw0JUJQYLtINNTCas6gLRUXLS9dyuVzAzptocN+Lk3iTG3Imw9AA7LETjfPJ4xA
         06vcnUZeN4vXwimT2ZoRaHObxeqfLtOBniij+qqK9aaf+GnawgfjRitGDOuJajxrveCO
         fKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j3C02oIjMpqzq5oCLOq2tqaFSOelCXqDgkUR4doIoIk=;
        b=JnOml/UDcDgY/ruIILNVjW5zfmttg2cCDKBv8v0CwITCEIUfP/sstHGNYnedSs37sE
         E+RvEFnIyP7nDG1UGiADFh2KV+CxXEHqU+4YairP/CkQPjzmWvT1uPWCo+NpshiWOc0S
         8sNT7MtSuS/nAJVasohjjLOX72IXptP0OMYYJiG652Z1U3RUJJ4nzrw7CSNLSMmhgZBV
         2CUE9iBuqlbyCJek9sselFsGTSoYMjOfAGREPTjnuOj5kiZXKGk9gLetdPjkhjohfJ/Z
         AfkQXo+N4LBQGsnslAzBwduBSCz4KWoEBe62q6H3W/aebVQdDysqW3YtBQKWV/JJw3Ju
         9mhQ==
X-Gm-Message-State: AOPr4FVqngcz0/IzBHzOFMwVkvzOd4YrTTxE4bggtkN2cs0r3Mahneyalg86N8NeDfczOg==
X-Received: by 10.37.83.131 with SMTP id h125mr9504765ybb.109.1461361981739;
        Fri, 22 Apr 2016 14:53:01 -0700 (PDT)
Received: from MRappazzo-8.local.com (pool-100-35-125-216.nwrknj.fios.verizon.net. [100.35.125.216])
        by smtp.gmail.com with ESMTPSA id m141sm5542104ywd.2.2016.04.22.14.53.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 14:53:01 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461361992-91918-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292269>

Executing `git-rev-parse` with `--git-common-dir`, `--git-path <path>`,
or `--shared-index-path` from the root of the main worktree results in
a relative path to the git dir.

When executed from a subdirectory of the main tree, however, it incorrectly
returns a path which starts 'sub/path/.git'.  Change this to return the
proper relative path to the git directory.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 builtin/rev-parse.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index c961b74..1da2e10 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -564,10 +564,13 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		}
 
 		if (!strcmp(arg, "--git-path")) {
+			struct strbuf sb = STRBUF_INIT;
 			if (!argv[i + 1])
 				die("--git-path requires an argument");
-			puts(git_path("%s", argv[i + 1]));
-			i++;
+
+			puts(relative_path(xstrfmt("%s/%s", get_git_dir(), argv[++i]),
+				prefix, &sb));
+			strbuf_release(&sb);
 			continue;
 		}
 		if (as_is) {
@@ -787,8 +790,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--git-common-dir")) {
-				const char *pfx = prefix ? prefix : "";
-				puts(prefix_filename(pfx, strlen(pfx), get_git_common_dir()));
+				struct strbuf sb = STRBUF_INIT;
+				puts(relative_path(get_git_common_dir(), prefix, &sb));
+				strbuf_release(&sb);
 				continue;
 			}
 			if (!strcmp(arg, "--is-inside-git-dir")) {
@@ -811,7 +815,12 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 					die(_("Could not read the index"));
 				if (the_index.split_index) {
 					const unsigned char *sha1 = the_index.split_index->base_sha1;
-					puts(git_path("sharedindex.%s", sha1_to_hex(sha1)));
+					struct strbuf sb = STRBUF_INIT;
+
+					puts(relative_path(
+						xstrfmt("%s/sharedindex.%s", get_git_dir(), sha1_to_hex(sha1)),
+						prefix, &sb));
+					strbuf_release(&sb);
 				}
 				continue;
 			}
-- 
2.8.0
