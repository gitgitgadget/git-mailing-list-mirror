From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] gitweb: respect $GITPERLLIB
Date: Fri, 20 Jun 2008 04:31:57 +0200
Message-ID: <1213929117-32037-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 04:33:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9WQy-00038B-3v
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 04:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbYFTCcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 22:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbYFTCcF
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 22:32:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:26281 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbYFTCb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 22:31:57 -0400
Received: by fg-out-1718.google.com with SMTP id 19so544490fgg.17
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 19:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:from;
        bh=BEqRmyaV2y6wuH9RQTBkzQN6UdFe8/nOCNFLhVHtQug=;
        b=ZCXdUi+qqxEB4yDPfCy7bQQ8TKN9OJ0bA0+ouIxWhDIfB3RyN2tKD4ZNgivfWiKN0C
         /wMdBKJSxIZxfu5lBFLEkA9Jq8iB6XshxTgwn1TzuZOW9E0zCdWaz7nnE/X3R9Hgzqp6
         lQOfsXVLH8lHtFuf1gZVT5NMzD2oz4XiLYDs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=sM9oMFGvPO/XPseZ671YOJraJVSUdWcgKQuS+YQZ8CTHGREjiv2rq+LnWnbojFbmww
         wGfAbTtYZGWaXz7UUyTBTUsWWgVhCA2E2Ma9kTu5S4XQZ26pVf73lwUzapXk9ukey1Xm
         6bJ5nwad1U4DJ3YsnYN05HiO5sadLYNrR2SYI=
Received: by 10.86.9.8 with SMTP id 8mr3125752fgi.41.1213929115662;
        Thu, 19 Jun 2008 19:31:55 -0700 (PDT)
Received: from fly ( [91.33.204.94])
        by mx.google.com with ESMTPS id e20sm2524632fga.1.2008.06.19.19.31.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Jun 2008 19:31:55 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <lea@fly>)
	id 1K9WPt-0008L6-Dx; Fri, 20 Jun 2008 04:31:57 +0200
X-Mailer: git-send-email 1.5.6.31.gcbcff.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85586>

gitweb/gitweb.cgi now respects $GITPERLLIB, like the Perl-based Git
commands.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
Junio C Hamano wrote in <http://mid.gmane.org/7vfxrwa008.fsf@gitster.siamese.dyndns.org>:
> The real fix to the issue [is] to fix the build
> procedure of gitweb/gitweb.perl so that the above script rewriting is also
> applied to it.

I've now implemented this, since it's becoming necessary for the
Mechanize tests.  However, I'm not totally confident that what I wrote
is (a) correct and (b) a good idea -- I simply copy-and-pasted from
the previous Makefile entry, since I'm not very proficient with sed.

Comments appreciated!

-- Lea

 Makefile |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index b003e3e..c5c6ac7 100644
--- a/Makefile
+++ b/Makefile
@@ -1081,7 +1081,14 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 
 gitweb/gitweb.cgi: gitweb/gitweb.perl
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
+	sed -e '1{' \
+	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
+	    -e '	h' \
+	    -e '	s=.*=use lib (split(/:/, $$ENV{GITPERLLIB} || "@@INSTLIBDIR@@"));=' \
+	    -e '	H' \
+	    -e '	x' \
+	    -e '}' \
+	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
 	    -e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
 	    -e 's|++GIT_BINDIR++|$(bindir)|g' \
 	    -e 's|++GITWEB_CONFIG++|$(GITWEB_CONFIG)|g' \
-- 
1.5.6.31.gcbcff.dirty
