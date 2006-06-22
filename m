From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] Make -p --stat and --stat -p behave like --patch-with-stat
Date: Thu, 22 Jun 2006 16:25:11 +0300
Message-ID: <20060622162511.4788505e.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 15:26:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtPBm-0006rF-8z
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 15:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161116AbWFVNZj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 09:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161117AbWFVNZj
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 09:25:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:968 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161116AbWFVNZi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 09:25:38 -0400
Received: by nf-out-0910.google.com with SMTP id o60so257101nfa
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 06:25:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=MduzHXbrchuamex9kTRRIS/e2yetnkfq2dxFRBndTwIKUKJZHwTHb2FmXtYbVhaJrMtZqP//dlx5DzAMgA9m3IGaZdnIYX1M4vUFkxwIz7EwujtrpBlqliO+arkUVDnuKSTEMGGyqzIZp9rx5B5FuwLjKKFAD3HpUgUCnJGvOpI=
Received: by 10.48.233.18 with SMTP id f18mr1399236nfh;
        Thu, 22 Jun 2006 06:25:37 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id q28sm1813894nfc.2006.06.22.06.25.11;
        Thu, 22 Jun 2006 06:25:25 -0700 (PDT)
To: junkio@cox.net
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22338>

git log                    log only
git log --stat             log with stat
git log -p                 log with patch
git log --stat -p          log with patch (no stat!)
git log -p --stat          log with stat (no patch!)
git log --patch-with-stat  log with patch and stat

This patch makes -p --stat and --stat -p work like --patch-with-stat.

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---

  Maybe DIFF_FORMAT_* should be reworked instead but this was easy.

  Only negative impact of this patch is that if you have a alias

     l=log --stat

  then you can't override --stat with "git l -p", it will still show
  diffstat, but I don't think it matters.

 diff.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 9e9cfc8..75632d3 100644
--- a/diff.c
+++ b/diff.c
@@ -1382,16 +1382,27 @@ int opt_arg(const char *arg, int arg_sho
 int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 {
 	const char *arg = av[0];
-	if (!strcmp(arg, "-p") || !strcmp(arg, "-u"))
+	if (!strcmp(arg, "-p") || !strcmp(arg, "-u")) {
+		if (options->output_format == DIFF_FORMAT_DIFFSTAT) {
+			// --stat -p
+			options->with_stat = 1;
+		}
 		options->output_format = DIFF_FORMAT_PATCH;
+	}
 	else if (opt_arg(arg, 'U', "unified", &options->context))
 		options->output_format = DIFF_FORMAT_PATCH;
 	else if (!strcmp(arg, "--patch-with-raw")) {
 		options->output_format = DIFF_FORMAT_PATCH;
 		options->with_raw = 1;
 	}
-	else if (!strcmp(arg, "--stat"))
-		options->output_format = DIFF_FORMAT_DIFFSTAT;
+	else if (!strcmp(arg, "--stat")) {
+		if (options->output_format == DIFF_FORMAT_PATCH) {
+			// -p --stat
+			options->with_stat = 1;
+		} else {
+			options->output_format = DIFF_FORMAT_DIFFSTAT;
+		}
+	}
 	else if (!strcmp(arg, "--check"))
 		options->output_format = DIFF_FORMAT_CHECKDIFF;
 	else if (!strcmp(arg, "--summary"))
-- 
1.4.0.g5fdc-dirty
