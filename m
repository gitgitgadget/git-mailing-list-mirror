From: drafnel@gmail.com
Subject: [PATCH] t7701-repack-unpack-unreachable.sh: check timestamp of unpacked objects
Date: Sat, 28 Jun 2008 19:25:05 -0500
Message-ID: <4866d5bb.0807c00a.5c4b.ffffe4d7@mx.google.com>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jun 29 02:23:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCkhN-00031Z-5M
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 02:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbYF2AWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 20:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751939AbYF2AWY
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 20:22:24 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:35788 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbYF2AWX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 20:22:23 -0400
Received: by yw-out-2324.google.com with SMTP id 9so477670ywe.1
        for <git@vger.kernel.org>; Sat, 28 Jun 2008 17:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:to:cc:subject:date:x-mailer
         :from:message-id;
        bh=MsQ7wDtkpsSCtsPfRLjzJNMpjQhFxj0HM2dWpQcSZBo=;
        b=Vf2pCtOB2htIkrHJ6GIoFn2l+cMmxAUiyQwK+YkF+MDSKQidssAI9zHNwBs+JE0TyU
         VoM+3tI7iIxdI1hPcN/pYz+k5/dTCh/Tfe9QYsFe2abqflQBht5KIn6cD7djUoFbSzBp
         rOuwVAxMA9XE/p0cpEFGmwO/xHlYmHJO69Y6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:x-mailer:from:message-id;
        b=at9ELf9pZWDjUHMhqeTwAQILY//NfOtcam7mXBB0Br1A9NADOHGBzzXxJvIuYITRcb
         6R5rM2R/iyRHTyjAUNRuoNhAZryt6kWPDieTOMNLb67MzWPVJV479oHwi8Vp5scipcnb
         yv16egqlOwaERAZPDQflE9mzSQHjnlopMG9YA=
Received: by 10.150.212.12 with SMTP id k12mr5238985ybg.228.1214698940415;
        Sat, 28 Jun 2008 17:22:20 -0700 (PDT)
Received: from localhost ( [65.1.46.252])
        by mx.google.com with ESMTPS id 8sm4019704ywg.6.2008.06.28.17.22.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Jun 2008 17:22:19 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86751>

From: Brandon Casey <drafnel@gmail.com>

Unpacked objects should receive the timestamp of the pack they were
unpacked from. Check.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 t/t7701-repack-unpack-unreachable.sh |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index 6a5211f..63485c1 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -4,6 +4,10 @@ test_description='git-repack works correctly'
 
 . ./test-lib.sh
 
+fsha1=
+csha1=
+tsha1=
+
 test_expect_success '-A option leaves unreachable objects unpacked' '
 	echo content > file1 &&
 	git add . &&
@@ -44,4 +48,34 @@ test_expect_success '-A option leaves unreachable objects unpacked' '
 	git show $tsha1
 '
 
+compare_mtimes ()
+{
+	perl -e 'my $reference = shift;
+		 foreach my $file (@ARGV) {
+			exit(1) unless(-f $file && -M $file == -M $reference);
+		 }
+		 exit(0);
+		' -- "$@"
+}
+
+test_expect_success 'unpacked objects receive timestamp of pack file' '
+	fsha1path=$(echo "$fsha1" | sed -e "s/\(..\)\(.*\)/\1\/\2/") &&
+	fsha1path=".git/objects/$fsha1path" &&
+	csha1path=$(echo "$csha1" | sed -e "s/\(..\)\(.*\)/\1\/\2/") &&
+	csha1path=".git/objects/$csha1path" &&
+	tsha1path=$(echo "$tsha1" | sed -e "s/\(..\)\(.*\)/\1\/\2/") &&
+	tsha1path=".git/objects/$tsha1path" &&
+	git branch transient_branch $csha1 &&
+	git repack -a -d -l &&
+	test ! -f "$fsha1path" &&
+	test ! -f "$csha1path" &&
+	test ! -f "$tsha1path" &&
+	test 1 = $(ls -1 .git/objects/pack/pack-*.pack | wc -l) &&
+	packfile=$(ls .git/objects/pack/pack-*.pack) &&
+	git branch -D transient_branch &&
+	sleep 1 &&
+	git repack -A -l &&
+	compare_mtimes "$packfile" "$fsha1path" "$csha1path" "$tsha1path"
+'
+
 test_done
-- 
1.5.6.1
