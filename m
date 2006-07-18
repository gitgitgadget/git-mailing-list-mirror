From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] upload-pack: fix timeout in create_pack_file
Date: Tue, 18 Jul 2006 19:14:51 +0200
Message-ID: <E1G2t9n-0005PW-72@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jul 18 19:15:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2t9u-0002BN-7X
	for gcvg-git@gmane.org; Tue, 18 Jul 2006 19:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWGRROz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Jul 2006 13:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWGRROy
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Jul 2006 13:14:54 -0400
Received: from moooo.ath.cx ([85.116.203.178]:4283 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932313AbWGRROy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Jul 2006 13:14:54 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23996>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
<yacc> fatal: packfile '../linux-2.6/.git/objects/pack/tmp-7iPJo5'
       SHA1 mismatch
<yacc> error: git-fetch-pack: unable to read from git-index-pack
<yacc> error: git-index-pack died with error code 128
<yacc> Any idea what this means?
This happens after ~12 minutes.  The problem is that the loop in
upload-pack.c actually sending the pack does not reset the timeout.
I'd guess --timeout is 600 or a bit more on git.kernel.org :)

This does not help for low timeouts with slow clients.  If a client is
slow enough so the server is blocked for more time than specified by
timeout the connection will be closed too (e.g. 15kb/s with a timeout
of 30 (git adds 10 extra) is not enough).  We should either add a
warning to the man page or try to fix this.  I don't know if this can
be fixed not using non-blocking sockets.

Perhaps support for resume would be quite useful too but I've no idea
how hard this is to implement.

A workaround for is to pull a part of the repository first and the
rest later.  For example using this:
$ git init-db
$ git fetch URL refs/tags/old-tag:refs/tags/old-tag
$ git fetch URL refs/tags/newer-tag:refs/tags/newer-tag
..
---
 upload-pack.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index f6f5a7e..07ecdb4 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -182,6 +182,8 @@ static void create_pack_file(void)
 		ssize_t sz;
 		int pe, pu, pollsize;
 
+		reset_timeout();
+
 		pollsize = 0;
 		pe = pu = -1;
 
-- 
1.4.2.rc1.ge7a0
