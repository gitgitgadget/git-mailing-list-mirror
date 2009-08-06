From: Mikhail Glushenkov <the.dead.shall.rise@gmail.com>
Subject: [PATCH] Make 'submodule update' honor the 'update' setting in .gitmodules.
Date: Thu,  6 Aug 2009 05:36:09 +0200
Message-ID: <1249529769-15720-1-git-send-email-the.dead.shall.rise@gmail.com>
Cc: Mikhail Glushenkov <the.dead.shall.rise@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 06:14:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYuNM-0006A8-OJ
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 06:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbZHFEOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 00:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbZHFEOk
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 00:14:40 -0400
Received: from mail.codedgers.com ([89.208.157.186]:55197 "EHLO
	mail.codedgers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbZHFEOj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 00:14:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=celestial; d=gmail.com;
	h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer;
	b=334iXn0jQFWzB2dvkt2PGAFk0qJU5zjr8TFWLz3GBhq3hyQ1etsY+M0iGHfmJqT/00572F+RewjR2oVYbg5c2Jn7D+eVOLiyfRR1CMZjMYHAF94nexqkedz0uns8oIbGYL3CP34lXzOCXlMPYUz7BbOL8aEYBv4q2voxdm5wsI4=;
Received: from ip6-99.bon.riksnet.se ([77.110.13.99] helo=localhost)
	by mail.codedgers.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <foldr@codedgers.com>)
	id 1MYtkv-0004Nj-76; Thu, 06 Aug 2009 07:35:05 +0400
X-Mailer: git-send-email 1.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125031>

Make the 'submodule update' command use the 'submodule.$path.update' setting in
.gitmodules unless this setting is overridden in '.git/config' or with
--rebase/--merge options.

Signed-off-by: Mikhail Glushenkov <the.dead.shall.rise@gmail.com>
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
