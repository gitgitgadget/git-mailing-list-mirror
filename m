From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Fix in-place editing in crlf_to_git and ident_to_git.
Date: Fri, 05 Oct 2007 10:20:26 +0200
Message-ID: <20071005082026.GE19879@artemis.corp>
References: <87wsu2sad0.fsf@gollum.intra.norang.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bernt Hansen <bernt@alumni.uwaterloo.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 10:21:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdiQY-0007en-3y
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 10:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804AbXJEIUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 04:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752616AbXJEIUa
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 04:20:30 -0400
Received: from pan.madism.org ([88.191.52.104]:49143 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752609AbXJEIU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 04:20:28 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 5D01923805;
	Fri,  5 Oct 2007 10:20:27 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id EC8A73D84; Fri,  5 Oct 2007 10:20:26 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>
Content-Disposition: inline
In-Reply-To: <87wsu2sad0.fsf@gollum.intra.norang.ca>
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60046>

When crlf_to_git or ident_to_git are called "in place", the buffer already
is big enough and should not be resized (as it could make the buffer address
change, hence invalidate the `src' pointers !).

Also fix the growth length at the same time: we want to replace the buffer
content (not append) in those functions as they are filters.

Thanks to Bernt Hansen for the bug report.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

  This patch is done on top of master, as strbuf's have been merged.
This is a major issue.

 convert.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/convert.c b/convert.c
index 0d5e909..4664197 100644
--- a/convert.c
+++ b/convert.c
@@ -110,7 +110,9 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 			return 0;
 	}
 
-	strbuf_grow(buf, len);
+	/* only grow if not in place */
+	if (src != buf->buf)
+		strbuf_grow(buf, len - buf->len);
 	dst = buf->buf;
 	if (action == CRLF_GUESS) {
 		/*
@@ -281,12 +283,12 @@ static int apply_filter(const char *path, const char *src, size_t len,
 		ret = 0;
 	}
 	if (close(pipe_feed[0])) {
-		ret = error("read from external filter %s failed", cmd);
+		error("read from external filter %s failed", cmd);
 		ret = 0;
 	}
 	status = finish_command(&child_process);
 	if (status) {
-		ret = error("external filter %s failed %d", cmd, -status);
+		error("external filter %s failed %d", cmd, -status);
 		ret = 0;
 	}
 
@@ -422,7 +424,9 @@ static int ident_to_git(const char *path, const char *src, size_t len,
 	if (!ident || !count_ident(src, len))
 		return 0;
 
-	strbuf_grow(buf, len);
+	/* only grow if not in place */
+	if (src != buf->buf)
+		strbuf_grow(buf, len - buf->len);
 	dst = buf->buf;
 	for (;;) {
 		dollar = memchr(src, '$', len);
-- 
1.5.3.4.207.gc79d4-dirty
