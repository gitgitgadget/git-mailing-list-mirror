From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/5] Towards a Git to SVN bridge
Date: Tue, 29 Mar 2011 23:43:07 +0530
Message-ID: <1301422392-21177-1-git-send-email-artagnon@gmail.com>
Cc: Peter Baumann <waste.manager@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 29 20:14:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4dRE-0000OF-I4
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 20:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438Ab1C2SOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 14:14:38 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35826 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018Ab1C2SOi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 14:14:38 -0400
Received: by gyd10 with SMTP id 10so187404gyd.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 11:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=Rz3yPlag8eYd0m10FYB+e9l8tUQAjjalkB6L3RqC5bY=;
        b=DqMY0ChnhgT0dqZk+wTn9DbQSKS6zI8m3JJxu651ScBsfnMbVS7HuZnQglT8nUARlS
         On9J9J48arBDlj/ix54k5WAjnjXfYQC9wXxxSnsBy0m8mZLwXjhqDOzEf4oYbKsXvv6m
         wVuUPereKFeX4H+rds5DeYxZirLPnqtXbT6CQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=h67jAumvrOxa9i+cyAhysC0xpQtBK/luzz1oeD7nLACSzWC3iThv8hOQNpsVlBwv4/
         5rc0QkgxI/NaR5GiOc2J71r+plHjojB+Ij6Gww5gLVmIGBVzBnAghRwKFfhB91h/nk3s
         UoSacWn0qSAlFyq94GtHoZ+85+MKgt79H6800=
Received: by 10.151.29.18 with SMTP id g18mr480234ybj.284.1301422477042;
        Tue, 29 Mar 2011 11:14:37 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id o2sm1971669ybn.21.2011.03.29.11.14.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 11:14:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170290>

Hi,

Thanks to Jonathan, Junio, Peter, and Erik among others for reviewing
previous iterations of this series. This iteration should take care of
most error handling and design issues addressed in the previous
iterations- it also comes along with a battery of tests.

Small introduction: svn-fi's design is modelled after git-fast-import.
It aims to be more comprehensive and production-ready than the
existing alternative, git2svn.  It converts a fast-import stream
to a Subversion dumpfile which can be loaded using `svnadmin load` (or
alternatively using `svnrdump load`, which will feature in Subversion
1.7).  The shortcomings can be summarized as follows:
1. dir_cache is a very naive implementation using string_list.  This
will not scale well either in memory or time, and should be replaced
with a prefix tree in future.
2. It currently only supports one branch. For supporting multiple
branches, two things need to be implemented: a branch-specific
dir_cache, and a mapper that maps branch names to directories (if the
standard "trunk", "branches", "tags" layout is not to be hardcoded).
3. Tags are currently unsupported, although it should be trivial to
implement once a mapping is in place.
4. Merges are unsupported.  This requires more thought.
5. The `from` command in the fast-import stream is ignored.  This
should probably be implemented like branching.
6. The data can't make round trips back-and-fourth yet.  Although this
topic has been discussed at length, there is no implementation of this
yet.

Thanks for reading.

-- Ram

Ramkumar Ramachandra (5):
  date: Expose the time_to_tm function
  fast-export: Introduce --inline-blobs
  strbuf: Introduce strbuf_fwrite corresponding to strbuf_fread
  vcs-svn: Introduce svnload, a dumpfile producer
  t9012-svn-fi: Add tests for svn-fi

 .gitignore                        |    1 +
 Documentation/git-fast-export.txt |    5 +
 Makefile                          |    6 +-
 builtin/fast-export.c             |   23 ++-
 cache.h                           |    1 +
 contrib/svn-fe/.gitignore         |    1 +
 contrib/svn-fe/Makefile           |   23 ++-
 contrib/svn-fe/svn-fi.c           |   16 +
 contrib/svn-fe/svn-fi.txt         |   28 ++
 date.c                            |    2 +-
 strbuf.c                          |   11 +
 strbuf.h                          |    1 +
 t/t9012-svn-fi.sh                 |  705 +++++++++++++++++++++++++++++++++++++
 test-svn-fi.c                     |   17 +
 vcs-svn/dir_cache.c               |   52 +++
 vcs-svn/dir_cache.h               |   11 +
 vcs-svn/dump_export.c             |  164 +++++++++
 vcs-svn/dump_export.h             |   26 ++
 vcs-svn/svnload.c                 |  485 +++++++++++++++++++++++++
 vcs-svn/svnload.h                 |   19 +
 20 files changed, 1591 insertions(+), 6 deletions(-)
 create mode 100644 contrib/svn-fe/svn-fi.c
 create mode 100644 contrib/svn-fe/svn-fi.txt
 create mode 100755 t/t9012-svn-fi.sh
 create mode 100644 test-svn-fi.c
 create mode 100644 vcs-svn/dir_cache.c
 create mode 100644 vcs-svn/dir_cache.h
 create mode 100644 vcs-svn/dump_export.c
 create mode 100644 vcs-svn/dump_export.h
 create mode 100644 vcs-svn/svnload.c
 create mode 100644 vcs-svn/svnload.h

-- 
1.7.4.rc1.7.g2cf08.dirty
