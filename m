From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH 1/2] lib-rebase.sh: fake-editor.sh: Allow checking of non-comment lines in $GIT_EDITOR
Date: Fri,  9 Jul 2010 13:20:42 +0800
Message-ID: <1278652843-30872-1-git-send-email-ayiehere@gmail.com>
Cc: johannes.schindelin@gmx.de, Nazri Ramliy <ayiehere@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 09 07:21:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX61i-0007Rb-NC
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 07:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957Ab0GIFVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 01:21:15 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55345 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815Ab0GIFVO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 01:21:14 -0400
Received: by pvc7 with SMTP id 7so627784pvc.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 22:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=xAHYm0ulWXDIIkJfsyzJHBVm4iXXWoNh/B5cqlh1GVI=;
        b=Ve5fwdgr1feejLBj7rZYXbAHzK/9VYcTncUCPN2UvPKIG6NidAAz3VqO6dmU6tNddx
         7cMwMd8kHgLehB+gn3KVYO4TY4ss7sN9nw0NN40NInm0giG2kno5uBCZ4EZu7N/AKGm0
         UaCe1kdNhPRVg0G8zadADix8mtY/BksOmYpJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=TdwmXj8dl9Y+ZaBkCnoOwLANwiLLNTES723ei4JqxMWuO/2SPYVRC5Rjpozq9LfaiU
         nu65Sf6vQ2KIWsquhEtywu/0UpsgHKjWJSJr7+SfhSAPRqInj+2YT+Fl0I+uEFn1xjEb
         I4LR8AUsohzq/hHkZeSE4NHo367TuUnXYy2mU=
Received: by 10.114.133.7 with SMTP id g7mr10731589wad.101.1278652873518;
        Thu, 08 Jul 2010 22:21:13 -0700 (PDT)
Received: from localhost.localdomain ([115.134.57.99])
        by mx.google.com with ESMTPS id 33sm7732585wad.18.2010.07.08.22.21.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 22:21:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150641>

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
---
This is in preparation of patch 2/2 in this series.

nazri.

 t/lib-rebase.sh |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 6aefe27..e1a33fc 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -4,6 +4,10 @@
 #
 # - override the commit message with $FAKE_COMMIT_MESSAGE
 # - amend the commit message with $FAKE_COMMIT_AMEND
+# - check that the non-comment text shown in the editor matches that in the
+#   file $EXPECT_NON_COMMENT_LINES. To make the comparison ignore the commit ids
+#   use the string "COMMIT_ID" in place of the sha1 in your 'expect' file and set
+#   REPLACE_COMMIT_ID=COMMIT_ID
 # - check that non-commit messages have a certain line count with $EXPECT_COUNT
 # - check the commit count in the commit message header with $EXPECT_HEADER_COUNT
 # - rewrite a rebase -i script as directed by $FAKE_LINES.
@@ -34,6 +38,17 @@ case "$1" in
 	exit
 	;;
 esac
+test -z "$EXPECT_NON_COMMENT_LINES" ||
+	(
+		grep -v '^#' < "$1" > out_non_comment.$$ &&
+		if test -n "$REPLACE_COMMIT_ID"
+		then
+			sed -i "s/^\([a-z]\+\) [0-9a-f]\+ /\1 $REPLACE_COMMIT_ID /" \
+			out_non_comment.$$
+		fi &&
+		diff "$EXPECT_NON_COMMENT_LINES" out_non_comment.$$ > /dev/null
+	) ||
+	exit
 test -z "$EXPECT_COUNT" ||
 	test "$EXPECT_COUNT" = $(sed -e '/^#/d' -e '/^$/d' < "$1" | wc -l) ||
 	exit
-- 
1.7.2.rc2
