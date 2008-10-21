From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] (squash) add index-pack with git-dir test
Date: Mon, 20 Oct 2008 22:03:19 -0700
Message-ID: <7vzlkyzgiw.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0810202110380.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 07:13:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks9QG-0000CX-FL
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 07:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbYJUFDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 01:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbYJUFDg
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 01:03:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57819 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbYJUFDf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 01:03:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2EC197251C;
	Tue, 21 Oct 2008 01:03:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8F3E972519; Tue, 21 Oct 2008 01:03:27 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0810202110380.26244@xanadu.home> (Nicolas
 Pitre's message of "Mon, 20 Oct 2008 21:17:07 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9CAB2F1E-9F2D-11DD-8A95-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98757>

This tries to make sure that the recent fix to d0b92a3 (index-pack: setup
git repository, 2008-08-26) does not introduce regression, and protects
the fix from getting broken again.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * And unfortunately the first one fails with the fix and succeeds
   without; the second one succeeds with your fix and fails without.

 t/t5302-pack-index.sh |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 6424db1..2edab73 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -177,4 +177,24 @@ test_expect_success \
        ".git/objects/pack/pack-${pack1}.pack" 2>&1) &&
      echo "$err" | grep "CRC mismatch"'
 
+test_expect_success 'running index-pack from a subdirectory' '
+    mkdir subdir &&
+    cp test-1-${pack1}.pack subdir/. &&
+    (
+	cd subdir &&
+	git index-pack test-1-${pack1}.pack
+    ) &&
+    test -f subdir/test-1-${pack1}.idx
+'
+
+test_expect_success 'running index-pack in the object store' '
+    rm -f .git/objects/pack/* &&
+    cp test-1-${pack1}.pack .git/objects/pack/pack-${pack1}.pack &&
+    (
+	cd .git/objects/pack
+	git index-pack pack-${pack1}.pack
+    ) &&
+    test -f .git/objects/pack/pack-${pack1}.idx
+'
+
 test_done
-- 
1.6.0.2.588.g31023
