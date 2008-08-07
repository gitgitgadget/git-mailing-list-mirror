From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH] tg-create.sh: Support for multiple {to,cc,bcc} options
Date: Thu,  7 Aug 2008 22:31:26 +0200
Message-ID: <1218141086-16063-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Aug 07 22:32:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRC9x-0004Yb-Ed
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 22:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbYHGUbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 16:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753092AbYHGUbb
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 16:31:31 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:20869 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbYHGUbb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 16:31:31 -0400
Received: by fg-out-1718.google.com with SMTP id 19so360153fgg.17
        for <git@vger.kernel.org>; Thu, 07 Aug 2008 13:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=10l8ISFrXYSoHY6YnbcGdvmEa53BmTFBy2pS94LptpY=;
        b=aAPjr2a0rndCsIGHpauE8NlT6X7Q38eRfUsa0T/xpJwwIR2+/wDOQEB76ejBp7kHYF
         ArUV/DwzJk1i/0kUV3Lcz9YzExb4H48jVLXuXxIfS1boUgpmowuxC9zKmEb+kPDosMbq
         4mhMiy0WSuuQ+kevxi4ZUdrrGA2JUpNsvY47g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=w5cPDk5soVtAm95jfb9veBNpoavIgo1fkPnMf0RxtXCo/XhjnLDMZ/V4ecvXbmPGT/
         3dKIwFshM0DmcztyQqD83c430kxXA6un09o0XXetCxGzj8eRX9jY8aD68Iq+Of6Z3C+F
         eNA0f2l1z5PHii7FrO0z+OA1Ff1csrB6TJoVg=
Received: by 10.86.65.9 with SMTP id n9mr832202fga.55.1218141089044;
        Thu, 07 Aug 2008 13:31:29 -0700 (PDT)
Received: from localhost ( [91.15.79.52])
        by mx.google.com with ESMTPS id 4sm202383fgg.4.2008.08.07.13.31.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Aug 2008 13:31:28 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91604>

Git config supports multiple values for the same config key, so support it
for these TopGit config options, too.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 tg-create.sh |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tg-create.sh b/tg-create.sh
index 6cce7ed..d47959b 100644
--- a/tg-create.sh
+++ b/tg-create.sh
@@ -100,13 +100,24 @@ git checkout -b "$name"
 echo "$deps" | sed 's/ /\n/g' >"$root_dir/.topdeps"
 git add "$root_dir/.topdeps"
 
+# Print each config value for a key ($1, without "topgit." prefix)
+# with the given prefix ($2)
+get_multi_config()
+{
+	# escape any / in prefix for sed
+	prefix="$(echo "$2" | sed -e 's/\//\\\\\//g')"
+
+	git config --get-all topgit.$1 2>/dev/null |
+		sed -e "s/^/$prefix /g"
+}
+
 author="$(git var GIT_AUTHOR_IDENT)"
 author_addr="${author%> *}>"
 {
 	echo "From: $author_addr"
-	! header="$(git config topgit.to)" || echo "To: $header"
-	! header="$(git config topgit.cc)" || echo "Cc: $header"
-	! header="$(git config topgit.bcc)" || echo "Bcc: $header"
+	get_multi_config to  "To:"
+	get_multi_config cc  "Cc:"
+	get_multi_config bcc "Bcc:"
 	! subject_prefix="$(git config topgit.subjectprefix)" || subject_prefix="$subject_prefix "
 	echo "Subject: [${subject_prefix}PATCH] $name"
 	echo
-- 
tg: (e311d15..) t/support-for-multiple-to-cc-bcc-options (depends on: master)
