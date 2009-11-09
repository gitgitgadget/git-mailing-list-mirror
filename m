From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/3] http-backend: Fix symbol clash on AIX 5.3
Date: Mon,  9 Nov 2009 10:10:35 -0800
Message-ID: <1257790237-30850-1-git-send-email-spearce@spearce.org>
Cc: Mike Ralphson <mike.ralphson@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 09 19:10:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7YhS-0007ma-H2
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 19:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbZKISKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 13:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbZKISKd
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 13:10:33 -0500
Received: from george.spearce.org ([209.20.77.23]:39664 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbZKISKc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 13:10:32 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 717B0381FE; Mon,  9 Nov 2009 18:10:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 01E85380E7
	for <git@vger.kernel.org>; Mon,  9 Nov 2009 18:10:37 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.351.g09432
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132499>

Mike says:
> > +static void send_file(const char *the_type, const char *name)
> > +{
>
> I think a symbol clash here is responsible for a build breakage in
> next on AIX 5.3:
>
> CC http-backend.o
> http-backend.c:213: error: conflicting types for `send_file'
> /usr/include/sys/socket.h:676: error: previous declaration of `send_file'
> gmake: *** [http-backend.o] Error 1

So we rename the function send_local_file().

Reported-by: Mike Ralphson <mike.ralphson@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 http-backend.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 9021266..646e910 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -209,7 +209,7 @@ static void send_strbuf(const char *type, struct strbuf *buf)
 	safe_write(1, buf->buf, buf->len);
 }
 
-static void send_file(const char *the_type, const char *name)
+static void send_local_file(const char *the_type, const char *name)
 {
 	const char *p = git_path("%s", name);
 	size_t buf_alloc = 8192;
@@ -247,28 +247,28 @@ static void get_text_file(char *name)
 {
 	select_getanyfile();
 	hdr_nocache();
-	send_file("text/plain", name);
+	send_local_file("text/plain", name);
 }
 
 static void get_loose_object(char *name)
 {
 	select_getanyfile();
 	hdr_cache_forever();
-	send_file("application/x-git-loose-object", name);
+	send_local_file("application/x-git-loose-object", name);
 }
 
 static void get_pack_file(char *name)
 {
 	select_getanyfile();
 	hdr_cache_forever();
-	send_file("application/x-git-packed-objects", name);
+	send_local_file("application/x-git-packed-objects", name);
 }
 
 static void get_idx_file(char *name)
 {
 	select_getanyfile();
 	hdr_cache_forever();
-	send_file("application/x-git-packed-objects-toc", name);
+	send_local_file("application/x-git-packed-objects-toc", name);
 }
 
 static int http_config(const char *var, const char *value, void *cb)
-- 
1.6.5.2.351.g09432
