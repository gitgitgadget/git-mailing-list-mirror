Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E60EA0
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 02:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UsHsKwYK"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15461ED
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 19:06:10 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 612062964E;
	Tue, 31 Oct 2023 22:06:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kOPt+Yvu8zA03PMczrSWx0U5jVIowrhspqp85y
	rscks=; b=UsHsKwYKGnUlH1fJAL8IJb9wOK/3LskEL+H1b7LVyj6xGNMoIvm5nv
	gDh818ANQNETXHsXCYs+1fqVpw4eW2HbZZSQzEihv5xzxFsNsDU17sTUAKrTkxl9
	9G8aT4g6bb2TbqVKChOjuvTNOsUdspY3NFtAF2+KtP5r3O0T9bfBo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5A6352964D;
	Tue, 31 Oct 2023 22:06:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EF22E2964C;
	Tue, 31 Oct 2023 22:06:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/2] commit-graph: detect commits missing in ODB
In-Reply-To: <xmqqh6m6z6pe.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	01 Nov 2023 08:57:01 +0900")
References: <cover.1698060036.git.ps@pks.im> <cover.1698736363.git.ps@pks.im>
	<ZUFSqRYXhwsWC+EA@nand.local> <xmqqh6m6z6pe.fsf@gitster.g>
Date: Wed, 01 Nov 2023 11:06:05 +0900
Message-ID: <xmqq34xqxm5u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 37E1C2A6-785B-11EE-8BC7-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> Thanks, the range-diff here looks exactly as expected. Thanks for
>> working on this, this version LGTM.
>
> OK, I'd like a version as incremental to v2 (since it already is in
> 'next') that results in the same tree state as v3 then.
>
> Thanks for working on it, and reviewing it.

In the meantime, here is a mechanically produced incremental I'll
tentatively queue.  Hopefully I did not screw up while generating
it.

Thanks.

--- >8 ---
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 31 Oct 2023 08:16:09 +0100
Subject: [PATCH] commit-graph: clarify GIT_COMMIT_GRAPH_PARANOIA documentation

In response to reviews of the previous round that has already hit
'next', clarify the help text for GIT_COMMIT_GRAPH_PARANOIA and
rename object_paranoia variable to commit_graph_paranoia for
consistency.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git.txt   | 15 ++++++++-------
 commit-graph.c          |  8 ++++----
 commit.c                |  8 ++++----
 t/t5318-commit-graph.sh |  2 +-
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 22c2b537aa..3bac24cf8a 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -912,13 +912,14 @@ for full details.
 	useful when trying to salvage data from a corrupted repository.
 
 `GIT_COMMIT_GRAPH_PARANOIA`::
-	If this Boolean environment variable is set to false, ignore the
-	case where commits exist in the commit graph but not in the
-	object database. Normally, Git will check whether commits loaded
-	from the commit graph exist in the object database to avoid
-	issues with stale commit graphs, but this check comes with a
-	performance penalty. The default is `1` (i.e., be paranoid about
-	stale commits in the commit graph).
+	When loading a commit object from the commit-graph, Git performs an
+	existence check on the object in the object database. This is done to
+	avoid issues with stale commit-graphs that contain references to
+	already-deleted commits, but comes with a performance penalty.
++
+The default is "true", which enables the aforementioned behavior.
+Setting this to "false" disables the existence check. This can lead to
+a performance improvement at the cost of consistency.
 
 `GIT_ALLOW_PROTOCOL`::
 	If set to a colon-separated list of protocols, behave as if
diff --git a/commit-graph.c b/commit-graph.c
index 376f59af73..b37fdcb214 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -907,18 +907,18 @@ int repo_find_commit_pos_in_graph(struct repository *r, struct commit *c,
 
 struct commit *lookup_commit_in_graph(struct repository *repo, const struct object_id *id)
 {
-	static int object_paranoia = -1;
+	static int commit_graph_paranoia = -1;
 	struct commit *commit;
 	uint32_t pos;
 
-	if (object_paranoia == -1)
-		object_paranoia = git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 1);
+	if (commit_graph_paranoia == -1)
+		commit_graph_paranoia = git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 1);
 
 	if (!prepare_commit_graph(repo))
 		return NULL;
 	if (!search_commit_pos_in_graph(id, repo->objects->commit_graph, &pos))
 		return NULL;
-	if (object_paranoia && !has_object(repo, id, 0))
+	if (commit_graph_paranoia && !has_object(repo, id, 0))
 		return NULL;
 
 	commit = lookup_commit(repo, id);
diff --git a/commit.c b/commit.c
index 7399e90212..8405d7c3fc 100644
--- a/commit.c
+++ b/commit.c
@@ -574,12 +574,12 @@ int repo_parse_commit_internal(struct repository *r,
 	if (item->object.parsed)
 		return 0;
 	if (use_commit_graph && parse_commit_in_graph(r, item)) {
-		static int object_paranoia = -1;
+		static int commit_graph_paranoia = -1;
 
-		if (object_paranoia == -1)
-			object_paranoia = git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 1);
+		if (commit_graph_paranoia == -1)
+			commit_graph_paranoia = git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 1);
 
-		if (object_paranoia && !has_object(r, &item->object.oid, 0)) {
+		if (commit_graph_paranoia && !has_object(r, &item->object.oid, 0)) {
 			unparse_commit(r, &item->object.oid);
 			return quiet_on_missing ? -1 :
 				error(_("commit %s exists in commit-graph but not in the object database"),
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 55e3c7ec78..2c62b91ef9 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -847,7 +847,7 @@ test_expect_success 'stale commit cannot be parsed when traversing graph' '
 		test_commit C &&
 		git commit-graph write --reachable &&
 
-		# Corrupt the repository by deleting the intermittent commit
+		# Corrupt the repository by deleting the intermediate commit
 		# object. Commands should notice that this object is absent and
 		# thus that the repository is corrupt even if the commit graph
 		# exists.
-- 
2.42.0-530-g692be87cbb

