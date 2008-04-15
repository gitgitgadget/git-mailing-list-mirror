From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-submodule - possibly use remote branch to describe a module
Date: Mon, 14 Apr 2008 22:19:11 -0400
Message-ID: <1208225951-1560-1-git-send-email-mlevedahl@gmail.com>
References: <7viqyk6je7.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 15 04:20:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlamI-00040g-L1
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 04:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761319AbYDOCTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 22:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761279AbYDOCTR
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 22:19:17 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:63266 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760724AbYDOCTR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 22:19:17 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1357317wxd.4
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 19:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jk4XzmJn+ZW5ZUqT3InTI/Qlt83bbB9gvgvuzsXh9cI=;
        b=CZxSwhmcLpChUbkyjPCNigy5+oYBKVKOrGm2Chhbbj7k++++dD/eHv6pD/trBXPjm3XiydjlhbEaF3dKu+zBqmRM0dPrrq3W5CRkGuQpyxC4Cl248fSBP5Fo0vnn4MlvCWlJeX0FI9gP/TEUKY8hb15hACRYXJBJAIVw2GjjpEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bBhn3QGHzNHL/1HuiKxBtrQXi1fLfxlLPOIqMYLzptECOet1Fui/MUhPqdyCGCPfz5l2EureUD33g2U943SmJFjsohiaEm9CdpV0v2OpWRXESI3I2ClujfW+XcZT2bHZSwNvdo9sBMLtcLMP3tQdld3YwraQ12j+JWtGny+otQ8=
Received: by 10.70.39.14 with SMTP id m14mr9051092wxm.49.1208225955038;
        Mon, 14 Apr 2008 19:19:15 -0700 (PDT)
Received: from localhost.localdomain ( [71.163.252.223])
        by mx.google.com with ESMTPS id i35sm27210307wxd.4.2008.04.14.19.19.13
        (version=SSLv3 cipher=OTHER);
        Mon, 14 Apr 2008 19:19:14 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.65.gf482
In-Reply-To: <7viqyk6je7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79559>

This changes the search logic for describing a submodule from:
- local branch
- tag
- tag on a later commit
- commit id

to

- local branch
- tag
- tag on a subsequent commit
- remote branch
- commit id

The change is describing with respect to a remote branch before falling
back to the commit id. By itself, git-submodule will maintain submodules
as headless checkouts without ever making a local branch. In
general, such heads cannot be described relative to a local branch but
can always be described relative to the remote branch.

This requires two describe steps in place of one: the first with
"--contains" (and no "--tags" as that is implied by "--contains"), and
a new final step having "--all --always". The split is needed as
"--contains" is incompatible with "--all".

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-submodule.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 28509ea..af195a7 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -389,7 +389,8 @@ set_name_rev () {
 		cd "$1" && {
 			git describe "$2" 2>/dev/null ||
 			git describe --tags "$2" 2>/dev/null ||
-			git describe --contains --tags --always "$2"
+			git describe --contains "$2" 2>/dev/null ||
+			git describe --all --always "$2"
 		}
 	) )
 	test -z "$revname" || revname=" ($revname)"
-- 
1.5.5.65.gf482
