From: Jay Soffian <jaysoffian@gmail.com>
Subject: [RFC/PATCH 1/2] Introduce CHERRY_HEAD
Date: Tue, 15 Feb 2011 16:23:53 -0500
Message-ID: <1297805034-3512-2-git-send-email-jaysoffian@gmail.com>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 15 22:24:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpSNh-0007JM-Ab
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 22:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755705Ab1BOVYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 16:24:18 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:52285 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab1BOVYR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 16:24:17 -0500
Received: by vxb37 with SMTP id 37so442844vxb.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 13:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=xISh01cyivsuDZzyTUfvSFESna4q3cB95nmnuWDGq9U=;
        b=lvf93e/zda51kI5QB1sfZCjLMzB/RNZTCU7eIXqQVN8n2bJghN+ZcHBVphcZtNgEs7
         Ua9ChHbekx64pQh9eyoKVIi0J5JdqiPVetiu9Ehtcx0o3hWZnrvz/BzZSKaGb1gdc09y
         ZxnL9pxyaFSjnmwnnAngsOqtlUAuyWSek9f4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HUhjqT5ZuccgYS0b2cJmXlJHugY8orJG6jj6a6wFXnGocw3XpUfanh0S/lnXYiVGMi
         JQ7auFifQrjfNGHWjhGNdulEjFO+xWQ269nV7i6wybDUb/ForLQcIIX9zkm7L1I5M4ob
         Yd9+f54ac03/B5tvXZRhwlEeIAQPtgMoH93u4=
Received: by 10.220.73.194 with SMTP id r2mr1567934vcj.267.1297805056646;
        Tue, 15 Feb 2011 13:24:16 -0800 (PST)
Received: from localhost (cpe-071-077-014-091.nc.res.rr.com [71.77.14.91])
        by mx.google.com with ESMTPS id c4sm1437317vcc.6.2011.02.15.13.24.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 13:24:16 -0800 (PST)
X-Mailer: git-send-email 1.7.4.5.g9affb
In-Reply-To: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166879>

When a cherry-pick conflicts git advises to use:

 $ git commit -c <original commit id>

to preserve the original commit message and authorship. Instead,
let's record the original commit id in CHERRY_HEAD and advise to use:

  $ git commit -c CHERRY_HEAD

In the next commit, we teach git to handle the '-c CHERRY_HEAD' part.
---
 branch.c         |    1 +
 builtin/commit.c |    1 +
 builtin/revert.c |   23 ++++++++++++++++++++---
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/branch.c b/branch.c
index 93dc866..81bbf95 100644
--- a/branch.c
+++ b/branch.c
@@ -217,6 +217,7 @@ void create_branch(const char *head,
 
 void remove_branch_state(void)
 {
+	unlink(git_path("CHERRY_HEAD"));
 	unlink(git_path("MERGE_HEAD"));
 	unlink(git_path("MERGE_RR"));
 	unlink(git_path("MERGE_MSG"));
diff --git a/builtin/commit.c b/builtin/commit.c
index 03cff5a..8850621 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1424,6 +1424,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		die("cannot update HEAD ref");
 	}
 
+	unlink(git_path("CHERRY_HEAD"));
 	unlink(git_path("MERGE_HEAD"));
 	unlink(git_path("MERGE_MSG"));
 	unlink(git_path("MERGE_MODE"));
diff --git a/builtin/revert.c b/builtin/revert.c
index dc1b702..c373e69 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -248,6 +248,22 @@ static void set_author_ident_env(const char *message)
 			sha1_to_hex(commit->object.sha1));
 }
 
+static void write_cherry_head(void)
+{
+	int fd;
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addf(&buf, "%s\n", sha1_to_hex(commit->object.sha1));
+
+	fd = open(git_path("CHERRY_HEAD"), O_WRONLY | O_CREAT, 0666);
+	if (fd < 0)
+		die_errno("Could not open '%s' for writing",
+			  git_path("CHERRY_HEAD"));
+	if (write_in_full(fd, buf.buf, buf.len) != buf.len)
+		die_errno("Could not write to '%s'", git_path("CHERRY_HEAD"));
+	close(fd);
+}
+
 static void advise(const char *advice, ...)
 {
 	va_list params;
@@ -269,9 +285,10 @@ static void print_advice(void)
 	advise("after resolving the conflicts, mark the corrected paths");
 	advise("with 'git add <paths>' or 'git rm <paths>'");
 
-	if (action == CHERRY_PICK)
-		advise("and commit the result with 'git commit -c %s'",
-		       find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
+	if (action == CHERRY_PICK) {
+		write_cherry_head();
+		advise("and commit the result with 'git commit -c CHERRY_HEAD'");
+	}
 }
 
 static void write_message(struct strbuf *msgbuf, const char *filename)
-- 
1.7.4.5.g9affb
