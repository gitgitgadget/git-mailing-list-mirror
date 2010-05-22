From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] test get_git_work_tree() return value for NULL
Date: Sat, 22 May 2010 14:21:27 +0200
Message-ID: <20100522122127.GA13372@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 22 14:21:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFni1-0007nn-Oz
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 14:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013Ab0EVMVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 08:21:36 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38968 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868Ab0EVMVf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 08:21:35 -0400
Received: by wyb29 with SMTP id 29so490592wyb.19
        for <git@vger.kernel.org>; Sat, 22 May 2010 05:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:mime-version:content-type:content-disposition
         :user-agent;
        bh=M3DSi9v8qf2Jbx1vQMR/JnF2JzD9ljxhShRPjcygNPk=;
        b=smPIZFMdtiDTQOz84yGrPilB+wnFEJT2D+BNVPZ3bKg7k0PQVCO0vitONuiyYmtV0n
         Qps5WoS2+iOqI6MUmAs2Bhi2X3opleeDDTyiqUjEfZ1f1OauwZHiwSr8zlSuJ2LLlHfe
         kDBGsiC3jQNhJMi0+2meFtI9qYOVJKOFy8FaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        b=gPYs2rFMKMaVV8dRuIRygO862ZNxBoMv7/SFsy9dR9DRvKDE5o9vAVLWIlthXleV+Q
         BXY8vnpZJC18/rcBI1kqo0XIKOu02PCfV1097XcVBOY8ZpBE7gwlY9TMzCDAJBF1EAEW
         H0DqIZTi8v5QdsmRSPdhTn7Mxcd05BwUyjwlw=
Received: by 10.227.141.145 with SMTP id m17mr2713079wbu.51.1274530894179;
        Sat, 22 May 2010 05:21:34 -0700 (PDT)
Received: from darc.lan (p549A3CF7.dip.t-dialin.net [84.154.60.247])
        by mx.google.com with ESMTPS id u36sm15087699wbv.6.2010.05.22.05.21.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 May 2010 05:21:33 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OFnhn-0007Fd-Tv; Sat, 22 May 2010 14:21:27 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147522>

If we are in a git directory, get_git_work_tree() can return NULL.
While trying to determine whether or not the given paths are outside
the work tree, the following command would read from it anyways and
trigger a segmentation fault.

 git diff / /

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 diff-no-index.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index aae8e7a..4cd9dac 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -150,16 +150,14 @@ static int queue_diff(struct diff_options *o,
 
 static int path_outside_repo(const char *path)
 {
-	/*
-	 * We have already done setup_git_directory_gently() so we
-	 * know we are inside a git work tree already.
-	 */
 	const char *work_tree;
 	size_t len;
 
 	if (!is_absolute_path(path))
 		return 0;
 	work_tree = get_git_work_tree();
+	if (!work_tree)
+		return 1;
 	len = strlen(work_tree);
 	if (strncmp(path, work_tree, len) ||
 	    (path[len] != '\0' && path[len] != '/'))
-- 
1.7.0.5.3.ga76e
