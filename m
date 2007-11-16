From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Fix and improve t7004
Date: Fri, 16 Nov 2007 23:02:08 +0100
Message-ID: <1195250528-9727-1-git-send-email-mh@glandium.org>
References: <7vbq9tyii3.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 17 08:39:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItIGc-0006go-CR
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 08:39:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbXKQHdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 02:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752100AbXKQHdK
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 02:33:10 -0500
Received: from vawad.err.no ([85.19.200.177]:59371 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752037AbXKQHdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 02:33:09 -0500
Received: from aputeaux-153-1-42-198.w82-124.abo.wanadoo.fr ([82.124.6.198] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1ItIAi-0001QX-2o; Sat, 17 Nov 2007 08:32:59 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1It9GK-0002XJ-T3; Fri, 16 Nov 2007 23:02:08 +0100
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <7vbq9tyii3.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: (score 5.7): Status=Yes hits=5.7 required=5.0 tests=DATE_IN_PAST_06_12,RCVD_IN_DSBL,RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65261>

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
> Perhaps...
> 
>       # check the first line --- should be empty
>       first=$(sed -e 1q <actual) &&
>         test -z "$first" &&
>       # remove commented lines from the remainder -- should be empty
>         rest=$(sed -e 1d -e '/^#/d' <actual) &&
>         test -z "$rest"

I like that better. So here is a new version using this. In the end, the
patch and most of the comment are yours, so maybe you should claim it is
your patch.

 t/t7004-tag.sh |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 096fe33..162bdf7 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1004,10 +1004,20 @@ test_expect_failure \
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
+	# check the first line --- should be empty
+	first=$(sed -e 1q <actual) &&
+	test -z "$first" &&
+	# remove commented lines from the remainder -- should be empty
+	rest=$(sed -e 1d -e '/^#/d' <actual) &&
+	test -z "$rest"
 '
 
 get_tag_header reuse $commit commit $time >expect
-- 
1.5.3.5
