From: Naohiro Aota <naota@elisp.net>
Subject: [PATCH] shell portability: Use sed instead of non-portable variable expansion
Date: Mon, 05 Sep 2011 14:11:47 +0900
Message-ID: <8762l73758.fsf@elisp.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: gitster@pobox.com, tarmigan+git@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 07:12:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0RTX-0000qm-Jn
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 07:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234Ab1IEFL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 01:11:58 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35818 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896Ab1IEFL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 01:11:57 -0400
Received: by iabu26 with SMTP id u26so5927138iab.19
        for <git@vger.kernel.org>; Sun, 04 Sep 2011 22:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=9xap9F8MAAgQ0Ids8fhNkxY8wMOpTfXWQcVAQzeiuik=;
        b=f/Ev7L8+1VHcyzayBQsrMfXpF8gGOLL35CB2p53/6umHcYQkjn8gObSkikHnRx7DEo
         BabGEhw4hqdu4BbnriWntbuIRXaOZDcaC0nS3zooUZAYERSxxndtwU9er9RCtV7PkLul
         5N7PpGd5TmQBEt9xgS1ODBPvu1tKFqdABlOYk=
Received: by 10.43.49.193 with SMTP id vb1mr3327612icb.321.1315199516886;
        Sun, 04 Sep 2011 22:11:56 -0700 (PDT)
Received: from kaede (e0109-49-132-8-98.uqwimax.jp [49.132.8.98])
        by mx.google.com with ESMTPS id o5sm12282913ibu.12.2011.09.04.22.11.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Sep 2011 22:11:56 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180717>

Variable expansions like "${foo#bar}" or "${foo%bar}" doesn't work on
shells like FreeBSD sh and they made the test to fail. This patch
replace such variable expansions with sed.

Signed-off-by: Naohiro Aota <naota@elisp.net>
---

Testing on FreeBSD failed because of this "bash-ism". After applying
this patch, I've verified the test to pass on FreeBSD. (and it worked
well also with GNU sed)

 t/t5560-http-backend-noserver.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-noserver.sh
index 0ad7ce0..c8237ef 100755
--- a/t/t5560-http-backend-noserver.sh
+++ b/t/t5560-http-backend-noserver.sh
@@ -9,8 +9,8 @@ test_have_prereq MINGW && export GREP_OPTIONS=-U
 
 run_backend() {
 	echo "$2" |
-	QUERY_STRING="${1#*\?}" \
-	PATH_TRANSLATED="$HTTPD_DOCUMENT_ROOT_PATH/${1%%\?*}" \
+	QUERY_STRING=$(echo "$1"|sed -e 's/^[^?]*?\(.*\)$/\1/') \
+	PATH_TRANSLATED="$HTTPD_DOCUMENT_ROOT_PATH/$(echo "$1"|sed -e 's/^\([^?]*\)?.*$/\1/')" \
 	git http-backend >act.out 2>act.err
 }
 
-- 
1.7.6
