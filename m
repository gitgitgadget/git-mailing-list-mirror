From: Lea Wiemann <lewiemann@gmail.com>
Subject: [RFC/PATCH v2] gitweb: respect $GITPERLLIB
Date: Fri, 20 Jun 2008 21:35:47 +0200
Message-ID: <1213990547-7585-2-git-send-email-LeWiemann@gmail.com>
References: <1213929117-32037-1-git-send-email-LeWiemann@gmail.com>
 <1213990547-7585-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 21:37:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9mPz-0001fy-Kx
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 21:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbYFTTgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 15:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbYFTTgJ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 15:36:09 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:20908 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbYFTTgH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 15:36:07 -0400
Received: by fg-out-1718.google.com with SMTP id 19so721298fgg.17
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 12:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:from;
        bh=JbjGtZHNAK/vH94VFxj+fQrV8of/AyFywdcbjoXi1WA=;
        b=KzIlenJu8t+Ib2E/oMYQwzfOsL7fUJhk2K2TmM+FkN6NyWefC5geBG4a3npwSFRxD4
         xWMjX9V99z9HWrECJ/Nl+EdKvCkuCeXofwL8xNhNSZGhdtAV347Rhm3HwF5EgjWgVmz6
         u8w1dyoUPYWdfD1EHZk7j1mLX3aYqHOdgFOds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=krKYuU4qAAvvd6W4zsYDBKn0n9Fw2/vtP1QBPoZqRbnuxfWQcHXuVRoKkZOp17H4C/
         VaDEUvddaF+e2sriITnc50e3Pg/1jyXL03yotTQfxhG+sUUIFRO0nh7AysoXiSdABSg/
         dnnjwRWDCeW2oJBe7ZS4IC0FQnttQRSABgfsY=
Received: by 10.86.77.5 with SMTP id z5mr2626723fga.34.1213990564296;
        Fri, 20 Jun 2008 12:36:04 -0700 (PDT)
Received: from fly ( [91.33.240.210])
        by mx.google.com with ESMTPS id e11sm3878713fga.4.2008.06.20.12.35.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Jun 2008 12:35:52 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <lea@fly>)
	id 1K9mOi-0001yk-74; Fri, 20 Jun 2008 21:35:48 +0200
X-Mailer: git-send-email 1.5.6.79.g4217
In-Reply-To: <1213990547-7585-1-git-send-email-LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85675>

gitweb/gitweb.cgi now respects $GITPERLLIB, like the Perl-based Git
commands.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
Changed since v1: Added missing INSTLIBDIR initialization.

I just noticed that as of now Gitweb isn't using any Perl modules, so
this change is actually not necessary yet; hence I'm making it an RFC
patch.  I'll probably squash this into a larger "gitweb: use new
Git::Repo API" patch (which I'll publish in a few days).

Comments on this change to the Makefile are still appreciated, of
course. :)

-- Lea

 Makefile |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 85c0846..64eeac1 100644
--- a/Makefile
+++ b/Makefile
@@ -1083,7 +1083,15 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 
 gitweb/gitweb.cgi: gitweb/gitweb.perl
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
+	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
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
1.5.6.79.g01e9.dirty
