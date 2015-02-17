From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 08/13] commit: avoid race when creating orphan commits
Date: Tue, 17 Feb 2015 18:00:18 +0100
Message-ID: <1424192423-27979-9-git-send-email-mhagger@alum.mit.edu>
References: <1424192423-27979-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 18:01:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNlWF-0003v4-AU
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 18:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbbBQRAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 12:00:49 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:42117 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752249AbbBQRAq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2015 12:00:46 -0500
X-AuditID: 1207440d-f79976d000005643-a7-54e373bc3240
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id B3.DC.22083.CB373E45; Tue, 17 Feb 2015 12:00:45 -0500 (EST)
Received: from michael.fritz.box (p5DDB008A.dip0.t-ipconnect.de [93.219.0.138])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1HH0TXd000419
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Feb 2015 12:00:43 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1424192423-27979-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqLu3+HGIQcccRouuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLXr7PrFabN7czuLA7vH3/Qcmj52z7rJ7LNhU6nHxkrLH501yAaxR
	3DZJiSVlwZnpefp2CdwZy9qeshcs5qlo/bKQrYHxJ2cXIyeHhICJxNvdnWwQtpjEhXvrgWwu
	DiGBy4wSC07dYYZwjjNJLOs5zgpSxSagK7Gop5kJxBYRUJOY2HaIBcRmFljNJLH1LtgkYQFP
	ifYLvUA2BweLgKpE85RakDCvgIvE8s2XmCGWyUmcP/4TzOYUcJVY9msZO4gtBFQzv2M20wRG
	3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdI30cjNL9FJTSjcxQoKMdwfj/3UyhxgFOBiV
	eHgtJjwKEWJNLCuuzD3EKMnBpCTKywkMUSG+pPyUyozE4oz4otKc1OJDjBIczEoivEEpQDne
	lMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgRvWxFQo2BRanpqRVpmTglC
	momDE2Q4l5RIcWpeSmpRYmlJRjwoMuKLgbEBkuIB2psF0s5bXJCYCxSFaD3FqCglzpsCkhAA
	SWSU5sGNhaWOV4ziQF8K864DqeIBph247ldAg5mABs//8whkcEkiQkqqgbFCUS7J53iQZJdT
	dF2jfFg/f8CfqiaO/1NtzeYvt+u3UVp0zLw15dQDx9rAbSXFW1ZwC3Y3n3l3fPtFtecHoy1/
	G83U1lIJz5mpd2KNya9JTSFHlDbccTwzw2HV+inWRgt9VK0/3M5U2qf+6vrL2M7p 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263963>

If HEAD doesn't point at anything during the initial check, then we
should make sure that it *still* doesn't point at anything when we are
ready to update the reference. Otherwise, another process might commit
while we are working (e.g., while we are waiting for the user to edit
the commit message) and we will silently overwrite it.

This fixes a failing test in t7516.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 builtin/commit.c        | 2 +-
 t/t7516-commit-races.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 8afb0ff..682f922 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1766,7 +1766,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD", sha1,
 				   current_head
-				   ? current_head->object.sha1 : NULL,
+				   ? current_head->object.sha1 : null_sha1,
 				   0, sb.buf, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		rollback_index_files();
diff --git a/t/t7516-commit-races.sh b/t/t7516-commit-races.sh
index ed04d1c..f2ce14e 100755
--- a/t/t7516-commit-races.sh
+++ b/t/t7516-commit-races.sh
@@ -3,7 +3,7 @@
 test_description='git commit races'
 . ./test-lib.sh
 
-test_expect_failure 'race to create orphan commit' '
+test_expect_success 'race to create orphan commit' '
 	write_script hare-editor <<-\EOF &&
 	git commit --allow-empty -m hare
 	EOF
-- 
2.1.4
