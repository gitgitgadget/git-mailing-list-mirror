From: newren@gmail.com
Subject: [PATCHv3 6/7] Add new fast-export testcases
Date: Thu, 25 Jun 2009 22:48:32 -0600
Message-ID: <1245991713-12782-7-git-send-email-newren@gmail.com>
References: <1245991713-12782-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, kusmabite@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 26 06:51:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK3PI-0003HF-Ou
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 06:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbZFZEvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 00:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752229AbZFZEu6
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 00:50:58 -0400
Received: from mail-pz0-f202.google.com ([209.85.222.202]:44971 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbZFZEuv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 00:50:51 -0400
Received: by mail-pz0-f202.google.com with SMTP id 40so3787pzk.33
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 21:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6ryfd5VPyZS1WqE8iBpPRnCNDuU2DhaUEPwRezFjCl0=;
        b=IeWZ2K0QnAzwxhZLTmI21VXOt9vt+PWy/2SkQC1QVGnJOZDcnGel/5RIXPNq35c/rl
         0/fBsbuhSM+H1HAIXOfV28q9yMDBpa2rBMHT0rCEX933OThPOxhF9lmlRF5gGj/w+6/P
         vbS+pe3Ve0rBCTKJVBDENx+p2HKmFLdtQekR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Kv/yHiTaNmSU7psT3CREEoZ52nuV9KPXReonIQ5sfPgwwdjuVl4DDea61T0n8/UMuG
         N+EyTy3bz36h9BoRyqa+pJKIN3czqoLxA/itdD3gS03DbwbvTifsrT8TsZoPcy2vAkOc
         oBqeErlLR8G3/EkE0y00PooVX7eatokIWIibE=
Received: by 10.142.200.3 with SMTP id x3mr1243394wff.312.1245991854588;
        Thu, 25 Jun 2009 21:50:54 -0700 (PDT)
Received: from localhost.localdomain (c-68-35-108-93.hsd1.nm.comcast.net [68.35.108.93])
        by mx.google.com with ESMTPS id 27sm160173wff.6.2009.06.25.21.50.52
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 21:50:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3.341.g1a0a
In-Reply-To: <1245991713-12782-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122274>

From: Elijah Newren <newren@gmail.com>

The testcases test the new --tag-of-filtered-object option, the output
when limiting what to export by path, and test behavior when no
exact-ref revision is included (e.g. master~8 present on command line
but not master).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Since the last series, one new testcase was added to document that running
with arguments like 'master~3' or 'master~7..master~2' are still broken.

 t/t9301-fast-export.sh |   88 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 88 insertions(+), 0 deletions(-)

diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index 3f13e6b..356964e 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -262,6 +262,94 @@ test_expect_success 'cope with tagger-less tags' '
 
 '
 
+test_expect_success 'setup for limiting exports by PATH' '
+	mkdir limit-by-paths &&
+	cd limit-by-paths &&
+	git init &&
+	echo hi > there &&
+	git add there &&
+	git commit -m "First file" &&
+	echo foo > bar &&
+	git add bar &&
+	git commit -m "Second file" &&
+	git tag -a -m msg mytag &&
+	echo morefoo >> bar &&
+	git add bar &&
+	git commit -m "Change to second file" &&
+	cd ..
+'
+
+cat > limit-by-paths/expected << EOF
+blob
+mark :1
+data 3
+hi
+
+reset refs/tags/mytag
+commit refs/tags/mytag
+mark :2
+author A U Thor <author@example.com> 1112912713 -0700
+committer C O Mitter <committer@example.com> 1112912713 -0700
+data 11
+First file
+M 100644 :1 there
+
+EOF
+
+test_expect_success 'dropping tag of filtered out object' '
+	cd limit-by-paths &&
+	git fast-export --tag-of-filtered-object=drop mytag -- there > output &&
+	test_cmp output expected &&
+	cd ..
+'
+
+cat >> limit-by-paths/expected << EOF
+tag mytag
+from :2
+tagger C O Mitter <committer@example.com> 1112912713 -0700
+data 4
+msg
+
+EOF
+
+test_expect_success 'rewriting tag of filtered out object' '
+	cd limit-by-paths &&
+	git fast-export --tag-of-filtered-object=rewrite mytag -- there > output &&
+	test_cmp output expected &&
+	cd ..
+'
+
+cat > limit-by-paths/expected << EOF
+blob
+mark :1
+data 4
+foo
+
+blob
+mark :2
+data 3
+hi
+
+reset refs/heads/master
+commit refs/heads/master
+mark :3
+author A U Thor <author@example.com> 1112912713 -0700
+committer C O Mitter <committer@example.com> 1112912713 -0700
+data 12
+Second file
+M 100644 :1 bar
+M 100644 :2 there
+
+EOF
+
+test_expect_failure 'no exact-ref revisions included' '
+	cd limit-by-paths &&
+	git fast-export master~2..master~1 > output &&
+	test_cmp output expected &&
+	cd ..
+'
+
+
 test_expect_success 'set-up a few more tags for tag export tests' '
 	git checkout -f master &&
 	HEAD_TREE=`git show -s --pretty=raw HEAD | grep tree | sed "s/tree //"` &&
-- 
1.6.3.2.323.geb889
