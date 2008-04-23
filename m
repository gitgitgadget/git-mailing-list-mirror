From: Adam Roben <aroben@apple.com>
Subject: Speed up git-svn fetch
Date: Wed, 23 Apr 2008 15:17:42 -0400
Message-ID: <1208978273-98146-1-git-send-email-aroben@apple.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Brian Downing <bdowning@lavos.net>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 21:20:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JokUN-0004sm-RH
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 21:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547AbYDWTR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 15:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753521AbYDWTR5
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 15:17:57 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:49398 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbYDWTR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 15:17:56 -0400
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out3.apple.com (Postfix) with ESMTP id 73DBF293AFFF;
	Wed, 23 Apr 2008 12:17:56 -0700 (PDT)
Received: from relay13.apple.com (unknown [127.0.0.1])
	by relay13.apple.com (Symantec Mail Security) with ESMTP id 5399128050;
	Wed, 23 Apr 2008 12:17:56 -0700 (PDT)
X-AuditID: 1180711d-aab95bb000000ed7-15-480f8b634f6f
Received: from localhost.localdomain (unknown [17.151.126.45])
	by relay13.apple.com (Apple SCV relay) with ESMTP id 51BAA28042;
	Wed, 23 Apr 2008 12:17:55 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.152.g9aeb7
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80240>


I first sent this patch series 6 months ago today [1], then resent it after
some comments from Junio, Johannes, and Brian [2]. Here it is again, addressing
further comments from Junio and Eric.

The point of the series is to speed up git-svn fetch on Cygwin, where forking
is quite slow. In my informal testing, this patch seems to speed things up by
~1.4-~1.7x. We accomplish this by having a single long-lived git-cat-file
process and a single long-lived git-hash-object process for the duration of the
git-svn invocation.

This series is based on top of next.

-Adam

--
 Documentation/git-cat-file.txt    |   43 +++++++-
 Documentation/git-hash-object.txt |    5 +-
 builtin-cat-file.c                |  153 ++++++++++++++++++++++++---
 git-svn.perl                      |   42 ++++----
 hash-object.c                     |   44 ++++++++-
 perl/Git.pm                       |  208 ++++++++++++++++++++++++++++++++++++-
 t/t1006-cat-file.sh               |  181 ++++++++++++++++++++++++++++++++
 t/t1007-hash-object.sh            |  139 +++++++++++++++++++++++++
 t/t5303-hash-object.sh            |   35 ------
 9 files changed, 768 insertions(+), 82 deletions(-)
