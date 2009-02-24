From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH 2/3] Give short-hands to --pretty=tformat:%formatstring
Date: Tue, 24 Feb 2009 18:59:15 +0900
Message-ID: <20090224185915.6117@nanako3.lavabit.com>
References: <20090224185913.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 11:06:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbuAn-0005UU-Jg
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 11:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258AbZBXKDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 05:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754199AbZBXKDw
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 05:03:52 -0500
Received: from karen.lavabit.com ([72.249.41.33]:58800 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754007AbZBXKDv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 05:03:51 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 7120C11B900
	for <git@vger.kernel.org>; Tue, 24 Feb 2009 04:03:49 -0600 (CST)
Received: from 2293.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 0ET7OS7B92CA
	for <git@vger.kernel.org>; Tue, 24 Feb 2009 04:03:49 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=D8/4L9/ytYLakvl6sHR93g1JI2c5wS7bXVcp+DvSzlf/uTX6cQjbJbmgcglXoBCic/fy2EoTuX3SEMHAx+z7KbdgTQBWKVxT1RBsE3o/yjIpVWEAZeSXoUCa2cqBjhlCWqNKa3O7ieSF73QwesOgiQ6zoT6T+jha7zguKCS0yBg=;
  h=From:To:In-Reply-To:References:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20090224185913.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111280>

Allow --pretty="%h %s" (and --format="%h %s") as shorthand for an often
used option --pretty=tformat:"%h %s".

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 Documentation/pretty-formats.txt |    9 +++++++++
 pretty.c                         |   20 ++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 159390c..5c6e678 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -152,3 +152,12 @@ $ git log -2 --pretty=tformat:%h 4da45bef \
 4da45be
 7134973
 ---------------------
++
+In addition, any unrecognized string that has a `%` in it is interpreted
+as if it has `tformat:` in front of it.  For example, these two are
+equivalent:
++
+---------------------
+$ git log -2 --pretty=tformat:%h 4da45bef
+$ git log -2 --pretty=%h 4da45bef
+---------------------
diff --git a/pretty.c b/pretty.c
index 6cd9149..d739f6d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -10,6 +10,15 @@
 
 static char *user_format;
 
+static void save_user_format(struct rev_info *rev, const char *cp, int is_tformat)
+{
+	free(user_format);
+	user_format = xstrdup(cp);
+	if (is_tformat)
+		rev->use_terminator = 1;
+	rev->commit_format = CMIT_FMT_USERFORMAT;
+}
+
 void get_commit_format(const char *arg, struct rev_info *rev)
 {
 	int i;
@@ -33,12 +42,7 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 		return;
 	}
 	if (!prefixcmp(arg, "format:") || !prefixcmp(arg, "tformat:")) {
-		const char *cp = strchr(arg, ':') + 1;
-		free(user_format);
-		user_format = xstrdup(cp);
-		if (arg[0] == 't')
-			rev->use_terminator = 1;
-		rev->commit_format = CMIT_FMT_USERFORMAT;
+		save_user_format(rev, strchr(arg, ':') + 1, arg[0] == 't');
 		return;
 	}
 	for (i = 0; i < ARRAY_SIZE(cmt_fmts); i++) {
@@ -50,6 +54,10 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 			return;
 		}
 	}
+	if (strchr(arg, '%')) {
+		save_user_format(rev, arg, 1);
+		return;
+	}
 
 	die("invalid --pretty format: %s", arg);
 }
-- 
1.6.2.rc1

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
