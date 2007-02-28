From: "James Bowes" <jbowes@dangerouslyinc.com>
Subject: [PATCH] add: Support specifying an excludes file with a configuration variable
Date: Tue, 27 Feb 2007 22:31:10 -0500
Message-ID: <3f80363f0702271931m266cdeeaob798e81c085456cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 04:31:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMFXc-0002Ah-Pj
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 04:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbXB1DbQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 22:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbXB1DbQ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 22:31:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:60548 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbXB1DbP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 22:31:15 -0500
Received: by ug-out-1314.google.com with SMTP id 44so13200uga
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 19:31:14 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=VM2bfqhg3xk7kVndKAa7JCmHcdlqSD6cn4Jp05XgG1D6zoIxNOqr0tEYm53WPU2rUD8kDIdh+8ZtLW7+hDJrVeTTkem7nDhNbZWNJOY60kH8NjqBquBk7ID7OLEkvSt+RMfcjCfEWxjTqIk0PyIazyi2oaRjEx2/xTZ2kPoAPFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=fCR1nyVQEzJH2a1Ew8QXd3/AvOnTpdyidBl4gftsAdqYPgpm/wH6U+0ztWHKhPZ/3wnhy5aTim12PkgfPFpdOe7ueNxSGts9KlocFfFTvFp5o4OgDbtAeMAlTqRaMLIJHlFQgwwUJyLK0fGC2l1FK02XErFtAZnKGVGmZJPzihw=
Received: by 10.114.131.2 with SMTP id e2mr691065wad.1172633470217;
        Tue, 27 Feb 2007 19:31:10 -0800 (PST)
Received: by 10.114.194.5 with HTTP; Tue, 27 Feb 2007 19:31:10 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: 55ab9860c169ebfd
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40882>

This adds the 'core.excludesfile' configuration variable. This variable can
hold a path to a file containing patterns of file names to exclude from
git-add, like $GIT_DIR/info/exclude. Patterns in the excludes file are used
in addition to those in info/exclude.

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---

This is a solution to the 'User-wide ignore list' from the recent unresolved
issues email. Thanks go to Junio for the implementation suggestion.

 builtin-add.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 87e16aa..9fcf514 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -12,6 +12,8 @@
 static const char builtin_add_usage[] =
 "git-add [-n] [-v] [-f] [--interactive | -i] [--] <filepattern>...";

+static const char *excludes_file;
+
 static void prune_directory(struct dir_struct *dir, const char
**pathspec, int prefix)
 {
 	char *seen;
@@ -67,6 +69,8 @@ static void fill_directory(struct dir_struct *dir,
const char **pathspec)
 	path = git_path("info/exclude");
 	if (!access(path, R_OK))
 		add_excludes_from_file(dir, path);
+	if (!access(excludes_file, R_OK))
+		add_excludes_from_file(dir, excludes_file);

 	/*
 	 * Calculate common prefix for the pathspec, and
@@ -88,6 +92,18 @@ static void fill_directory(struct dir_struct *dir,
const char **pathspec)
 		prune_directory(dir, pathspec, baselen);
 }

+static int git_add_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "core.excludesfile")) {
+		if (!value)
+			die("core.excludesfile without value");
+		excludes_file = xstrdup(value);
+		return 0;
+	}
+
+	return git_default_config(var, value);
+}
+
 static struct lock_file lock_file;

 static const char ignore_warning[] =
@@ -115,7 +131,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		exit(1);
 	}

-	git_config(git_default_config);
+	git_config(git_add_config);

 	newfd = hold_lock_file_for_update(&lock_file, get_index_file(), 1);

-- 
1.4.4.2
