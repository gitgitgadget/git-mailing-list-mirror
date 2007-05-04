From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Small correction in reading of commit headers
Date: Fri, 4 May 2007 23:51:32 +0200
Message-ID: <20070504215132.GD4033@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 04 23:51:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk5gh-0006rB-7U
	for gcvg-git@gmane.org; Fri, 04 May 2007 23:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S376156AbXEDVvg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 17:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S376158AbXEDVvg
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 17:51:36 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:46225 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S376156AbXEDVvf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 17:51:35 -0400
Received: from tigra.home (195.4.202.37)
	by post.webmailer.de (fruni mo23) (RZmta 5.9)
	with ESMTP id B04920j44L8p5D ; Fri, 4 May 2007 23:51:32 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 9DD6E277BD;
	Fri,  4 May 2007 23:51:32 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 701CFD171; Fri,  4 May 2007 23:51:32 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTl9Ag==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46220>

Check if a line of the header has enough characters to possibly
contain the requested prefix.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Noticed by debugging git-log crash in broken repos with
missing packs. It happened to be up in backtrace.
At the moment the optimization is actually a slow down:
no line in the header is shorter than the only key this
function is ever asked for: encoding. But, in case the
function ever gets asked for something longer, the old
condition is just wrong: it does not take into account
the amount of data in the line when comparing with key.

 commit.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/commit.c b/commit.c
index aa7059c..d01833d 100644
--- a/commit.c
+++ b/commit.c
@@ -638,7 +638,9 @@ static char *get_header(const struct commit *commit, const char *key)
 			next = NULL;
 		} else
 			next = eol + 1;
-		if (!strncmp(line, key, key_len) && line[key_len] == ' ') {
+		if (eol - line > key_len &&
+		    !strncmp(line, key, key_len) &&
+		    line[key_len] == ' ') {
 			int len = eol - line - key_len;
 			char *ret = xmalloc(len);
 			memcpy(ret, line + key_len + 1, len - 1);
-- 
1.5.2.rc1.21.g80e79
