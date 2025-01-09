Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE9721504D
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736412153; cv=none; b=WBdsW0UennKfBaJTNa64KkRzc/LUEeSuRgy7/NbfTjj5ftKdCYrNWBSHxsF0JRvC63wtpzUavAhIttsmrBPRvIYITKrkdShGQGMRGghpw2Mwgc9srylAfbAt5PncinpcdyJrDpJyVwbq0EUUnnGdkO3+Zkj3W+vscd4nQLD8rrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736412153; c=relaxed/simple;
	bh=q+Sfo1geaO7t/PMKaTDhR02Bunb3zzNTSgO0ZYa+QnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEyX53iP6OGzkmxdRLQO39jiqiM4Ydn2SxCUgxo+t7rWplOR44377ZtFasjeKf9RdApGmDXws6dGh2UcEQmva6BvNYZ6lvQtDrnc9NME5a094OPuMFIAlfVVsXPf5+xYo0YUEi8Lsddl14Yty3VryCxdgZ9Ac0VubNBshMzxh8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YisQa8R8; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YisQa8R8"
Received: (qmail 25656 invoked by uid 109); 9 Jan 2025 08:42:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=q+Sfo1geaO7t/PMKaTDhR02Bunb3zzNTSgO0ZYa+QnU=; b=YisQa8R8YT/TQbcZtkaeZHE20fVrSKUu8lxvpaDc96XhFnz9yERKb/QQtEW+vGMNLuklZZCo9TnnTz3QcxjutbRuNra7yTB9UNjFzV2ifXxERgLaAWIE5KbNB5rq5UqRB0OrhUM45Prv4Ja6ZLcko9uV1ZH9CdBXlEj/kw5wBoSXn44/Yg2SYKD/Z8KuTt1fJ38KV0iA8sW2puuyPu6WvQ2l1JURfgBZ4dUrMmQbHqBlwBCWWkXp9G0plBXUY6rCVclpD61BSyBf8qGxPFkd7Pp6BNC4mZ4z3S1XrV1NU26FCqULVzO/Tjse93k4jst9pK7eY63s+8sa93WEu1uMog==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jan 2025 08:42:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20288 invoked by uid 111); 9 Jan 2025 08:42:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jan 2025 03:42:30 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Jan 2025 03:42:29 -0500
From: Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Wink Saville <wink@saville.com>
Subject: [PATCH 04/14] combine-diff: use pointer for parent paths
Message-ID: <20250109084229.GD2748836@coredump.intra.peff.net>
References: <20250109082723.GA2748497@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109082723.GA2748497@coredump.intra.peff.net>

Commit d76ce4f734 (log,diff-tree: add --combined-all-paths option,
2019-02-07) added a "path" field to each combine_diff_parent struct.
It's defined as a strbuf, but this is overkill. We never manipulate the
buffer beyond inserting a single string into it.

And in fact there's a small bug: we zero the parent structs, including
the path strbufs. For the 0th parent, we strbuf_init() the strbuf before
adding to it. But for subsequent parents, we never do the init. This is
technically violating the strbuf API, though the code there is resilient
enough to handle this zero'd state.

This patch switches us to just store an allocated string pointer.
Zeroing it is enough to properly initialize it there (modulo the usual
assumption we make that a NULL pointer is all-zeroes).

And as a bonus, we can just check for a non-NULL value to see if it is
present, rather than repeating the combined_all_paths logic at each
site.

Signed-off-by: Jeff King <peff@peff.net>
---
 combine-diff.c | 30 +++++++++++-------------------
 diff.h         |  2 +-
 2 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 45548fd438..ae3cbfc699 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -60,9 +60,7 @@ static struct combine_diff_path *intersect_paths(
 
 			if (combined_all_paths &&
 			    filename_changed(p->parent[n].status)) {
-				strbuf_init(&p->parent[n].path, 0);
-				strbuf_addstr(&p->parent[n].path,
-					      q->queue[i]->one->path);
+				p->parent[n].path = xstrdup(q->queue[i]->one->path);
 			}
 			*tail = p;
 			tail = &p->next;
@@ -83,9 +81,7 @@ static struct combine_diff_path *intersect_paths(
 			/* p->path not in q->queue[]; drop it */
 			*tail = p->next;
 			for (j = 0; j < num_parent; j++)
-				if (combined_all_paths &&
-				    filename_changed(p->parent[j].status))
-					strbuf_release(&p->parent[j].path);
+				free(p->parent[j].path);
 			free(p);
 			continue;
 		}
@@ -101,8 +97,7 @@ static struct combine_diff_path *intersect_paths(
 		p->parent[n].status = q->queue[i]->status;
 		if (combined_all_paths &&
 		    filename_changed(p->parent[n].status))
-			strbuf_addstr(&p->parent[n].path,
-				      q->queue[i]->one->path);
+			p->parent[n].path = xstrdup(q->queue[i]->one->path);
 
 		tail = &p->next;
 		i++;
@@ -987,8 +982,9 @@ static void show_combined_header(struct combine_diff_path *elem,
 
 	if (rev->combined_all_paths) {
 		for (i = 0; i < num_parent; i++) {
-			char *path = filename_changed(elem->parent[i].status)
-				? elem->parent[i].path.buf : elem->path;
+			const char *path = elem->parent[i].path ?
+					   elem->parent[i].path :
+					   elem->path;
 			if (elem->parent[i].status == DIFF_STATUS_ADDED)
 				dump_quoted_path("--- ", "", "/dev/null",
 						 line_prefix, c_meta, c_reset);
@@ -1269,12 +1265,10 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
 
 	for (i = 0; i < num_parent; i++)
 		if (rev->combined_all_paths) {
-			if (filename_changed(p->parent[i].status))
-				write_name_quoted(p->parent[i].path.buf, stdout,
-						  inter_name_termination);
-			else
-				write_name_quoted(p->path, stdout,
-						  inter_name_termination);
+			const char *path = p->parent[i].path ?
+					   p->parent[i].path :
+					   p->path;
+			write_name_quoted(path, stdout, inter_name_termination);
 		}
 	write_name_quoted(p->path, stdout, line_termination);
 }
@@ -1636,9 +1630,7 @@ void diff_tree_combined(const struct object_id *oid,
 		struct combine_diff_path *tmp = paths;
 		paths = paths->next;
 		for (i = 0; i < num_parent; i++)
-			if (rev->combined_all_paths &&
-			    filename_changed(tmp->parent[i].status))
-				strbuf_release(&tmp->parent[i].path);
+			free(tmp->parent[i].path);
 		free(tmp);
 	}
 
diff --git a/diff.h b/diff.h
index 5cddd5a870..f5f6ea00fb 100644
--- a/diff.h
+++ b/diff.h
@@ -480,7 +480,7 @@ struct combine_diff_path {
 		char status;
 		unsigned int mode;
 		struct object_id oid;
-		struct strbuf path;
+		char *path;
 	} parent[FLEX_ARRAY];
 };
 #define combine_diff_path_size(n, l) \
-- 
2.48.0.rc2.413.gc1c80375a3

