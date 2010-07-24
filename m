From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/9] setup: split off a function to checks working dir for
 .git file
Date: Sat, 24 Jul 2010 06:20:15 -0500
Message-ID: <20100724112015.GD16054@burratino>
References: <1279886651-14590-1-git-send-email-pclouds@gmail.com>
 <20100724111505.GC7150@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 13:21:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OccnD-0004Hg-2N
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 13:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755078Ab0GXLVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 07:21:18 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56295 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754679Ab0GXLVS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 07:21:18 -0400
Received: by iwn7 with SMTP id 7so1094603iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 04:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uhv7KWdKuOWFWuSEyj+nt4nKeku6dspvhmLY6fT7ieo=;
        b=b/g5xc1pZzHdFkM7KRGUe96w1wdUJzCa3Tv3oNCdSgKPjwpzVLCrNRiLGQZnxRQPtV
         93nmdk/bHY6HmoCEun6JNTAA4qCgapo2C1nNL8gJZPrZW7+pEEkOQ3cn4ao+DFbwuPBR
         XRz055YB5+bvk5xiDGwAKx5U5Mf0016lFoBZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=eY014tMSXi/Q7CwNQj19LqhtDBVXSrafMj0FOkIkGFnU4uAfdqhEWaLqDSDeND8T41
         X7c46zC0z8+S+8Hnff9mPZx5C1IWePqPhVdgS8VrIS+2IdnAwmnSqhv+Djv8oLNgnRly
         8mHNzlN9ueI217ddJuKpa26UUt7DmivJr5TrA=
Received: by 10.231.118.28 with SMTP id t28mr4784189ibq.131.1279970476368;
        Sat, 24 Jul 2010 04:21:16 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id e8sm1253500ibb.8.2010.07.24.04.21.15
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 04:21:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100724111505.GC7150@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151615>

The repository discovery procedure looks something like this:

	while (same filesystem) {
		check .git in working dir
		check .
		chdir(..)
	}

Add a function for the first step to make the actual code look a bit
closer to that pseudocode.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 setup.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/setup.c b/setup.c
index 16bee6d..3d25d0f 100644
--- a/setup.c
+++ b/setup.c
@@ -348,6 +348,18 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 	return retval;
 }
 
+static int cwd_contains_git_dir(const char **gitfile_dirp)
+{
+	const char *gitfile_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
+	*gitfile_dirp = gitfile_dir;
+	if (gitfile_dir) {
+		if (set_git_dir(gitfile_dir))
+			die("Repository setup failed");
+		return 1;
+	}
+	return is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT);
+}
+
 /*
  * We cannot decide in this function whether we are in the work tree or
  * not, since the config can only be read _after_ this function was called.
@@ -407,13 +419,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		current_device = buf.st_dev;
 	}
 	for (;;) {
-		gitfile_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
-		if (gitfile_dir) {
-			if (set_git_dir(gitfile_dir))
-				die("Repository setup failed");
-			break;
-		}
-		if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
+		if (cwd_contains_git_dir(&gitfile_dir))
 			break;
 		if (is_git_directory(".")) {
 			inside_git_dir = 1;
-- 
1.7.2.rc3.593.g19611.dirty
