From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/3] t6200-fmt-merge-msg: Exercise '--log' to configure shortlog length
Date: Sat, 28 Aug 2010 16:05:34 +0530
Message-ID: <1282991734-3368-4-git-send-email-artagnon@gmail.com>
References: <1282991734-3368-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 28 12:38:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpIo4-0003rS-4D
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 12:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714Ab0H1Kia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 06:38:30 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:64962 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab0H1Ki3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 06:38:29 -0400
Received: by pxi10 with SMTP id 10so1408815pxi.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 03:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Qsb1v1u/YF+4/Un8lw5qZZ8/AzK11LL5k0Ls275Vwcs=;
        b=uzECAAf9P5gN0h9LtNfvT3kzuyvF2JZvCQNJbw3bm6ScOemh1jcKaRvDK1ph2XfLap
         JmiAcT0cS0ZUSfWpVEcm6zoZyWqaDwPOEA9ljKfZvqHGQie/W0owW4AswQ+VEaRngZjX
         AfRqVeNM0funiAe6uVCnsufg5sDRlhqGfBGCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nYXWdyIU8ZLgEFfmru4ufKVV3o2DPLtBAde5UpCFG1buLiFRPnub3EStTvG25n45L/
         M8W6qa0rNaaH2sSl5unBS3CzUO+aOLh8JpZmiCkp4AaAPng5bUXwcGNAsfBE0TczOL4o
         aH00o0VAD15VFxxISKhxFfl3H1CSWx4wuEQ+A=
Received: by 10.142.165.19 with SMTP id n19mr973122wfe.268.1282991909008;
        Sat, 28 Aug 2010 03:38:29 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id t11sm5855798wfc.4.2010.08.28.03.38.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 03:38:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282991734-3368-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154639>

Add a test to exercise the '--log' command-line option of 'git
fmt-merge-msg'. It controls the number of shortlog entries to display
in merge commit messages.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t6200-fmt-merge-msg.sh |   59 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 528fdf9..395c23e 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -193,6 +193,65 @@ test_expect_success 'merge.log=-1 does something sane' '
 	test_cmp expected actual
 '
 
+test_expect_success '--log=3 limits shortlog length' '
+	cat >expected <<-EOF &&
+	Merge branch ${apos}left${apos}
+
+	* left: (5 commits)
+	  Left #5
+	  Left #4
+	  Left #3
+	  ...
+	EOF
+
+	git fmt-merge-msg --log=3 <.git/FETCH_HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--log=5 shows all 5 commits' '
+	cat >expected <<-EOF &&
+	Merge branch ${apos}left${apos}
+
+	* left:
+	  Left #5
+	  Left #4
+	  Left #3
+	  Common #2
+	  Common #1
+	EOF
+
+	git fmt-merge-msg --log=5 <.git/FETCH_HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--no-log disables shortlog' '
+	echo "Merge branch ${apos}left${apos}" >expected &&
+	git fmt-merge-msg --no-log <.git/FETCH_HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--log=0 disables shortlog' '
+	echo "Merge branch ${apos}left${apos}" >expected &&
+	git fmt-merge-msg --no-log <.git/FETCH_HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--log=-1 does something sane' '
+	cat >expected <<-EOF &&
+	Merge branch ${apos}left${apos}
+
+	* left:
+	  Left #5
+	  Left #4
+	  Left #3
+	  Common #2
+	  Common #1
+	EOF
+
+	git fmt-merge-msg --log=-1 <.git/FETCH_HEAD >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'fmt-merge-msg -m' '
 	echo "Sync with left" >expected &&
 	cat >expected.log <<-EOF &&
-- 
1.7.2.2.409.gdbb11.dirty
