From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] update-hook: fix incorrect use of git-describe and sed for finding previous tag
Date: Wed, 14 Mar 2007 14:25:52 +0000
Message-ID: <200703141425.53192.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 15:26:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRUQh-0000ei-EX
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 15:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161282AbXCNOZ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 10:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161286AbXCNOZ7
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 10:25:59 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:2288 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161282AbXCNOZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 10:25:58 -0400
Received: by wx-out-0506.google.com with SMTP id h31so190989wxd
        for <git@vger.kernel.org>; Wed, 14 Mar 2007 07:25:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=BAIaym68oViShgRh+BOEPv79Lnjdhfp02rxMbETyCqmAv4QRr3AAFN2keFkUVGYYf9f19SC8pA0YSDfkUCYhGI1F9VQSpiUBdWcNZMUGPnZNaNPOXQ9nB5jRfYWG6JCU3UptwyaYpStardArBPITydzqbCc7F3R1BpfE9lp44rE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=LfAzj+MJnH7l5opWXDYzAqGBkxKAE3cXmtE+XzKT2x0GYVCc3TI/xBKU8tnmJ0zkMAvfbbQH9dDikj7dJeD4BWKtgHv37E3RWYbBKA/boAoWePMvjTGqlREvecdfrbBoarWiPv1DJ11lSjg5gsulggFjHUwobixIc91ioOkjxeI=
Received: by 10.90.90.16 with SMTP id n16mr7258733agb.1173882357720;
        Wed, 14 Mar 2007 07:25:57 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id o9sm24967116nfa.2007.03.14.07.25.56;
        Wed, 14 Mar 2007 07:25:57 -0700 (PDT)
X-TUID: 4bddc2396aa4f600
X-UID: 287
X-Length: 1642
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42209>

Previously git-describe would output lines of the form
 v1.1.1-gf509d56
The update hook found the dash and stripped it off using
 sed 's/-g.*//'
The remainder was then used as the previous tag name.

However, git-describe has changed format.  The output is now of the form
 v1.1.1-23-gf509d56
The above sed fragment doesn't strip the middle "-23", and so the
previous tag name used would be "v1.1.1-23".  This is incorrect.

Since the hook script was written, git-describe now gained support for
"--abbrev=0", which it uses as a special flag to tell it not to output
anything other than the nearest tag name.  This patch fixes the problem,
and prevents any future recurrence by using this new flag rather than
sed to find the previous tag.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 templates/hooks--update |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index 5b82b68..8f6c4fe 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -210,7 +210,7 @@ case "$refname_type" in
 		fi
 
 		# If this tag succeeds another, then show which tag it replaces
-		prevtag=$(git describe $newrev^ 2>/dev/null | sed 's/-g.*//')
+		prevtag=$(git describe --abbrev=0 $newrev^ 2>/dev/null)
 		if [ -n "$prevtag" ]; then
 			echo "  replaces  $prevtag"
 		fi
-- 
1.5.0.3.402.g0c48
