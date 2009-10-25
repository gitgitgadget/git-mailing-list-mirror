From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 3/7] http-push: add more 'error <dst> <why>' status reports
Date: Sun, 25 Oct 2009 23:20:44 +0800
Message-ID: <20091025232044.06d7ce5c.rctay89@gmail.com>
References: <20091025231932.be9a6dfa.rctay89@gmail.com>
 <20091025231809.15b470fa.rctay89@gmail.com>
 <20091025231651.18c75559.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 16:21:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N24u8-0001WC-0r
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 16:21:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbZJYPUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 11:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752437AbZJYPUq
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 11:20:46 -0400
Received: from mail-gx0-f216.google.com ([209.85.217.216]:37267 "EHLO
	mail-gx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291AbZJYPUp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 11:20:45 -0400
Received: by gxk8 with SMTP id 8so12601295gxk.1
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 08:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=FbEaHgK8HUzsn2ORQUN2MM4gHPuM3I3fI0pqUwfyvLk=;
        b=vFFEKWZ6W2AZP8Pjd1VhdTz9Jp+bZtdS6sdRWcR3dw2dtHB30QYonRhuB0xu8SqRnq
         hc7NfhArLrcXUqaxA+tPJnwxm+9ZeTwvj//ZKtDfwzlmgMFQrVhkcpX1d2vGjk1eM7u+
         j45aFGNTXE84KoXrjTY8kxUNHFkjDCPgThfh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=pk6DK1wDBW2fSBhUwN3fteUGLN9DUYmelAYh6q7+xWCtGySWp6dNoa1YNr0vdXfuU5
         PABuB/LGSjZw5bF014f2rVInd40CpZu7yjzCavkR+gbLsv4TuNAFRhO8dznlEAnMtCqr
         3X44ebRumIrGPeK1L+RjJi1CfIkf57kfNqRzU=
Received: by 10.101.49.19 with SMTP id b19mr8242416ank.146.1256484050194;
        Sun, 25 Oct 2009 08:20:50 -0700 (PDT)
Received: from your-cukc5e3z5n (cm73.zeta152.maxonline.com.sg [116.87.152.73])
        by mx.google.com with ESMTPS id 15sm896532yxh.40.2009.10.25.08.20.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 08:20:49 -0700 (PDT)
In-Reply-To: <20091025231932.be9a6dfa.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131210>

Complement c6aa27e (Move WebDAV HTTP push under remote-curl, Wed Oct
14) by adding error reports for 'cannot remove' (failed to delete
branch) and 'no match'.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/http-push.c b/http-push.c
index b97ea1f..f10803a 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1916,9 +1916,12 @@ int main(int argc, char **argv)

 	/* Remove a remote branch if -d or -D was specified */
 	if (delete_branch) {
-		if (delete_remote_branch(refspec[0], force_delete) == -1)
+		if (delete_remote_branch(refspec[0], force_delete) == -1) {
 			fprintf(stderr, "Unable to delete remote branch %s\n",
 				refspec[0]);
+			if (helper_status)
+				printf("error %s cannot remove\n", refspec[0]);
+		}
 		goto cleanup;
 	}

@@ -1930,6 +1933,8 @@ int main(int argc, char **argv)
 	}
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n");
+		if (helper_status)
+			printf("error null no match\n");
 		rc = 0;
 		goto cleanup;
 	}
--
1.6.4.4
