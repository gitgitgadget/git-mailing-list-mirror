From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 3/3] gitweb/Makefile: Add 'test' and 'test-installed' targets
Date: Sun, 26 Sep 2010 15:02:26 +0200
Message-ID: <1285506146-8009-4-git-send-email-jnareb@gmail.com>
References: <1285506146-8009-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 26 15:11:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozr0o-0001r2-CT
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 15:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757778Ab0IZNLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 09:11:10 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33662 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757755Ab0IZNLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 09:11:09 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so2792344bwz.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 06:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QjhQSvBBX9ZJwbXVQcI58Xu8R3CXYpkxdwLITRI0P6U=;
        b=LhkjQVdtVz7tibb5fI9ejTS7rkQKBWprSheXnVqgxrKfW2THIB0vwjNB9sN6ckBce0
         j/Yk7E2Aq6uJZc29TxQ4Q6nomJgdyco6u/1kQ3CBFyX+S+YBb3jz0I2zuZkElvo5NVvQ
         OWnEAd5NZAIC5Ykhjac+/vrljvfkjI7xWdoJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PJZI8BWwNBayeXRHg5VzldAhpLTwacBT1bAGoqGmjLoe0nZ6JpBETX8ljr534320H+
         NmrnFguHZQq7CnXJUiBCsqKw5UQhC6o/ik5WejbFkMjpL8OTlt17k3sQBAAgmnp0H9+d
         yOdIu5CS7R+t6fUaO02yBM/tPYsaZfUAaISds=
Received: by 10.204.98.4 with SMTP id o4mr1299105bkn.123.1285506669087;
        Sun, 26 Sep 2010 06:11:09 -0700 (PDT)
Received: from localhost.localdomain (abwp12.neoplus.adsl.tpnet.pl [83.8.239.12])
        by mx.google.com with ESMTPS id x13sm3388546bki.0.2010.09.26.06.11.06
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 06:11:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1285506146-8009-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157224>

The 'test-installed' target in gitweb/Makefile tests installed gitweb,
using the same destination directory that 'install' target uses.

The 'test' target is just a convenience wrapper invoking 'gitweb-test'
target of t/Makefile.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Changes from previous version:

* 'test-installed' no longer has 'install' as requirement, which means that
  testing installed target does not force an install.  We cannot check easily
  and reliably that install is fresh.

* Added 'test' convenience target.

* Moved "Testing rules" section before "Installation rules", the way it is done
  in main Makefile.

 gitweb/Makefile |   11 ++++++++++-
 t/Makefile      |    4 ++++
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 88bcf08..df908a1 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -144,6 +144,15 @@ gitweb.cgi: gitweb.perl GITWEB-BUILD-OPTIONS
 	chmod +x $@+ && \
 	mv $@+ $@
 
+### Testing rules
+
+test:
+	$(MAKE) -C ../t gitweb-test
+
+test-installed:
+	GITWEB_TEST_INSTALLED='$(DESTDIR_SQ)$(gitwebdir_SQ)' \
+		$(MAKE) -C ../t gitweb-test
+
 ### Installation rules
 
 install: all
@@ -157,5 +166,5 @@ install: all
 clean:
 	$(RM) gitweb.cgi static/gitweb.min.js static/gitweb.min.css GITWEB-BUILD-OPTIONS
 
-.PHONY: all clean install .FORCE-GIT-VERSION-FILE FORCE
+.PHONY: all clean install test test-installed .FORCE-GIT-VERSION-FILE FORCE
 
diff --git a/t/Makefile b/t/Makefile
index c7baefb..7aa409a 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -17,6 +17,7 @@ SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 
 T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
 TSVN = $(wildcard t91[0-9][0-9]-*.sh)
+TGITWEB = $(wildcard t95[0-9][0-9]-*.sh)
 
 all: pre-clean
 	$(MAKE) aggregate-results-and-cleanup
@@ -46,6 +47,9 @@ full-svn-test:
 	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=1 LC_ALL=C
 	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=0 LC_ALL=en_US.UTF-8
 
+gitweb-test:
+	$(MAKE) $(TGITWEB)
+
 valgrind:
 	GIT_TEST_OPTS=--valgrind $(MAKE)
 
-- 
1.7.3
