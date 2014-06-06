From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 08/20] git-mergetool.sh: avoid "test <cond> -a/-o <cond>"
Date: Fri,  6 Jun 2014 07:55:51 -0700
Message-ID: <1402066563-28519-9-git-send-email-gitter.spiros@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 16:56:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsvZf-00025K-1g
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 16:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbaFFO4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 10:56:17 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:42614 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086AbaFFO4P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 10:56:15 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so2589578pbb.39
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6D71nneD+7/nkkKY3lCPPlKSOdeGtRdg3bnoUzuj4J8=;
        b=C/YxY90q3kjBrr6Ryt09GEw52777CF7I3esDvEAvmCAPhzT6axGaQCz+OonJPI8mNA
         iZzfoxsJiQxOyA9ZtbKPpBMvl7pOUI9bCCBsuuNsTUJMxGWCz/S4xH1bQxc/KykxtAPt
         p5UJ9ozMDJnLbjnIUEnGKons29OItgLyflt+2+DwHWZv7NLxbIaJCnGBTMnQSRm5Q6AH
         9gq6F2/xTakIGwwsb9Pve5rB4VTc953/wpFS/Hv2VSexZhJTDUKUw9xTUgPT3es11skg
         u1n9vnNZYmvDRZ8nlTwxpMBulUX83RWcvhy0P2FVIylU8jkCUXScdV0ruXAXDI4TDx1p
         aRCw==
X-Received: by 10.69.20.65 with SMTP id ha1mr1632882pbd.75.1402066575260;
        Fri, 06 Jun 2014 07:56:15 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pu5sm36850769pbb.4.2014.06.06.07.56.14
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 07:56:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250933>

The construct is error-prone; "test" being built-in in most modern
shells, the reason to avoid "test <cond> && test <cond>" spawning
one extra process by using a single "test <cond> -a <cond>" no
longer exists.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 git-mergetool.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index d08dc92..9a046b7 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -205,7 +205,7 @@ checkout_staged_file () {
 		"$(git checkout-index --temp --stage="$1" "$2" 2>/dev/null)" \
 		: '\([^	]*\)	')
 
-	if test $? -eq 0 -a -n "$tmpfile"
+	if test $? -eq 0 && test -n "$tmpfile"
 	then
 		mv -- "$(git rev-parse --show-cdup)$tmpfile" "$3"
 	else
@@ -256,7 +256,7 @@ merge_file () {
 	checkout_staged_file 2 "$MERGED" "$LOCAL"
 	checkout_staged_file 3 "$MERGED" "$REMOTE"
 
-	if test -z "$local_mode" -o -z "$remote_mode"
+	if test -z "$local_mode" || test -z "$remote_mode"
 	then
 		echo "Deleted merge conflict for '$MERGED':"
 		describe_file "$local_mode" "local" "$LOCAL"
-- 
1.7.10.4
