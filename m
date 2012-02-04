From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] send-email: add extra safetly in address sanitazion
Date: Sat,  4 Feb 2012 18:32:42 +0200
Message-ID: <1328373162-25188-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	"Brandon Casey" <drafnel@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	"Brian Gernhardt" <brian@gernhardtsoftware.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 17:33:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtiYc-0007Vw-LN
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 17:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261Ab2BDQdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 11:33:41 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53785 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751212Ab2BDQdk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2012 11:33:40 -0500
Received: by lagu2 with SMTP id u2so2335120lag.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 08:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=6+2EzJmk4IZqW9btd+0oTE4x2E3CtdQKqWrX5HKzui8=;
        b=hfwOvnrVgT8rOl5xGp5mV8jgql/3JtgyuN5k5vPI7buPOfza7NyuMseVAkIk9TAYim
         D8b/RHsQgzODiu9Mw96n7yHwXcLpTM3dWD14Sy0DMGt7JRCSKqmu/Bx/ofmbgJCUWnmb
         lXxZcMRHGSZsgahptwhil/lOfdc3FZZOQU0Ok=
Received: by 10.112.24.129 with SMTP id u1mr3056575lbf.8.1328373218841;
        Sat, 04 Feb 2012 08:33:38 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi. [91.153.253.80])
        by mx.google.com with ESMTPS id op8sm7889273lab.15.2012.02.04.08.33.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 08:33:37 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189889>

Currently bad addresses like 'Foo Bar <foo@bar.com>>' will just be sent
verbatim -- that's not good; we should either error out, or sanitize
them.

The following patch adds extra sanitazion so the following
transformations are performed:

  'Foo Bar <foo@bar.com>' -> 'Foo Bar <foo@bar.com>'
  '"Foo Bar" <foo@bar.com>' -> '"Foo Bar" <foo@bar.com>'
  'foo@bar.com' -> 'foo@bar.com'
  '<foo@bar.com>' -> 'foo@bar.com'
  'Foo Bar' -> 'Foo Bar'
  'Foo Bar <foo@bar.com>>' -> 'Foo Bar <foo@bar.com>'
  '"Foo Bar" <foo@bar.com>>' -> '"Foo Bar" <foo@bar.com>'
  '<foo@bar.com>>' -> 'foo@bar.com'

Basically, we try to check that the address is in the form of
"Name <email>", and if not, assume it's "email". According to commit
155197e[1], the "prhase" should not be empty, so if it is, remove the
<>. Extra characters after the first ">" are ignored.

[1] send-email: rfc822 forbids using <address@domain> without a non-empty "phrase"

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-send-email.perl |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index ef30c55..19c600f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -889,15 +889,21 @@ sub is_rfc2047_quoted {
 # use the simplest quoting being able to handle the recipient
 sub sanitize_address {
 	my ($recipient) = @_;
-	my ($recipient_name, $recipient_addr) = ($recipient =~ /^(.*?)\s*(<.*)/);
+	my ($recipient_name, $recipient_addr);
+
+	if ($recipient =~ /^(.*?)\s*<(.*?)>/) {
+		($recipient_name, $recipient_addr) = ($1, $2);
+	} else {
+		$recipient_addr = $recipient;
+	}
 
 	if (not $recipient_name) {
-		return $recipient;
+		return $recipient_addr;
 	}
 
 	# if recipient_name is already quoted, do nothing
 	if (is_rfc2047_quoted($recipient_name)) {
-		return $recipient;
+		return "$recipient_name <$recipient_addr>";
 	}
 
 	# rfc2047 is needed if a non-ascii char is included
@@ -912,7 +918,7 @@ sub sanitize_address {
 		$recipient_name = qq["$recipient_name"];
 	}
 
-	return "$recipient_name $recipient_addr";
+	return "$recipient_name <$recipient_addr>";
 
 }
 
-- 
1.7.9
