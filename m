From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Make i18n (encoding) tests in t9500 leave clean state
Date: Sun, 27 Feb 2011 17:58:32 +0100
Message-ID: <20110227165624.13543.89662.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 27 17:59:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptjxm-0007Vv-T8
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 17:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883Ab1B0Q7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 11:59:07 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55383 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806Ab1B0Q7D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 11:59:03 -0500
Received: by fxm17 with SMTP id 17so3077802fxm.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 08:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:subject:to:date:message-id:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=A17shtP+XzSamY78wspQyhJAS/1lDTBEGwtPsnvO1JI=;
        b=n8Sgkyx7Sex3XDrIBqUkP+yjP4NAD6mPP83E/Tb43Zoere9SI8dXTCdxu0RzRbbLMP
         ET6ZbsnXpU3vwYfL6MJaAJL+3lEHa3OSEFUe8CVqHaBXbz453enw2U0rDnkfCDyUruon
         mL2dUjbSIDDC3krBOp3GAJYvGtZe559sWcqV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=d153rEfESpdbNnp/XUdYp7Dcs5vfqlANZPprvZmtUNofEE7ZphhQHoNKUkiJ9c3arX
         FAwZbKVTQhOl7cUMNKfhH1s2sdzHMuXug3OdBjF4jhIS/MqSN1UwyIUhOmgW7xqglTCJ
         Ks6oA1ME8gAY7VkpO7ttj9DEzlGTerrHvO+tI=
Received: by 10.223.102.67 with SMTP id f3mr141682fao.125.1298825941881;
        Sun, 27 Feb 2011 08:59:01 -0800 (PST)
Received: from localhost.localdomain (abvh253.neoplus.adsl.tpnet.pl [83.8.205.253])
        by mx.google.com with ESMTPS id 11sm1155728faw.44.2011.02.27.08.58.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Feb 2011 08:59:00 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p1RGwWdx013587;
	Sun, 27 Feb 2011 17:58:38 +0100
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168044>

The most important issue is that after unsetting `i18n.commitencoding'
config variable t9500 no longer will use author and comitter name
containing ISO-8859-1 characters, which are invalid UTF-8 characters.

Besides it is good practice in general to clean up the state in tests.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 t/t9500-gitweb-standalone-no-errors.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 0dc573d..9e24bdd 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -446,6 +446,8 @@ test_expect_success \
 test_expect_success \
 	'encode(commit): utf8' \
 	'. "$TEST_DIRECTORY"/t3901-utf8.txt &&
+	 test_when_finished "GIT_AUTHOR_NAME=\"A U Thor\"" &&
+	 test_when_finished "GIT_COMMITTER_NAME=\"C O Mitter\"" &&
 	 echo "UTF-8" >> file &&
 	 git add file &&
 	 git commit -F "$TEST_DIRECTORY"/t3900/1-UTF-8.txt &&
@@ -454,11 +456,13 @@ test_expect_success \
 test_expect_success \
 	'encode(commit): iso-8859-1' \
 	'. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+	 test_when_finished "GIT_AUTHOR_NAME=\"A U Thor\"" &&
+	 test_when_finished "GIT_COMMITTER_NAME=\"C O Mitter\"" &&
 	 echo "ISO-8859-1" >> file &&
 	 git add file &&
 	 git config i18n.commitencoding ISO-8859-1 &&
+	 test_when_finished "git config --unset i18n.commitencoding" &&
 	 git commit -F "$TEST_DIRECTORY"/t3900/ISO8859-1.txt &&
-	 git config --unset i18n.commitencoding &&
 	 gitweb_run "p=.git;a=commit"'
 
 test_expect_success \
