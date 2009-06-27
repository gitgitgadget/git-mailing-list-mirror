From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 8/9] gitweb: use picon for gravatar fallback
Date: Sat, 27 Jun 2009 14:05:04 +0200
Message-ID: <1246104305-15191-9-git-send-email-giuseppe.bilotta@gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-5-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-6-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-7-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-8-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 27 14:06:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKWfk-0007Dq-Qn
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 14:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071AbZF0MFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 08:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753956AbZF0MF3
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 08:05:29 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:31643 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbZF0MFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 08:05:16 -0400
Received: by fg-out-1718.google.com with SMTP id e12so183147fga.17
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 05:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GFda23Ihey6nJJEXHvkaWSwxWvjcAE168HhBKPxLauY=;
        b=vz2LvKJmObZK8/ezSm3D/eISR+7MgtsXLLbQOtWL7r9o0IYAiLWh4+idelIxUIfGH/
         viPTHRqITaBZHz9TuIrQRTT3OB5xpvMqRSb6WeJ5shnY8Yd+g6yALrNknWrNbA92HDgZ
         Q+FYOBncRB8x3UXONkjK2MZyse6KaAAUiN0ts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AswPeEhTwuLDG2/0/28s6fcAH6azs3HY00Sv96uhVpqg4l5lYAHkr7JTvvAkXmbjbM
         ydLRixgCmMPykPwB6/YjE/ErqU/OT8kJBkaXjlx9WFisSzZzCK/uZZWGkUsfeQyXHd27
         wywZK4k9pjtLHFManaddbbyvEEMJJf2ZhJH9M=
Received: by 10.86.96.12 with SMTP id t12mr4471963fgb.77.1246104319301;
        Sat, 27 Jun 2009 05:05:19 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-10-227.clienti.tiscali.it [94.37.10.227])
        by mx.google.com with ESMTPS id e11sm2134337fga.16.2009.06.27.05.05.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Jun 2009 05:05:18 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1246104305-15191-8-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122360>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ae73d45..e2638cb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1546,9 +1546,13 @@ sub picon_url {
 sub gravatar_url {
 	my $email = lc shift;
 	my $size = shift;
-	$avatar_cache{$email} ||=
-		"http://www.gravatar.com/avatar.php?gravatar_id=" .
-			Digest::MD5::md5_hex($email) . "&amp;size=";
+	if (!$avatar_cache{$email}) {
+		my $picon = CGI::escape(picon_url($email));
+		$avatar_cache{$email} = "http://www.gravatar.com/avatar.php?gravatar_id=" .
+			Digest::MD5::md5_hex($email) .
+			"&amp;default=$picon" .
+			"&amp;size=";
+	}
 	return $avatar_cache{$email} . $size;
 }
 
-- 
1.6.3.rc1.192.gdbfcb
