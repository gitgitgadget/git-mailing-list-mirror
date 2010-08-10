From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v4 4/9] stash: teach git stash pop to fail early if the argument is not a stash ref
Date: Tue, 10 Aug 2010 10:04:43 +1000
Message-ID: <1281398688-21008-5-git-send-email-jon.seymour@gmail.com>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 02:06:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OicMl-0001dO-02
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 02:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757356Ab0HJAGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 20:06:25 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60333 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757316Ab0HJAGY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 20:06:24 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so1536919pwj.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 17:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6rO5Eizk6A6vz822E36aoKzgsArKeuv4gaFdvLrDsW8=;
        b=NFyFU7Ax6LTepaDkN5yO4fbFhxdISIAeBjmd4nCnIsGkRjsG/m7mnvGDwaAvqyeyEa
         NjhigxmkhXYPa6v1ys92BFp/n6huiJfD1CMfyuJVtxqHZ91gabCuCHEddD8CHHGdJ+pz
         KGFEjPjz5YEJX/igOtfjhLPrX+2cQIlAOjKms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Zqv5TY5Iizvs1GoqfRY7L3Qno488GiWPJmxyn8zZ2bwYodKHMcflyKtaJiH4Mmd7Fi
         8QRMJlp9xBiv9SJ/ln4HPSCKVa/oYyKWp6fFv5NFbK7QCnnRePQKajk8AF9yEgk3ip9X
         uTI1GxrIGfY5kWbgVuLEs32Uo85KQpYM13GhE=
Received: by 10.142.108.21 with SMTP id g21mr1139408wfc.295.1281398784080;
        Mon, 09 Aug 2010 17:06:24 -0700 (PDT)
Received: from localhost.localdomain ([120.16.203.103])
        by mx.google.com with ESMTPS id x18sm7096974wfd.8.2010.08.09.17.06.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 17:06:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.53.gddb82
In-Reply-To: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153065>

With this change, git stash pop will fail early if a specified
revision argument is not a valid stash reference.

This fixes the case where the apply succeeds, but the drop fails which
caused git stash pop to exit with a non-zero exit code and a dirty tree.

Now, git stash pop fails with a non-zero exit code, but the tree is not
modified.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 41a9359..4f28c09 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -351,10 +351,10 @@ apply_stash () {
 }
 
 pop_stash() {
-	if apply_stash "$@"
-	then
-		drop_stash "$applied_stash"
-	fi
+	assert_stash_ref "$@"
+
+	apply_stash "$@" &&
+	drop_stash "$applied_stash"
 }
 
 drop_stash () {
-- 
1.6.5.rc3.8.g8ba5e
