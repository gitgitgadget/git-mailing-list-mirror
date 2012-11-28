From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 p1 10/13] remote-testgit: report success after an import
Date: Wed, 28 Nov 2012 23:11:06 +0100
Message-ID: <1354140669-23533-11-git-send-email-felipe.contreras@gmail.com>
References: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 23:12:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdprt-0003JU-74
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 23:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932819Ab2K1WL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 17:11:59 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43342 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932809Ab2K1WL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 17:11:57 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5972393bkw.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 14:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ooq0wgIPB1+aC0f6a+G/R/D/iJ7h+bNuQE/dnXqhRWk=;
        b=ec+dBMtnmCGnGiQeicZW5HfTKXiatRkJc6zjn6hoQUrKJQrC63WfRNNs0/3qshkZIR
         aOKCPlS3noY/xelyTCARxJDd/8yp8YKkm4CQzBxCcSmRMztTieJRD8+sTJ6Qzr1GZt3U
         f3t7TiMChUbSaf6I1kY11ylJtHH4kCYo2MIN0YVRSm5Lt88aSzWEPatBvSlNzZvIkAgF
         aizYOFqnCOe+HK9qlFY+2U+xodb4JNzQv4pan9XlCyzjAxWo1AZcu4zxjihjFdZEa824
         gx1psmuO7QDtl62oEV6aZdXROm6hUaBDAXNfd6AxyIB/kqVZ6ke3iUtOcFbEXD4JB72K
         sOpQ==
Received: by 10.204.147.78 with SMTP id k14mr6126800bkv.7.1354140717111;
        Wed, 28 Nov 2012 14:11:57 -0800 (PST)
Received: from localhost (ip-109-43-0-26.web.vodafone.de. [109.43.0.26])
        by mx.google.com with ESMTPS id l17sm13799012bkw.12.2012.11.28.14.11.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2012 14:11:56 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1
In-Reply-To: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210791>

Doesn't make a difference for the tests, but it does for the ones
seeking reference.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-remote-testgit | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/git-remote-testgit b/git-remote-testgit
index efda74b..6fb8780 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -65,7 +65,20 @@ do
 		sed -e "s#refs/heads/#${prefix}/heads/#g"
 		;;
 	export)
+		before=$(git for-each-ref --format='%(refname) %(objectname)')
+
 		git fast-import "${testgitmarks_args[@]}" --quiet
+
+		after=$(git for-each-ref --format='%(refname) %(objectname)')
+
+		# figure out which refs were updated
+		join -e 0 -o '0 1.2 2.2' -a 2 <(echo "$before") <(echo "$after") |
+		while read ref a b
+		do
+			test $a == $b && continue
+			echo "ok $ref"
+		done
+
 		echo
 		;;
 	'')
-- 
1.8.0.1
