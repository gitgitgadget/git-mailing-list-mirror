From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI script
Date: Fri,  7 May 2010 14:54:03 +0200
Message-ID: <1273236845-6523-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Eric Wong <normalperson@yhbt.net>,
	Juan Jose Comellas <juanjo@comellas.org>,
	Peter Vereshagin <peter@vereshagin.org>,
	John Goerzen <jgoerzen@complete.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 14:54:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAN4X-0003xh-F3
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 14:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987Ab0EGMyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 08:54:20 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:33443 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab0EGMyT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 08:54:19 -0400
Received: by bwz19 with SMTP id 19so556582bwz.21
        for <git@vger.kernel.org>; Fri, 07 May 2010 05:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=btprOZReLPAkxd9B3UQDrHSom2a3gI7OiqHiDpeNsjg=;
        b=Os1Y3rY07vaHggTfHegZJiaQk2UoYpqDhwv9l3T8mdEVyQFDAvbqbVK7FrM67JhJI8
         Ksa1Ny2EvnDbg/o8kzBaO2Pw0Us1m4jX75WSViYnLlr1WXX7zNN5uiHgYC1P+R1/fPuf
         hz5nEnswOs938UOxu7K8fi9uKK1S/PG6w6PVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ufQlgbLztQ14HfgDpu2jM7BQcQ/r0HrJtd9isNbUa53Q1k+B9RBTet+Gj6vwtx2UZL
         oYudazqpQZEqr8937u62lw1UqwhZGLHiLmn1QcKUZM/fCSDz2FaVHW7rO3Vn9aa8iKEQ
         JUcccbLpzuMb9lwCNpnJZDoA5CUiYlHfI1Pr0=
Received: by 10.204.33.149 with SMTP id h21mr71396bkd.203.1273236855418;
        Fri, 07 May 2010 05:54:15 -0700 (PDT)
Received: from localhost.localdomain (abvc175.neoplus.adsl.tpnet.pl [83.8.200.175])
        by mx.google.com with ESMTPS id 14sm710017bwz.2.2010.05.07.05.54.11
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 07 May 2010 05:54:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146532>

This series requires the following patch:

  [PATCH 3/5] gitweb: Use nonlocal jump instead of 'exit' in die_error
  http://article.gmane.org/gmane.comp.version-control.git/145678

which is present as c42b00c commit in 'pu', as part of
'jn/gitweb-caching-prep' branch, which was merged into 'pu' at
97153ab7.


This patch adds support for FastCGI directly to gitweb.perl (so it
would be present in gitweb.cgi); selecting between FastCGI and CGI
is done via command-line switch (command-line option).  It uses
CGI::Fast, which is core Perl module.

It is port of old patch by Sam Vilain from 2006 to new gitweb
announced in

  "Re: gitweb testing with non-apache web server"
  http://article.gmane.org/gmane.comp.version-control.git/24718

The preparatory patch is refactoring work, to not need to have request
loop around large parts of code.  I think the preparatory patch makes
gitweb code more clean.


The alternate solution would be to add gitweb.fcgi wrapper, like e.g.:
in the following patch by Eric Wong

  "[PATCH 1/2] gitweb: add a simple wrapper for FCGI support"
  http://thread.gmane.org/gmane.comp.version-control.git/35920/focus=35921

which was part of the "[0/2 PATCH] FastCGI and nginx support for gitweb"
series.  (Note that the patch does 'do $gitweb_cgi;' without checking for
errors, see the bottom of `perldoc -f do` documentation on how it should
be done).


Some other references:
* "GitWeb in FastCGI" by Peter Vereshagin
  http://thread.gmane.org/gmane.comp.version-control.git/142132
* "FastCGI support in gitweb" by Juan Jose Comellas
  http://thread.gmane.org/gmane.comp.version-control.git/75704

Table of contents:
~~~~~~~~~~~~~~~~~~
 [PATCH/RFC 1/2] gitweb: Put all per-connection code in run() subroutine
 [PATCH/RFC 2/2] gitweb: Add support for FastCGI, using CGI::Fast

Jakub Narebski (1):
  gitweb: Put all per-connection code in run() subroutine

Sam Vilain (1):
  gitweb: Add support for FastCGI, using CGI::Fast

Diffstat:
~~~~~~~~~

 gitweb/gitweb.perl |  409 ++++++++++++++++++++++++++++++++--------------------
 1 files changed, 255 insertions(+), 154 deletions(-)

Diffstat -w:
~~~~~~~~~~~~
When ignoring whitespace change (reindenting)

 gitweb/gitweb.perl |  117 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 109 insertions(+), 8 deletions(-)

-- 
Jakub Narebski
