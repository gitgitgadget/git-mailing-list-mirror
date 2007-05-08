From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: [PATCH] remove unnecessary loop
Date: Tue, 08 May 2007 12:49:35 +0800
Message-ID: <4640015F.1080407@gmail.com>
References: <463FEC07.8080605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 06:53:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlHhb-0002Uh-19
	for gcvg-git@gmane.org; Tue, 08 May 2007 06:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967789AbXEHExZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 00:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967792AbXEHExZ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 00:53:25 -0400
Received: from nz-out-0506.google.com ([64.233.162.234]:12910 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967789AbXEHExY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 00:53:24 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1843100nzf
        for <git@vger.kernel.org>; Mon, 07 May 2007 21:53:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=HC2sMLr4HuCcLVuOUvO95zN0Fqcyy7zKizHK8p++8J6F2owTyXTaNjIWfbD0QBWmKYpQ8bTfFTZ6m71NTQDZ62i0ZjDX+WI/4UrxyP7WSdE109i9OGDGcBas5R07xu1Ia3lCDLrLQcDi59if+xYi9QMLdvSU0Zr57dFjjGYaOwE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=AWRFqAZh02Y+mOpQzJJfBAj/aRy3MM8WW3g4cVMLCQooqXUbcXgF/fjVt4Cdm393Q3Cw4/Rq2dwG+KkK5gxxCX91F7ZU0HCeIHhVnVdP6fSYs/NpLw0fqnyURlDHVRenwJnK1im6tFRQzEXoPmxaJRlKo//QPmMuCwYvkJJJS2A=
Received: by 10.114.12.9 with SMTP id 9mr2464999wal.1178600002720;
        Mon, 07 May 2007 21:53:22 -0700 (PDT)
Received: from ?192.168.88.85? ( [221.122.47.70])
        by mx.google.com with ESMTP id z15sm166316pod.2007.05.07.21.53.20;
        Mon, 07 May 2007 21:53:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.7) Gecko/20060909 Thunderbird/1.5.0.7 Mnenhy/0.7.4.666
In-Reply-To: <463FEC07.8080605@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46539>

Liu Yubao wrote:
> Hi,
>    Here is a minor optimization, the involved second "for" loop doesn't
> need to start from beginning.
> 

I found it when I debugged a strange problem on Cygwin, at last, I think
it's a bug of Cygwin.

$ touch hello.exe
$ git add hello
The following paths are ignored by one of your .gitignore files:
hello
Use -f if you really want to add them.

Here is a ugly fix, I don't hope it will be merged into git tree as it's not
git's fault, I will file a bug report for Cygwin.

---
 builtin-add.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 9d10fdc..ff1e74f 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -42,6 +42,9 @@ static void prune_directory(struct dir_struct *dir, const char **pathspec, int p
 	for (i = 0; i < specs; i++) {
 		struct stat st;
 		const char *match;
+#ifdef __CYGWIN__
+		int fd;
+#endif
 		if (seen[i])
 			continue;
 
@@ -50,9 +53,18 @@ static void prune_directory(struct dir_struct *dir, const char **pathspec, int p
 			continue;
 
 		/* Existing file? We must have ignored it */
+#ifdef __CYGWIN__
+		/*
+		 * On cygwin, lstat("hello", &st) returns 0 when
+		 * "hello.exe" exists, so test with open() again.
+		 */
+		if (lstat(match, &st) && -1 != (fd = open(match, O_RDONLY))) {
+			struct dir_entry *ent;
+			close(fd);
+#else
 		if (!lstat(match, &st)) {
 			struct dir_entry *ent;
-
+#endif
 			ent = dir_add_name(dir, match, strlen(match));
 			ent->ignored = 1;
 			if (S_ISDIR(st.st_mode))
-- 
1.5.2.rc0.95.ga0715-dirty
