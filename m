Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA8C28507F
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 23:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755214008; cv=none; b=CZ9oa4xcxLBJ86+CxKBF6RHJKGlj2ebT2ebaK2Q/hH8Ximini7DQEY5Sybc0J3aYYTHOe/YyAejUt2lvGY/8UcoxmOPZgU2JHMXa0gOAkpZK99EtQa9g4FEsai01q7HgHXOH36NzKDeSuHeAM/fnIMwJnUuWErZ5PQYpaZLYKb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755214008; c=relaxed/simple;
	bh=HgVB2EJLZKv5rJ0pTgbrabXiSPlwBNDVgGMclmRbdP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZKAqYQ8+m18rXyRrQPF8bHVBT2zyTubb46IcGJnE0nLUCeritfdtAtpIkA2hJOr150Ax27rWVHdXg5YWqyY9w+fRJTDdt4DMZte1TrEaokGDOZ8M6WAAUrK1W1N2wEFOZOP3M6dxytJNnlA0FWLDz4IAeP/9wec8KMU/Gp1XlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=H27MqEiD; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="H27MqEiD"
Received: (qmail 1542 invoked by uid 109); 14 Aug 2025 23:26:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HgVB2EJLZKv5rJ0pTgbrabXiSPlwBNDVgGMclmRbdP4=; b=H27MqEiDvM/F+n3O6PBEao22fdzwa7Zqis7cN0MELi4aGq7tH91od7VhjDQpMEeNpRS/jd9vP+sJCDPCSmByL4hha+bjCJKVPU2xJMmwzD5fKRZTIFw3oshLnXIhxc+s5XJXLpcH2Jor31jJEDPobOHllRRctsGLX9i2qV3UTm1U4Uf2+qps4ntUq90jc2ZLrl/s0dJ9Mjltwj5eTMD5FGHXz/kZqjfavOxPLM7tnTTJePgjwyMdzhDFVFxGCBC5ZgTDpldMD+RsURoGoE2BGR280aYXKNg5GAzCQmsQoGOz9F7oWAsOJRq57s+fnFkGbFv7M7xts0LgyiakYGIcgg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Aug 2025 23:26:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9811 invoked by uid 111); 14 Aug 2025 23:26:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Aug 2025 19:26:47 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 14 Aug 2025 19:26:44 -0400
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: Cheng <prophecheng@stu.pku.edu.cn>, git@vger.kernel.org
Subject: Re: Potential Null Pointer Dereference detected by static analysis
 tool
Message-ID: <20250814232644.GC2937@coredump.intra.peff.net>
References: <AAkArwD3JXZP4EIjvKF0Waow.1.1755044612233.Hmail.2201111603@stu.pku.edu.cn>
 <5303c45e-d95b-4bc8-9cd1-bf4efe6bfbae@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5303c45e-d95b-4bc8-9cd1-bf4efe6bfbae@gmail.com>

On Wed, Aug 13, 2025 at 02:19:14PM +0100, Phillip Wood wrote:

> I had a quick look at the callers of describe_commit() and they all seem to
> use an oid that they get from looking up a commit so I'm not sure under what
> circumstances this call to lookup_commit_reference() can fail.

I wonder if it would make sense for describe_commit() to just take a
"struct commit" pointer. Then it could skip the call to turn the oid
into a commit entirely, and the compiler would make sure we always have
a commit. :)

Something like this (totally untested, and not something I'm planning to
follow up on, but maybe inspirational):

diff --git a/builtin/describe.c b/builtin/describe.c
index 32f5bf513f..3e8691a4c4 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -352,26 +352,24 @@ static void append_suffix(int depth, const struct object_id *oid, struct strbuf
 		    repo_find_unique_abbrev(the_repository, oid, abbrev));
 }
 
-static void describe_commit(struct object_id *oid, struct strbuf *dst)
+static void describe_commit(struct commit *cmit, struct strbuf *dst)
 {
-	struct commit *cmit, *gave_up_on = NULL;
+	struct commit *gave_up_on = NULL;
 	struct lazy_queue queue = LAZY_QUEUE_INIT;
 	struct commit_name *n;
 	struct possible_tag all_matches[MAX_TAGS];
 	unsigned int match_cnt = 0, annotated_cnt = 0, cur_match;
 	unsigned long seen_commits = 0;
 	unsigned int unannotated_cnt = 0;
 
-	cmit = lookup_commit_reference(the_repository, oid);
-
 	n = find_commit_name(&cmit->object.oid);
 	if (n && (tags || all || n->prio == 2)) {
 		/*
 		 * Exact match to an existing ref.
 		 */
 		append_name(n, dst);
 		if (n->misnamed || longformat)
-			append_suffix(0, n->tag ? get_tagged_oid(n->tag) : oid, dst);
+			append_suffix(0, n->tag ? get_tagged_oid(n->tag) : &cmit->object.oid, dst);
 		if (suffix)
 			strbuf_addstr(dst, suffix);
 		return;
@@ -528,7 +526,7 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 }
 
 struct process_commit_data {
-	struct object_id current_commit;
+	struct commit *current_commit;
 	struct object_id looking_for;
 	struct strbuf *dst;
 	struct rev_info *revs;
@@ -537,7 +535,7 @@ struct process_commit_data {
 static void process_commit(struct commit *commit, void *data)
 {
 	struct process_commit_data *pcd = data;
-	pcd->current_commit = commit->object.oid;
+	pcd->current_commit = commit;
 }
 
 static void process_object(struct object *obj, const char *path, void *data)
@@ -546,7 +544,7 @@ static void process_object(struct object *obj, const char *path, void *data)
 
 	if (oideq(&pcd->looking_for, &obj->oid) && !pcd->dst->len) {
 		reset_revision_walk();
-		describe_commit(&pcd->current_commit, pcd->dst);
+		describe_commit(pcd->current_commit, pcd->dst);
 		strbuf_addf(pcd->dst, ":%s", path);
 		clear_prio_queue(&pcd->revs->commits);
 	}
@@ -556,7 +554,7 @@ static void describe_blob(struct object_id oid, struct strbuf *dst)
 {
 	struct rev_info revs;
 	struct strvec args = STRVEC_INIT;
-	struct process_commit_data pcd = { *null_oid(the_hash_algo), oid, dst, &revs};
+	struct process_commit_data pcd = { NULL, oid, dst, &revs};
 
 	strvec_pushl(&args, "internal: The first arg is not parsed",
 		     "--objects", "--in-commit-order", "--reverse", "HEAD",
@@ -589,7 +587,7 @@ static void describe(const char *arg, int last_one)
 	cmit = lookup_commit_reference_gently(the_repository, &oid, 1);
 
 	if (cmit)
-		describe_commit(&oid, &sb);
+		describe_commit(cmit, &sb);
 	else if (odb_read_object_info(the_repository->objects,
 				      &oid, NULL) == OBJ_BLOB)
 		describe_blob(oid, &sb);
