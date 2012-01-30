From: Nicholas Harteau <nrh@spotify.com>
Subject: [PATCH] use 'installsitelib' even with NO_PERL_MAKEMAKER
Date: Mon, 30 Jan 2012 11:51:44 +0100
Message-ID: <24482D02-B773-4FE3-8FC7-92B8B4D8C0FA@spotify.com>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 11:51:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rropy-0000gM-LX
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 11:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225Ab2A3Kvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 05:51:46 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:58169 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751202Ab2A3Kvp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 05:51:45 -0500
Received: by lagu2 with SMTP id u2so2101944lag.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 02:51:44 -0800 (PST)
Received: by 10.112.24.196 with SMTP id w4mr4319340lbf.62.1327920704299;
        Mon, 30 Jan 2012 02:51:44 -0800 (PST)
Received: from [192.168.0.216] ([212.181.83.218])
        by mx.google.com with ESMTPS id i9sm13851634lbz.3.2012.01.30.02.51.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 02:51:43 -0800 (PST)
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189340>

perl/Makefile installs Git.pm into $prefix/lib when ExtUtils::MakeMaker
is not present.  perl can't "use Git;" in that scenario, as $prefix/lib
isn't in perl's include path.

This patch installs Git.pm into perl's 'installsitelib', generally
$prefix/lib/perl5/site_perl, so that even when ExtUtils::MakeMaker isn't
present, Git.pm gets installed in a location where 'use Git;' just
works.

for some additional discussion, see:
https://github.com/mxcl/homebrew/pull/8643
https://github.com/mxcl/homebrew/issues/8620
---
 perl/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/perl/Makefile b/perl/Makefile
index b2977cd..2199eb1 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -21,7 +21,7 @@ clean:
 	$(RM) $(makfile).old
 
 ifdef NO_PERL_MAKEMAKER
-instdir_SQ = $(subst ','\'',$(prefix)/lib)
+instdir_SQ = $(subst ','\'',$(subst installsitelib=,'',$(shell $(PERL_PATH_SQ) -V:installsitelib)))
 $(makfile): ../GIT-CFLAGS Makefile
 	echo all: private-Error.pm Git.pm > $@
 	echo '	mkdir -p blib/lib' >> $@
-- 
1.7.8.3

--
nicholas harteau
nrh@spotify.com
