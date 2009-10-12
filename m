From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 4/4] check-ref-format: simplify --print implementation
Date: Mon, 12 Oct 2009 00:33:01 -0500
Message-ID: <20091012053301.GE11106@progeny.tock>
References: <4AD0C93C.6050306@web.de>
 <7vws327wbp.fsf@alter.siamese.dyndns.org>
 <20091012052536.GA11106@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 07:29:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxDTQ-0000T2-05
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 07:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbZJLFZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 01:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbZJLFZL
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 01:25:11 -0400
Received: from mail-yx0-f188.google.com ([209.85.210.188]:52636 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbZJLFZK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 01:25:10 -0400
Received: by yxe26 with SMTP id 26so3252248yxe.4
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 22:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Iffye18zMSKrx/yHwEj6Kelb3OQ3aH6GSQkh0JZCNqk=;
        b=r9ilZeNTJzbeG8yiQljr8SFDfg6rys0UQTFz7WcnNi4fAPkpgdyCUKnoQFqRt8g1RG
         QyMiimm7HIL0cH9QLmPFWDuQ9/04RKFmwOe2K5B6NcMHLBw0xKffUCB75X6dgRQN5FuY
         6nbyUCN8MBtyLH23ovDR50U7FhJtNpAU+teK4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=yHwXQKsCJLklK4CFw8TPir5xH2Ol8sv44LA/s94hplEwJLE5+yVAbPAYvGRwhp6v4h
         NKwZjdkrfrxzx1YLK7P5qtEIfIw2it6mK1CzZrh6tf22XWcxsrkKqTXzXccmTdEKbife
         Y3eW3uGB17ChWXOH+uM7Qg0VBZcJRaavsRgmY=
Received: by 10.101.57.4 with SMTP id j4mr5060540ank.104.1255325074394;
        Sun, 11 Oct 2009 22:24:34 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm2090920yxe.15.2009.10.11.22.24.33
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 22:24:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091012052536.GA11106@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129983>

normalize_path_copy() is a complicated function, but most of its
functionality will never apply to a ref name that has been checked
with check_ref_format().

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin-check-ref-format.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/builtin-check-ref-format.c b/builtin-check-ref-format.c
index b97b61a..e439136 100644
--- a/builtin-check-ref-format.c
+++ b/builtin-check-ref-format.c
@@ -7,6 +7,28 @@
 #include "builtin.h"
 #include "strbuf.h"
 
+/*
+ * Replace each run of adjacent slashes in src with a single slash,
+ * and write the result to dst.
+ *
+ * This function is similar to normalize_path_copy(), but stripped down
+ * to meet check_ref_format's simpler needs.
+ */
+static void collapse_slashes(char *dst, const char *src)
+{
+	char ch;
+	char prev = '\0';
+
+	while (ch = *src++) {
+		if (prev == '/' && ch == prev)
+			continue;
+
+		*dst++ = ch;
+		prev = ch;
+	}
+	*dst = '\0';
+}
+
 int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 {
 	if (argc == 3 && !strcmp(argv[1], "--branch")) {
@@ -22,8 +44,7 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 
 		if (check_ref_format(argv[2]))
 			exit(1);
-		if (normalize_path_copy(refname, argv[2]))
-			die("Could not normalize ref name '%s'", argv[2]);
+		collapse_slashes(refname, argv[2]);
 		printf("%s\n", refname);
 		exit(0);
 	}
-- 
1.6.5.rc1.199.g596ec
