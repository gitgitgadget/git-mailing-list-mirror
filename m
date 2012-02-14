From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 2/2] t: mailmap: add simple name translation test
Date: Wed, 15 Feb 2012 01:32:28 +0200
Message-ID: <1329262348-9546-3-git-send-email-felipe.contreras@gmail.com>
References: <1329262348-9546-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	"Marius Storm-Olsen" <marius@trolltech.com>,
	"Jim Meyering" <jim@meyering.net>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 00:33:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxRsR-00024p-0z
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 00:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761346Ab2BNXdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 18:33:31 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:64199 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761336Ab2BNXda (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2012 18:33:30 -0500
Received: by lagu2 with SMTP id u2so494610lag.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 15:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fTjyqzii41hnmwbNOuPi9r5GM7KAEAue4q3K24uHLQg=;
        b=dD6h5NU4eWmz8+I7N2DgIKoYeL9LzNyG64ZAGm//EFgsP1wLNwwUSACNqrvOYr8o14
         z5R11jTAktn3n30uDTGXUeFlyVhykKd4VVECvWzKi9Tr6fHMYlyZ1JxEF3BFsAl6e+dT
         wmT8CPOatlDNW4LcXO+31qaEC66TUlZw0MISY=
Received: by 10.152.136.20 with SMTP id pw20mr16403816lab.32.1329262408490;
        Tue, 14 Feb 2012 15:33:28 -0800 (PST)
Received: from localhost (a91-153-255-128.elisa-laajakaista.fi. [91.153.255.128])
        by mx.google.com with ESMTPS id m3sm963233lbm.17.2012.02.14.15.33.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Feb 2012 15:33:27 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1329262348-9546-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190799>

There's already tests for this, but they don't check the output of
'git blame'.

Note that the output of 'git blame -e' was fixed in commit f026358 [1],
so the test would fail before that.

[1] mailmap: always return a plain mail address from map_user()

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t4203-mailmap.sh |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index ec5d98c..d2bab98 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -157,6 +157,9 @@ A U Thor <author@example.com> (1):
 CTO <cto@company.xx> (1):
       seventh
 
+Mr. Right <right@company.xx> (1):
+      eight
+
 Other Author <other@author.xx> (2):
       third
       fourth
@@ -196,6 +199,11 @@ test_expect_success 'Shortlog output (complex mapping)' '
 	test_tick &&
 	git commit --author "CTO <cto@coompany.xx>" -m seventh &&
 
+	echo eight >>one &&
+	git add one &&
+	test_tick &&
+	git commit --author "Wrong <right@company.xx>" -m eight &&
+
 	mkdir -p internal_mailmap &&
 	echo "Committed <committer@example.com>" > internal_mailmap/.mailmap &&
 	echo "<cto@company.xx>                       <cto@coompany.xx>" >> internal_mailmap/.mailmap &&
@@ -204,6 +212,7 @@ test_expect_success 'Shortlog output (complex mapping)' '
 	echo "Other Author <other@author.xx>         <nick2@company.xx>" >> internal_mailmap/.mailmap &&
 	echo "Santa Claus <santa.claus@northpole.xx> <me@company.xx>" >> internal_mailmap/.mailmap &&
 	echo "Santa Claus <santa.claus@northpole.xx> <me@company.xx>" >> internal_mailmap/.mailmap &&
+	echo "Mr. Right <right@company.xx>" >> internal_mailmap/.mailmap &&
 
 	git shortlog -e HEAD >actual &&
 	test_cmp expect actual
@@ -212,6 +221,9 @@ test_expect_success 'Shortlog output (complex mapping)' '
 
 # git log with --pretty format which uses the name and email mailmap placemarkers
 cat >expect <<\EOF
+Author Wrong <right@company.xx> maps to Mr. Right <right@company.xx>
+Committer C O Mitter <committer@example.com> maps to Committed <committer@example.com>
+
 Author CTO <cto@coompany.xx> maps to CTO <cto@company.xx>
 Committer C O Mitter <committer@example.com> maps to Committed <committer@example.com>
 
@@ -248,6 +260,7 @@ OBJID (Other Author DATE 4) four
 OBJID (Santa Claus  DATE 5) five
 OBJID (Santa Claus  DATE 6) six
 OBJID (CTO          DATE 7) seven
+OBJID (Mr. Right    DATE 8) eight
 EOF
 test_expect_success 'Blame output (complex mapping)' '
 	git blame one >actual &&
@@ -264,6 +277,7 @@ OBJID (<other@author.xx>          DATE 4) four
 OBJID (<santa.claus@northpole.xx> DATE 5) five
 OBJID (<santa.claus@northpole.xx> DATE 6) six
 OBJID (<cto@company.xx>           DATE 7) seven
+OBJID (<right@company.xx>         DATE 8) eight
 EOF
 test_expect_success 'Blame show email output (complex mapping)' '
 	git blame -e one >actual &&
-- 
1.7.9
