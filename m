From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3.5 03/12] send-email: Interpret --smtp-server "" as "use a default".
Date: Sat, 18 Apr 2009 12:01:59 -0500
Message-ID: <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 19:06:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvDzG-0006Oc-Vm
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 19:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651AbZDRREF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 13:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753358AbZDRRED
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 13:04:03 -0400
Received: from mail-qy0-f126.google.com ([209.85.221.126]:34618 "EHLO
	mail-qy0-f126.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbZDRREB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 13:04:01 -0400
Received: by qyk32 with SMTP id 32so633150qyk.33
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 10:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OBO/A40b1MsLP0PB9S0YaPtaRrdgKSBkepxqM86kVyM=;
        b=r/QWOtrJP6k1LZwswXna+kIVpiB562lAINoYLj6Woi5Yiz+REytQUQJiOSjMe6ZHSr
         3RXCTkGKHa/zoU0UMLs2i0WlnGE3E9ODpOGv0IzUOe+V79jSwulqWL13rmMpzoMVZQuW
         6srboARlcNcgjHcp5gWWslL6XthOimrmkM9YE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hs8TOKfnzU2ETw6s1yN1llbSYO2F58mGcc7T8CawQKG6GzIXU2HxO6QP0B0DHec61b
         F4cw/LAhOySKuAJsmmI5fimXf5zAZ6r1NuzGIBddSGnUEjScMUqFPOdu9y0/Ul8wHpN6
         XyvW9x72hRHux3dI5Tig/05gROyopXDZbnGAA=
Received: by 10.220.83.149 with SMTP id f21mr4242217vcl.34.1240074239561;
        Sat, 18 Apr 2009 10:03:59 -0700 (PDT)
Received: from localhost.localdomain (97-116-125-103.mpls.qwest.net [97.116.125.103])
        by mx.google.com with ESMTPS id 6sm1776586ywn.52.2009.04.18.10.03.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Apr 2009 10:03:59 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116845>

Why not? It's at least useful for testing.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-send-email.txt |    4 +++-
 git-send-email.perl              |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 071e9bf..ae01632 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -132,7 +132,9 @@ user is prompted for a password while the input is masked for privacy.
 	be specified by the 'sendemail.smtpserver' configuration
 	variable; the built-in default is `/usr/sbin/sendmail` or
 	`/usr/lib/sendmail` if such a program is available, or
-	`localhost` otherwise.
+	`localhost` otherwise. Also, a built-in default is used if
+	`<host>` or 'sendemail.smtpserver' is the empty string (for
+	example, if '--smtp-server ""' is specified on the command line).
 
 --smtp-server-port=<port>::
 	Specifies a port different from the default port (SMTP
diff --git a/git-send-email.perl b/git-send-email.perl
index 1a20b2c..5e669c7 100755
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
