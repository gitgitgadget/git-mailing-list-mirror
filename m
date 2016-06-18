Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 618C71FEAA
	for <e@80x24.org>; Sat, 18 Jun 2016 04:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbcFREPq (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 00:15:46 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:54716 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751239AbcFREPq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2016 00:15:46 -0400
X-AuditID: 1207440d-bb3ff7000000090b-47-5764cae7e18e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id D3.2C.02315.7EAC4675; Sat, 18 Jun 2016 00:15:35 -0400 (EDT)
Received: from michael.fritz.box (p4FEEA991.dip0.t-ipconnect.de [79.238.169.145])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5I4FLJg029401
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jun 2016 00:15:33 -0400
From:	Michael Haggerty <mhagger@alum.mit.edu>
To:	Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
Cc:	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 05/13] remote rm: handle symbolic refs correctly
Date:	Sat, 18 Jun 2016 06:15:11 +0200
Message-Id: <e039bde30ed4481c8ac4266807ec3e660fadaeb5.1466222921.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1466222921.git.mhagger@alum.mit.edu>
References: <cover.1466222921.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqPv8VEq4weJz/BbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2uLMm0ZGBw6Pv+8/MHnsnHWX3eNZ7x5Gj4uXlD32
	L93G5rH4gZfHguf32T0+b5IL4IjitklKLCkLzkzP07dL4M64eHMmY0EPZ0X3s3+sDYyr2LsY
	OTkkBEwkNv6YAGRzcQgJbGWUmLFjJyOEc5JJYs+a2WwgVWwCuhKLepqZQGwRgQiJhlctYEXM
	AnOYJG4/7GQGSQgLOEs0bzoJVsQioCrx8sEnFhCbVyBKYlf7DxaIdXISl6c/ABvKKWAhsWDL
	PqB6DqBt5hJ7FxtOYORZwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXSC83s0QvNaV0EyMk
	6Hh3MP5fJ3OIUYCDUYmHN8A+JVyINbGsuDL3EKMkB5OSKO+VSqAQX1J+SmVGYnFGfFFpTmrx
	IUYJDmYlEd4tJ4ByvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJ3qUn
	gRoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQTEQXwyMApAUD9DeTSDtvMUFiblA
	UYjWU4yKUuK8C0AOEgBJZJTmwY2FpZJXjOJAXwrzvgBp5wGmIbjuV0CDmYAGa85LBhlckoiQ
	kmpgZHlxeVW2w5sHCVqTEyIV9nT2MzeXmUu+irg6Y+GTyIWSAsVu4VsXXij+H5F+9+83rQdB
	8uLv1tsX/l7uZDA5+EVhspqR5t3jlYnxvGXT54WXHZcRzXjyaPEOu8vbT9Y8sNB4v68inzMy
	5baj2lx1P7Vnwu1sRtOj5mtMqgvievZy1fbi8IeSSizFGYmGWsxFxYkAX1+bSgADAAA=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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

