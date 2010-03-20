From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC] rev-list: fix --pretty=oneline with empty message
Date: Sat, 20 Mar 2010 19:20:01 +0100
Message-ID: <1269109201-5768-1-git-send-email-kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 19:21:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt3IR-0001Sq-39
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 19:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337Ab0CTSVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 14:21:09 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:51270 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154Ab0CTSVH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 14:21:07 -0400
Received: by ewy8 with SMTP id 8so291694ewy.28
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 11:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=Y0TvcaCZRjbUnRt7mYRRZszI3R3gGjT+5Q1fDt8TFYw=;
        b=CjYwtm7b7qib+DHKC/xSByEdkCeUC3Fjzaw3qvBMAMhZRuE1Sdqg10ga9mdved9TDh
         oauZceSJdyjH4XPegKjMFEVbYbP3xgD4nZYEtu/9n7xoqhhTfcYPeKsrqQmXZw7sA6Su
         qCwdYsWbpADb810HsWdWtMP+kpusr72Vm6lKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=gbJoORiXQvVw/KmD5S3fRdk1m0nWFAdIf5A1Zl0G56KK6i1dfADu93+M3kYEKfLuU+
         4GVDs9waK5L5zbkGnx8jjp1AW2b2odqG+T0G8v5w4QfUVRQPOOAabs0llKIoy09R3wsJ
         iZywxduKAq27rCAbMoWlNywQ9b5P/90wkPA5E=
Received: by 10.213.37.82 with SMTP id w18mr721206ebd.97.1269109264390;
        Sat, 20 Mar 2010 11:21:04 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id 16sm846713ewy.3.2010.03.20.11.21.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 11:21:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2.456.g64f24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142733>

55246aa (Dont use "<unknown>" for placeholders and suppress printing
of empty user formats) introduced a check to prevent empty
user-formats from being printed. This test didn't take empty commit
messages into account, and prevented the line-termination from being
output. This lead to multiple commits on a single line.

Correct it by guarding with a check for user-format.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

This is a fix for the issue I posted about with rebase -i:
http://permalink.gmane.org/gmane.comp.version-control.git/141782

 builtin/rev-list.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 5679170..133056b 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -135,7 +135,8 @@ static void show_commit(struct commit *commit, void *data)
 					putchar('\n');
 			}
 		} else {
-			if (buf.len)
+			if (revs->commit_format != CMIT_FMT_USERFORMAT ||
+			    buf.len)
 				printf("%s%c", buf.buf, info->hdr_termination);
 		}
 		strbuf_release(&buf);
-- 
1.7.0.2.456.g64f24
