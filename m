From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/2] gitweb: Begin splitting gitweb
Date: Tue,  1 Feb 2011 17:50:12 +0100
Message-ID: <1296579016-13356-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 01 17:50:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkJRG-0007Hk-KJ
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 17:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902Ab1BAQul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 11:50:41 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41376 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640Ab1BAQul (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 11:50:41 -0500
Received: by bwz15 with SMTP id 15so6510232bwz.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 08:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=8vibC/PdfmMPyus9Ai8jK2IIosDdjvXs9+uao294EYY=;
        b=Stnpm13atpX0Byg8mnAkthjmgXxBpBUnY2JI+KI5KBZIz15s31Di4tio/vZDKWe70l
         vYzE/zXoWO9PFI3QVk5SKtkerJfNpzi7Y+a5P1fzX1VuOy1fFgHBWxKuAr979lSceU9m
         SfLejH8cotnJi0nXv097onma4RL4k24oRdRjk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=UgW6Y4PFyeCLxKva2sl2lxIH4yTRKLjl4GdWUIiUWdc7eDWqVObTvOVvQV5tZFO+wN
         Za+D7YVHZOPbTgLo6xIyQ8UdIXp9pDaKcM7FDseKI1p3q1T1nWnv/SqCvD00DE1HpKmk
         GDWmmMOSkaEsP/i++hxjAzpKJ/jnEYq8JcEbE=
Received: by 10.204.82.32 with SMTP id z32mr6968674bkk.158.1296579039592;
        Tue, 01 Feb 2011 08:50:39 -0800 (PST)
Received: from localhost.localdomain (abuz232.neoplus.adsl.tpnet.pl [83.8.197.232])
        by mx.google.com with ESMTPS id z18sm8881027bkf.20.2011.02.01.08.50.36
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 08:50:38 -0800 (PST)
X-Mailer: git-send-email 1.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165824>

Gitweb is currently next to largest file (after gitk) in git sources,
more than 220K with more than 25,000 lines.  Therefore adding any
large feature that would require large amount of code added, like
gitweb caching by J.H. and my rewrite of it, or "gitweb admin/write"
[failed] GSoC 2010 project by Pavan Kumar Sunkara require for new code
to be added as a separate module or module.  Otherwise gitweb would
fast become unmaintainable.

Not in all cases it would require splitting gitweb upfront.  At least
in the case of gitweb caching it doesn't.  What must be done however
is preparing the infrastructure for modular gitweb sources; to
properly test such infrastructure we need at least one split gitweb
module.


This series is intended to bring such infrastructure to gitweb, to
prepare way for adding output caching to gitweb. Alternatively it can
be thought as beginning of splitting gitweb into smaller submodules,
for better maintability.


Table of contents:
~~~~~~~~~~~~~~~~~~
* [PATCH (version A) 1/2] gitweb: Prepare for splitting gitweb

    sub __DIR__ () {
    	File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1]);
    }
    use lib __DIR__ . '/lib';

  Advantages:
  - no changes to t/gitweb-lib.sh, ability to run source version
    of gitweb without any changes
  
  Disadvantages:
  - supports only modules installed either alongside gitweb, or in one
    of PERL5LIB directories; no support for installing modules not
    alongside gitweb
  - because we cannot rely on FindBin::again being available nor on
    having Dir::Self installed, __DIR__ must be defined -- more code.
 
* [PATCH (version B) 1/2] gitweb: Prepare for splitting gitweb

    use lib $ENV{'GITWEBLIBDIR'} || "++GITWEBLIBDIR++";

  Advantages:
  - supports relocating gitweb modules (to gitweblibdir)
  - shortest code of all the cases

  Disadvantages:
  - required changes to t/gitweb-lib.sh to pick up gitweb modules
    by source version of gitweb

* [PATCH (version C) 1/2] gitweb: Prepare for splitting gitweb

    sub __DIR__ () {
    	File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1]);
    }
    use lib __DIR__ . '/lib';
    use lib "++GITWEBLIBDIR++";

  Advantages:
  - can run source version of gitweb (gitweb/gitweb.perl) as a script simply
  - supports relocating gitweb modules (to gitweblibdir)

  Disadvantages:
  - most complicated code of all cases


* [PATCH (proof of concept) 2/2] gitweb: Create Gitweb::Util module

  Something to actually test previous patch(es) with... and I guess
  good start to splitting gitweb into smaller modules.

  All versions pass "make -C gitweb test" and "make -C gitweb test-installed"
  after "make -C gitweb install" / "make install-gitweb".


Shortlog:
~~~~~~~~~
Jakub Narebski (1):
  gitweb: Prepare for splitting gitweb

Pavan Kumar Sunkara (1):
  gitweb: Create Gitweb::Util module

Diffstat (for version C):
~~~~~~~~~~~~~~~~~~~~~~~~~
 gitweb/Makefile           |   22 +++++-
 gitweb/gitweb.perl        |  150 ++++-----------------------------------
 gitweb/lib/Gitweb/Util.pm |  177 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 210 insertions(+), 139 deletions(-)
 create mode 100644 gitweb/lib/Gitweb/Util.pm

-- 
1.7.3
