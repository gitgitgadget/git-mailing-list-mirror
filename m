From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3.5.1 03/12] send-email: Interpret --smtp-server "" as "use a default".
Date: Sun, 19 Apr 2009 09:16:55 -0500
Message-ID: <1240150615-3939-1-git-send-email-mfwitten@gmail.com>
References: <b4087cc50904181713m49849f89q87a9f5a392085939@mail.gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 19 16:18:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvXr8-0001Eh-Ku
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 16:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758098AbZDSORS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 10:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758091AbZDSORR
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 10:17:17 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:51830 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757417AbZDSORQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 10:17:16 -0400
Received: by qw-out-2122.google.com with SMTP id 5so640711qwd.37
        for <git@vger.kernel.org>; Sun, 19 Apr 2009 07:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=s5PDvt0CgfAYBsePKDwcGeP3UBwhqvOVsbaeu3qFh+A=;
        b=aQqBl/e4CmGR/CW1Il+MddVOrsseGTmA6fTGeLg6ESFwib1FkuWd5PoN0WQPLLhddz
         j4kh70bxbGwexFAD+OcZDliz9bNwXNTqtZE+4A6gUM3TCFNC1SL09Z1YXDJsg19f5+ap
         dfxKS+q6szq7Pq3+taJ2+GNLfHCbJxW8UJnmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VwFT9S11hdBSdTNFyNV5EKlwtmF5Ex9ILzO+4KqanDnWUXvuKnmiwKbxs3KoDbToEp
         dRnleR0qBoQqvQEHr9vfgx8s+Ks+ztNVtm5/itkteU7z/PUS13hWRvCyvjP9HtrmW6U6
         KdLOapMY2HC0JMAXey1KAqSLibX1ErXH7ag7c=
Received: by 10.220.100.83 with SMTP id x19mr4639645vcn.84.1240150635087;
        Sun, 19 Apr 2009 07:17:15 -0700 (PDT)
Received: from localhost.localdomain (97-116-111-23.mpls.qwest.net [97.116.111.23])
        by mx.google.com with ESMTPS id 5sm3978397ywd.20.2009.04.19.07.17.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Apr 2009 07:17:14 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <b4087cc50904181713m49849f89q87a9f5a392085939@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116898>

Why not? It's at least useful for testing.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---

		NOTE: This also resulted in a similar change to:
		[PATCH RFC3.5 04/12] send-email: Verification...

 Documentation/git-send-email.txt |    4 +++-
 git-send-email.perl              |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 071e9bf..0937dd0 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -132,7 +132,9 @@ user is prompted for a password while the input is masked for privacy.
 	be specified by the 'sendemail.smtpserver' configuration
 	variable; the built-in default is `/usr/sbin/sendmail` or
 	`/usr/lib/sendmail` if such a program is available, or
-	`localhost` otherwise.
+	`localhost` otherwise. Also, the built-in default is used if
+	`<host>` or 'sendemail.smtpserver' is the empty string (for
+	example, if '--smtp-server ""' is specified on the command line).
 
 --smtp-server-port=<port>::
 	Specifies a port different from the default port (SMTP
diff --git a/git-send-email.perl b/git-send-email.perl
index fed3554..be6d171 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -675,7 +675,7 @@ if (defined $initial_reply_to) {
 	$initial_reply_to = "<$initial_reply_to>" if $initial_reply_to ne '';
 }
 
-if (defined $smtp_server) {
+if (defined $smtp_server && $smtp_server ne '') {
 
 	$smtp_server_is_a_command = ($smtp_server =~ m{^/});
 
-- 
1.6.2.2.479.g2aec
