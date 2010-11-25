From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 7/9] http-push: check path length before using it
Date: Thu, 25 Nov 2010 16:21:08 +0800
Message-ID: <1290673270-4284-8-git-send-email-rctay89@gmail.com>
References: <1290433298-6000-1-git-send-email-rctay89@gmail.com>
 <1290673270-4284-1-git-send-email-rctay89@gmail.com>
 <1290673270-4284-2-git-send-email-rctay89@gmail.com>
 <1290673270-4284-3-git-send-email-rctay89@gmail.com>
 <1290673270-4284-4-git-send-email-rctay89@gmail.com>
 <1290673270-4284-5-git-send-email-rctay89@gmail.com>
 <1290673270-4284-6-git-send-email-rctay89@gmail.com>
 <1290673270-4284-7-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 25 09:23:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLX7D-0000LA-Pu
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 09:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756Ab0KYIXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 03:23:33 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34173 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745Ab0KYIXc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 03:23:32 -0500
Received: by mail-iw0-f174.google.com with SMTP id 5so389iwn.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 00:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=HNQFNVDzNS5DLjKhc/Fuziza69NQLID75jU2nyuUxE4=;
        b=cEMMqbuQ6HPbPHRPNcs9Ufp3mduYsn9FYfvJi0RWfLFParGyMwb+lY3L95SHZbL8iz
         dSYLAdBtmUEV134Hvc9fTfGMjRAb6Qp44faTZcvRri+rHcDyicDELUTgNYQWKUzRAt1j
         5WMU3jL76+HQVF0M8DcmuK2/LAvv3Nt1eP0KA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vuboiyEgG4+OZGJ4En3fWmUNx1ffI963QLS2VQJwr7d1eknbB+nf8gGeiALjjd7z97
         5aW4UywFCp1H1e5KA9TvZboMQLe16qQ+yZC3SKwVcZnYibMZBDIARPb+Is7zyv2/VMQs
         wvYTMjC+x/5Z9n9yGtlOp2ICTFQ+Zz949IW74=
Received: by 10.231.192.76 with SMTP id dp12mr317782ibb.185.1290673411991;
        Thu, 25 Nov 2010 00:23:31 -0800 (PST)
Received: from localhost.localdomain (cm60.zeta152.maxonline.com.sg [116.87.152.60])
        by mx.google.com with ESMTPS id i16sm513271ibl.12.2010.11.25.00.23.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 00:23:30 -0800 (PST)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1290673270-4284-7-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162112>

We use path_len to skip the base url/path, but we do not know for sure
if path does indeed contain the base url/path. Check if this is so.

Helped-by: Johnathan Nieder <jrnieder@gmail.com>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/http-push.c b/http-push.c
index 565e580..bfa1fe7 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1116,8 +1116,16 @@ static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
 				}
 			}
 			if (path) {
-				path += repo->path_len;
-				ls->dentry_name = xstrdup(path);
+				const char *url = repo->url;
+				if (repo->path)
+					url = repo->path;
+				if (strncmp(path, url, repo->path_len))
+					error("Parsed path '%s' does not match url: '%s'\n",
+					      path, url);
+				else {
+					path += repo->path_len;
+					ls->dentry_name = xstrdup(path);
+				}
 			}
 		} else if (!strcmp(ctx->name, DAV_PROPFIND_COLLECTION)) {
 			ls->dentry_flags |= IS_DIR;
-- 
1.7.3.2.495.gc7b3f
