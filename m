From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2] difftool: only copy back files modified during directory diff
Date: Thu, 19 Jul 2012 01:27:09 -0700
Message-ID: <1342686429-87847-1-git-send-email-davvid@gmail.com>
References: <CAJDDKr4Q+nQapO0aAQmmpj_guR=_tXwareWsn020BckZR5V+uA@mail.gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 10:28:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Srm5a-0007R6-GL
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 10:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713Ab2GSI1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 04:27:15 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40431 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572Ab2GSI1J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 04:27:09 -0400
Received: by pbbrp8 with SMTP id rp8so4018240pbb.19
        for <git@vger.kernel.org>; Thu, 19 Jul 2012 01:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ozgau2qGT6GJyOyZGQxgexv2LhwbSUVDQv7c6+DVRXI=;
        b=OHW8QEgmm0ZJhpbsNG6YIwyLugDwDPENsW+DptmWt+EgYKX9uarS6Ee93o5zPcIMhh
         eewwFbFSnQknw1k4AVQAg7nBy6mewXefLayD+Su+vWbR9PzxyQZI2tQIwShcb58/5O6W
         jqkgeL+rybOIqVINpKhooTxq+9NTxHpS7cuLVbkmgUB5yZ27wicC2oEozdJJkfoU0kz4
         00W7SuCgmsnKSMjBBdU10NawslygkymzIEkKrGE2AdFzTT/uJoAFNjzkbaRZugKJU/zc
         f5A3ROI8TFfdjtwigr29xYveRcShsMe8qC3yOyv8xXh3wYMrVuIcORY/fRfzcVrnP0Ru
         Y63A==
Received: by 10.68.229.2 with SMTP id sm2mr3356275pbc.57.1342686429176;
        Thu, 19 Jul 2012 01:27:09 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id oq4sm1354718pbb.21.2012.07.19.01.27.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jul 2012 01:27:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.2.250.g00b4b9a
In-Reply-To: <CAJDDKr4Q+nQapO0aAQmmpj_guR=_tXwareWsn020BckZR5V+uA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201729>

From: Tim Henigan <tim.henigan@gmail.com>

When 'difftool --dir-diff' is used to compare working tree files,
it always copies files from the tmp dir back to the working tree
when the diff tool is closed, even if the files were not modified
by the diff tool.

This causes the file timestamp to change. Files should only be
copied from the tmp dir back to the working copy if they were
actually modified.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---

Perhaps something like this...

 git-difftool.perl | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index ae1e052..c079854 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -15,6 +15,7 @@ use strict;
 use warnings;
 use File::Basename qw(dirname);
 use File::Copy;
+use File::Compare;
 use File::Find;
 use File::stat;
 use File::Path qw(mkpath);
@@ -336,8 +337,10 @@ if (defined($dirdiff)) {
 	# files were modified during the diff, then the changes
 	# should be copied back to the working tree
 	for my $file (@working_tree) {
-		copy("$b/$file", "$workdir/$file") or die $!;
-		chmod(stat("$b/$file")->mode, "$workdir/$file") or die $!;
+		if (-e "$b/$file" && compare("$b/$file", "$workdir/$file")) {
+			copy("$b/$file", "$workdir/$file") or die $!;
+			chmod(stat("$b/$file")->mode, "$workdir/$file") or die $!;
+		}
 	}
 } else {
 	if (defined($prompt)) {
-- 
1.7.11.2.250.g00b4b9a
