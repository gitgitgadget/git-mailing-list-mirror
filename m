Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8F4147C9B
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 20:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550772; cv=none; b=BIP5J5YxBHEj0Mtq/mkg5vsYj4Ztu1K5M6gIZCLIKVw3vDUQBL9QeV4hM0wkV8FSTNJk9iGgUy2HKbqXCxMK+sA4hg33CTMfyBlwT7pyReVSURxx+/ucI2LjynuoYqzOgZRtqqPkcs3X/Em6JCYUBXABf24GxmhgYj5IfdB4by4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550772; c=relaxed/simple;
	bh=hp1Kg5m2FT4ilQ7fy44pe9/+7ZhwF4iO4zPTpjeQ0fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZ/oZFDdmXrR9N1p/+luAi/0NL2LO9+zvVyCcGDCtLKWyTBFIKnU61nFbeklKMvTknFGvCVNWodtU9L/InDfM0zX5k+SDZHQU2ZwdjOkf/glOmsF+yViD7oieBldFUY3REWJkZylhdnpYIkeVyslvWxJQWvu/N5LYfj6YNmhfig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FAYJ3JmH; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FAYJ3JmH"
Received: (qmail 23264 invoked by uid 109); 18 Aug 2025 20:59:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=hp1Kg5m2FT4ilQ7fy44pe9/+7ZhwF4iO4zPTpjeQ0fI=; b=FAYJ3JmHg6zQMBENnzfH5PAVHKvXiunfkitpk2DVf2Gsk8QpjmPXtNdgYoxxKm3e41N/32/KOIEhV88ooOOaHVdlgsbADBAzw7/XhwaY4Cu4e/7A5AP7KoEBvyHMuzptMGhfG7z8EUZ44j5ef53W+7grXQr0JhNfB53eYpQ7lNeWhaMdbscXjKrGZ12eSpo5SLScpCSNOtcYKLbk+pjhsmTuQXRMi3wols/wysph7ponfFX7pJufXDDbz5xFwQ2IrxEoQHTDqAZaFdu9vk63FPR1iUWrKpZY+z3B+ZyBecw76W9x4DVIl2Ro2d1jjYzaFgeWz8Htwax5EM96MwEf+Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Aug 2025 20:59:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30268 invoked by uid 111); 18 Aug 2025 20:59:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Aug 2025 16:59:29 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 18 Aug 2025 16:59:29 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: phillip.wood@dunelm.org.uk, Cheng <prophecheng@stu.pku.edu.cn>,
	git@vger.kernel.org
Subject: [PATCH 1/5] describe: pass oid struct by const pointer
Message-ID: <20250818205929.GA1024556@coredump.intra.peff.net>
References: <20250818205812.GA1018043@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250818205812.GA1018043@coredump.intra.peff.net>

We pass a "struct object_id" to describe_blob() by value. This isn't
wrong, as an oid is composed only of copy-able values. But it's unusual;
typically we pass structs by const pointer, including object_ids. Let's
do so.

It similarly makes sense for us to hold that pointer in the callback
data (rather than yet another copy of the oid).

Signed-off-by: Jeff King <peff@peff.net>
---
Not strictly related, but I noticed while in the area and remembered a
recent discussion in this direction.

 builtin/describe.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index d7dd8139de..383d3e6b9a 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -490,7 +490,7 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 
 struct process_commit_data {
 	struct object_id current_commit;
-	struct object_id looking_for;
+	const struct object_id *looking_for;
 	struct strbuf *dst;
 	struct rev_info *revs;
 };
@@ -505,7 +505,7 @@ static void process_object(struct object *obj, const char *path, void *data)
 {
 	struct process_commit_data *pcd = data;
 
-	if (oideq(&pcd->looking_for, &obj->oid) && !pcd->dst->len) {
+	if (oideq(pcd->looking_for, &obj->oid) && !pcd->dst->len) {
 		reset_revision_walk();
 		describe_commit(&pcd->current_commit, pcd->dst);
 		strbuf_addf(pcd->dst, ":%s", path);
@@ -514,7 +514,7 @@ static void process_object(struct object *obj, const char *path, void *data)
 	}
 }
 
-static void describe_blob(struct object_id oid, struct strbuf *dst)
+static void describe_blob(const struct object_id *oid, struct strbuf *dst)
 {
 	struct rev_info revs;
 	struct strvec args = STRVEC_INIT;
@@ -554,7 +554,7 @@ static void describe(const char *arg, int last_one)
 		describe_commit(&oid, &sb);
 	else if (odb_read_object_info(the_repository->objects,
 				      &oid, NULL) == OBJ_BLOB)
-		describe_blob(oid, &sb);
+		describe_blob(&oid, &sb);
 	else
 		die(_("%s is neither a commit nor blob"), arg);
 
-- 
2.51.0.326.gecbb38d78e

