From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit: Allow to amend a merge commit that does not change the tree
Date: Mon, 03 Dec 2007 00:26:21 -0800
Message-ID: <7vir3gmbf6.fsf@gitster.siamese.dyndns.org>
References: <1196666690-22187-1-git-send-email-johannes.sixt@telecom.at>
	<7vtzn0md0h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: krh@redhat.com, Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Dec 03 09:26:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz6db-0008NS-Qf
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 09:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbXLCI02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 03:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753270AbXLCI02
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 03:26:28 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:50933 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233AbXLCI01 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 03:26:27 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8AAC32F0;
	Mon,  3 Dec 2007 03:26:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 01ACA9B4CC;
	Mon,  3 Dec 2007 03:26:44 -0500 (EST)
In-Reply-To: <7vtzn0md0h.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 02 Dec 2007 23:51:58 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66887>

Will roll in this as a new test.

--

 t/t7501-commit.sh |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 31a6f63..2e7bcb0 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -244,4 +244,36 @@ test_expect_success 'multiple -m' '
 
 '
 
+test_expect_success 'same tree (single parent)' '
+
+	if git commit -m empty
+	then
+		echo oops -- should have complained
+		false
+	else
+		: happy
+	fi
+
+'
+
+test_expect_success 'same tree (merge and amend merge)' '
+
+	git checkout -b side HEAD^ &&
+	echo zero >zero &&
+	git add zero &&
+	git commit -m "add zero" &&
+	git checkout master &&
+
+	git merge -s ours side -m "empty ok" &&
+	git diff HEAD^ HEAD >actual &&
+	: >expected &&
+	diff -u expected actual &&
+
+	git commit --amend -m "empty really ok" &&
+	git diff HEAD^ HEAD >actual &&
+	: >expected &&
+	diff -u expected actual
+
+'
+
 test_done
-- 
1.5.3.7-2077-ga07a
