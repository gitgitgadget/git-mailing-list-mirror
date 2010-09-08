From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/5] t6200-fmt-merge-msg: Exercise 'merge.log' to configure shortlog length
Date: Wed,  8 Sep 2010 23:29:56 +0530
Message-ID: <1283968797-31793-5-git-send-email-artagnon@gmail.com>
References: <1283968797-31793-1-git-send-email-artagnon@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 20:03:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtOz4-0001BB-Oq
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 20:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484Ab0IHSCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 14:02:23 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50851 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443Ab0IHSCV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 14:02:21 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so195346iwn.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 11:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8VQkPhK/QKL8sdU3lqwk+AixEfeIUhoh1jyp/R2DAeU=;
        b=gzJKoYtzNEEECipRHQtl3FUzdCboMpokfZ+Po+TxlOUFQqtDI2ZZ46X+SZft7RFEE+
         3bx+kfq5zR0ZqgzeIOumuePlPuBwjNZ2idmty7sinTPKuUOE2u4MW15D9k34k7Xah7Rn
         6JsCDfaLVYesg0j4x5R27QxMKG4qdhgIZn70o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Kb/DsGiC7+eOCMCBFtJuG7XDhMmPWyaQ0cIApHj2NxK9HcNp/HPEc5vdsr9mRT84si
         NBW4nf9RaJepQ7WIwz6LLvrXUXWLWjm1LyXpOUBNrRnECrSbNJ7G+/mdWm9Lv24WtH7x
         s04SramxHEIaUoOafmFYCXxrMcYbz6Ha7z5LY=
Received: by 10.231.80.213 with SMTP id u21mr9312139ibk.173.1283968940784;
        Wed, 08 Sep 2010 11:02:20 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id z6sm199616ibc.12.2010.09.08.11.02.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Sep 2010 11:02:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1283968797-31793-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155805>

Add a test to exercise the 'merge.log' configuration option of 'git
fmt-merge-msg'. It controls the number of shortlog entries to display
in merge commit messages.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t6200-fmt-merge-msg.sh |   48 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 71f6cad..9b600a8 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -129,6 +129,54 @@ test_expect_success '[merge] summary/log configuration' '
 	test_cmp expected actual2
 '
 
+test_expect_success 'setup: clear [merge] configuration' '
+	test_might_fail git config --unset-all merge.log &&
+	test_might_fail git config --unset-all merge.summary
+'
+
+test_expect_success 'setup FETCH_HEAD' '
+	git checkout master &&
+	test_tick &&
+	git fetch . left
+'
+
+test_expect_success 'merge.log=3 limits shortlog length' '
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
+	git -c merge.log=3 fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'merge.log=5 shows all 5 commits' '
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
+	git -c merge.log=5 fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'merge.log=0 disables shortlog' '
+	echo "Merge branch ${apos}left${apos}" >expected
+	git -c merge.log=0 fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'fmt-merge-msg -m' '
 	echo "Sync with left" >expected &&
 	cat >expected.log <<-EOF &&
-- 
1.7.2.2.409.gdbb11.dirty
