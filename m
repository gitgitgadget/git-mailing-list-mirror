From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH] poll/select: prevent busy-waiting
Date: Mon, 28 Apr 2014 13:42:24 +0200
Organization: <)><
Message-ID: <20140428114224.GA11186@camelia.ucw.cz>
References: <20140428083931.GA10257@camelia.ucw.cz> <CABPQNSaC30p7TEOvc85u=+skjrFj17182vWWSL=QNVuvzVFE=w@mail.gmail.com> <20140428113815.GA10559@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Theodore Leblond <theodore.leblond@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 13:42:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejxF-00026X-Tc
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 13:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957AbaD1Lma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 07:42:30 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:52031 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572AbaD1Lm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 07:42:26 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 6DB2E1C0093;
	Mon, 28 Apr 2014 13:42:25 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s3SBgPAb011209;
	Mon, 28 Apr 2014 13:42:25 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s3SBgOSX011208;
	Mon, 28 Apr 2014 13:42:25 +0200
Content-Disposition: inline
In-Reply-To: <20140428113815.GA10559@camelia.ucw.cz>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247302>

From: Paolo Bonzini <bonzini@gnu.org>
Date: Mon, 21 May 2012 09:52:42 +0200

Backported from Gnulib.

2012-05-21  Paolo Bonzini  <bonzini@gnu.org>

	poll/select: prevent busy-waiting.  SwitchToThread() only gives away
	the rest of the current time slice to another thread in the current
	process. So if the thread that feeds the file decscriptor we're
	polling is not in the current process, we get busy-waiting.
	* lib/poll.c: Use SleepEx(1, TRUE) instead of SwitchToThread().
	Patch from Theodore Leblond.
	* lib/select.c: Split polling out of the loop that sets the output
	fd_sets.  Check for zero result and loop if the wait timeout is
	infinite.

Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/poll/poll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index 31163f2..a9b41d8 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -605,7 +605,7 @@ restart:
 
   if (!rc && timeout == INFTIM)
     {
-      SwitchToThread();
+      SleepEx (1, TRUE);
       goto restart;
     }
 
-- 
1.9.2.msysgit.0.158.g6070cee
