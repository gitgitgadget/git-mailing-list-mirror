From: Louis Kruger <louisk@gmail.com>
Subject: [PATCH] Support --threads arg for git-repack.
Date: Fri, 20 Apr 2012 11:56:52 -0400
Message-ID: <CAK65ue8OCVvdBcqX3W54ZcBzCte+=9o_LqGSDipJBX9aaKvNJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 20 17:57:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLGCg-00088N-EI
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 17:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757241Ab2DTP4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 11:56:54 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46904 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987Ab2DTP4x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 11:56:53 -0400
Received: by vcqp1 with SMTP id p1so6486241vcq.19
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 08:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=1ou8MhdbG+gwPuxXdiaBQe8ZLCjy2e4tfnPq29KX0yU=;
        b=q+32oG7TPi6zX9/pQlQMRWEQrGnY8hEQ1dJHui9uqLyjgmpRXaX5zSZDPctgDB3oKg
         nLvwP7orsrodqH6R6C30fEhbgfLRKsXWP0zc1uxWxqf8uvthB9miz9x3Q//u6k7nqpWS
         tci1tSO/9UBKwD//mdJ+N7crX8Q3h7VGejLJ4UQBMKfgBQqTqVhjI/BKlIV+r6ugD0NS
         /ippHiQ4FXWJCHS5Q9yYNhVu/iKpGnSNdE7LqcSddiFuWTjMaw2Z0f6/91y9hCkFWkmi
         xPyUhve6LyKsCBPv65ELMaKyXiDt4zfPkK1yDuyrQ4JpEin4k1A1KYiZVBfmSNM+Ye4X
         Qpsg==
Received: by 10.220.198.135 with SMTP id eo7mr2103395vcb.35.1334937412567;
 Fri, 20 Apr 2012 08:56:52 -0700 (PDT)
Received: by 10.220.140.203 with HTTP; Fri, 20 Apr 2012 08:56:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196005>

This very simple patch adds a --threads argument for git-repack.  It
simply forwards the argument to git-pack-objects.

---
 Documentation/git-repack.txt |   11 +++++++++++
 git-repack.sh                |    3 ++-
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 4c1aff6..be52789 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [--window=<n>]
[--depth=<n>]
+        [--threads=<n>]

 DESCRIPTION
 -----------
@@ -92,6 +93,16 @@ other objects in that pack they already have locally.
 	to be applied that many times to get to the necessary object.
 	The default value for --window is 10 and --depth is 50.

+--threads=<n>::
+        Specifies the number of threads to spawn when searching for best
+        delta matches. This requires that pack-objects be compiled with
+        pthreads otherwise this option is ignored with a warning. This is
+        meant to reduce packing time on multiprocessor machines. The required
+        amount of memory for the delta search window is however multiplied
+        by the number of threads. Specifying 0 will cause git to auto-detect
+	`--threads=0` makes git auto-detect the number of threads to use,
+        which is the default.
+
 --window-memory=<n>::
 	This option provides an additional limit on top of `--window`;
 	the window size will dynamically scale down so as to not take
diff --git a/git-repack.sh b/git-repack.sh
index 624feec..c8cf5cc 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -20,6 +20,7 @@ window=         size of the window used for delta compression
 window-memory=  same as the above, but limit memory size instead of
entries count
 depth=          limits the maximum delta depth
 max-pack-size=  maximum size of each packfile
+threads=        maximum number of threads
 "
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
@@ -38,7 +39,7 @@ do
 	-f)	no_reuse=--no-reuse-delta ;;
 	-F)	no_reuse=--no-reuse-object ;;
 	-l)	local=--local ;;
-	--max-pack-size|--window|--window-memory|--depth)
+	--max-pack-size|--window|--window-memory|--depth|--threads)
 		extra="$extra $1=$2"; shift ;;
 	--) shift; break;;
 	*)	usage ;;
-- 
1.7.7.3
