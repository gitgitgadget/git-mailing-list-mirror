From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 0/14] fork/exec removal series
Date: Sat, 13 Oct 2007 22:06:10 +0200
Message-ID: <1192305984-22594-1-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 13 22:06:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgnFv-0008MX-FS
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 22:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757378AbXJMUG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 16:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756733AbXJMUG2
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 16:06:28 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:52566 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbXJMUG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 16:06:27 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 0DD1913A400;
	Sat, 13 Oct 2007 22:06:24 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.1134.gee562
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60757>

Junio,

here is a series of patches that removes a number fork/exec pairs.

The series consists of 2 parts:

- The first half replaces a number of fork/exec pairs by start_command/
  finish_command or run_command.

- The second half introduces a new framework that runs a function
  asynchronously. New functions start_async and finish_async are implemented
  similarly to start_command and run_command. They are used to replace
  occurrences of fork() that does not exec() in the child. Such code
  could in principle be run in a thread, and on MinGW port we will go this
  route, but on Posix we stay with fork().

The series can be applied on top of 2b5a06e (Restore default verbosity for
http fetches), as you reqested, but that commit does not compile, so I
developed it on 90446a00 (bundle transport: fix an alloc_ref() call),
which is a few commits earlier.

There will be some strbuf related merge conflicts once you merge this into
master.

 builtin-archive.c     |    8 +-
 builtin-fetch-pack.c  |  101 +++++++++----------------
 cache.h               |    4 +-
 connect.c             |  131 ++++++++++++++++-----------------
 convert.c             |   87 ++++++++--------------
 diff.c                |   38 +---------
 peek-remote.c         |    8 +-
 run-command.c         |   79 +++++++++++++++++---
 run-command.h         |   24 ++++++
 send-pack.c           |    8 +-
 t/t0021-conversion.sh |    7 ++-
 transport.c           |    9 +--
 upload-pack.c         |  199 ++++++++++++++++++++++---------------------------
 13 files changed, 334 insertions(+), 369 deletions(-)

-- Hannes
