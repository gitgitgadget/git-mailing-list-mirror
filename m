From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v6 6/9] detached-stash: simplify git stash branch
Date: Sat, 21 Aug 2010 14:09:01 +1000
Message-ID: <1282363744-4924-7-git-send-email-jon.seymour@gmail.com>
References: <1282363744-4924-1-git-send-email-jon.seymour@gmail.com>
Cc: j6t@kdbg.org, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 21 06:10:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmfPM-0006qB-L6
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 06:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355Ab0HUEJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 00:09:59 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61215 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab0HUEJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 00:09:58 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1476555pvg.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 21:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=9sb07jYZjx0xONGpMJIzUVZr9xVn9ZUKstzU2nwX4AI=;
        b=JLsuUwwm8b97bHez1oCeFmQOJ0l/OPLNOE2HTPvMxssOVVEpnfXh7HMrjU6jyTFNpo
         18uyLakd6ukbAp3ZZ2IRaylPRMq9/SfjK9qK3tAWdDUQt7aCzAW8GlCOWgBrl9o2w3vu
         q46VYF0b7WyQT8qPDZwfebo4jJJMoCqaRoqUM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nvy0T5ThSJeZ9kG5fcUd4rL7fNPqL4j1pdZSPA8We3XiJ2kJbmHScZIyYVeDRt7Pxj
         EbD5pkcTeNKez75/xt3jBcob71H3Fw8xeqJBfARRRoBtl/t5G5v12jYMBWftNiPSwfOZ
         /yuNTDc+3iW0DRPZTBIkAihKUQmuHKzbUePUw=
Received: by 10.142.147.7 with SMTP id u7mr1764406wfd.218.1282363798244;
        Fri, 20 Aug 2010 21:09:58 -0700 (PDT)
Received: from localhost.localdomain (124-169-98-91.dyn.iinet.net.au [124.169.98.91])
        by mx.google.com with ESMTPS id z1sm4208931wfd.3.2010.08.20.21.09.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 21:09:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.110.g34f32
In-Reply-To: <1282363744-4924-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154107>

This patch teaches git stash branch to tolerate stash-like arguments.

In particular, a stash is only required if an argument isn't specified
and the stash is only dropped if a stash entry reference was
specified or implied.

The implementation has been simplified by taking advantage of
assert_stash_like() and the variables established by
parse_flags_and_rev().

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index ac4c0f6..ff1edc9 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -441,20 +441,17 @@ drop_stash () {
 }
 
 apply_to_branch () {
-	have_stash || die 'Nothing to apply'
-
 	test -n "$1" || die 'No branch name specified'
 	branch=$1
+	shift 1
 
-	if test -z "$2"
-	then
-		set x "$ref_stash@{0}"
-	fi
-	stash=$2
+	set -- --index "$@"
+	assert_stash_like "$@"
+
+	git checkout -b $branch $REV^ &&
+	apply_stash "$@"
 
-	git checkout -b $branch $stash^ &&
-	apply_stash --index $stash &&
-	drop_stash $stash
+	test -z "$IS_STASH_REF" || drop_stash "$@"
 }
 
 PARSE_CACHE='--not-parsed'
-- 
1.7.2.1.110.g34f32
