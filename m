From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 07/13] commit: add tests of commit races
Date: Tue, 17 Feb 2015 18:00:17 +0100
Message-ID: <1424192423-27979-8-git-send-email-mhagger@alum.mit.edu>
References: <1424192423-27979-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 18:08:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNldi-0007bM-Qe
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 18:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbbBQRIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 12:08:30 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:58007 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752561AbbBQRI2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2015 12:08:28 -0500
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Feb 2015 12:08:28 EST
X-AuditID: 12074414-f797f6d000004084-bf-54e373bb8c97
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id BC.C3.16516.BB373E45; Tue, 17 Feb 2015 12:00:43 -0500 (EST)
Received: from michael.fritz.box (p5DDB008A.dip0.t-ipconnect.de [93.219.0.138])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1HH0TXc000419
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Feb 2015 12:00:42 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1424192423-27979-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqLu7+HGIwctvMhZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvT2fWK12Ly5ncWB3ePv+w9MHjtn3WX3WLCp1OPiJWWPz5vkAlij
	uG2SEkvKgjPT8/TtErgzdjX9Zy+4zV9xrKmDqYHxKU8XIyeHhICJxN2Zc1kgbDGJC/fWs3Ux
	cnEICVxmlLh/aj0rhHOcSWLOs62MIFVsAroSi3qamUBsEQE1iYlth8C6mQVWM0lsvcsGYgsL
	WEv8uzObGcRmEVCV+PztCFicV8BF4u/szWwQ2+Qkzh//CVbDKeAqsezXMnYQWwioZn7HbKYJ
	jLwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFula6OVmluilppRuYoSEmcgOxiMn5Q4xCnAw
	KvHwWkx4FCLEmlhWXJl7iFGSg0lJlJcTGKRCfEn5KZUZicUZ8UWlOanFhxglOJiVRHiDUoBy
	vCmJlVWpRfkwKWkOFiVx3m+L1f2EBNITS1KzU1MLUotgsjIcHEoSvKZFQI2CRanpqRVpmTkl
	CGkmDk6Q4VxSIsWpeSmpRYmlJRnxoNiILwZGB0iKB2hvFkg7b3FBYi5QFKL1FKOilDivBkhC
	ACSRUZoHNxaWPF4xigN9KcybC1LFA0w8cN2vgAYzAQ2e/+cRyOCSRISUVAMj/97PtTXHkm9e
	jl1979lF9y8f84RPX6n8uGtZm7NizJGFipdlPGx/mkuLK2Z7Sfmee+QZdXC2fGPYq/4d7/wi
	+HnDPjuZN2lsyTkpXTrRv0tbO/ZdjeR09zsd5el+p76ZJ4klb5dludPTPdfCxWr5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263968>

Committing involves the following steps:

1. Determine the current value of HEAD (if any).
2. Create the new commit object.
3. Update HEAD.

Please note that step 2 can take arbitrarily long, because it might
involve the user editing a commit message.

If a second process sneaks in a commit during step 2, then the first
commit process should fail. This is usually done correctly, because
step 3 verifies that HEAD still points at the same commit that it
pointed to during step 1.

However, if there is a race when creating an *orphan* commit, then the
test in step 3 is skipped.

Add tests for proper handling of such races. One of the new tests
fails. It will be fixed in a moment.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t7516-commit-races.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100755 t/t7516-commit-races.sh

diff --git a/t/t7516-commit-races.sh b/t/t7516-commit-races.sh
new file mode 100755
index 0000000..ed04d1c
--- /dev/null
+++ b/t/t7516-commit-races.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description='git commit races'
+. ./test-lib.sh
+
+test_expect_failure 'race to create orphan commit' '
+	write_script hare-editor <<-\EOF &&
+	git commit --allow-empty -m hare
+	EOF
+	test_must_fail env EDITOR=./hare-editor git commit --allow-empty -m tortoise -e &&
+	git show -s --pretty=format:%s >subject &&
+	grep hare subject &&
+	test -z "$(git show -s --pretty=format:%P)"
+'
+
+test_expect_success 'race to create non-orphan commit' '
+	write_script airplane-editor <<-\EOF &&
+	git commit --allow-empty -m airplane
+	EOF
+	git checkout --orphan branch &&
+	git commit --allow-empty -m base &&
+	git rev-parse HEAD >base &&
+	test_must_fail env EDITOR=./airplane-editor git commit --allow-empty -m ship -e &&
+	git show -s --pretty=format:%s >subject &&
+	grep airplane subject &&
+	git rev-parse HEAD^ >parent &&
+	test_cmp base parent
+'
+
+test_done
-- 
2.1.4
