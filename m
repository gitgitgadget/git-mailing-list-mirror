From: Deskin Miller <deskinm@umich.edu>
Subject: [PATCH] maint: check return of split_cmdline to avoid bad config
	strings
Date: Wed, 24 Sep 2008 02:10:28 -0400
Message-ID: <20080924061028.GA2792@riemann.deskinm.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 24 08:12:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiNc4-0004CT-4N
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 08:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbYIXGL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 02:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbYIXGL0
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 02:11:26 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:51418 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbYIXGLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 02:11:25 -0400
Received: by yx-out-2324.google.com with SMTP id 8so379323yxm.1
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 23:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent
         :sender;
        bh=BVBm6RNiG57XmlOK1lBmwWrQAQ02u/27Frce6VH83+E=;
        b=ZkvMSnO2hW03T6iZUshsfru8MOIDbV0w680eo5tx/uBDQphUJzs6eRp/zXo23BsBs2
         rguLzb7j6Po08FYtG4bC0/5/UmzyZs/l8a4LUueJpOGxmnwZVzydVrwvvAQtw4vOfY1i
         4EUgAECw9iD93UPZtq6U/aCP7UdtxYn7modgM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent:sender;
        b=OROt2WEXB+oV3l/2kolShB48bXxjdhXqPznA0mU10vMw8KSiyetDVjn4FVSj260lte
         SzxB6ndJT/zZFfxhpMYQJNDXtDfsqL2+eCurOHph3Dc02FVutVSsty+G8VRWhWSB5azo
         S42/oljQO39wsGMpHmm7QTcERlCIBtbLFF1d8=
Received: by 10.90.70.15 with SMTP id s15mr2843539aga.78.1222236683673;
        Tue, 23 Sep 2008 23:11:23 -0700 (PDT)
Received: from riemann.deskinm.fdns.net ([68.40.49.130])
        by mx.google.com with ESMTPS id c44sm1794106hsc.12.2008.09.23.23.11.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Sep 2008 23:11:22 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96617>

>From 7679d395856d17d7853eea0fc196435eab9be08f Mon Sep 17 00:00:00 2001
From: Deskin Miller <deskinm@umich.edu>
Date: Mon, 22 Sep 2008 11:06:41 -0400
Subject: [PATCH] maint: check return of split_cmdline to avoid bad config strings

Signed-off-by: Deskin Miller <deskinm@umich.edu>
---
As the testcase demonstrates, it's possible to have split_cmdline return -1 and
deallocate any memory it's allocated, if the config string is missing an end
quote.  In both the cases below, the return isn't checked, causing a pretty
immediate segfault.
 builtin-merge.c        |    2 ++
 git.c                  |    2 ++
 t/t1300-repo-config.sh |   10 ++++++++++
 3 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index b280444..dcaf368 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -442,6 +442,8 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 
 		buf = xstrdup(v);
 		argc = split_cmdline(buf, &argv);
+		if (argc < 0)
+			die("Bad branch.%s.mergeoptions string", branch);
 		argv = xrealloc(argv, sizeof(*argv) * (argc + 2));
 		memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
 		argc++;
diff --git a/git.c b/git.c
index fdb0f71..5582c51 100644
--- a/git.c
+++ b/git.c
@@ -162,6 +162,8 @@ static int handle_alias(int *argcp, const char ***argv)
 			    alias_string + 1, alias_command);
 		}
 		count = split_cmdline(alias_string, &new_argv);
+		if (count < 0)
+			die("Bad alias.%s string", alias_command);
 		option_count = handle_options(&new_argv, &count, &envchanged);
 		if (envchanged)
 			die("alias '%s' changes environment variables\n"
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 64567fb..3794d23 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -741,4 +741,14 @@ test_expect_success 'symlinked configuration' '
 
 '
 
+test_expect_success 'check split_cmdline return' "
+	git config alias.split-cmdline-fix 'echo \"' &&
+	git split-cmdline-fix || test \$? = 128 &&
+	echo foo > foo &&
+	git add foo &&
+	git commit -m 'initial commit' &&
+	git config branch.master.mergeoptions 'echo \"' &&
+	git merge master || test \$? = 128
+	"
+
 test_done
-- 
1.6.0.2.GIT
