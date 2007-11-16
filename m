From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Fix and improve t7004
Date: Fri, 16 Nov 2007 21:28:37 +0100
Message-ID: <1195244917-25659-1-git-send-email-mh@glandium.org>
References: <7vlk8yx9rp.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 16 21:30:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It7pC-0004Aw-Lt
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 21:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbXKPU3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 15:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753194AbXKPU3q
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 15:29:46 -0500
Received: from vawad.err.no ([85.19.200.177]:46029 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752891AbXKPU3p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 15:29:45 -0500
Received: from aputeaux-153-1-42-198.w82-124.abo.wanadoo.fr ([82.124.6.198] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1It7oa-0007dm-Kd; Fri, 16 Nov 2007 21:29:35 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1It7np-0006gJ-Np; Fri, 16 Nov 2007 21:28:37 +0100
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <7vlk8yx9rp.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: (score 8.5): Status=Yes hits=8.5 required=5.0 tests=RCVD_IN_DSBL,RCVD_IN_SORBS_DUL,SPF_HELO_SOFTFAIL,SPF_SOFTFAIL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65245>

Brown paper bag fix to avoid using non portable sed syntax. The
test by itself didn't catch what it was supposed to, anyways.

The new test first checks whether the user exited the editor
without editing the file, then whether what the user was
presented in the editor was any useful to her, which we define
as the following:
 * It begins with a single blank line, where the invoked editor
   would typically place the editing curser at so that the user
   can immediately start typing;

 * It has some instruction but that comes after that initial
   blank line, all lines prefixed with "#".

 * And it has nothing else, as the expected behaviour is "Hey
   you did not leave any message".

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 t/t7004-tag.sh |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 096fe33..42b1f97 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1004,10 +1004,17 @@ test_expect_failure \
 	'verify signed tag fails when public key is not present' \
 	'git-tag -v signed-tag'
 
+test_expect_failure \
+	'git-tag -a fails if tag annotation is empty' '
+	GIT_EDITOR=cat git tag -a initial-comment > /dev/null 2>&1
+'
+
 test_expect_success \
 	'message in editor has initial comment' '
 	GIT_EDITOR=cat git tag -a initial-comment > actual || true &&
-	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
+	( read empty ;
+	  [ "$empty" ] && exit 1 ;
+	  ! grep -ve "^#" > /dev/null 2>&1 ) < actual
 '
 
 get_tag_header reuse $commit commit $time >expect
-- 
1.5.3.5
