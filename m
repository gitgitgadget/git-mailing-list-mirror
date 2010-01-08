From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 9/9] rerere forget path: forget recorded resolution
Date: Fri, 8 Jan 2010 22:55:51 +0100
Message-ID: <201001082255.51499.j6t@kdbg.org>
References: <1262122958-9378-1-git-send-email-gitster@pobox.com> <1262122958-9378-10-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 22:56:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTMp7-0002Vh-OJ
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 22:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040Ab0AHV4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 16:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754027Ab0AHV4p
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 16:56:45 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:22543 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753994Ab0AHV4o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 16:56:44 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1DA56CDF89;
	Fri,  8 Jan 2010 22:56:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 8CD9519F6C6;
	Fri,  8 Jan 2010 22:55:51 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1262122958-9378-10-git-send-email-gitster@pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136481>

Your implementation forgets to re-insert the forgotten resolutions into
MERGE_RR, therefore, the next 'git rerere' does not record the new
resolution.

In my implementation of 'rerere forget', I had the following tests.
The latter two of the three new tests fail with your implementation.

-- Hannes

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index a6bc028..a3f0c18 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -75,8 +75,9 @@ test_expect_success 'no postimage or thisimage yet' \
 test_expect_success 'preimage has right number of lines' '
 
 	cnt=$(sed -ne "/^<<<<<<</,/^>>>>>>>/p" $rr/preimage | wc -l) &&
-	test $cnt = 13
-
+	test $cnt = 13 &&
+	cnt=$(grep "To die! T" $rr/preimage | wc -l) &&
+	test $cnt = 1
 '
 
 git show first:a1 > a1
@@ -142,7 +143,23 @@ test_expect_success 'rerere kicked in' "! grep ^=======$ a1"
 
 test_expect_success 'rerere prefers first change' 'test_cmp a1 expect'
 
-rm $rr/postimage
+test_expect_success 'rerere forget drops postimage' '
+	git rerere forget a1 &&
+	! test -f $rr/postimage
+'
+
+test_expect_success 'conflict hash is the same as before' '
+	test $sha1 = "$(perl -pe "s/	.*//" .git/MERGE_RR)"
+'
+
+test_expect_success 'preimage was updated' '
+	cnt=$(sed -ne "/^<<<<<<</,/^>>>>>>>/p" $rr/preimage | wc -l) &&
+	test $cnt = 13 &&
+	cnt=$(grep "To die! T" $rr/preimage | wc -l) &&
+	test $cnt = 2
+'
+
+rm -f $rr/postimage
 echo "$sha1	a1" | perl -pe 'y/\012/\000/' > .git/MERGE_RR
 
 test_expect_success 'rerere clear' 'git rerere clear'
