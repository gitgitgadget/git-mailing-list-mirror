From: Adam Roben <aroben@apple.com>
Subject: [PATCH 0/9] Make git-svn fetch ~1.7x faster
Date: Mon, 22 Oct 2007 22:46:28 -0700
Message-ID: <1193118397-4696-1-git-send-email-aroben@apple.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 07:47:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkCbt-0007N2-CH
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 07:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbXJWFrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 01:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbXJWFrM
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 01:47:12 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:61930 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbXJWFrL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 01:47:11 -0400
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out3.apple.com (Postfix) with ESMTP id 241BB15F2464;
	Mon, 22 Oct 2007 22:47:11 -0700 (PDT)
Received: from relay14.apple.com (unknown [127.0.0.1])
	by relay14.apple.com (Symantec Mail Security) with ESMTP id 078DD28050;
	Mon, 22 Oct 2007 22:47:11 -0700 (PDT)
X-AuditID: 11807134-a665bbb000000c52-5b-471d8ade404f
Received: from localhost.localdomain (aroben3.apple.com [17.203.12.72])
	by relay14.apple.com (Apple SCV relay) with ESMTP id D9ADE2804C;
	Mon, 22 Oct 2007 22:47:10 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.1333.ga2f32
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62098>


This patch series makes git-svn fetch about 1.7x faster by reducing the number
of forks/execs that occur for each file retrieved from Subversion. To do so, a
few new options are added to git-cat-file and git-hash-object to allow
continuous input on stdin and continuous output on stdout, so that one instance
of each of these commands can be kept running for the duration of the fetch.

The series is based on top of next. I considered basing it on top of the
parse_options work since I touch the option parsing in these two commands, but
I didn't know how wise it would be to base a patch series on something in pu.

I tried to add some new tests for cat-file and hash-object to ensure that I
didn't break old behavior, but I'm not very experienced with the git test suite
and I'm sure my tests could use some improvement. This is the most invasive
change I've yet made to git, so comments are more than welcome.

-Adam

--
 Documentation/git-cat-file.txt    |   11 +++-
 Documentation/git-hash-object.txt |    5 +-
 builtin-cat-file.c                |   96 +++++++++++++++++++++----
 git-svn.perl                      |   94 +++++++++++++++++++------
 hash-object.c                     |   29 ++++++++-
 perl/Git.pm                       |   56 +++++++++++++++
 t/t1005-cat-file.sh               |  139 +++++++++++++++++++++++++++++++++++++
 t/t1006-hash-object.sh            |   49 +++++++++++++
 8 files changed, 438 insertions(+), 41 deletions(-)
--
