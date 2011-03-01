From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 1/3] t6022: New test checking for unnecessary updates of renamed+modified files
Date: Mon, 28 Feb 2011 18:08:50 -0700
Message-ID: <1298941732-19763-2-git-send-email-newren@gmail.com>
References: <1298941732-19763-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, Stephen Rothwell <sfr@canb.auug.org.au>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 02:09:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuE5O-0004v0-27
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 02:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659Ab1CABJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 20:09:01 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58756 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370Ab1CABI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 20:08:57 -0500
Received: by eyx24 with SMTP id 24so1504609eyx.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 17:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=VVvU35oJVQ6lfZc15AeIYYgvcN16VcXRLp65Fb3i/Dg=;
        b=hCSbRHemvVVfSam36IRksb0up+B0SQWYhR+becrmVQnyBrUXxuXDCLO0aggrl6B5kT
         BigIQ9EMbECvdxUpdSJucU9H5R2o6uMV+VueZaBqI37JFOHDypxZi8ZOAbOEaSC/VgVO
         pvhX7XrhBmaViPgK3WQffDQ4UwogxCB5Nl3KU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sRomufDchfqezVahN68YHPNGoUhDUmLCOUAHsozRbPethAru0q6ewm8n3AJqaip1db
         rbj2dto7Bki0HtCDWEXQWSN6+E/v4FXWnyCQk/4ddq0jmK0tFTzptqkLiExtWEb41L8U
         Aqa7awIvmFAgjGjEcJYXLB2R0IzDnWTufkUhw=
Received: by 10.213.106.6 with SMTP id v6mr2181534ebo.91.1298941736325;
        Mon, 28 Feb 2011 17:08:56 -0800 (PST)
Received: from Miney.hsd1.nm.comcast.net. (c-174-56-87-200.hsd1.nm.comcast.net [174.56.87.200])
        by mx.google.com with ESMTPS id q52sm3692922eei.9.2011.02.28.17.08.53
        (version=SSLv3 cipher=OTHER);
        Mon, 28 Feb 2011 17:08:55 -0800 (PST)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1298941732-19763-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168174>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6022-merge-rename.sh |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 1ed259d..3667e18 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -609,4 +609,36 @@ test_expect_success 'check handling of differently renamed file with D/F conflic
 	! test -f original
 '
 
+test_expect_success 'setup avoid unnecessary update, normal rename' '
+	git reset --hard &&
+	git checkout --orphan avoid-unnecessary-update-1 &&
+	git rm -rf . &&
+	git clean -fdqx &&
+
+	printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n" >original &&
+	git add -A &&
+	git commit -m "Common commmit" &&
+
+	git mv original rename &&
+	echo 11 >>rename &&
+	git add -u &&
+	git commit -m "Renamed and modified" &&
+
+	git checkout -b merge-branch-1 HEAD~1 &&
+	echo "random content" >random-file &&
+	git add -A &&
+	git commit -m "Random, unrelated changes"
+'
+
+test_expect_failure 'avoid unnecessary update, normal rename' '
+	git checkout -q avoid-unnecessary-update-1^0 &&
+	touch -t 197001010000.01 rename &&
+	orig=$(stat --format="%Y" rename) &&
+	git merge merge-branch-1 &&
+	new=$(stat --format="%Y" rename) &&
+	echo "Checking whether stat times are same: $orig vs $new" &&
+	test "$orig" == "$new" &&
+	git diff-files --exit-code # Is "rename" clean, or only racily clean?
+'
+
 test_done
-- 
1.7.4
