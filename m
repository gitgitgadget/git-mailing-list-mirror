From: Jiang Xin <worldhello.net@gmail.com>
Subject: [RFC] reflog: show committer date in verbose mode
Date: Fri, 31 May 2013 09:44:53 +0800
Message-ID: <c05d3472f28695a10154cda8ed2c973baf5e20b7.1369964641.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 31 03:45:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiEPJ-0002DD-JL
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 03:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469Ab3EaBpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 21:45:09 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:59169 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab3EaBpH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 21:45:07 -0400
Received: by mail-pd0-f179.google.com with SMTP id q11so1349704pdj.10
        for <git@vger.kernel.org>; Thu, 30 May 2013 18:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=V2FUMVbAiIiUmmysF3KdpfiQEN+QoyjKmWdnYRdBYbI=;
        b=Dy2llQA4dkU+qwres0QZTZcBazFoBT3+cosTGNksbfBIhh5cJJw/eMNTrCY0fO3WJK
         WdWEBv7Od0mT0u5+eSwzq8geVSyOOdZk5J8Kw7Nb65LcvCQEzYV1reyTjVdw9XEQEvoq
         AGN6/9VKGiSeWbhrnzwT6oKvf6HtlcOLUAfP+E7CegJ5Y39OKPpsl/E9bd06ScYvR/HG
         T7eMNKX+hIclb0WNX1kzCvx6wDXu7/xbLUT7Q9MggA8TByZvQXjpwjJKKVG2BNfmxcaC
         4GWfFyrT5ZAc3JUqspewA+sYS2gea5ED7tizCD+uvntg6YRgJTemevSXwcVPIq6Lmaw2
         foaw==
X-Received: by 10.68.217.197 with SMTP id pa5mr10538380pbc.127.1369964707118;
        Thu, 30 May 2013 18:45:07 -0700 (PDT)
Received: from localhost.localdomain ([114.248.151.127])
        by mx.google.com with ESMTPSA id xu10sm47248032pab.3.2013.05.30.18.45.04
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 30 May 2013 18:45:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.466.g52d8e0f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226043>

By default, reflog won't show committer date and for some cases won't
show commit log either. It will be helpful to show them all by passing
a more complicated pretty formatter to `git reflog` like this:

    $ git reflog show \
      --pretty="%Cred%h%Creset %gd: %gs%n  >> %Cblue%ci (%cr)%Creset: %s"

It will be nice to add this pretty formatter automatically when run
`git reflog` in verbose mode. Also add new flag "verbose" to rev_info.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/log.c | 31 +++++++++++++++++++++++++++++++
 revision.c    |  1 +
 revision.h    |  1 +
 3 files changed, 33 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index dd3f10..fd213 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -615,6 +615,37 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	rev.use_terminator = 1;
 	rev.always_show_header = 1;
 	cmd_log_init_finish(argc, argv, prefix, &rev, &opt);
+	if (rev.verbose && !rev.pretty_given) {
+		struct strbuf formatter = STRBUF_INIT;
+		rev.verbose_header = 1;
+		rev.pretty_given = 1;
+		strbuf_addf(&formatter, "%s%%h%s %%gd: %%gs%%n",
+			    diff_get_color_opt(&rev.diffopt, DIFF_COMMIT),
+			    diff_get_color_opt(&rev.diffopt, DIFF_RESET));
+		switch (rev.verbose) {
+		case 1:
+			strbuf_addf(&formatter, "    >> %s%%ci%s (%s%%cr%s)",
+				    diff_get_color_opt(&rev.diffopt, DIFF_METAINFO),
+				    diff_get_color_opt(&rev.diffopt, DIFF_RESET),
+				    diff_get_color_opt(&rev.diffopt, DIFF_METAINFO),
+				    diff_get_color_opt(&rev.diffopt, DIFF_RESET));
+			strbuf_addstr(&formatter, ": %s");
+			break;
+		default:
+			strbuf_addf(&formatter, "    >> %s%%cD%s (%s%%cr%s)",
+				    diff_get_color_opt(&rev.diffopt, DIFF_METAINFO),
+				    diff_get_color_opt(&rev.diffopt, DIFF_RESET),
+				    diff_get_color_opt(&rev.diffopt, DIFF_METAINFO),
+				    diff_get_color_opt(&rev.diffopt, DIFF_RESET));
+			strbuf_addf(&formatter, ", by %s%%an%s",
+				    diff_get_color_opt(&rev.diffopt, DIFF_METAINFO),
+				    diff_get_color_opt(&rev.diffopt, DIFF_RESET));
+			strbuf_addstr(&formatter, ": %s");
+			break;
+		}
+		get_commit_format(formatter.buf, &rev);
+		strbuf_release(&formatter);
+	}
 
 	return cmd_log_walk(&rev);
 }
diff --git a/revision.c b/revision.c
index 518cd..f7483 100644
--- a/revision.c
+++ b/revision.c
@@ -1514,6 +1514,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->combine_merges = 1;
 	} else if (!strcmp(arg, "-v")) {
 		revs->verbose_header = 1;
+		revs->verbose++;
 	} else if (!strcmp(arg, "--pretty")) {
 		revs->verbose_header = 1;
 		revs->pretty_given = 1;
diff --git a/revision.h b/revision.h
index a313a..032ec 100644
--- a/revision.h
+++ b/revision.h
@@ -119,6 +119,7 @@ struct rev_info {
 			show_notes_given:1,
 			show_signature:1,
 			pretty_given:1,
+			verbose:4,
 			abbrev_commit:1,
 			abbrev_commit_given:1,
 			use_terminator:1,
-- 
1.8.3.466.g52d8e0f
