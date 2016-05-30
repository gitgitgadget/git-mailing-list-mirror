From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/13] remote rm: handle symbolic refs correctly
Date: Mon, 30 May 2016 09:55:26 +0200
Message-ID: <157904e27af9c3377b21376c301f3e16ba6a5aa2.1464537050.git.mhagger@alum.mit.edu>
References: <cover.1464537050.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon May 30 09:56:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7I4F-0001ai-7x
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 09:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737AbcE3H4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 03:56:32 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:50408 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932192AbcE3Hz4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 03:55:56 -0400
X-AuditID: 1207440e-f07ff700000008c5-cf-574bf20ab6d5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id B5.F7.02245.A02FB475; Mon, 30 May 2016 03:55:54 -0400 (EDT)
Received: from michael.fritz.box (p508EADDB.dip0.t-ipconnect.de [80.142.173.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u4U7tgRu032144
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 30 May 2016 03:55:52 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464537050.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqMv1yTvcYNsbCYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DA7sHn8ff+ByWPnrLvsHs969zB6XLyk7LHg+X12j8+b5ALY
	orhtkhJLyoIz0/P07RK4My7enMlY0MNZ0f3sH2sD4yr2LkZODgkBE4lXiyYzdTFycQgJbGWU
	WP1vERuEc5JJYuurLywgVWwCuhKLepqZQGwRgQiJhlctjCBFzAL7GCVOrpsPViQs4CBxdPsc
	RhCbRUBV4vanx2AreAWiJC7MPsAKsU5O4vL0B2wgNqeAhcTEWe/AhgoJmEssm3mSeQIjzwJG
	hlWMcok5pbm6uYmZOcWpybrFyYl5ealFusZ6uZkleqkppZsYISHFt4Oxfb3MIUYBDkYlHt4C
	Te9wIdbEsuLK3EOMkhxMSqK8bhxAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8bx8D5XhTEiur
	UovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErxNH4AaBYtS01Mr0jJzShDSTByc
	IMO5pESKU/NSUosSS0sy4kFREF8MjAOQFA/Q3v0g7bzFBYm5QFGI1lOMuhxH9t9byyTEkpef
	lyolzmsPUiQAUpRRmge3ApZAXjGKA30szHsCpIoHmHzgJr0CWsIEtMTsnBfIkpJEhJRUAyPb
	R+/Dt67/Y9jiy7H6YF17ctpTs88iUzj+LWUNXbtPyH6tbcBG7t+zHq0snFVrv3sN26okP50l
	wlrbWWLz9u7a312x9/hpm8RLIeaPSqNc/0wt6dVIM33yInXJ9uyQT4JLWCzvyJnv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295869>

In the modern world of reference backends, it is not OK to delete a
symref by unlink()ing the file directly. This must be done via the refs
API.

We do so by adding the symref to the list of references to delete along
with the non-symbolic references, then calling delete_refs() with the
new flags option set to REF_NODEREF.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/remote.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 1bbf9b4..c4b4d67 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -539,10 +539,6 @@ static int add_branch_for_removal(const char *refname,
 		return 0;
 	}
 
-	/* make sure that symrefs are deleted */
-	if (flags & REF_ISSYMREF)
-		return unlink(git_path("%s", refname));
-
 	string_list_append(branches->branches, refname);
 
 	return 0;
@@ -788,7 +784,7 @@ static int rm(int argc, const char **argv)
 	strbuf_release(&buf);
 
 	if (!result)
-		result = delete_refs(&branches, 0);
+		result = delete_refs(&branches, REF_NODEREF);
 	string_list_clear(&branches, 0);
 
 	if (skipped.nr) {
-- 
2.8.1
