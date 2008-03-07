From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3] gitweb: Simplify object type detection in git_object()
Date: Fri,  7 Mar 2008 22:03:19 +0100
Message-ID: <1204923800-5923-3-git-send-email-jnareb@gmail.com>
References: <1204923800-5923-1-git-send-email-jnareb@gmail.com>
Cc: Gerrit Pape <pape@smarden.org>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 22:04:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXjkB-0003vg-GD
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 22:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759462AbYCGVDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 16:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760149AbYCGVDk
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 16:03:40 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:2616 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932605AbYCGVDc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 16:03:32 -0500
Received: by fg-out-1718.google.com with SMTP id e21so703931fga.17
        for <git@vger.kernel.org>; Fri, 07 Mar 2008 13:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=PUOVPp4MCKorMN+iuCdwl3C3CB91iF1uDWVkU5hIyY8=;
        b=KGBOHlQZwf0MS+AuY4XmoV85J33+RkHD39QR7sw54Xgpwmtze1kmZ1N1zAyqMiu7nXBTg5zdrEz/3Lp4zILkSG+11ruXOEwc8q/VTDVCcHZvbUg0nx55Z5XiDs2gJ6v1gp1Av03qiZ0zSp007oMa2sCMGfQ/TKrvk60ClIhTPLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=o/mAqAgRGa6+5DNxyWLO5Eg5d2S/cUxmt+JzzeLjy0TJW+Y5fG+CxjsfFPSEuJFGHBBhvzHzDcE7lG7cEr1Eo15DAL+gt53ADlj8v/V8eYaVWOjttmtGy8X7Y0GNNvdkUkzpumQu4m3ydjsqWiWxQMaerwU1PS1xgHBHhQ5lr+U=
Received: by 10.86.53.8 with SMTP id b8mr2019206fga.32.1204923809603;
        Fri, 07 Mar 2008 13:03:29 -0800 (PST)
Received: from localhost.localdomain ( [83.8.243.158])
        by mx.google.com with ESMTPS id 4sm4431160fge.3.2008.03.07.13.03.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Mar 2008 13:03:27 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m27L3P3F005950;
	Fri, 7 Mar 2008 22:03:25 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m27L3PsX005949;
	Fri, 7 Mar 2008 22:03:25 +0100
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1204923800-5923-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76525>

Taken from commit 7f9778b19b07601ae8134fc4ff23b7bf7cac28bd by Gerrit Pape
  "gitweb: choose appropriate view for file type if a= parameter missing"

Contrary to previous version it does not find 'h' (hash) parameter
value if it is not set, and only 'hb' (hash_base) and 'f' (file_name)
parameters are provided, resulting perhaps in slightly less efficient
URLs, but also one which more closely follow what was requested.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   34 ++++++----------------------------
 1 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a76c4ac..f507a5a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4768,42 +4768,20 @@ sub git_object {
 
 	# - hash or hash_base alone
 	if ($hash || ($hash_base && !defined $file_name)) {
-		my $object_id = $hash || $hash_base;
-
-		my $git_command = git_cmd_str();
-		open my $fd, "-|", "$git_command cat-file -t $object_id 2>/dev/null"
-			or die_error('404 Not Found', "Object does not exist");
-		$type = <$fd>;
-		chomp $type;
-		close $fd
-			or die_error('404 Not Found', "Object does not exist");
+		$type = git_get_type($hash || $hash_base);
 
 	# - hash_base and file_name
 	} elsif ($hash_base && defined $file_name) {
-		$file_name =~ s,/+$,,;
+		$type = git_get_type("$hash_base:$file_name");
 
-		system(git_cmd(), "cat-file", '-e', $hash_base) == 0
-			or die_error('404 Not Found', "Base object does not exist");
-
-		# here errors should not hapen
-		open my $fd, "-|", git_cmd(), "ls-tree", $hash_base, "--", $file_name
-			or die_error(undef, "Open git-ls-tree failed");
-		my $line = <$fd>;
-		close $fd;
