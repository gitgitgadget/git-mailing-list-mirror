From: William Clifford <mr.william.clifford@gmail.com>
Subject: [PATCH/RFC 1/2] Add sequence.format to interactive rebase
Date: Fri, 5 Sep 2014 01:40:01 -0700
Message-ID: <861trli9lb.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 09 08:36:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRF2t-000679-4V
	for gcvg-git-2@plane.gmane.org; Tue, 09 Sep 2014 08:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755710AbaIIGgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 02:36:51 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:42400 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755666AbaIIGgu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 02:36:50 -0400
Received: by mail-pd0-f170.google.com with SMTP id fp1so593302pdb.15
        for <git@vger.kernel.org>; Mon, 08 Sep 2014 23:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:mime-version:content-type;
        bh=D0ndWWZ6h65upSgKJXNBvR3VUbL2L+RCkFxMzsciD7w=;
        b=c/s6hP1L5QDhiySk1ICQ57bLXld9YtnrwKFrIfuG6PqyLKo6bp2O1HteLJDCiHajMX
         d50V1vp0h6inU9oDHFBoq8tNvGcdozh5R3BBsj5ICwb2VZ7MeM8walFtoA19hWqyVgrK
         6P0LWyElOrArZCTUG3iIyL5a0yhYmKgv6EMdoUrmD6G3qU8Ombg9Sf6K/vRW0dXwmPyT
         09JPD+YcjRPX0znyPsq2Odrv313YTc2k637XkHwo2A1xAznN5O8QDxVZ4dOIDDJ53KGK
         BCec/sBx2EIoxuGWUWVbTv6Jly6PjFBjwSt3FdXGJVmFnTaoj94j/mN9v0YHkctcbS3g
         2z4A==
X-Received: by 10.70.128.137 with SMTP id no9mr12992536pdb.143.1410244610235;
        Mon, 08 Sep 2014 23:36:50 -0700 (PDT)
Received: from LOVE-MACHINE (75-175-34-145.ptld.qwest.net. [75.175.34.145])
        by mx.google.com with ESMTPSA id we5sm11280385pab.28.2014.09.08.23.36.48
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Sep 2014 23:36:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256684>

Allow user to customize the format of commit table in interactive
rebase todo file. Short hashes are still required to be the second
column so these are added to the format if not already present.
Defaults to oneline as before.

Signed-off-by: William Clifford <mr.william.clifford@gmail.com>
Signed-off-by: Matthew Boeh <m@mboeh.com>
---
 git-rebase--interactive.sh | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b64dd28..ba1f4b8 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -961,7 +961,19 @@ else
 	revisions=$onto...$orig_head
 	shortrevisions=$shorthead
 fi
-git rev-list $merges_option --pretty=oneline --abbrev-commit \
+
+if test -z "$GIT_SEQUENCE_FORMAT"
+then
+	GIT_SEQUENCE_FORMAT="$(git config sequence.format)"
+fi
+if test -n "$GIT_SEQUENCE_FORMAT"
+then
+	if test "$GIT_SEQUENCE_FORMAT" = "${GIT_SEQUENCE_FORMAT#>%h}"
+	then
+		GIT_SEQUENCE_FORMAT=">%h $GIT_SEQUENCE_FORMAT"
+	fi
+fi
+git rev-list $merges_option --pretty="${GIT_SEQUENCE_FORMAT:-oneline}" --abbrev-commit \
 	--abbrev=7 --reverse --left-right --topo-order \
 	$revisions ${restrict_revision+^$restrict_revision} | \
 	sed -n "s/^>//p" |
-- 
William Clifford
