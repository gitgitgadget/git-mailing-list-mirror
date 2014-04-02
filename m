From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 05/22] lockfile: unlock file if lockfile permissions cannot
 be adjusted
Date: Wed, 02 Apr 2014 08:47:39 +0200
Message-ID: <533BB28B.10906@web.de>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu> <1396367910-7299-6-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 03 13:14:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeJ0-0006sp-Gf
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756758AbaDBGsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 02:48:13 -0400
Received: from mout.web.de ([212.227.17.11]:59048 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756565AbaDBGsN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 02:48:13 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MDjw6-1WGLnH2hRO-00H6Ap; Wed, 02 Apr 2014 08:47:57
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131104 Icedove/17.0.10
In-Reply-To: <1396367910-7299-6-git-send-email-mhagger@alum.mit.edu>
X-Provags-ID: V03:K0:e2kJI9XeXLQ9EH3JjTSKl0Xy3xHJkytF6xLr3RNliFHFCXqpmxr
 xu5gJnlvevmWfSY56Q0rK7s8lSgKxQDDtssjULYfKvCV1giOfr5SthUCD8z7iwUtLZW5PHX
 x/WXN5GPYtug8MJLpVwaSii8Y4/J8kwzNYuWuiJgv7dJFBFTbtf6WNDNI9coJL8IO79X0ml
 Aeqsjx7KJGOdo7SWXsIlA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245709>

[]

diff --git a/lockfile.c b/lockfile.c
index c1af65b..1928e5e 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -148,9 +148,11 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
  			lock_file_list = lk;
  			lk->on_list = 1;
  		}
-		if (adjust_shared_perm(lk->filename))
-			return error("cannot fix permission bits on %s",
-				     lk->filename);
+		if (adjust_shared_perm(lk->filename)) {
+			error("cannot fix permission bits on %s", lk->filename);
+			rollback_lock_file(lk);
+			return -1;

Would it make sense to change the order of rollback() and error()?
Make the rollback first (and as early as possible) and whine then?
