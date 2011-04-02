From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Try to remove the given path even if it can't be opened
Date: Sat, 2 Apr 2011 22:09:20 +0200
Message-ID: <20110402200920.GA18171@blimp.dmz>
References: <AANLkTikfmXiZQquWi4STTCUy0qoY9J_waJ44nrPAvB1d@mail.gmail.com>
 <7vy63tg7yz.fsf@alter.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 22:09:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q678q-00047A-7N
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 22:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756558Ab1DBUJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2011 16:09:37 -0400
Received: from mout1.freenet.de ([195.4.92.91]:35744 "EHLO mout1.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756239Ab1DBUJg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2011 16:09:36 -0400
Received: from [195.4.92.19] (helo=9.mx.freenet.de)
	by mout1.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.72 #3)
	id 1Q678P-0004Zo-HN; Sat, 02 Apr 2011 22:09:25 +0200
Received: from krlh-4d037963.pool.mediaways.net ([77.3.121.99]:56436 helo=tigra.home)
	by 9.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 25) (Exim 4.72 #3)
	id 1Q678P-0008L7-DN; Sat, 02 Apr 2011 22:09:25 +0200
Received: from blimp.localdomain (unknown [192.168.0.94])
	by tigra.home (Postfix) with ESMTP id D44899FE78;
	Sat,  2 Apr 2011 22:09:20 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 72345E5D; Sat,  2 Apr 2011 22:09:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vy63tg7yz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170661>

Consider unreadable empty directories. rmdir(2) will remove
them just fine, assuming the parent directory is modifiable.

Noticed by Linus.
Fix suggested by Michael Gruber and Linus.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
Junio C Hamano, Fri, Apr 01, 2011 20:08:36 +0200:
> 
> Please don't do an attachment that has an inline patch and then attach the
> patch itself again in base64.  It is extremely annoying.

Sorry. Hard to notice on GMail.

The extended error information is a little bit tricky: there is at least four
error cases (opendir, stat, unlink and rmdir) and there is a closedir, which
resets errno to output the error in the caller of remove_dir_recursively.

 dir.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dir.c b/dir.c
index 325fb56..532bcb6 100644
--- a/dir.c
+++ b/dir.c
@@ -1192,7 +1192,7 @@ int remove_dir_recursively(struct strbuf *path, int flag)
 
 	dir = opendir(path->buf);
 	if (!dir)
-		return -1;
+		return rmdir(path->buf);
 	if (path->buf[original_len - 1] != '/')
 		strbuf_addch(path, '/');
 
-- 
1.7.4
