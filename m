From: Mikhail Glushenkov <foldr@codedgers.com>
Subject: [PATCH] Make 'submodule update' honor the 'update' setting in .gitmodules.
Date: Thu,  6 Aug 2009 05:56:17 +0200
Message-ID: <1249530977-17501-1-git-send-email-foldr@codedgers.com>
Cc: gitster@pobox.com, Mikhail Glushenkov <foldr@codedgers.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 05:56:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYu5t-0001s4-V9
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 05:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105AbZHFD4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 23:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753819AbZHFD4d
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 23:56:33 -0400
Received: from mail.codedgers.com ([89.208.157.186]:60816 "EHLO
	mail.codedgers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900AbZHFD4c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 23:56:32 -0400
X-Greylist: delayed 1218 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Aug 2009 23:56:32 EDT
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=celestial; d=codedgers.com;
	h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer;
	b=C9LtJFh8SewvPiXd7+bbejxgGDQwoJ4h1S7yq//9Usugro8Zzl9TVv1LFJ1Z3gHXn1xPS0f//JUVzRP6YQ8osUC8TrHbbonhTZl4D8JOADTE769FAJUnyng0RYjbsWuCYtDGhUpoJQDv3YoTHn42DtiTdyv4LXYqrCujGqPkjAs=;
Received: from ip6-99.bon.riksnet.se ([77.110.13.99] helo=localhost)
	by mail.codedgers.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <foldr@codedgers.com>)
	id 1MYu4Y-0004Os-66; Thu, 06 Aug 2009 07:55:22 +0400
X-Mailer: git-send-email 1.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125028>

Make the 'submodule update' command honor the 'submodule.$path.update' setting
in .gitmodules unless this setting is overridden in '.git/config' or with
--rebase/--merge options.

Signed-off-by: Mikhail Glushenkov <foldr@codedgers.com>
---
 git-submodule.sh |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ebed711..636023a 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -372,6 +372,15 @@ cmd_update()
 		name=$(module_name "$path") || exit
 		url=$(git config submodule."$name".url)
 		update_module=$(git config submodule."$name".update)
+
+		if test -z "$update_module"
+		then
+		    update_module="$(git config -f .gitmodules submodule."$name".update)"
+		    test -z "$update_module" ||
+		    git config submodule."$name".update "$update_module" ||
+		    die "Failed to register update mode for submodule path '$path'"
+		fi
+
 		if test -z "$url"
 		then
 			# Only mention uninitialized submodules when its
-- 
1.6.4
