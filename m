From: apodtele <apodtele@gmail.com>
Subject: [PATCH 1/2] diff --stat: use asymptotic scaling in graph
Date: Thu, 12 Oct 2006 15:37:17 -0400
Message-ID: <d620685f0610121237k458665c5m7bbde2d565d7ef81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Oct 12 22:03:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY6Mu-0005lI-70
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 21:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWJLThU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 15:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWJLThU
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 15:37:20 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:13166 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750806AbWJLThS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 15:37:18 -0400
Received: by wx-out-0506.google.com with SMTP id s14so645676wxc
        for <git@vger.kernel.org>; Thu, 12 Oct 2006 12:37:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hImQxFHYJbFXXUEyLmvl4hzJ/h9qWRjTnd5+CyeVOUOr/t9q6OrGcydC899QUBhv9TctsmhuRQCvutq71ym5ymsNFuEJ9ez3jvlb+q6IroZTXSBiMAwwZQtjZZCImqLb5e3jGQxv+C1x/hm9sy4W2hwm4zbkEhByPTEabVv/24E=
Received: by 10.90.79.6 with SMTP id c6mr1716797agb;
        Thu, 12 Oct 2006 12:37:18 -0700 (PDT)
Received: by 10.90.95.6 with HTTP; Thu, 12 Oct 2006 12:37:17 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28792>

Instead of conditionally scaling the stat graph for large changes,
always scale it asymptotically: small changes shall appear without any
distortions.

Signed-off-by: Alexei Podtelezhnikov

--- diff.c	2006-10-12 14:45:13.000000000 -0400
+++ diff.c	2006-10-12 15:07:30.000000000 -0400
@@ -637,15 +637,9 @@

 const char mime_boundary_leader[] = "------------";

-static int scale_linear(int it, int width, int max_change)
+static int scale_nonlinear(int it, int width)
 {
-	/*
-	 * make sure that at least one '-' is printed if there were deletions,
-	 * and likewise for '+'.
-	 */
-	if (max_change < 2)
-		return it;
-	return ((it - 1) * (width - 1) + max_change - 1) / (max_change - 1);
+	return it * width / (it + width) + 1;
 }

 static void show_name(const char *prefix, const char *name, int len,
@@ -776,11 +770,9 @@
 		adds += add;
 		dels += del;

-		if (width <= max_change) {
-			add = scale_linear(add, width, max_change);
-			del = scale_linear(del, width, max_change);
-			total = add + del;
-		}
+		add = scale_nonlinear(add, width / 2);
+		del = scale_nonlinear(del, width / 2);
+		total = add + del;
 		show_name(prefix, name, len, reset, set);
 		printf("%5d ", added + deleted);
 		show_graph('+', add, add_c, reset);
