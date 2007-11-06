From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5530-upload-pack-error: Check more carefully for failures.
Date: Mon, 05 Nov 2007 16:22:17 -0800
Message-ID: <7vve8gkyti.fsf@gitster.siamese.dyndns.org>
References: <200711042046.48257.johannes.sixt@telecom.at>
	<7v3avkqwyz.fsf@gitster.siamese.dyndns.org>
	<200711052240.12822.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Nov 06 01:22:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpCDJ-0003oW-If
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 01:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460AbXKFAW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 19:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755093AbXKFAW0
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 19:22:26 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56020 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453AbXKFAWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 19:22:25 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 012EC2EF;
	Mon,  5 Nov 2007 19:22:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 7418D92A38;
	Mon,  5 Nov 2007 19:22:43 -0500 (EST)
In-Reply-To: <200711052240.12822.johannes.sixt@telecom.at> (Johannes Sixt's
	message of "Mon, 5 Nov 2007 22:40:12 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63599>

Johannes Sixt <johannes.sixt@telecom.at> writes:

>   On Monday 05 November 2007 21:05, Junio C Hamano wrote:
>   > > 	The test case checks for failures in rev-list (a missing
>   > > 	object). Any hints how to trigger a failure in pack-objects
>   > > 	that does not also trigger in rev-list would be welcome.
>   >
>   > How about removing a blob from the test repository  to corrupt
>   > it?  rev-list --objects I think would happily list the blob
>   > because it sees its name in its containing tree without checking
>   > its existence.
>
>   That does it. This goes on top of my previous patch.

Thanks.  Will squash with further changes attached for readability.

---
 t/t5530-upload-pack-error.sh |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index 70d4f86..cc8949e 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -6,6 +6,13 @@ test_description='errors in upload-pack'
 
 D=`pwd`
 
+corrupt_repo () {
+	object_sha1=$(git rev-parse "$1") &&
+	ob=$(expr "$object_sha1" : "\(..\)") &&
+	ject=$(expr "$object_sha1" : "..\(..*\)") &&
+	rm -f ".git/objects/$ob/$ject"
+}
+
 test_expect_success 'setup and corrupt repository' '
 
 	echo file >file &&
@@ -15,7 +22,7 @@ test_expect_success 'setup and corrupt repository' '
 	test_tick &&
 	echo changed >file &&
 	git commit -a -m changed &&
-	rm -f .git/objects/5e/a2ed416fbd4a4cbe227b75fe255dd7fa6bd4d6
+	corrupt_repo HEAD:file
 
 '
 
@@ -35,7 +42,7 @@ test_expect_success 'upload-pack fails due to error in pack-objects' '
 test_expect_success 'corrupt repo differently' '
 
 	git hash-object -w file &&
-	rm -f .git/objects/be/c63e37d08c454ad3a60cde90b70f3f7d077852
+	corrupt_repo HEAD^^{tree}
 
 '
 
