Received: from web23.osl1.nordkapp.net (web23.osl1.nordkapp.net [185.114.57.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990B51EB31
	for <git@vger.kernel.org>; Sat, 13 Apr 2024 21:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.114.57.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713043284; cv=none; b=KSl1DT21Jk77pV5HsSyqPG2Uv4NjQjPHeCudgkc30kiFgMc+sNWx4R1bOs6xj90oNbNQ3bMSZK2QxiQnq6kmSsGk56pehHc7HIliHAv77eNaPWlCCCIShbvbhpn66DQvZ7Pa+C2CjI5eTiO52yiD/gD3tQg29hqEsjXzeMEeGOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713043284; c=relaxed/simple;
	bh=jaD7WgCg8EbhmeImOsq2Qv80kp2cL1/qMqzWHQ+rwKM=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=U33DULfUDfDp+N3M1K/V0PmRYlQjjiBtlAA19nSBLmazkAgJaB8SaEAOXQrd+s2RfIXo1N1npO0EywxY20nuTCBimVNNuihYKlNNweu0zL1zPWE0/6NTghLiMcvt7grQwERHvRiewmV/b0CJDHS0VBxv0cuFbH3fZi3p+sS4XJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se; spf=pass smtp.mailfrom=softwolves.pp.se; dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b=O6tiZCo0; arc=none smtp.client-ip=185.114.57.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b="O6tiZCo0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=softwolves.pp.se; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:cc:To
	:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7n1IjJsU/ucAr7txbgqINVhrGUgOrfvtUhr/NQcFMTo=; b=O6tiZCo0ixBUHrBzaoZSN1You/
	ZAIIB6oOr2AB3alOx6dzfGoTQs6B69SK/orIAzW2PZ8cl169B1Ho2ypPckTleMtUK+fO6zg512ex6
	7m5TtE3Mn5Bk5g/s65hIBe7MwoAHHar9kjYBp5hV3DAhwbz4QpyK5jmRTDNXkiuF4uDDh2IShtMek
	WI6b9DG6rK/ibq7uGWoyM6kGqlntRBiHNrw+pGne5A0RmB7H1Avl9Tulm2R6A2QLwgfv8YOEdU5ia
	kXIMTIYfz6TBcS/Afi67j/D0svBQ+6u7u/JZ55R53RKe6CBlc1E08o2bziNEQJxi+/9pbEu9wqnLg
	WoDTGLpA==;
Received: from mail01.osl1.nordkapp.net ([185.114.57.50]:51096 helo=mail.nordhost.no)
	by web23.osl1.nordkapp.net with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <peter@softwolves.pp.se>)
	id 1rvjlw-000000098cf-2JrE;
	Sat, 13 Apr 2024 22:14:48 +0200
Date: Sat, 13 Apr 2024 21:14:48 +0100 (CET)
From: Peter Krefting <peter@softwolves.pp.se>
To: git@vger.kernel.org
cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
    Christian Couder <christian.couder@gmail.com>, 
    Michael Osipov <michael.osipov@innomotics.com>
Subject: [PATCH v3] bisect: report the found commit with "show"
Message-ID: <965ae345-fd58-c46c-5a7a-de181e901f21@softwolves.pp.se>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Relay-Host: 185.114.57.50
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus

When "git bisect" finds the first bad commit and shows it to the user,
it calls "git diff-tree" to do so, whose output is meant to be stable
and deliberately ignores end-user customizations.

As the output is supposed to be consumed by humans, replace this with
a call to "git show". This command honors configuration options (such
as "log.date" and "log.mailmap") and other UI improvements (renames
are detected).

Pass some hard-coded options to "git show" to make the output similar
to the one we are replacing, such as showing a patch summary only.

Reported-by: Michael Osipov <michael.osipov@innomotics.com>
Signed-off-By: Peter Krefting <peter@softwolves.pp.se>
Cc: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>
Cc: Christian Couder <christian.couder@gmail.com>
---
  bisect.c | 37 ++++++++++++++++++++++---------------
  1 file changed, 22 insertions(+), 15 deletions(-)

Changes compared to v2:
- Adds --no-pager and a comment stating why we do so.
- Adds --diff-merges=first-parent, as per previous discussion.

This seems to generate a final output as close to the previous one as 
possible, while honouring the user's settings for how to display log 
entries and calculating diffs.

diff --git a/bisect.c b/bisect.c
index 8487f8cd1b..3be2460c65 100644
--- a/bisect.c
+++ b/bisect.c
@@ -959,23 +959,30 @@ static enum bisect_error check_good_are_ancestors_of_bad(struct repository *r,
  }

  /*
- * This does "git diff-tree --pretty COMMIT" without one fork+exec.
+ * Display a commit summary to the user.
   */
-static void show_diff_tree(struct repository *r,
-			   const char *prefix,
-			   struct commit *commit)
+static void show_commit(struct commit *commit)
  {
-	const char *argv[] = {
-		"diff-tree", "--pretty", "--stat", "--summary", "--cc", NULL
-	};
-	struct rev_info opt;
+	struct child_process show = CHILD_PROCESS_INIT;

-	git_config(git_diff_ui_config, NULL);
-	repo_init_revisions(r, &opt, prefix);
-
-	setup_revisions(ARRAY_SIZE(argv) - 1, argv, &opt, NULL);
-	log_tree_commit(&opt, commit);
-	release_revisions(&opt);
+	/* Call git show with --no-pager, as it would otherwise
+	 * paginate the "git show" output only, not the output
+	 * from bisect_next_all(); this can be fixed by moving
+	 * it into a --format parameter, but that would override
+	 * the user's default options for "git show", which we
+	 * are trying to honour. */
+	strvec_pushl(&show.args,
+	             "--no-pager",
+	             "show",
+	             "--stat",
+	             "--summary",
+	             "--no-abbrev-commit",
+	             "--diff-merges=first-parent",
+	             oid_to_hex(&commit->object.oid), NULL);
+	show.git_cmd = 1;
+	if (run_command(&show))
+		die(_("unable to start 'show' for object '%s'"),
+		    oid_to_hex(&commit->object.oid));
  }

  /*
@@ -1092,7 +1099,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
  		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
  			term_bad);

-		show_diff_tree(r, prefix, revs.commits->item);
+		show_commit(revs.commits->item);
  		/*
  		 * This means the bisection process succeeded.
  		 * Using BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND (-10)
-- 
2.39.2
