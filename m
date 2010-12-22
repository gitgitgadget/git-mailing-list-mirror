From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH v7 0/9] gitweb: Output caching,
	with eval/die based error handling
Date: Thu, 23 Dec 2010 00:54:32 +0100
Message-ID: <20101222234843.7998.87068.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog9@eaglescrag.net>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 23 00:55:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVYWg-0006mw-Ha
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 00:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838Ab0LVXzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 18:55:15 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52803 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452Ab0LVXzO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 18:55:14 -0500
Received: by fxm20 with SMTP id 20so6638578fxm.19
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 15:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=UBtZiFoI0jP6fUmD3VriIuWWdEBuW0aHH1RhxrAY2eU=;
        b=A4ypoN2v9r5Eup8oWWhKuKP4tbYod/fC5rVGzv3mSQ6vuT9QAT9GEq5aETrI0HtXv6
         NH7KLBG2pkpzGSbWa5l6DSDP2ddrlWjQVAKLB21l5trdnbxYRqZvIhWqX/LI/9xZlXKZ
         7Ed4IVsNOOvJkBzkPCIXC+QoRXpKXAMo222Ow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=QWiUZR/3CQOR1MaqmQK87crbl5f62KObv3mBjbMDGyV2LdwzkZVQTI1iQjvVNgmcq1
         dT7jzAc1uXdpvyiaOy8sPEHX9BZ1bNgIQR2L8BrWWrA/3eCDGniOPkpMISnXtn+d5XRM
         syukj5S+3wAArn1fYpHxuWyUn6j6Y5V5J9lpw=
Received: by 10.223.70.193 with SMTP id e1mr6693688faj.91.1293062111863;
        Wed, 22 Dec 2010 15:55:11 -0800 (PST)
Received: from localhost.localdomain (abvw91.neoplus.adsl.tpnet.pl [83.8.220.91])
        by mx.google.com with ESMTPS id k6sm1855288faa.30.2010.12.22.15.55.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Dec 2010 15:55:10 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBMNsW5q008074;
	Thu, 23 Dec 2010 00:54:43 +0100
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164101>

This is preliminary (proof of concept) version of shortened series
intended as replacement (rewrite) of "Gitweb caching v8" series from
John 'Warthog9' Hawley (J.H.).

This series shows how one can manage exception handling using
die_error like die, even in the presence of output caching.  The
output caching engine has an option that allows to turn off (default)
or on caching of error pages.

This series is unfinished; it does not include adaptive cache
lifetime, nor support for other caching engines than the one provided
(like Cache::Cache or CHI), nor does it support background cache
generation or progress info indicator.

This is just intended as proof of concept.

---
Jakub Narebski (9):
      gitweb: Add optional output caching
      gitweb/lib - Cache captured output (using compute_fh)
      gitweb/lib - Very simple file based cache
      gitweb/lib - Simple output capture by redirecting STDOUT to file
      t/test-lib.sh: Export also GIT_BUILD_DIR in test_external
      gitweb: Prepare for splitting gitweb
      gitweb: Introduce %actions_info, gathering information about actions
      gitweb: use eval + die for error (exception) handling
      gitweb: Go to DONE_REQUEST rather than DONE_GITWEB in die_error

 gitweb/Makefile                                |   22 +
 gitweb/README                                  |   46 ++
 gitweb/gitweb.perl                             |  280 +++++++++++++--
 gitweb/lib/GitwebCache/CacheOutput.pm          |   84 ++++
 gitweb/lib/GitwebCache/Capture/ToFile.pm       |  109 ++++++
 gitweb/lib/GitwebCache/FileCacheWithLocking.pm |  452 ++++++++++++++++++++++++
 t/gitweb-lib.sh                                |   11 +
 t/t9500-gitweb-standalone-no-errors.sh         |   20 +
 t/t9501-gitweb-standalone-http-status.sh       |   13 +
 t/t9502-gitweb-standalone-parse-output.sh      |   33 ++
 t/t9510-gitweb-capture-interface.sh            |   34 ++
 t/t9510/test_capture_interface.pl              |  132 +++++++
 t/t9511-gitweb-caching-interface.sh            |   34 ++
 t/t9511/test_cache_interface.pl                |  381 ++++++++++++++++++++
 t/t9512-gitweb-cache-output-interface.sh       |   34 ++
 t/t9512/test_cache_output.pl                   |  162 +++++++++
 t/test-lib.sh                                  |    4 
 17 files changed, 1806 insertions(+), 45 deletions(-)
 create mode 100644 gitweb/lib/GitwebCache/CacheOutput.pm
 create mode 100644 gitweb/lib/GitwebCache/Capture/ToFile.pm
 create mode 100644 gitweb/lib/GitwebCache/FileCacheWithLocking.pm
 create mode 100755 t/t9510-gitweb-capture-interface.sh
 create mode 100755 t/t9510/test_capture_interface.pl
 create mode 100755 t/t9511-gitweb-caching-interface.sh
 create mode 100755 t/t9511/test_cache_interface.pl
 create mode 100755 t/t9512-gitweb-cache-output-interface.sh
 create mode 100755 t/t9512/test_cache_output.pl

-- 
Jakub Narebski
ShadeHawk on #git
Poland
