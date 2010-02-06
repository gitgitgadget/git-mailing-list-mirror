From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] grep: simple test for operation in a bare repository
Date: Sat, 06 Feb 2010 10:35:19 +0100
Message-ID: <4B6D37D7.6010505@lsrfire.ath.cx>
References: <4B69BD7C.4010608@lsrfire.ath.cx> <4B6A0BDE.2050908@lsrfire.ath.cx> 	<4B6B653A.8060909@lsrfire.ath.cx> <fcaeb9bf1002041840l4d8e8ac9k3ad5e9e8761aa1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 06 10:36:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndh4c-00016p-LA
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 10:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858Ab0BFJfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 04:35:25 -0500
Received: from india601.server4you.de ([85.25.151.105]:37262 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138Ab0BFJfY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 04:35:24 -0500
Received: from [10.0.1.100] (p57B7C6CB.dip.t-dialin.net [87.183.198.203])
	by india601.server4you.de (Postfix) with ESMTPSA id 3E2B12F8045;
	Sat,  6 Feb 2010 10:35:22 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <fcaeb9bf1002041840l4d8e8ac9k3ad5e9e8761aa1b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139153>

Am 05.02.2010 03:40, schrieb Nguyen Thai Ngoc Duy:
> setup_pager() calls git_config(), which indirectly calls get_git_dir()
> and sets git_dir in stone. Changing GIT_DIR environment variable alone
> won't work, as you have seen.
> 
> When RUN_SETUP is set, setup_git_directory() would be called before
> setup_pager() can kick in, so everything is properly set.
> 
>> There are five more sites in git.c, path.c and setup.c where $GIT_DIR
>> is set directly with setenv().  I wonder if they should better call
>> set_git_dir() instead, too.
> 
> Yes, they should.

This patch converts the setenv() calls in path.c and setup.c.  After
the call, git grep with a pager works again in bare repos.

It leaves the setenv(GIT_DIR_ENVIRONMENT, ...) calls in git.c alone, as
they respond to command line switches that emulate the effect of setting
the environment variable directly.

The remaining site in environment.c is in set_git_dir() and is left
alone, too, of course.  Finally, builtin-init-db.c is left changed
because the repo is still being carefully constructed when the
environment variable is set.

This fixes git shortlog when run inside a git directory, which had been
broken by abe549e1.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Since it's doesn't fix a regression (abe549e1 was committed in March
2008), this patch doesn't have to go in at this point in the release
cycle.  And perhaps it's even superseded by the more general fix Duy
is working on?

 path.c  |    2 +-
 setup.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/path.c b/path.c
index 79aa104..0005df3 100644
--- a/path.c
+++ b/path.c
@@ -336,7 +336,7 @@ char *enter_repo(char *path, int strict)
  	if (access("objects", X_OK) == 0 && access("refs", X_OK) == 0 &&
 	    validate_headref("HEAD") == 0) {
-		setenv(GIT_DIR_ENVIRONMENT, ".", 1);
+		set_git_dir(".");
 		check_repository_format();
 		return path;
 	}
diff --git a/setup.c b/setup.c
index 710e2f3..b38cbee 100644
--- a/setup.c
+++ b/setup.c
@@ -404,9 +404,9 @@ const char *setup_git_directory_gently(int *nongit_ok)
 				inside_work_tree = 0;
 			if (offset != len) {
 				cwd[offset] = '\0';
-				setenv(GIT_DIR_ENVIRONMENT, cwd, 1);
+				set_git_dir(cwd);
 			} else
-				setenv(GIT_DIR_ENVIRONMENT, ".", 1);
+				set_git_dir(".");
 			check_repository_format_gently(nongit_ok);
 			return NULL;
 		}
