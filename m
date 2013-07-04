From: benoit.person@ensimag.fr
Subject: [PATCH v8 2/7] wrap-for-bin: Make bin-wrappers chainable
Date: Thu,  4 Jul 2013 22:38:55 +0200
Message-ID: <1372970340-6545-3-git-send-email-benoit.person@ensimag.fr>
References: <1372970340-6545-1-git-send-email-benoit.person@ensimag.fr>
Cc: Celestin Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Benoit Person <benoit.person@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 22:39:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuqJI-0007Qc-Hs
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 22:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756943Ab3GDUjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 16:39:16 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39548 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756909Ab3GDUjO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 16:39:14 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r64Kd6Na024353
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 4 Jul 2013 22:39:06 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r64Kd9Iu020594;
	Thu, 4 Jul 2013 22:39:09 +0200
Received: from localhost.localdomain (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r64Kd3ig025632;
	Thu, 4 Jul 2013 22:39:08 +0200
X-Mailer: git-send-email 1.8.3.1.590.gc07d91b
In-Reply-To: <1372970340-6545-1-git-send-email-benoit.person@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 04 Jul 2013 22:39:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r64Kd6Na024353
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: benoit.person@ensimag.fr
MailScanner-NULL-Check: 1373575148.75418@Al8sDFG94hvLuNx9q0AKjQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229612>

From: Benoit Person <benoit.person@ensimag.fr>

For now, bin-wrappers overwrites GITPERLLIB. If we want to chain to
those scripts and define GITPERLLIB before, our changes will be
discarded.

This patch makes the bin-wrappers prepend their modifications to
GITPERLLIB rather than redefining it. It also unset GITPERLLIB in the
test-suite to prevent broken $GITPERLLIB in the user's configuration
from interfering with the testsuite.

The codes using GIT_TEMPLATE_DIR and GIT_TEXTDOMAINDIR handle only one
path in each of this variable so this new behavior would be useless on
those variables.

Signed-off-by: Benoit Person <benoit.person@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 t/test-lib.sh   | 1 +
 wrap-for-bin.sh | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index eff3a65..43e2a39 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -92,6 +92,7 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e '
 	print join("\n", @vars);
 ')
 unset XDG_CONFIG_HOME
+unset GITPERLLIB
 GIT_AUTHOR_EMAIL=author@example.com
 GIT_AUTHOR_NAME='A U Thor'
 GIT_COMMITTER_EMAIL=committer@example.com
diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
index 53a8dd0..35b394a 100644
--- a/wrap-for-bin.sh
+++ b/wrap-for-bin.sh
@@ -14,7 +14,7 @@ else
 	GIT_TEMPLATE_DIR='@@BUILD_DIR@@/templates/blt'
 	export GIT_TEMPLATE_DIR
 fi
-GITPERLLIB='@@BUILD_DIR@@/perl/blib/lib'
+GITPERLLIB='@@BUILD_DIR@@/perl/blib/lib:'"${GITPERLLIB:+:$GITPERLLIB}"
 GIT_TEXTDOMAINDIR='@@BUILD_DIR@@/po/build/locale'
 PATH='@@BUILD_DIR@@/bin-wrappers:'"$PATH"
 export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
-- 
1.8.3.1.590.gc07d91b
