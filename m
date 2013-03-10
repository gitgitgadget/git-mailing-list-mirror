From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC/PATCH] Documentation/technical/api-fswatch.txt: start with outline
Date: Mon, 11 Mar 2013 01:47:03 +0530
Message-ID: <1362946623-23649-1-git-send-email-artagnon@gmail.com>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 10 21:16:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEmf9-0008Uy-0g
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 21:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227Ab3CJUPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 16:15:33 -0400
Received: from mail-da0-f52.google.com ([209.85.210.52]:48805 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab3CJUPc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 16:15:32 -0400
Received: by mail-da0-f52.google.com with SMTP id f10so595110dak.39
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 13:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=GcLmeTYmp0yZ9Ww1le3nDptSA/N3/GneiIS7hRImdAQ=;
        b=P2LNsIe9STNdmQt311CGZz4l48ZHOE5hyDj+NKjbmBpxoJrqihMt5XTEEzu7CJdmxd
         MszCDqPoEKslHiQghtFbYGlQK04Q4H3+vdrHjXU1dUzGi6es5+Rld9qamqa7QGD1qiLD
         j2cSzAWyDoD05Qh1my66+Qie9qdjLi3bFUgbiFp1iAr8PAD1MZxK1TTqKGDv/D/aw1a+
         L90HsfdrX2jGLiQFoRneLS4RGQtwYocLgLCEIVl7aLH8KWaPxUhL/Fe7Ya+t5wItVaf3
         JqztRjj1oCoejmU6c5z6zAqEcDF0oIFYd1GjOM2s6Nup7eASUGv9V9ymrN+9UxdnJ29P
         l+sA==
X-Received: by 10.68.228.164 with SMTP id sj4mr21724268pbc.180.1362946531951;
        Sun, 10 Mar 2013 13:15:31 -0700 (PDT)
Received: from localhost.localdomain ([122.174.83.195])
        by mx.google.com with ESMTPS id hs8sm16797982pbc.27.2013.03.10.13.15.28
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 13:15:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217817>

git operations are slow on repositories with lots of files, and lots
of tiny filesystem calls like lstat(), getdents(), open() are
reposible for this.  On the linux-2.6 repository, for instance, the
numbers for "git status" look like this:

  top syscalls sorted     top syscalls sorted
  by acc. time            by number
  ----------------------------------------------
  0.401906 40950 lstat    0.401906 40950 lstat
  0.190484 5343 getdents  0.150055 5374 open
  0.150055 5374 open      0.190484 5343 getdents
  0.074843 2806 close     0.074843 2806 close
  0.003216 157 read       0.003216 157 read

To solve this problem, we propose to build a daemon which will watch
the filesystem using inotify and report batched up events over a UNIX
socket.  Since inotify is Linux-only, we have to leave open the
possibility of writing similar daemons for other platforms.
Everything will continue to work as before if there is no helper
present.

The fswatch API introduces a generic way for git.git to request for
filesystem changes.  Different helpers (like the inotify daemon on
Linux) will be plugged into this API on different platforms.  It falls
back to using the filesystem calls.

The daemon will start up with the very first operation done on the git
repository, and will die after a specified period of repository
inactivity.  It is going to be a per-repo daemon and will write to a
socket in the repository: access control is managed by filesystem
permissions.

This design is inspired by the credential helper design.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/technical/api-fswatch.txt | 62 +++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/technical/api-fswatch.txt

diff --git a/Documentation/technical/api-fswatch.txt b/Documentation/technical/api-fswatch.txt
new file mode 100644
index 0000000..9c6826a
--- /dev/null
+++ b/Documentation/technical/api-fswatch.txt
@@ -0,0 +1,62 @@
+fswatch API
+===========
+
+The fswatch API provides an abstracted way of collecting information
+about filesystem changes.  A remote helper is typically a daemon which
+uses inotify to watch the filesystem, and this information is used by
+git instead of making expensive system calls like lstat(), open().
+
+Typical setup
+-------------
+
+------------
++-----------------------+
+| Git code (C)          |--- requires information about fs changes
+|.......................|
+| C fswatch API         |--- system calls ---> filesystem
++-----------------------+
+     ^             |
+     | UNIX socket |
+     |             v
++-----------------------+
+| Git fswatch helper    |--- daemon inotify-watching ---> filesystem
++-----------------------+
+------------
+
+The Git code will call the C API to obtain changes in filesystem
+information.  The API will itself call a configured helper (e.g. "git
+fswatch-notify") which may run filesystem changes, if the remote
+helper daemon was started in a previous invocation.  If the daemon is
+not already running, it is started, and the C API will fall back to
+making expensive system calls.
+
+C API
+-----
+
+The credential C API is meant to be called by Git code which needs
+information aboutx filesystem changes.  It is centered around an
+object representing the changes the filesystem since the last
+invocation.
+
+Data Structures
+~~~~~~~~~~~~~~~
+
+`struct fschanges`::
+
+	TODO
+
+
+Functions
+~~~~~~~~~
+
+TODO
+
+Example
+~~~~~~~
+
+TODO
+
+fswatch Helpers
+---------------
+
+TODO
-- 
1.8.1.5
