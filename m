From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 11/13] for_each_reflog(): don't abort for bad references
Date: Mon, 30 May 2016 09:55:32 +0200
Message-ID: <6228ed402dbdf9f937cb504aff6bbf8849771c54.1464537050.git.mhagger@alum.mit.edu>
References: <cover.1464537050.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon May 30 09:56:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7I3i-0001Mf-TZ
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 09:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697AbcE3H4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 03:56:17 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:53642 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932685AbcE3H4L (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 03:56:11 -0400
X-AuditID: 12074411-e3fff70000000955-5f-574bf2147974
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id B4.30.02389.412FB475; Mon, 30 May 2016 03:56:04 -0400 (EDT)
Received: from michael.fritz.box (p508EADDB.dip0.t-ipconnect.de [80.142.173.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u4U7tgS2032144
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 30 May 2016 03:56:03 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464537050.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqCvyyTvcoOu5psX8TScYLbqudDNZ
	NPReYba4vWI+s0X3lLeMFj9aepgd2Dz+vv/A5LFz1l12j2e9exg9Ll5S9ljw/D67x+dNcgFs
	Udw2SYklZcGZ6Xn6dgncGZPe/WMu6OWsWHRsHmMD4xL2LkZODgkBE4lr+88ygthCAlsZJc5d
	1+9i5AKyTzJJ9JzbxgaSYBPQlVjU08wEYosIREg0vGphBCliFtjHKHFy3XyWLkYODmEBD4mt
	2/1BalgEVCX6Hh5iBbF5BaIkfp//zwKxTE7i8vQHYDM5BSwkJs56xwSx2Fxi2cyTzBMYeRYw
	MqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXVy80s0UtNKd3ECAknwR2MM07KHWIU4GBU4uEt
	0PQOF2JNLCuuzD3EKMnBpCTK68YBFOJLyk+pzEgszogvKs1JLT7EKMHBrCTC+/YxUI43JbGy
	KrUoHyYlzcGiJM7Lt0TdT0ggPbEkNTs1tSC1CCYrw8GhJMEr/BGoUbAoNT21Ii0zpwQhzcTB
	CTKcS0qkODUvJbUosbQkIx4UAfHFwBgASfEA7d3/AWRvcUFiLlAUovUUoy7Hkf331jIJseTl
	56VKifPagxQJgBRllObBrYAlj1eM4kAfC/O6glzCA0w8cJNeAS1hAlpids4LZElJIkJKqoFx
	ziIm5+vKL14Yv923LEzfW/2H3s9D7kZfHP9vOe1hd5ttMQPTIo24Yw839K0v2Lu97syK9H9q
	TUVleo7LouWeMgj4vg6/YdA7mSVnL4er+7ErVVpiqwXD2RctfaiqZM2QtSg6fc6a 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295865>

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
index c48a006..a7cc0e2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3325,7 +3325,7 @@ static int do_for_each_reflog(struct strbuf *name, each_ref_fn fn, void *cb_data
 				struct object_id oid;
 
 				if (read_ref_full(name->buf, 0, oid.hash, NULL))
-					retval = error("bad ref for %s", name->buf);
+					error("bad ref for %s", name->buf);
 				else
 					retval = fn(name->buf, &oid, 0, cb_data);
 			}
-- 
2.8.1
