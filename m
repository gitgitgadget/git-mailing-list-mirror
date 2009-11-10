From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 2/4] teach warn_dangling_symref to take a FILE argument
Date: Mon,  9 Nov 2009 23:58:31 -0500
Message-ID: <1257829113-52168-3-git-send-email-jaysoffian@gmail.com>
References: <1257829113-52168-1-git-send-email-jaysoffian@gmail.com>
 <1257829113-52168-2-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 05:59:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7ip3-0004pk-4S
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 05:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755975AbZKJE6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 23:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755647AbZKJE6t
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 23:58:49 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:29818 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755607AbZKJE6r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 23:58:47 -0500
Received: by qw-out-2122.google.com with SMTP id 3so726576qwe.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 20:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wVCwpLUsiqysAT97ZpPZCbvyKJGb4+1cg91PW3om+rM=;
        b=kTyZne1Lia83o86Lwla9b3MSmr5BEuQvS4LrFicfp5mTOG6POYtlDOt6Ix2+CQr/7J
         Nw62+zDujlqFaTYwN1EG2JRvRPBH/ZaGofKDjFpczmQ5TvHoBD+ZVIw3Y3+wdioqDRqi
         hdAx2EZJyjPm/7uaEChVncxBXxeuxJnuQbCj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lFOUh3qAXZv9+I9R6q7BcDRjPsrs1IwlG/nOzQif+CbzuXEegjG7hAABMCUh54lCUj
         BfWkwt9uKbElY15VSauqjsZVuWQ+6v7udRkQFCh4DG13mfk5ZhoRhk8a4z665qw6xfS7
         uF/X2b+XD70vwdSxOohkQYxKhJv4/cROLqhCY=
Received: by 10.224.124.4 with SMTP id s4mr4612337qar.307.1257829133706;
        Mon, 09 Nov 2009 20:58:53 -0800 (PST)
Received: from localhost (cpe-069-134-096-008.nc.res.rr.com [69.134.96.8])
        by mx.google.com with ESMTPS id 20sm260323qyk.5.2009.11.09.20.58.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 20:58:52 -0800 (PST)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1257829113-52168-2-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132531>

Different callers of warn_dangling_symref() may want to control whether its
output goes to stdout or stderr so let it take a FILE argument.
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
