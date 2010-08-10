From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v4 6/9] stash: teach git stash branch to tolerate stash-like arguments
Date: Tue, 10 Aug 2010 10:04:45 +1000
Message-ID: <1281398688-21008-7-git-send-email-jon.seymour@gmail.com>
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
	id 1OicMm-0001dO-23
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 02:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757366Ab0HJAGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 20:06:37 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45353 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757316Ab0HJAGg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 20:06:36 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so974893pvg.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 17:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Qm6n5iVHWfiNWoXrwwExdbguVk+SPYbwQ1bCv4dtENU=;
        b=M/ltMawcUvT75V+RRTVdQ/A6yrJ+CRqHSGg5AjGoIjcxND7eZ/KOEnw4sRaHInZPKA
         y0dENMOKAkwcifmXlviD7A/JnDTt6gJRpmqiQF8iMfHDRgvdGUlwR1bLbGC9UGabSuPp
         wu3dUbFEiYHQOi4DzC64+w3kS/BWQ9VqO0VMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pKhFvzQtJhk0IQY1bJz4X3dBUcLDA5BGoJRedGX/8ASxCy1Dtw6Ybx5IfF+QpUJzpN
         4QvT/h5ueOvHBu04boduBEDmcMJk02ihAwr5HvmeDZEMV6o0DyqzFNHbAoyOVNjzPsfQ
         0+g1ezqBzaCSMhO9dzjnbQPTEdc1sFO/wyNiA=
Received: by 10.142.174.16 with SMTP id w16mr12952111wfe.21.1281398796191;
        Mon, 09 Aug 2010 17:06:36 -0700 (PDT)
Received: from localhost.localdomain ([120.16.203.103])
        by mx.google.com with ESMTPS id x18sm7096974wfd.8.2010.08.09.17.06.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 17:06:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.53.gddb82
In-Reply-To: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153064>

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
1.6.5.rc3.8.g8ba5e
