From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/7] t3302: drop unnecessary NOT_EXPENSIVE pseudo-prerequisite
Date: Mon,  9 Jun 2014 16:22:53 -0700
Message-ID: <1402356175-7249-6-git-send-email-gitster@pobox.com>
References: <1402356175-7249-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 01:23:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu8ui-0004Rp-NX
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 01:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934303AbaFIXXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 19:23:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56642 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753978AbaFIXX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 19:23:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6188C1D412;
	Mon,  9 Jun 2014 19:23:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=TDOk
	oeDvzYqfLFdXQBYgsgNy9v0=; b=oqXa4leyaQVrn8G689meuDgBTXtdrh08+Hdu
	fj4GFa3brIIoIsRkBu9Uzv3tC/LWUi4C0I3SXniW1LWX10pAqswG7Mk49iqiM5aD
	NsuJ6eEfhpmg2PU0cEUGOrIfmppVrLpzo2nTHGKKY/mMtSgWFptnAsOs3RoZfdX0
	ZvhePnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=p7bWfW
	6awbly2fn7OQIkgGmgipQwsftLSUY3o4nvoqK4JKH9Khb+QRxuMuKKuthUuXbm+e
	pVSbMrbaN0kCP1Nwbgewu9E5Plfw9K+3qzJnWQbBE0idiVj6kJbsMQIS1i6qiI+S
	ZeFk0KOekTbiRWm8d+hN1anyDojVKtp4Z3sqg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 57BCC1D411;
	Mon,  9 Jun 2014 19:23:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3FC791D40D;
	Mon,  9 Jun 2014 19:23:24 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-483-g1a584c4
In-Reply-To: <1402356175-7249-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0D8BA05A-F02D-11E3-BCFC-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251137>

This was only necessary because do_tests helper the script defines
took its parameters in a wrong order.  Just pass an empty string (or
not passing the optional EXPENSIVE prerequisite) when running the
test with a light-weight set of parameters and have the shell do the
right thing when parsing test_expect_success helper.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3302-notes-index-expensive.sh | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-expensive.sh
index 7712cf3..8d44e04 100755
--- a/t/t3302-notes-index-expensive.sh
+++ b/t/t3302-notes-index-expensive.sh
@@ -7,7 +7,6 @@ test_description='Test commit notes index (expensive!)'
 
 . ./test-lib.sh
 
-test_set_prereq NOT_EXPENSIVE
 test -n "$GIT_NOTES_TIMING_TESTS" && test_set_prereq EXPENSIVE
 
 create_repo () {
@@ -103,8 +102,7 @@ time_notes () {
 }
 
 do_tests () {
-	pr=$1
-	count=$2
+	count=$1 pr=${2-}
 
 	test_expect_success $pr "setup $count" '
 		mkdir "$count" &&
@@ -121,7 +119,7 @@ do_tests () {
 		)
 	'
 
-	test_expect_success USR_BIN_TIME,$pr 'notes timing with /usr/bin/time' '
+	test_expect_success "USR_BIN_TIME${pr:+,$pr}" 'notes timing with /usr/bin/time' '
 		(
 			cd "$count" &&
 			time_notes 100
@@ -129,10 +127,10 @@ do_tests () {
 	'
 }
 
-do_tests NOT_EXPENSIVE 10
+do_tests 10
 for count in 100 1000 10000
 do
-	do_tests EXPENSIVE $count
+	do_tests "$count" EXPENSIVE
 done
 
 test_done
-- 
2.0.0-435-g307a092
