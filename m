From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 11/13] for_each_reflog(): don't abort for bad references
Date: Fri,  3 Jun 2016 14:33:51 +0200
Message-ID: <2ef290baec6d7114e230ca09a3c59d09e6ade9aa.1464957077.git.mhagger@alum.mit.edu>
References: <cover.1464957077.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 14:34:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8oJ5-0005H2-KK
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 14:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbcFCMe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 08:34:27 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:49582 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932526AbcFCMeX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 08:34:23 -0400
X-AuditID: 12074413-473ff700000008c7-d9-5751794df62e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 93.23.02247.D4971575; Fri,  3 Jun 2016 08:34:21 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53CXtiv005761
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 08:34:19 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464957077.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqOtbGRhusPGIhMX8TScYLbqudDNZ
	NPReYba4vWI+s0X3lLeMFj9aepgtZl61tjjzppHRgcPj7/sPTB47Z91l93jWu4fR4+IlZY/9
	S7exeSx+4OWx4Pl9do/Pm+QCOKK4bZISS8qCM9Pz9O0SuDNmXD3MVtDLWXHl+lXGBsYl7F2M
	nBwSAiYSJ04vZexi5OIQEtjKKPH3xgsWkISQwHEmiR9HHEBsNgFdiUU9zUwgtohAhETDqxaw
	BmaBOUwStx92MoMkhAW8Je7+mAhWxCKgKrHy/kywDbwCURIHd9xjhdgmJ3F5+gM2EJtTwEKi
	794Pdohl5hIP5+xmn8DIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrrlebmaJXmpK6SZG
	SNAJ72DcdVLuEKMAB6MSD++KBQHhQqyJZcWVuYcYJTmYlER5z58FCvEl5adUZiQWZ8QXleak
	Fh9ilOBgVhLh/VMQGC7Em5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLg
	Na8AahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHxUB8MTAKQFI8QHsrQNp5iwsS
	c4GiEK2nGBWlxHmFQRICIImM0jy4sbBU8opRHOhLYV4fkCoeYBqC634FNJgJaHDBI3+QwSWJ
	CCmpBsa2XiEzr7PFqzIW+oXnlFk6O4ZP+7zfb9USoyqliK4JrjOUa89vOyUWH6D9bc67/tlz
	PxhLfZO5dbzwapiarQCjZnAGy1ZGEeXCKy5q2kr7y9f8XLN75ieHc9JzwpOzN5l9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296324>

If there is a file under "$GIT_DIR/logs" with no corresponding
reference, the old code was emitting an error message, aborting the
reflog iteration, and returning -1. But

* None of the callers was checking the exit value

* The callers all want to find all legitimate reflogs (sometimes for the
  purpose of determining object reachability!) and wouldn't benefit from
  a truncated iteration anyway.

So instead, emit an error message and skip the "broken" reflog, but
continue with the iteration.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index cd8c7ee..e8dd9d1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3324,7 +3324,7 @@ static int do_for_each_reflog(struct strbuf *name, each_ref_fn fn, void *cb_data
 				struct object_id oid;
 
 				if (read_ref_full(name->buf, 0, oid.hash, NULL))
-					retval = error("bad ref for %s", name->buf);
+					error("bad ref for %s", name->buf);
 				else
 					retval = fn(name->buf, &oid, 0, cb_data);
 			}
-- 
2.8.1
