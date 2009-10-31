From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/8] Teach git var about GIT_PAGER
Date: Fri, 30 Oct 2009 20:41:27 -0500
Message-ID: <20091031014127.GE5160@progeny.tock>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 02:31:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N42oP-0005hX-0t
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 02:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757597AbZJaBbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 21:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757594AbZJaBbI
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 21:31:08 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:62874 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757591AbZJaBbG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 21:31:06 -0400
Received: by yxe17 with SMTP id 17so3223719yxe.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 18:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=SMFxL9aoUgSLYxOgK8l7qO2Pv95Th72AC90HKxP4rXU=;
        b=PT4d+IyBW2UhdLJnLpzIiqGT8MtoaT0xuntdfzdcLtsDPR/PWsipO4veSnj4T+qO8V
         uYeLTAj8TFUH2LNYIhkM4OmFd+9+piwmFSTX1p4mVrVKvuq9v+R5epZeTK7uzMztzVNP
         jzk/03TN6/Ybv2Gs+aGlosLW8Tmyau68Vttb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=K1UrYJD7Cq0iBMngMIyQxjf2WTv/9btgyyK0TtzRzz0Sgwf9yKuXaQ2qqRkck73M/X
         P19EQiYlOsNnF30dOXcY8lNqKPEE8CCmtYuqXOqc6cHnbqY23N2yQk0zO/FQ/4KfxTz7
         ZmATKB3iec2Wctznlb6zwRvZjXyeyJ3ocBVkc=
Received: by 10.150.63.16 with SMTP id l16mr4319984yba.12.1256952671194;
        Fri, 30 Oct 2009 18:31:11 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 14sm37658gxk.10.2009.10.30.18.31.09
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 18:31:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091031012050.GA5160@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131817>

Expose the command found by setup_pager() for scripts to use.
Scripts can use this to avoid repeating the logic to look for a
proper pager in each command.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
No changes from the last version sent.

 Documentation/git-var.txt |    6 ++++++
 cache.h                   |    1 +
 pager.c                   |   18 +++++++++++++++---
 var.c                     |   10 ++++++++++
 4 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 89e4b4f..ef6aa81 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -44,6 +44,12 @@ GIT_EDITOR::
     environment variable, then `core.editor` configuration, then
     `$VISUAL`, then `$EDITOR`, and then finally 'vi'.
 
+GIT_PAGER::
+    Text viewer for use by git commands (e.g., 'less').  The value
+    is meant to be interpreted by the shell.  The order of preference
+    is the `$GIT_PAGER` environment variable, then `core.pager`
+    configuration, then `$PAGER`, and then finally 'less'.
+
 Diagnostics
 -----------
 You don't exist. Go away!::
diff --git a/cache.h b/cache.h
index 311cfe1..5aaa4ba 100644
--- a/cache.h
+++ b/cache.h
@@ -751,6 +751,7 @@ extern const char *git_committer_info(int);
 extern const char *fmt_ident(const char *name, const char *email, const char *date_str, int);
 extern const char *fmt_name(const char *name, const char *email);
 extern const char *git_editor(void);
+extern const char *git_pager(void);
 
 struct checkout {
 	const char *base_dir;
diff --git a/pager.c b/pager.c
index 86facec..0b63d99 100644
--- a/pager.c
+++ b/pager.c
@@ -44,12 +44,14 @@ static void wait_for_pager_signal(int signo)
 	raise(signo);
 }
 
-void setup_pager(void)
+const char *git_pager(void)
 {
-	const char *pager = getenv("GIT_PAGER");
+	const char *pager;
 
 	if (!isatty(1))
-		return;
+		return NULL;
+
+	pager = getenv("GIT_PAGER");
 	if (!pager) {
 		if (!pager_program)
 			git_config(git_default_config, NULL);
@@ -60,6 +62,16 @@ void setup_pager(void)
 	if (!pager)
 		pager = "less";
 	else if (!*pager || !strcmp(pager, "cat"))
+		pager = NULL;
+
+	return pager;
+}
+
+void setup_pager(void)
+{
+	const char *pager = git_pager();
+
+	if (!pager)
 		return;
 
 	spawned_pager = 1; /* means we are emitting to terminal */
diff --git a/var.c b/var.c
index 399f409..facec11 100644
--- a/var.c
+++ b/var.c
@@ -23,6 +23,15 @@ static const char *editor(int flag)
 	return pgm;
 }
 
+static const char *pager(int flag)
+{
+	const char *pgm = git_pager();
+
+	if (!pgm)
+		pgm = "cat";
+	return pgm;
+}
+
 struct git_var {
 	const char *name;
 	const char *(*read)(int);
@@ -31,6 +40,7 @@ static struct git_var git_vars[] = {
 	{ "GIT_COMMITTER_IDENT", git_committer_info },
 	{ "GIT_AUTHOR_IDENT",   git_author_info },
 	{ "GIT_EDITOR", editor },
+	{ "GIT_PAGER", pager },
 	{ "", NULL },
 };
 
-- 
1.6.5.2
