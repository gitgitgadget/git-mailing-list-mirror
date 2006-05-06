From: sean <seanlkml@sympatico.ca>
Subject: [PATCH] t1300-repo-config: two new config parsing tests.
Date: Sat, 6 May 2006 15:43:43 -0400
Message-ID: <BAYC1-PASMTP090EE19E31F9EEBD579719AEAA0@CEZ.ICE>
References: <20060506141402.3909cb37.seanlkml@sympatico.ca>
	<BAYC1-PASMTP08FCAC8B8FB768ED1791F1AEAA0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sat May 06 21:48:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcSls-0006qT-2Q
	for gcvg-git@gmane.org; Sat, 06 May 2006 21:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWEFTso (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 15:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWEFTso
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 15:48:44 -0400
Received: from bayc1-pasmtp09.bayc1.hotmail.com ([65.54.191.169]:6691 "EHLO
	BAYC1-PASMTP09.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932071AbWEFTsn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 May 2006 15:48:43 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP09.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 6 May 2006 12:50:19 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id E3BEC644C28;
	Sat,  6 May 2006 15:48:41 -0400 (EDT)
To: git@vger.kernel.org
Message-Id: <20060506154343.750a806a.seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP08FCAC8B8FB768ED1791F1AEAA0@CEZ.ICE>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 06 May 2006 19:50:19.0281 (UTC) FILETIME=[4DC17010:01C67146]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


- correctly insert a new variable into a section that only
  contains a single (different) variable.

- correctly insert a new section that matches the initial
  substring of an existing section.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>


---

Both tests fail with v1.3.2 and pass with latest patches.


 t/t1300-repo-config.sh |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

ef2178a10e27f43d4120884bc587c460e9b1bfcb
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 1bf728f..0914be2 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -278,5 +278,36 @@ git-repo-config > output 2>&1
 test_expect_success 'no arguments, but no crash' \
 	"test $? = 129 && grep usage output"
 
+cat > .git/config << EOF
+[a.b]
+	c = d
+EOF
+
+git-repo-config a.x y
+
+cat > expect << EOF
+[a.b]
+	c = d
+[a]
+	x = y
+EOF
+
+test_expect_success 'new section is partial match of another' 'cmp .git/config expect'
+
+git-repo-config b.x y
+git-repo-config a.b c
+
+cat > expect << EOF
+[a.b]
+	c = d
+[a]
+	x = y
+	b = c
+[b]
+	x = y
+EOF
+
+test_expect_success 'new variable inserts into proper section' 'cmp .git/config expect'
+
 test_done
 
-- 
1.3.2.gd777c
