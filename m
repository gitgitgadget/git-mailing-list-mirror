From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Die if there are parsing errors in config file
Date: Sun, 07 Feb 2010 10:40:16 +0100
Message-ID: <20100207093744.29846.6468.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 07 10:41:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ne3dO-0007Zy-71
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 10:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028Ab0BGJkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 04:40:49 -0500
Received: from mail-fx0-f211.google.com ([209.85.220.211]:47971 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739Ab0BGJks (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 04:40:48 -0500
Received: by fxm3 with SMTP id 3so6119042fxm.39
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 01:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=K653ZUQ/rOBlpRU4xIUczcVfDLH040G/7ratTXokqyQ=;
        b=c/E0amlVS62QhH9/b0i/6PwdjtKLlRs2gWpWtUx81mDeK6WiPePXcUynuzYSoRd0I0
         5G9U8nC5zIPmuu71Ty50oXtAfP2NoVkHYG1fRqhDZhWPYl2QNVojMSNEHhTWgkna2O7L
         eJ2RYxZGq4ml2FE3asxzpcN7mF4qvoymheDI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=Tg++BOMJyYna6xNBC2ZcCjxRoEPLAEZw8thF1ZzhydUJeRM4IDn0kfruOCIim4sumc
         jbXJJWkuDOKRaC0rM/9hWQaFX2E8WhMkBam2SwD60HraKfo4uzuzcZivKdL1C6zOv4hO
         MV1alkktKzf4YguotJhjz4PXRCj9PdMWrqJm4=
Received: by 10.87.40.26 with SMTP id s26mr3904353fgj.72.1265535646708;
        Sun, 07 Feb 2010 01:40:46 -0800 (PST)
Received: from localhost.localdomain (abvv164.neoplus.adsl.tpnet.pl [83.8.219.164])
        by mx.google.com with ESMTPS id 16sm1391301fxm.0.2010.02.07.01.40.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Feb 2010 01:40:45 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o179eHPZ029904;
	Sun, 7 Feb 2010 10:40:27 +0100
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139226>

Otherwise the errors can propagate, and show in damnest places, and
you would spend your time chasing ghosts instead of debugging real
problem (yes, it is from personal experience).

This follows (parts of) advice in `perldoc -f do` documentation.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is fallout from my work on [split] "Gitweb output caching" series.
Before I used `die $@ if $@;' in t/t9503/test_cache_interface.pl, tests
failed for no discernable reason...

So I think the same should be done for the gitweb config file.

 gitweb/gitweb.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1f6978a..a5bc359 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -556,6 +556,8 @@ if (-e $GITWEB_CONFIG) {
 	our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
 	do $GITWEB_CONFIG_SYSTEM if -e $GITWEB_CONFIG_SYSTEM;
 }
+# die if there are errors parsing config file
+die $@ if $@;
 
 # Get loadavg of system, to compare against $maxload.
 # Currently it requires '/proc/loadavg' present to get loadavg;
