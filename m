Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379583CF41
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708504982; cv=none; b=msrI57mKN9p9/bJxFGiwGRsOOR6XhE62PWJ2X2l4TlypvuBliiunGNAsYx8zuzDKz79bK73IAcvc/XgEe3hv83bIEQ/EOg6VcUEjyZcYnwXVgrfKUp7QfXnMEc0MhKFa42zeQbMHzgplvwhRj9vqbPnASQm+RMRzr/BJAyKU04g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708504982; c=relaxed/simple;
	bh=nLkWAOtu5GVOEwPCqcoQQxKGJUNc1Zqi5B+7WcpMXAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrYmHcXs+PW/ygb9ocSHMRF22G46Vy97i75+YUMbLh56dsUVVoJ+zMUAP/IL62416S1QSFOPEordtCjjgHYoqiC+baus2JXzt6CWq7tZBd3DiLoA5QjmD0szjkkHUcCxeHhJ7GYEH7jB7TzMn+j8UjvGPxLt40KjhR7Ihk735pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 2531 invoked by uid 109); 21 Feb 2024 08:42:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Feb 2024 08:42:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 511 invoked by uid 111); 21 Feb 2024 08:42:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Feb 2024 03:42:55 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 21 Feb 2024 03:42:50 -0500
From: Jeff King <peff@peff.net>
To: Yasushi SHOJI <yasushi.shoji@gmail.com>
Cc: Denton Liu <liu.denton@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Segfault: git show-branch --reflog refs/pullreqs/1
Message-ID: <20240221084250.GA25385@coredump.intra.peff.net>
References: <CAELBRWK-bZTV0qx6_34HAgpmYwy+5Zo2E0M+4B6yZJJ3CqweTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAELBRWK-bZTV0qx6_34HAgpmYwy+5Zo2E0M+4B6yZJJ3CqweTw@mail.gmail.com>

On Wed, Feb 21, 2024 at 10:48:25AM +0900, Yasushi SHOJI wrote:

> Does anyone see a segfault on `git show-branch --reflog refs/pullreqs/1`?
> 
> It seems files_reflog_path() creates a wrong path with the above command
> using REF_WORKTREE_SHARED.

I can trigger a segfault, but I think the issue is simply a ref that has
no reflog. Here's a simple reproduction:

  $ git init
  $ git commit --allow-empty -m foo
  $ rm -rf .git/logs
  $ git show-branch --reflog
  Segmentation fault

The bug is in read_ref_at(). When asked for the reflog at position "0",
it calls refs_for_each_reflog_ent_reverse() with a special callback, but
does not check that it actually found anything! So we return "0" for
success, but all of the returned fields are garbage (including the
pointer to reflog message, which is where I see the segfault).

The bug was introduced by 6436a20284 (refs: allow @{n} to work with
n-sized reflog, 2021-01-07). Probably the fix is something like:

diff --git a/refs.c b/refs.c
index 03968ad787..c2a48f8188 100644
--- a/refs.c
+++ b/refs.c
@@ -945,6 +945,8 @@ static int read_ref_at_ent_newest(struct object_id *ooid, struct object_id *noid
 
 	set_read_ref_cutoffs(cb, timestamp, tz, message);
 	oidcpy(cb->oid, noid);
+	cb->reccnt++;
+	cb->found_it = 1;
 	/* We just want the first entry */
 	return 1;
 }
