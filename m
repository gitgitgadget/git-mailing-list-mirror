Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B352520179
	for <e@80x24.org>; Sat, 18 Jun 2016 04:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbcFREP6 (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 00:15:58 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:58383 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750868AbcFREPs (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2016 00:15:48 -0400
X-AuditID: 12074412-52fff700000009f7-54-5764caf3dbde
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 88.D6.02551.3FAC4675; Sat, 18 Jun 2016 00:15:47 -0400 (EDT)
Received: from michael.fritz.box (p4FEEA991.dip0.t-ipconnect.de [79.238.169.145])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5I4FLJm029401
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jun 2016 00:15:46 -0400
From:	Michael Haggerty <mhagger@alum.mit.edu>
To:	Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
Cc:	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 11/13] for_each_reflog(): don't abort for bad references
Date:	Sat, 18 Jun 2016 06:15:17 +0200
Message-Id: <372c42ae0618a3d1f1b42797ca9878adf277fa54.1466222921.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1466222921.git.mhagger@alum.mit.edu>
References: <cover.1466222921.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsUixO6iqPv5VEq4wecOE4v5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh77
	l25j81j8wMtjwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGdc2veevaCXs+LtmQ3sDYxL2LsY
	OTkkBEwkZq5+w9bFyMUhJLCVUWLznlnsEM5JJok1f94xglSxCehKLOppZgKxRQQiJBpetTCC
	FDELzGGSuP2wk7mLkYNDWMBbYtO3apAaFgFViRk/d4Nt4BWIkrj4cCYzxDY5icvTH7CB2JwC
	FhILtuxjAmkVEjCX2LvYcAIjzwJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFumZ6uZkleqkp
	pZsYISEntINx/Um5Q4wCHIxKPLwB9inhQqyJZcWVuYcYJTmYlER5r1QChfiS8lMqMxKLM+KL
	SnNSiw8xSnAwK4nwbjkBlONNSaysSi3Kh0lJc7AoifP+XKzuJySQnliSmp2aWpBaBJOV4eBQ
	kuBdehKoUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4UAfHFwBgASfEA7X0C0s5b
	XJCYCxSFaD3FqCglzvsMJCEAksgozYMbC0skrxjFgb4U5lUGphUhHmASgut+BTSYCWiw5rxk
	kMEliQgpqQbG6JiIEFFPk1aenz3zf7RZNy1oNPBddOZuc6kn15ZHh+RlL151OrrqrrPmi0v5
	y+vMmpbxVnVqSB79pXh+/xYRd+llBubV8lbf5D+tK5rzYHnQb3uJhCn5Coz9szu2dLO+z5DI
	DfVU2Lemh6ExwzlMjIe91rAmL0x2A1OI1CHfBadP2n08vESJpTgj0VCLuag4EQBHYIoV/wIA
	AA==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
index 4232da8..ab40db3 100644
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

