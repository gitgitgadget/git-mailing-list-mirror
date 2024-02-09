Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736131805F
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 23:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707522890; cv=none; b=T2zhwpMwoxYWDSDsz0jCPw2Rz4KgJtyPHigZtLrGBeCWSbj+4xxgac/o2jFcqao4PniHLkOhCTdmTUAEJLuLiYVwKqV+B84pZKdhBX1QKHcrp092Qw5jJHMAbaDgnRy7QqK2VJWi/vG/k1lQKQxxlHEBt72BFltTYds6eFSi14g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707522890; c=relaxed/simple;
	bh=RyV+wbv/dWkx9KIQ6MizMZnf5c5rA/SnOWymDSJ4oOc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DnujdhYwVNDC5CTIVy1pVodYp9YmphOMwF7sxEuaUsWA+9lChpaJGWtFAuCL6FEJ681lOaVtKvLT4pe365GqbLDSo3dKLbaM0ahkoNM+nFA0EnJS5sxKIzW/cCv2N+cOgwC6LuFK87+FXlHZsfnqsoAnTV12cDSas1c9gcPpqVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=t3TWjpGJ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t3TWjpGJ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BE4A521473;
	Fri,  9 Feb 2024 18:54:47 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RyV+wbv/dWkx9KIQ6MizMZnf5c5rA/SnOWymDS
	J4oOc=; b=t3TWjpGJQWTMIsCLkwvcRbjwEr47We2/w0E06UNzuAD2TXraCYIS1z
	mOe1sdZZ8MNRlIA96gFCBrE8fR+lS6JmFuC877SPp/i19m/NTCJLiU/yLCv17uE3
	sM2FqYnhOhBIb9swteqKP/MYmPKMd7xSahVcPkthi4qsP00rWCsF4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B788E21472;
	Fri,  9 Feb 2024 18:54:47 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D7A5821471;
	Fri,  9 Feb 2024 18:54:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Elijah Newren <newren@gmail.com>,  Michael Lohmann
 <mi.al.lohmann@gmail.com>,  git@vger.kernel.org,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 2/2] revision: Implement `git log --merge` also for
 rebase/cherry_pick/revert
In-Reply-To: <dfb582cf-b1e4-414d-bfe1-0f93d910ec54@kdbg.org> (Johannes Sixt's
	message of "Wed, 24 Jan 2024 18:19:39 +0100")
References: <xmqqzfxa9usx.fsf@gitster.g>
	<20240117081405.14012-1-mi.al.lohmann@gmail.com>
	<20240117081405.14012-2-mi.al.lohmann@gmail.com>
	<CABPp-BE4zqRX=wd5EBj96hzCS8V73QpdN-2pCpv7qMdkpkX93w@mail.gmail.com>
	<dfb582cf-b1e4-414d-bfe1-0f93d910ec54@kdbg.org>
Date: Fri, 09 Feb 2024 15:54:43 -0800
Message-ID: <xmqq7cjdchx8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9981A00E-C7A6-11EE-BB0C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Johannes Sixt <j6t@kdbg.org> writes:

>> Also, what about cases where users do a cherry-pick in the middle of a
>> rebase, so that both REBASE_HEAD and CHERRY_PICK_HEAD exist?  What
>> then?
>
> Good point! IMO, REBASE_HEAD should have lower precedence than all the
> other *_HEADs. It would mean to reorder the entries:
>
> 	static const char *const other_head[] = {
> 		"MERGE_HEAD", "CHERRY_PICK_HEAD", "REVERT_HEAD", "REBASE_HEAD"
> 	};
>
> (and perhaps adjust the error message, too).

I've tweaked this change into the commit.

Thanks, all.

------- >8 ------------- >8 ------------- >8 ------------- >8 -------
From: Michael Lohmann <mi.al.lohmann@gmail.com>
Date: Wed, 17 Jan 2024 09:14:05 +0100
Subject: [PATCH] revision: implement `git log --merge` also for
 rebase/cherry_pick/revert

Co-authored-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
[jc: tweaked in j6t's precedence fix that tries REBASE_HEAD last]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/revision.c b/revision.c
index aa4c4dc778..36dc2f94f7 100644
--- a/revision.c
+++ b/revision.c
@@ -1961,11 +1961,31 @@ static void add_pending_commit_list(struct rev_info *revs,
 	}
 }
 
+static const char *lookup_other_head(struct object_id *oid)
+{
+	int i;
+	static const char *const other_head[] = {
+		"MERGE_HEAD", "CHERRY_PICK_HEAD", "REVERT_HEAD", "REBASE_HEAD"
+	};
+
+	for (i = 0; i < ARRAY_SIZE(other_head); i++)
+		if (!read_ref_full(other_head[i],
+				RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+				oid, NULL)) {
+			if (is_null_oid(oid))
+				die("%s is a symbolic ref???", other_head[i]);
+			return other_head[i];
+		}
+
+	die("--merge without MERGE_HEAD, CHERRY_PICK_HEAD, REVERT_HEAD or REBASE_HEAD?");
+}
+
 static void prepare_show_merge(struct rev_info *revs)
 {
 	struct commit_list *bases;
 	struct commit *head, *other;
 	struct object_id oid;
+	const char *other_name;
 	const char **prune = NULL;
 	int i, prune_num = 1; /* counting terminating NULL */
 	struct index_state *istate = revs->repo->index;
@@ -1973,15 +1993,10 @@ static void prepare_show_merge(struct rev_info *revs)
 	if (repo_get_oid(the_repository, "HEAD", &oid))
 		die("--merge without HEAD?");
 	head = lookup_commit_or_die(&oid, "HEAD");
-	if (read_ref_full("MERGE_HEAD",
-			RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-			&oid, NULL))
-		die("--merge without MERGE_HEAD?");
-	if (is_null_oid(&oid))
-		die("MERGE_HEAD is a symbolic ref???");
-	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
+	other_name = lookup_other_head(&oid);
+	other = lookup_commit_or_die(&oid, other_name);
 	add_pending_object(revs, &head->object, "HEAD");
-	add_pending_object(revs, &other->object, "MERGE_HEAD");
+	add_pending_object(revs, &other->object, other_name);
 	bases = repo_get_merge_bases(the_repository, head, other);
 	add_rev_cmdline_list(revs, bases, REV_CMD_MERGE_BASE, UNINTERESTING | BOTTOM);
 	add_pending_commit_list(revs, bases, UNINTERESTING | BOTTOM);
-- 
2.44.0-rc0



