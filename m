From: Adam Simpkins <simpkins@facebook.com>
Subject: [PATCH] Add test case for rev-list --parents --show-all
Date: Wed, 19 Aug 2009 15:58:52 -0700
Message-ID: <20090819225852.GA21187@facebook.com>
References: <1250628954.114121983@192.168.1.201> <20090818211812.GL8147@facebook.com> <7vk5103chi.fsf@alter.siamese.dyndns.org> <20090819022918.GO8147@facebook.com> <20090819023433.GP8147@facebook.com> <7vhbw41g3f.fsf@alter.siamese.dyndns.org> <7v4os41frm.fsf@alter.siamese.dyndns.org> <20090819225547.GR8147@facebook.com>
Reply-To: Adam Simpkins <simpkins@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
To: Junio C Hamano <gitster@pobox.com>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 20 00:59:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdu7f-00036m-80
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 00:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363AbZHSW6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 18:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753316AbZHSW6y
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 18:58:54 -0400
Received: from mailout-snc1.facebook.com ([69.63.179.25]:58163 "EHLO
	mailout-snc1.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207AbZHSW6x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 18:58:53 -0400
Received: from mail.thefacebook.com (intlb01.snat.snc1.facebook.com [10.128.203.16] (may be forged))
	by pp01.snc1.tfbnw.net (8.14.1/8.14.1) with ESMTP id n7JMwmI3032055
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Wed, 19 Aug 2009 15:58:48 -0700
Received: from simpkins (192.168.18.252) by mail.TheFacebook.com
 (192.168.18.105) with Microsoft SMTP Server (TLS) id 8.1.393.1; Wed, 19 Aug
 2009 15:58:53 -0700
Received: from simpkins by simpkins with local (Exim 4.69)	(envelope-from
 <simpkins@facebook.com>)	id 1Mdu7I-0005Xs-KR; Wed, 19 Aug 2009 15:58:52 -0700
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090819225547.GR8147@facebook.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166 definitions=2009-08-19_15:2009-08-11,2009-08-19,2009-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0907200000 definitions=main-0908190185
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126587>

This test case ensures that rev-list --parents --show-all gets the
parent history correct.  Normally, --parents rewrites parent history to
skip TREESAME parents.  However, --show-all causes TREESAME parents to
still be included in the revision list, so the parents should still be
included too.

Signed-off-by: Adam Simpkins <simpkins@facebook.com>
---

Looking through the code, I believe TREESAME commits are the only ones
affected by my earlier bug in simplify_commit().

 t/t6015-rev-list-show-all-parents.sh |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100644 t/t6015-rev-list-show-all-parents.sh

diff --git a/t/t6015-rev-list-show-all-parents.sh b/t/t6015-rev-list-show-all-parents.sh
new file mode 100644
index 0000000..8b146fb
--- /dev/null
+++ b/t/t6015-rev-list-show-all-parents.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+
+test_description='--show-all --parents does not rewrite TREESAME commits'
+
+. ./test-lib.sh
+
+test_expect_success 'set up --show-all --parents test' '
+	test_commit one foo.txt &&
+	commit1=`git rev-list -1 HEAD` &&
+	test_commit two bar.txt &&
+	commit2=`git rev-list -1 HEAD` &&
+	test_commit three foo.txt &&
+	commit3=`git rev-list -1 HEAD`
+	'
+
+test_expect_success '--parents rewrites TREESAME parents correctly' '
+	echo $commit3 $commit1 > expected &&
+	echo $commit1 >> expected &&
+	git rev-list --parents HEAD -- foo.txt > actual &&
+	test_cmp expected actual
+	'
+
+test_expect_success '--parents --show-all does not rewrites TREESAME parents' '
+	echo $commit3 $commit2 > expected &&
+	echo $commit2 $commit1 >> expected &&
+	echo $commit1 >> expected &&
+	git rev-list --parents --show-all HEAD -- foo.txt > actual &&
+	test_cmp expected actual
+	'
+
+test_done
-- 
1.6.0.4
