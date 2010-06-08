From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH 2/2 v2] git-gui - provide commit base to the hooks/pre-commit script
Date: Mon,  7 Jun 2010 22:56:03 -0400
Message-ID: <1275965763-18940-2-git-send-email-mlevedahl@gmail.com>
References: <1275965763-18940-1-git-send-email-mlevedahl@gmail.com>
Cc: peff@peff.net, jsixt@viscovery.net, spearce@spearce.org,
	Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 08 04:56:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLozV-0006VI-U9
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 04:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689Ab0FHC41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 22:56:27 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57278 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554Ab0FHC40 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 22:56:26 -0400
Received: by mail-vw0-f46.google.com with SMTP id 17so851376vws.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 19:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Z3FE2TyNOQqzDtHjNjcVa07k8+Vhq+XEphoZLkJ5oSE=;
        b=HRHNoGfP/XEJBk9tmmB6q91PwbOlwkLUW7HaPUIBgOisjlNIEaH81Ha2hXJWPODF9y
         AORwZT4xnnVRmC9ET8vwbXW12n/Tyvmlv8688JoCBadySP840bg0XS3be+Iac1HIUobC
         XoRSnXlPN6pEewiFHJu8oGckn/S4cmoMrTt64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BPDa6OKxWZRpAbArKir0tqkWtsDqRi1Wpi2VQLZEFu2VQ5XN2uYGk1egReg5TSPJxL
         hhTYR7Z6IwrD+Tt1MGjSlpIzFa98Bs0SHgUk0Aqz4X5tYi11hiX65mLuBA76rekIK+Wd
         TGHAJY+iFNUeguzDgKyrjqHL9WxF5FH7tOEmU=
Received: by 10.224.18.218 with SMTP id x26mr9482384qaa.160.1275965785848;
        Mon, 07 Jun 2010 19:56:25 -0700 (PDT)
Received: from mark-laptop.lan (pool-71-191-167-79.washdc.fios.verizon.net [71.191.167.79])
        by mx.google.com with ESMTPS id 4sm8913147qwe.55.2010.06.07.19.56.25
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 07 Jun 2010 19:56:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.269.g9fb6
In-Reply-To: <1275965763-18940-1-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148640>

If hooks/pre-commit acts based upon the changes to be checked in
rather than just the resulting content, the script needs to know which
commit to use. For a normal commit, this is HEAD, but when amending this
is HEAD~1. So, this modifies commit.tcl to pass $1 as HEAD|HEAD~1 depending
upon the commit type. Existing scripts are unaffected as they did not
expect any argument so will silently ignore this extra bit of info.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui/lib/commit.tcl |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
index 7f459cd..a62edc9 100644
--- a/git-gui/lib/commit.tcl
+++ b/git-gui/lib/commit.tcl
@@ -225,7 +225,13 @@ A good commit message has the following format:
 
 	# -- Run the pre-commit hook.
 	#
-	set fd_ph [githook_read pre-commit]
+	if {[string compare $commit_type "normal"] == 0} {
+		set against "HEAD"
+	} else {
+		set against "HEAD~1"
+	}
+
+	set fd_ph [githook_read pre-commit $against]
 	if {$fd_ph eq {}} {
 		commit_commitmsg $curHEAD $msg_p
 		return
-- 
1.7.1.269.g9fb6
