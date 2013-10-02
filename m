From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Bug? Files are losing history after subtree merge
Date: Wed,  2 Oct 2013 21:20:17 +0200
Message-ID: <1380741617-14593-1-git-send-email-ralf.thielow@gmail.com>
Cc: Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 02 21:20:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRRyQ-0001x3-07
	for gcvg-git-2@plane.gmane.org; Wed, 02 Oct 2013 21:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053Ab3JBTUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Oct 2013 15:20:34 -0400
Received: from mail-bk0-f44.google.com ([209.85.214.44]:55691 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878Ab3JBTUd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Oct 2013 15:20:33 -0400
Received: by mail-bk0-f44.google.com with SMTP id mz10so549259bkb.31
        for <git@vger.kernel.org>; Wed, 02 Oct 2013 12:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=HI8IWfuc29vVoMObDhwr8ClvJZlT2wbKy3OqByWn+LQ=;
        b=UONcOepzZre/rEljOw6I4vSt8HzbswxG5EqXzbNJdu4ro9VsYFwuycxBs/Q1oSnlIb
         28JANte7nmBfAPNwfEMCp8wX5RvIQJ657tCQY8CVycp86lO0YY9POUj3uWnF1g/mPGGp
         F7Bfi9i2VEKkaAOUKStITi78CNjdvGieX0tLhOvEvu1EcLwXqqxOFSvGuItXzZNOxT0b
         0owRmOQyJOpXCdmRkPJtnRvYe6/kS+y8WcYu2mqSs2cgalQEfbDwramyB40HwVgdP4gb
         ZRyd1qjV2uViRt3WLNjNLZxHZY6uYyomH5m7ZNv+s9Ie3bnRMLT8PJ9yelnX8IjR3yJW
         aMQw==
X-Received: by 10.204.71.133 with SMTP id h5mr3872920bkj.0.1380741632346;
        Wed, 02 Oct 2013 12:20:32 -0700 (PDT)
Received: from localhost (dslb-178-005-121-004.pools.arcor-ip.net. [178.5.121.4])
        by mx.google.com with ESMTPSA id ny10sm2341472bkb.17.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 02 Oct 2013 12:20:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.652.g0d6e0ce
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235670>

Hi,

recently I did a merge where a complete repo shall be
merged into a specific directory of another repo. I
tried both the "subtree" merge strategy and the option
"-Xsubtree=<dir>" of "recursive". I noticed that in both
cases somehow the history of single files were lost
during these merges (with history I mean 'git log <file>'
and 'git log --follow <file>'). I've worked around this
by merging without 'subtree' and moving the dirs/files
manually. In this case the file history was there.

I've added a test case below for that behaviour. It doesn't
catch "-S recursive -Xsubtree=<dir>" but it should show
the issue (hopefully:).

Ralf
---
 t/t6029-merge-subtree.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t6029-merge-subtree.sh b/t/t6029-merge-subtree.sh
index 73fc240..e9a97d7 100755
--- a/t/t6029-merge-subtree.sh
+++ b/t/t6029-merge-subtree.sh
@@ -61,6 +61,14 @@ test_expect_success 'initial merge' '
 	test_cmp expected actual
 '
 
+test_expect_failure 'file keeps history after subtree merge' '
+	cd ../git-gui &&
+	git log --follow git-gui.sh >../git/expected &&
+	cd ../git &&
+	git log --follow git-gui/git-gui.sh >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'merge update' '
 	cd ../git-gui &&
 	echo git-gui2 > git-gui.sh &&
-- 
1.8.4.652.g0d6e0ce
