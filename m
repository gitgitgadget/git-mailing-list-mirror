From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 0/2] gitweb: Beginnings of splitting gitweb into modules
Date: Tue,  3 May 2011 16:04:08 +0200
Message-ID: <1304431450-23901-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	"Alejandro R. Sedeno" <asedeno@mit.edu>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 16:04:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHGDR-0004v8-6x
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 16:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724Ab1ECOEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 10:04:36 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57473 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903Ab1ECOEf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 10:04:35 -0400
Received: by wya21 with SMTP id 21so83361wya.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 07:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=dYcyjYN8hM8co1zTBZ3j81ev2OEbzmLfvxrNQ7hfpzg=;
        b=v3xCVjNqZdqFBtGgvrX6dGxBXMpvnUkjCjZO6XfO7f2kCGCMFQUXe4d92BK4iSxIGt
         xb53QT3R26e6816PZ1Dq+kceuwAP52xayfpV0cEZaCAgb37ClBbwhABU9tUfInOG58dA
         zdTc8KVkomxspdLpbZxkn9Infc1qMsijI9UXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=sFM2Z3XhrHwJUYs87nILG4MwH7HQ3V8IRnW/rz5L0b74TOaUNj+AlBlD3LBn+HuCtB
         PPQHAukGHgin775YsRX/sFpJ69wf9RqCi50H59j2d9ehRZcAYgw0mB9ElS2dJeBy5M+z
         bnSbJ+kdXGmwa3kzfkDW6g3gGaAysF5hyPFqU=
Received: by 10.227.159.141 with SMTP id j13mr3916488wbx.108.1304431474383;
        Tue, 03 May 2011 07:04:34 -0700 (PDT)
Received: from roke.localdomain (abvt77.neoplus.adsl.tpnet.pl [83.8.217.77])
        by mx.google.com with ESMTPS id ed10sm78669wbb.32.2011.05.03.07.04.31
        (version=SSLv3 cipher=OTHER);
        Tue, 03 May 2011 07:04:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172659>

Gitweb is currently next to largest file (after gitk) in git sources,
more than 225KB with more than 7,000 lines.  Therefore adding any
large feature that would require large amount of code added, like
gitweb caching by J.H. and my rewrite of it, or "gitweb admin/write"
[failed] GSoC 2010 project by Pavan Kumar Sunkara, would require for
new code to be added as a separate module.  Otherwise gitweb would
fast become unmaintainable.

Note that there is already patch series sent which as one of side
effects splits the JavaScript side of gitweb into many smaller
self-contained files:

  [PATCH 03/13] gitweb: Split JavaScript for maintability, combining on build
  http://thread.gmane.org/gmane.comp.version-control.git/172384/focus=172385

Not in all cases splitting gitweb upfront would be required.  At least
in the case of gitweb caching it doesn't.  What must be done however
is preparing the infrastructure for modular gitweb sources; to
properly test such infrastructure we need at least one split gitweb
module.  With patch series preparing for splitting or true splitting of
gitweb sent upfront the future patch series that implements
code-extensive feature (like e.g. output caching) would be smaller and
easier to review.


This series is intended to bring such infrastructure to gitweb, to
prepare way for adding output caching to gitweb. Alternatively it can
be thought as beginning of splitting gitweb into smaller submodules,
for better maintainability.

This patch series was sent to git mailing list as

  [PATCH 0/2] gitweb: Begin splitting gitweb
  http://thread.gmane.org/gmane.comp.version-control.git/165824

In the above mentioned first version of this series, the first patch
that prepared the way for splitting gitweb was in three versions: A, B
and C.  In this second version of this series the first patch in
series most closely resembles version C in v1 series.

In this version gitweb uses _both_ 'use lib __DIR__."/lib";' and
'use lib "++GITWEBLIBDIR++";', in correct order (as compared to
version C of v1 series), so that __DIR__."/lib" is checked first,
i.e. modules installed alongside gitweb.cgi win.

Pull request:
~~~~~~~~~~~~~
This series is available in the git repository at:
  git://repo.or.cz/git/jnareb-git.git gitweb/split
  git://github.com/jnareb/git.git gitweb/split

Well, those patches has a few minor cosmetic fixups...

Table of contents:
~~~~~~~~~~~~~~~~~~
* [PATCHv2 1/2] gitweb: Prepare for splitting gitweb
  [PATCHv2 2/2] gitweb: Create Gitweb::Util module

  First patch implements infrastructure, second proof of concept patch uses
  this infrastructure, testing it ("make -C gitweb test-installed").

Shortlog:
~~~~~~~~~
Jakub Narebski (1):
  gitweb: Prepare for splitting gitweb

Pavan Kumar Sunkara (1):
  gitweb: Create Gitweb::Util module

Diffstat:
~~~~~~~~~
 gitweb/INSTALL            |    7 ++
 gitweb/Makefile           |   23 ++++++-
 gitweb/gitweb.perl        |  151 ++++-----------------------------------
 gitweb/lib/Gitweb/Util.pm |  177 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 219 insertions(+), 139 deletions(-)
 create mode 100755 gitweb/lib/Gitweb/Util.pm

-- 
1.7.3
