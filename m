From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC PATCH 2/3] grep: prepare grep for submodules
Date: Thu, 30 Sep 2010 11:34:08 -0700
Message-ID: <4CA4D820.5040100@gmail.com>
References: <1285792134-26339-1-git-send-email-judge.packham@gmail.com>	<1285792134-26339-3-git-send-email-judge.packham@gmail.com> <AANLkTik3bvJneak9gjG8O1A=LZeivPkFc6MF5_T7nbWo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jens.Lehmann" <Jens.Lehmann@web.de>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 20:34:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1NxF-0001Mt-82
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 20:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110Ab0I3Sdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 14:33:53 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:42917 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754880Ab0I3Sdv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 14:33:51 -0400
Received: by pxi10 with SMTP id 10so586112pxi.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 11:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=YB/UcYz2T+e4FkfFf19/s5I/2i+aliZjmbtaGFpfsQs=;
        b=avLq4OWkLkgCWwwHuICN1VDRszZTdODDUfOKCpT+svU3mFht7GSx2Ru0KpGlFZEaBR
         gPCR8Vl6/H6U2A1445+ERUpNhdqjyjZWYV19aWFJLbYo3f4mOv39Flm8DuR85xlqDUBx
         A9RGRFtMbSXD6Fy5n7rpmdEsyTD7LJYtzkSEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=VXlDb3rV411LiibKSeQoySdKtBBwjDyU4ROuDuLNGW5cWeKcH7Cpb9qkCSGgltS+gn
         XpJFHZlOdswSsIL/XrCNigDS0Q5mi0tHabhhGhubwUd1QGbYLOwnm8wD5lbbwhfmlFmv
         ZaSr9imEocDQ8odkHZ3pDP4wyV2AEwhdaQ5n4=
Received: by 10.114.67.11 with SMTP id p11mr4767803waa.202.1285871630984;
        Thu, 30 Sep 2010 11:33:50 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id r37sm228559wak.23.2010.09.30.11.33.48
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 11:33:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Thunderbird/3.0.6
In-Reply-To: <AANLkTik3bvJneak9gjG8O1A=LZeivPkFc6MF5_T7nbWo@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157700>

On 29/09/10 18:10, Nguyen Thai Ngoc Duy wrote:
> On Thu, Sep 30, 2010 at 6:28 AM, Chris Packham <judge.packham@gmail.com> wrote:
>> Add --submodule-prefix option to pass to subprocess grep invocations. The
>> prefix is then used when outputting the results.
> 
> I haven't followed the recursive submodule support in Git lately. But
> I think --submodule-prefix is unnecessary. I would imagine you need to
> add --submodule-prefix to a lot more commands as they support recusive
> submodule search. There is a corner case in Git's prefix setup that we
> can utilize to avoid the new option.
> 
> If you do this at the superproject repo:
> 
> $ GIT_DIR=path/to/submodule/.git GIT_WORK_TREE=path/to/submodule git grep blah
> 
> I would expect that it shows the result correctly (i.e. all files
> prefixed by "path/to/submodule"), but it does not right now. If you
> make that setup work, then you don't need --submodule-prefix, just set
> GIT_DIR/GIT_WORK_TREE properly and run "git grep".
> 
> You can make setup_explicit_git_dir() realize that situation (current
> working directory outside $GIT_WORK_TREE), then calculate and save the
> submodule prefix in startup_info struct. Then "git grep" or any
> commands can just read startup_info to find out the submodule prefix.

Here's my first naive attempt at implementing what you describe. Needs
tests, more comments, sign-off etc.

One situation that could be handled better is when the cwd is a
subdirectory of the specified worktree. At the moment this ends up
giving the full path to the worktree, the output would look much nicer
if it gave the relative path (e.g. ../../).

---8<---
From: Chris Packham <judge.packham@gmail.com>
Date: Thu, 30 Sep 2010 11:19:29 -0700
Subject: [RFC PATCH] save the work tree prefix in startup_info

This is the relative path between the cwd and the worktree or the
absolute path of the worktree if the worktree is not a subdirectory
of the worktree.
---
 cache.h |    1 +
 dir.c   |   26 ++++++++++++++++++++++++++
 dir.h   |    1 +
 setup.c |    4 ++++
 4 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index e1d3ffd..f320e78 100644
--- a/cache.h
+++ b/cache.h
@@ -1111,6 +1111,7 @@ const char *split_cmdline_strerror(int cmdline_errno);
 /* git.c */
 struct startup_info {
 	int have_repository;
+	const char *prefix;
 };
 extern struct startup_info *startup_info;

diff --git a/dir.c b/dir.c
index 58ec1a1..2148730 100644
--- a/dir.c
+++ b/dir.c
@@ -1036,6 +1036,32 @@ char *get_relative_cwd(char *buffer, int size,
const char *dir)
 	}
 }

+char *get_relative_wt(char *buffer, int size, const char *dir)
+{
+	char *cwd = buffer;
+	
+	if (!dir)
+		return NULL;
+	if (!getcwd(buffer, size))
+		die_errno("can't find the current directory");
+	if (!is_absolute_path(dir))
+		dir = make_absolute_path(dir);
+	if (strstr(dir, cwd)) {
+		dir += strlen(cwd);
+		switch(*dir){
+		case '\0':
+			return NULL;
+		case '/':
+			dir++;
+			break;
+		default:
+			break;
+		}
+	}
+	strncpy(buffer, dir, size);
+	return buffer;
+}
+
 int is_inside_dir(const char *dir)
 {
 	char buffer[PATH_MAX];
diff --git a/dir.h b/dir.h
index b3e2104..d3c161f 100644
--- a/dir.h
+++ b/dir.h
@@ -81,6 +81,7 @@ extern void add_exclude(const char *string, const char
*base,
 extern int file_exists(const char *);

 extern char *get_relative_cwd(char *buffer, int size, const char *dir);
+extern char *get_relative_wt(char *buffer, int size, const char *dir);
 extern int is_inside_dir(const char *dir);

 static inline int is_dot_or_dotdot(const char *name)
diff --git a/setup.c b/setup.c
index a3b76de..bd9d9fd 100644
--- a/setup.c
+++ b/setup.c
@@ -317,6 +317,7 @@ static const char *setup_explicit_git_dir(const char
*gitdirenv,
 				const char *work_tree_env, int *nongit_ok)
 {
 	static char buffer[1024 + 1];
+	static char wtbuf[1024 + 1];
 	const char *retval;

 	if (PATH_MAX - 40 < strlen(gitdirenv))
@@ -337,6 +338,9 @@ static const char *setup_explicit_git_dir(const char
*gitdirenv,
 	}
 	if (check_repository_format_gently(nongit_ok))
 		return NULL;
+
+	startup_info->prefix=get_relative_wt(wtbuf, sizeof(wtbuf) - 1,
+			get_git_work_tree());
 	retval = get_relative_cwd(buffer, sizeof(buffer) - 1,
 			get_git_work_tree());
 	if (!retval || !*retval)
-- 
1.7.3.1
