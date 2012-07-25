From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/3] difftool: Check all return codes from compare()
Date: Tue, 24 Jul 2012 20:14:23 -0700
Message-ID: <1343186064-49350-3-git-send-email-davvid@gmail.com>
References: <1343186064-49350-1-git-send-email-davvid@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 05:15:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sts4N-0002cl-9o
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 05:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756124Ab2GYDPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 23:15:12 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64048 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755782Ab2GYDOd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 23:14:33 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so653821pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 20:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EZbTIV/7tBKkUL4aSErIGNADO113EfsExxVpIttBlcI=;
        b=rBwGzmMHXgBugOIwYUUvy7uE7189VKpT+aIU8aG6UTaOneXT8CAie6MBb7Iw5gd/rs
         yfBX308lCnMcekEAva50adjAGOosooob3K61IoDOQP0xU2isx2L3sMXulwV7rKlEr1ZL
         qKZZs/A3l//OsoZ6pxIdawPpKXljnZqWz3L3oFnWUxH+glC6pkEQNh+NnAsVRhigh6Xh
         9o07ZdtA/7iLmJqdBlnDAUuoy/D+9gojzqG7x+XmyS61Nrfeb4RRdKtFiDjMeXi0rBiq
         ijMKuycneML6XbjVGvVUoiaqYtH49tH9Zv4lG8+ZZNI/LKuxh3MrhxGHCPMDwJUIZw6m
         SZ/A==
Received: by 10.68.190.102 with SMTP id gp6mr49888261pbc.5.1343186073135;
        Tue, 24 Jul 2012 20:14:33 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id ms9sm13401672pbb.43.2012.07.24.20.14.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 20:14:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.15.g8157c39
In-Reply-To: <1343186064-49350-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202104>

Handle the case where compare() is unable to read its inputs.
Emit a warning so that the user knows that something went wrong.

We may later want to restructure the code so that we can inhibit
tempdir cleanup when this condition is reached.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool.perl | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 3057480..591ee75 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -370,7 +370,16 @@ sub dir_diff
 	# external tool did not replace the original link with a file.
 	for my $file (@worktree) {
 		next if $symlinks && -l "$b/$file";
-		if (-f "$b/$file" && compare("$b/$file", "$workdir/$file")) {
+		next if ! -f "$b/$file";
+
+		my $diff = compare("$b/$file", "$workdir/$file");
+		if ($diff == 0) {
+			next;
+		} elsif ($diff == -1 ) {
+			my $errmsg = "warning: could not compare ";
+			$errmsg += "'$b/$file' with '$workdir/$file'\n";
+			warn $errmsg;
+		} elsif ($diff == 1) {
 			copy("$b/$file", "$workdir/$file") or die $!;
 			my $mode = stat("$b/$file")->mode;
 			chmod($mode, "$workdir/$file") or die $!;
-- 
1.7.12.rc0.15.g8157c39
