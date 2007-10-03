From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 0/5, resend] fork/exec removal series
Date: Wed,  3 Oct 2007 22:09:35 +0200
Message-ID: <1191442180-15905-1-git-send-email-johannes.sixt@telecom.at>
References: <200709302340.17644.johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 03 22:09:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdAXZ-0003Ig-Fj
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 22:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908AbXJCUJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 16:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752791AbXJCUJm
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 16:09:42 -0400
Received: from smtp3.srv.eunet.at ([193.154.160.89]:33591 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbXJCUJm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 16:09:42 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 7013110B299;
	Wed,  3 Oct 2007 22:09:40 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.1134.gee562
In-Reply-To: <200709302340.17644.johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59873>

Here is a series of patches that removes a number fork/exec pairs.
They are replaced by delegating to start_command/finish_command/run_command.

I've addressed all issues that were raised. However, concerning whether
git_connect() shoud return NULL or not, I decided to stay with my earlier
approach to return NULL for non-forking connections. Consequently, I had to
remove all error checks because there is now no unique value that can
indicate failure. The motivation is that the alternate approach (to always
return non-NULL for any successful connection and NULL for failure) would
benefit *only* libification; but *if* that ever happens, a major audit
(and possibly) rewrite in the callers has to be done anyway because
currently we are juggling, leaking, and double-closing file descriptors
like mad - in error paths and normal paths.

Patch 2 depends on Patch 1; otherwise, there are no dependencies.
The series goes on top of 'master'. Note that 'next' has an additional
call of git_connect() in the new transport.c.

 builtin-archive.c |    8 +--
 cache.h           |    4 +-
 connect.c         |  128 +++++++++++++++++++++++++---------------------------
 convert.c         |   30 +++----------
 diff.c            |   38 +--------------
 fetch-pack.c      |   43 +++++------------
 peek-remote.c     |    8 +--
 send-pack.c       |    8 +--
 8 files changed, 96 insertions(+), 171 deletions(-)

-- Hannes
