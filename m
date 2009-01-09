From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: [PATCH] Get format-patch to show first commit after root commit
Date: Fri,  9 Jan 2009 15:33:07 -0600
Message-ID: <1231536787-20685-1-git-send-email-nathan.panike@gmail.com>
Cc: "Nathan W. Panike" <nathan.panike@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 09 22:35:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLP0K-0007ZQ-Sq
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 22:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758047AbZAIVdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 16:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757653AbZAIVdU
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 16:33:20 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:40347 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757458AbZAIVdT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 16:33:19 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1200095nfc.21
        for <git@vger.kernel.org>; Fri, 09 Jan 2009 13:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=z0FXxMklz4F9pqbUL/hRMMXqB6AO6WYUNRCXk8eo/P8=;
        b=ihSxv4AlqRtZCyAIlfAAn1oSAGv+iGRiIsaIH9N0mAHyoE188WXlztu39hrSujsZEq
         EsEkKnJAs7LitPzJPPCSp+YVFy6FdnoYpoJTk6hBwJzAQVxzQDBEUIbV/KB41/e3+/M7
         Wd+RJM6eT0BBphlsKZUAxc/Y7Firv5uJ8Mpyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=dId689T6bL4JHJKMNKjW4JZOp9mN1biDrvHk0JIHnATw+PmC8m9W62vbBvpFXQ+tcc
         znadLUlGCME8Mnv4kQLEjCZvF3DNQ1UooracVhlZOTdvnwYnz0Y802N/pFfaZYauji2s
         iNyR/Q53HVfiNu3YXHaRtcElCS0Mxnc19ZPDs=
Received: by 10.67.29.4 with SMTP id g4mr15227715ugj.73.1231536796851;
        Fri, 09 Jan 2009 13:33:16 -0800 (PST)
Received: from localhost (dyn-108-77.uwnet.wisc.edu [72.33.108.77])
        by mx.google.com with ESMTPS id i30sm30457174ugd.30.2009.01.09.13.33.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jan 2009 13:33:16 -0800 (PST)
X-Mailer: git-send-email 1.6.1.76.gc123b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105041>

Rework this patch to try to handle the case where one does

git format-patch -n ...

and n is a number larger than 1.  Currently, the command

git format-patch -1 e83c5163316f89bfbde

in the git repository creates an empty file.  Instead, one is
forced to do

git format-patch -1 --root e83c5163316f89bfbde

This seems arbitrary.  This patch fixes this case, so that

git format-patch -1 e83c5163316f89bfbde

will produce an actual patch.

Signed-off-by: Nathan W. Panike <nathan.panike@gmail.com>
---
 builtin-log.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 4a02ee9..0eca15f 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -975,6 +975,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		nr++;
 		list = xrealloc(list, nr * sizeof(list[0]));
 		list[nr - 1] = commit;
+		if(!commit->parents){
+			rev.show_root_diff=1;
+		}
 	}
 	total = nr;
 	if (!keep_subject && auto_number && total > 1)
-- 
1.6.1.76.gc123b.dirty
