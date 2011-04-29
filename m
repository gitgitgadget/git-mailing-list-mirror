From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/6] gitweb: Improve ctags, introduce categories
Date: Fri, 29 Apr 2011 19:51:55 +0200
Message-ID: <1304099521-27617-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Sebastien Cevey <seb@cine7.net>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 19:52:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFrrh-0001C5-82
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 19:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760730Ab1D2RwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 13:52:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35897 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757894Ab1D2RwX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 13:52:23 -0400
Received: by fxm17 with SMTP id 17so2635553fxm.19
        for <git@vger.kernel.org>; Fri, 29 Apr 2011 10:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=u3Oe/CZu6DUxjc9CD4mXpQUnAa/IBRyrzusZvhgcBPc=;
        b=BAvW46ce1PxTBMk0FGT/gLG/86qqyoTVLHJtaU05hL60PHiRCVe8+L1ETcwXyY3B7N
         0LHuWSKd2k5tB1w6Ra5Y6zOHlDTaH5n3LRFjEWZxRtfSgf22qx6RqP+O7caksbH+y8UV
         htIHja1wQCBi91Ph4bjoEfwIlXvhoKY79V3Tg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Ri9iu3iGDER7m4lqCz/ev/HN+nKG0ChB7aaqCo/I7IqZvDZgRVIkk0Kd2IgvVZOo4i
         xydxC0FkBSh4bsNGyRntvHOkmFjHwCGDI/SiIihAuUaSva2Jh50spLQU/syXHG4KSNdZ
         Lg9lOLWYPUsxYo0x5qiK77fG+nVU/lpUagZqU=
Received: by 10.223.1.16 with SMTP id 16mr2571601fad.88.1304099540541;
        Fri, 29 Apr 2011 10:52:20 -0700 (PDT)
Received: from localhost.localdomain (abvr62.neoplus.adsl.tpnet.pl [83.8.215.62])
        by mx.google.com with ESMTPS id n26sm962346fam.37.2011.04.29.10.52.16
        (version=SSLv3 cipher=OTHER);
        Fri, 29 Apr 2011 10:52:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172477>

This series is composed of two independent parts: improvements to
content tags (ctags) handling in patches 2-3, and introducing optional
grouping of projects by categories in patches 4-6 (where 4-5 are
preparatory).

Both of those series are based on 1st patch in series which
restructures how projects list is being generated, to make those
changes easy to introduce.  Because both of those depend on the same
introductory patch they are put in single series... that and the fact
that there was trivial conflict to be resolved in rebasing 'project
category' part on top of 'ctags' part.

Table of contents:
~~~~~~~~~~~~~~~~~~
* [PATCH 1/6 (v2)] gitweb: Restructure projects list generation

  This patch extracts filtering out "forks" and searching for projects
  (i.e. limiting listed projects) into separate subroutines.  Also
  filtering is done upfront and not while printing.  This makes for
  more clear code and makes subsequent changes much easier.

  Filtering forks is now faster thanks to using trie; see comments in
  code and in the patch itself.

* [PATCH 2/6] gitweb: Change the way "content tags" ('ctags') are handled

  Making ctags info parsing more robust sort of fixes bug noticed in

    gitweb: cloud tags feature produces malformed XML for errors
    http://thread.gmane.org/gmane.linux.debian.devel.bugs.general/802865/focus=168266
    http://bugs.debian.org/616005

  caused by myshandling underdocumented then 'ctags' feature.  This
  patch DOES NOT however resolve deeper fundamental problem with error
  / exception handling in gitweb after some data was already sent to a
  browser.

  It also removes gitweb half of interface for adding content tags
  (labels) to a project; it was quarter of feature at best (there
  is/was no example implementation of server side half of adding
  content tags, no way to delete or fix content tags).

* [PATCH 3/6] gitweb: Mark matched 'ctag' / contents tag (?by_tag=foo)

  This is simple improvement, done while working on 'ctags' feature.

* [PATCH 4/6] gitweb: Split git_project_list_body in two functions
  [PATCH 5/6] gitweb: Modularized git_get_project_description to be more generic

  Those two patches are refactoring preparing way for project
  categories (for the next patch).

* [PATCH 6/6] gitweb: Optional grouping of projects by category

  Port of Sebastien Cevey port of Sham Chukoury's patch for the XMMS2
  gitweb to modern gitweb.

Shortlog:
~~~~~~~~~
Jakub Narebski (3):
  gitweb: Restructure projects list generation
  gitweb: Change the way "content tags" ('ctags') are handled
  gitweb: Mark matched 'ctag' / contents tag (?by_tag=foo)

Sebastien Cevey (3):
  gitweb: Split git_project_list_body in two functions
  gitweb: Modularized git_get_project_description to be more generic
  gitweb: Optional grouping of projects by category

Diffstat:
~~~~~~~~~
 gitweb/README                             |   16 +
 gitweb/gitweb.perl                        |  546 ++++++++++++++++++++---------
 gitweb/static/gitweb.css                  |    7 +
 t/t9500-gitweb-standalone-no-errors.sh    |   57 +++
 t/t9502-gitweb-standalone-parse-output.sh |   74 ++++
 5 files changed, 542 insertions(+), 158 deletions(-)

-- 
1.7.3