@@ -980,12 +982,10 @@ int read_ref_at(struct ref_store *refs, const char *refname,
 	cb.cutoff_cnt = cutoff_cnt;
 	cb.oid = oid;
 
-	if (cb.cnt == 0) {
+	if (cb.cnt == 0)
 		refs_for_each_reflog_ent_reverse(refs, refname, read_ref_at_ent_newest, &cb);
-		return 0;
-	}
-
-	refs_for_each_reflog_ent_reverse(refs, refname, read_ref_at_ent, &cb);
+	else
+		refs_for_each_reflog_ent_reverse(refs, refname, read_ref_at_ent, &cb);
 
 	if (!cb.reccnt) {
 		if (flags & GET_OID_QUIETLY)

but that breaks t1508.35, which explicitly tests for branch@{0} to work
with an empty reflog file (added by that same commit). The code in
get_oid_basic() to parse reflogs doesn't suffer from the same bugs: it
checks up front that the reflog file exists, it preloads the output oid
with the current ref value, and it doesn't look at other fields (like
the reflog message).

So I'm not sure if read_ref_at() needs to be made safer, or if
cmd_show_branch() needs to learn the same tricks as get_oid_basic().
Those are the only two callers of read_ref_at().

Beyond that confusion, I noticed we do not have many tests for
show-branch, and none for "--reflog". So I thought to add a basic one
where we _do_ have an actual reflog to show. But wow, this has been
broken for some time. I found at least two issues trying to run a test
like:

diff --git a/t/t3207-show-branch-reflog.sh b/t/t3207-show-branch-reflog.sh
new file mode 100755
index 0000000000..7f52c8dcb1
--- /dev/null
+++ b/t/t3207-show-branch-reflog.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+test_description='show-branch reflog tests'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit base &&
+	git checkout -b branch &&
+	test_commit one &&
+	git reset --hard HEAD^ &&
+	test_commit two &&
+	test_commit three
+'
+
+test_expect_success '--reflog shows reflog entries' '
+	cat >expect <<-\EOF &&
+	! [branch@{0}] (0 seconds ago) commit: three
+	 ! [branch@{1}] (60 seconds ago) commit: two
+	  ! [branch@{2}] (2 minutes ago) reset: moving to HEAD^
+	   ! [branch@{3}] (2 minutes ago) commit: one
+	----
+	+    [refs/heads/branch@{0}] three
+	++   [refs/heads/branch@{1}] two
+	   + [refs/heads/branch@{3}] one
+	++++ [refs/heads/branch@{2}] base
+	EOF
+	# the output always contains relative timestamps; use
+	# a known time to get deterministic results
+	GIT_TEST_DATE_NOW=$test_tick \
+	git show-branch --reflog branch >actual &&
+	test_cmp expect actual
+'
+
+test_done

The first is that "show-branch" does not print the correct reflog
message, and you get output like this:

  ! [branch@{0}] (0 seconds ago) (none)
   ! [branch@{1}] (0 seconds ago) (none)
    ! [branch@{2}] (60 seconds ago) (none)
     ! [branch@{3}] (2 minutes ago) (none)

Once upon a time, read_ref_at() returned the whole reflog line, and
show-branch had to find the tab-separator. But since 4207ed285f (refs.c:
change read_ref_at to use the reflog iterators, 2014-06-03), it returns
just the actual message (curiously, with the newline still attached). So
we need something like this to fix it:

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index d6d2dabeca..b678b9fedb 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -761,7 +761,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		for (i = 0; i < reflog; i++) {
 			char *logmsg;
 			char *nth_desc;
-			const char *msg;
+			char *eol;
 			timestamp_t timestamp;
 			int tz;
 
@@ -771,15 +771,13 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				reflog = i;
 				break;
 			}
-			msg = strchr(logmsg, '\t');
-			if (!msg)
-				msg = "(none)";
-			else
-				msg++;
+			eol = strchr(logmsg, '\n');
+			if (eol)
+				*eol = '\0';
 			reflog_msg[i] = xstrfmt("(%s) %s",
 						show_date(timestamp, tz,
 							  DATE_MODE(RELATIVE)),
-						msg);
+						logmsg);
 			free(logmsg);
 
 			nth_desc = xstrfmt("%s@{%d}", *av, base+i);

Easy enough. But the output is still subtly wrong! Now we're back to
6436a20284 (refs: allow @{n} to work with n-sized reflog, 2021-01-07)
again. Before that commit, applying the fix above gives the expected
output from my test:

  ! [branch@{0}] (0 seconds ago) commit: three
   ! [branch@{1}] (60 seconds ago) commit: two
    ! [branch@{2}] (2 minutes ago) reset: moving to HEAD^
     ! [branch@{3}] (2 minutes ago) commit: one

but afterwards, entries higher than one are all shifted (so 1 is a
duplicate of 0, 2 is the old 1, and so on):

  ! [branch@{0}] (0 seconds ago) commit: three
   ! [branch@{1}] (0 seconds ago) commit: three
    ! [branch@{2}] (60 seconds ago) commit: two
     ! [branch@{3}] (2 minutes ago) reset: moving to HEAD^

I am still trying to wrap my head around how it can get such wrong
results for show-branch when asking for "git rev-parse branch@{0}", etc,
are correct. I think it is that "rev-parse branch@{0}" is only looking
at the output oid and does not consider the reflog message at all. So I
think it is subtly broken, but in a way that happens to work for that
caller. But I'm not sure of the correct fix. At least not at this time
of night.

Cc-ing folks involved in 6436a20284.

-Peff
