From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 5/5] pull: add warning on non-ff merges
Date: Sun,  8 Sep 2013 20:23:16 -0500
Message-ID: <1378689796-19305-6-git-send-email-felipe.contreras@gmail.com>
References: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	sandals@crustytoothpaste.net,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 09 03:28:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIqHc-0001W6-8K
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 03:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413Ab3IIB2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 21:28:46 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:36160 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab3IIB2m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 21:28:42 -0400
Received: by mail-oa0-f47.google.com with SMTP id g12so6031705oah.34
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 18:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t7bVT3ph4o+iZrpO8XxIG91vzwElbIZF4/s2C+x7K5I=;
        b=IXWWz2MdiBf1gAJmuDl6vl6EXjHtR2Uw4ilXYE/KjCMe2yq1tqEfkc3876CnMsZYZB
         aMO1ByZxlTSE1+gPo9vD58KvDUCfIm5aMYGUj4y6t8rtC6dL4wZkraicWnapbdhQ/yNt
         1NUNJotUcawszFgOwFM0JnNTAxpPYRplsUH8wHRM2dkDfWpEJimAx1VLCRy9S0MTFisc
         okXaNBS4h8/obVvBv0Ydq43VjiKu/zmQUL90kAq45rdNEfhPekhYNmkUe/Ys2ySIJ5mO
         ujTu07ia9k/d9xswROfz3TPYreCGFRapriA+1jMfxn/5OhanjQPO6gojKgdObkMzWNv8
         Azdw==
X-Received: by 10.182.129.42 with SMTP id nt10mr9534512obb.19.1378690122110;
        Sun, 08 Sep 2013 18:28:42 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u8sm2329261obd.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 18:28:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
In-Reply-To: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234300>

To prepare our uses for the upcoming changes we should warn them and let
them know that they will need to specify a merge or a rebase in the
future (when a non-fast-forward situation arises). Also, let them know
we fallback to 'git pull --merge', so when the obsoletion of this mode
comes, they know what to type without interrupting or changing their
workflow.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-pull.sh | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 580d633..1f777de 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -62,7 +62,7 @@ then
 		echo "Please use pull.mode and branch.<name>.pullmode instead."
 	fi
 fi
-test -z "$mode" && mode=merge
+test -z "$mode" && mode=default
 dry_run=
 while :
 do
@@ -286,12 +286,21 @@ case "$merge_head" in
 *)
 	# check if a non-fast-foward merge would be needed
 	merge_head=${merge_head% }
-	if test "$mode" = merge-ff-only -a -z "$no_ff$ff_only${squash#--no-squash}" &&
+	if test -z "$no_ff$ff_only${squash#--no-squash}" &&
 		test -n "$orig_head" &&
 		! git merge-base --is-ancestor "$orig_head" "$merge_head" &&
 		! git merge-base --is-ancestor "$merge_head" "$orig_head"
 	then
-		die "The pull was not fast-forward, please either merge or rebase."
+		case "$mode" in
+		merge-ff-only)
+			die "The pull was not fast-forward, please either merge or rebase."
+			;;
+		default)
+			say "The pull was not fast-forward, in the future you would have to choose
+a merge or a rebase, falling back to old style for now (git pull --merge).
+Read 'git pull --help' for more information."
+			;;
+		esac
 	fi
 	;;
 esac
-- 
1.8.4-338-gefd7fa6
