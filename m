From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v9 0/4] submodule: improve support for relative superproject origin URLs
Date: Wed,  6 Jun 2012 21:57:26 +1000
Message-ID: <1338983850-9872-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 13:58:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScEsC-0000Jj-4e
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 13:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896Ab2FFL5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 07:57:44 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:65099 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab2FFL5l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 07:57:41 -0400
Received: by dady13 with SMTP id y13so8693843dad.19
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 04:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=v+fzhDDLo6MGZVMSDAA9pUHLAeP7JEdis9HgrJY1iGo=;
        b=elBRTJ1EGe9gHjB6NhIkwaBRUee9RSUtLxwmzTlOzH48xXsXCsCOfB7ZgSrLwx9Lvc
         1BUUu1blh5aKK6wRU3Y9YvhMVIk3jKlENWOVm3H8VvPBQvCpz7dEJqlqrxuYuYZts3O7
         UsjV0wODSPmLIP5RkgHhCc6m+aWk+r3qB0bgBeytqwE5TlkDmTkcoAe/vhlz0m1x8Wh6
         UolOaHmeIl2vwBiBlSj/vByx4FCDbsGB/KrFm6TC3oOB/ZIRf75Oid+8tvN2ITjBfgZc
         /CrzwJ0jnruiOrJ47HfIg3vybBr2EpCtUP1w2SLCRKR8ys/3gR6Lg1jdzhEXpQE6xIUh
         II9A==
Received: by 10.68.136.229 with SMTP id qd5mr9495628pbb.2.1338983861343;
        Wed, 06 Jun 2012 04:57:41 -0700 (PDT)
Received: from ubuntu.au.ibm.com ([175.103.19.195])
        by mx.google.com with ESMTPS id pg3sm197182pbc.2.2012.06.06.04.57.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 04:57:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.650.g9c513dd.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199314>

This series improves handling by 'git submodule' of relative superproject origin URLs. 

Currently, 'git submodule':

* incorrectly configures origin URL for submodules with a path that is relative to
the work tree of the superproject when the configured path needs to be relative 
to the work tree of the submodule

* unnecessarily fails with an error if the superproject origin URL is of the form: foo

This series corrects these problems for paths like the following:
  foo
  foo/bar
  ./foo
  ./foo/bar
  ../foo
  ../foo/bar

It does not change current behaviour for URLs that begin with a leading '/' or contain
a ':' as such URLs are deemed to be absolute URLs for which no correction is required.

In addition, this series ensures that relative URLs configured by git submodule do
not include a superfluous leading or embedded './'.

This series differs from v7 by removing the patches dealing incorrect handling 
of greedy submodule URLs (those with too many leading ../'s) and those that deal
with improperly normalized superproject origin URLs. These patches may resubmitted
at a later date.

This series differs from v8 by fixing the indentation of case branches, using 
a sed idiom that avoids a Solaris sed bug, and reverts the name of the 
'module_url' variable used by cmd_sync() to 'url'. The commentary for
resolve_relative_url is adjusted slightly to remove the implication that the 
first argument is always a relative URL.

Jon Seymour (4):
  submodule: additional regression tests for relative URLs
  submodule: document failure to handle relative superproject origin
    URLs
  submodule: fix sync handling of some relative superproject origin
    URLs
  submodule: fix handling of superproject origin URLs like foo, ./foo
    and ./foo/bar

 git-submodule.sh           |  60 +++++++++++++++++--
 t/t7400-submodule-basic.sh | 144 ++++++++++++++++++++++++++++++++++++++++++++-
 t/t7403-submodule-sync.sh  |  90 +++++++++++++++++++++++++++-
 3 files changed, 284 insertions(+), 10 deletions(-)

-- 
1.7.10.2.650.g9c513dd.dirty
