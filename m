From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/4] commit: -F overrides -t
Date: Sat, 23 May 2009 11:53:10 -0700
Message-ID: <1243104793-3254-2-git-send-email-bebarino@gmail.com>
References: <1243104793-3254-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 20:53:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7wLr-0007xZ-GK
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 20:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbZEWSxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 14:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbZEWSxU
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 14:53:20 -0400
Received: from mail-px0-f103.google.com ([209.85.216.103]:54773 "EHLO
	mail-px0-f103.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903AbZEWSxT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 14:53:19 -0400
Received: by mail-px0-f103.google.com with SMTP id 1so1894468pxi.33
        for <git@vger.kernel.org>; Sat, 23 May 2009 11:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=K76hTsxz1VAOlcpNkC7hsPletMnhX5FLr3NV1K3Ohjo=;
        b=XcgUWBF2HoacW9rEmxNLS4HJx5Ig9983/XMA8hAxp+M1SCTJVW+0ok+uWTAR4vMT6N
         IquX9quYbW241X3emZLLmigxyD4WP/9P/7q9f/hZd2ZFe65OHIVreGobny6IY/7jqKIj
         AFz88/uOyW5jReCPihGaiSGJZlpyBaFN5x3IA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rZkplB7gLhKtHLTfeTyzp4PYL2nomkfS15mqIcOijbf0ZaRaxwkcIPbywCvYk1t5XI
         WUVUtVntG/sHytsYdgL4lHqa6CjkqtBEeK5UnSkxsn3xfOsUez6kPDAk/SFUjMvR5utM
         2X0Bf3Yuzq/p/9knq4GZUFfkSKZxYMtdrw22o=
Received: by 10.114.127.1 with SMTP id z1mr10933944wac.3.1243104801747;
        Sat, 23 May 2009 11:53:21 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id j28sm10705022waf.23.2009.05.23.11.53.18
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 May 2009 11:53:19 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sat, 23 May 2009 11:53:17 -0700
X-Mailer: git-send-email 1.6.3.1.145.gb74d77
In-Reply-To: <1243104793-3254-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119783>

Commit dbd0f5c7 (Files given on the command line are relative to $cwd,
2008-08-06) introduced parse_options_fix_filename() as a quick fix for
filename arguments used in the parse options API.

git-commit was still broken. This means

    git commit -F log -t temp

in a subdirectory would make git think the log message should be taken
from temp instead of log.

This is because parse_options_fix_filename() calls prefix_filename()
which uses a single static char buffer to do its work. Making two calls
with two char pointers causes the pointers to alias. To prevent
aliasing, we duplicate the string returned by
parse_options_fix_filename().

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 builtin-commit.c  |    4 ++++
 t/t7500-commit.sh |   10 ++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 81371b1..baaa75c 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -699,7 +699,11 @@ static int parse_and_validate_options(int argc, const char *argv[],
 
 	argc = parse_options(argc, argv, builtin_commit_options, usage, 0);
 	logfile = parse_options_fix_filename(prefix, logfile);
+	if (logfile)
+		logfile = xstrdup(logfile);
 	template_file = parse_options_fix_filename(prefix, template_file);
+	if (template_file)
+		template_file = xstrdup(template_file);
 
 	if (force_author && !strchr(force_author, '>'))
 		force_author = find_author_by_nickname(force_author);
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 5998baf..8eec0fa 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -183,4 +183,14 @@ test_expect_success 'commit message from stdin' '
 	commit_msg_is "Log with foo word"
 '
 
+test_expect_success 'commit -F overrides -t' '
+	(
+		cd subdir &&
+		echo "-F log" > f.log &&
+		echo "-t template" > t.template &&
+		git commit --allow-empty -F f.log -t t.template
+	) &&
+	commit_msg_is "-F log"
+'
+
 test_done
-- 
1.6.3.1.145.gb74d77
