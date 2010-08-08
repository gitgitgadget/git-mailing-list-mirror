From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 6/9] stash: teach git stash branch to tolerate stash-like arguments
Date: Sun,  8 Aug 2010 14:46:08 +1000
Message-ID: <1281242771-24764-7-git-send-email-jon.seymour@gmail.com>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, ams@toroid.org, nanako3@bluebottle.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 08 06:48:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ohxns-0007vl-B0
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 06:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183Ab0HHEr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 00:47:56 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64812 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab0HHErz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 00:47:55 -0400
Received: by pvg2 with SMTP id 2so408951pvg.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 21:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Jilj1vlzmkPrS0L0HCyswu3URgTw2CF9qiuoqapYntk=;
        b=Ot05dQNxyPO5NQAeJAYSfbbu7fhBDdRgw1zTzR9THLmbMteUztyMbq+59e5Jlqlr7d
         QAwkop7xkoLJd3CQN/WLXxcWhc8ZFdaCVxHhqD1f5eLyiS1EEyC9xMTcck1EPjxP8a9z
         4KkOJWh6gugCEiB6nqVYIAptp/ZgK3rMoT/L8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=i1L0Wz5DjHYOzf+bVBbZzLA0cAFlwn4WVR8/bm53gjLemQitV0UzQgVYCTpcQ0XwWK
         mlWQ5tcCNjukVQAhTm7jIczbcrgnRvuBFVbLWoIQYq4FKhg/KC5lkhlYkLZb4LOWwP1l
         /uR+hHOHEhbhtCIqxLsipnnl7lcFvS+yhu/wI=
Received: by 10.142.232.13 with SMTP id e13mr12094040wfh.87.1281242875120;
        Sat, 07 Aug 2010 21:47:55 -0700 (PDT)
Received: from localhost.localdomain ([120.16.216.92])
        by mx.google.com with ESMTPS id n2sm4295884wfl.13.2010.08.07.21.47.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Aug 2010 21:47:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.47.gc532
In-Reply-To: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152890>

This patch teaches git stash branch to tolerate stash-like arguments.

In particular, a stash is only required if an argument isn't specified
and the stash is only dropped if a stash entry reference was
specified or implied.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 86cd446..97e3749 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -390,20 +390,27 @@ drop_stash () {
 }
 
 apply_to_branch () {
-	have_stash || die 'Nothing to apply'
-
 	test -n "$1" || die 'No branch name specified'
 	branch=$1
 
 	if test -z "$2"
 	then
 		set x "$ref_stash@{0}"
+		have_stash || die 'Nothing to apply'
 	fi
 	stash=$2
 
+	assert_stash_like "$stash"
+
 	git checkout -b $branch $stash^ &&
-	apply_stash --index $stash &&
-	drop_stash $stash
+	apply_stash --index $stash
+
+	if is_stash_ref "$stash"
+	then
+		drop_stash "$stash"
+	else
+		true
+	fi
 }
 
 # The default command is "save" if nothing but options are given
-- 
1.7.2.1.51.g82c0c0
