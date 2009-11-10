From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 2/4] teach warn_dangling_symref to take a FILE argument
Date: Tue, 10 Nov 2009 00:03:32 -0500
Message-ID: <1257829414-52316-3-git-send-email-jaysoffian@gmail.com>
References: <1257829414-52316-1-git-send-email-jaysoffian@gmail.com>
 <1257829414-52316-2-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 06:04:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7itn-0006KC-Fg
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 06:04:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbZKJFDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 00:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbZKJFDo
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 00:03:44 -0500
Received: from mail-qy0-f194.google.com ([209.85.221.194]:49831 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbZKJFDl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 00:03:41 -0500
Received: by qyk32 with SMTP id 32so1482737qyk.4
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 21:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=tvjPc4gnIwxd1RJnZm0o2dsGZfRa5SAnd7C4YlpM/q8=;
        b=KjzJ4s1XDOz6Y79uVSMyFRWmAEfI0sEkZEiw9arfyDInwq+0/3aCfUdzL1NaUyUn3u
         W5vh6cQ6z7N6FSiME7UpSjtGO2RPZEuRhszGVY3Paa8+vY4lSF3+F2ysKbEkbcR2HJzH
         6BrN9Bd4KG9ZCxLsDqBvyCTj5Y2Fu76ytGfSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VYLwvOmKDSvOG/WS0jHtaQE2zQ6J9l5uu/DzRtNnDfWfM10/AzxMrNyfgi9SO9vG/8
         g5DXlxgSFLMw3bNx9p24hdpyMrDHd9mfA5woYLBSMVpnIAC6YN5v0/G3CYKNPy97aQm7
         u7teM/p4ADA0mydtpuIRiHHcYz/hOnvCXfWRI=
Received: by 10.224.69.84 with SMTP id y20mr179329qai.353.1257829427166;
        Mon, 09 Nov 2009 21:03:47 -0800 (PST)
Received: from localhost (cpe-069-134-096-008.nc.res.rr.com [69.134.96.8])
        by mx.google.com with ESMTPS id 20sm262928qyk.5.2009.11.09.21.03.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 21:03:46 -0800 (PST)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1257829414-52316-2-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132536>

Different callers of warn_dangling_symref() may want to control whether its
output goes to stdout or stderr so let it take a FILE argument.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-remote.c |    2 +-
 refs.c           |    7 ++++---
 refs.h           |    2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 0ea4e60..e67b89f 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -1166,7 +1166,7 @@ static int prune_remote(const char *remote, int dry_run)
 
 		printf(" * [%s] %s\n", dry_run ? "would prune" : "pruned",
 		       abbrev_ref(refname, "refs/remotes/"));
-		warn_dangling_symref(dangling_msg, refname);
+		warn_dangling_symref(stdout, dangling_msg, refname);
 	}
 
 	free_remote_ref_states(&states);
diff --git a/refs.c b/refs.c
index 808f56b..3e73a0a 100644
--- a/refs.c
+++ b/refs.c
@@ -286,6 +286,7 @@ static struct ref_list *get_ref_dir(const char *base, struct ref_list *list)
 }
 
 struct warn_if_dangling_data {
+	FILE *fp;
 	const char *refname;
 	const char *msg_fmt;
 };
@@ -304,13 +305,13 @@ static int warn_if_dangling_symref(const char *refname, const unsigned char *sha
 	if (!resolves_to || strcmp(resolves_to, d->refname))
 		return 0;
 
-	printf(d->msg_fmt, refname);
+	fprintf(d->fp, d->msg_fmt, refname);
 	return 0;
 }
 
-void warn_dangling_symref(const char *msg_fmt, const char *refname)
+void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
 {
-	struct warn_if_dangling_data data = { refname, msg_fmt };
+	struct warn_if_dangling_data data = { fp, refname, msg_fmt };
 	for_each_rawref(warn_if_dangling_symref, &data);
 }
 
diff --git a/refs.h b/refs.h
index 777b5b7..e141991 100644
--- a/refs.h
+++ b/refs.h
@@ -29,7 +29,7 @@ extern int for_each_replace_ref(each_ref_fn, void *);
 /* can be used to learn about broken ref and symref */
 extern int for_each_rawref(each_ref_fn, void *);
 
-extern void warn_dangling_symref(const char *msg_fmt, const char *refname);
+extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname);
 
 /*
  * Extra refs will be listed by for_each_ref() before any actual refs
-- 
1.6.4.2
