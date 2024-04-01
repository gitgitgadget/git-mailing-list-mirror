Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6761362
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 02:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711939455; cv=none; b=WX4yByItIr20WEk7bjWkxt0nUKUxv+r7HfnDapAj5DUHBp365haOM6iSamGKqbl/vm/SsNyTWw+Ym6oB8d9Ih7/oXfdijhIYrDJPu9ZiGbUBJxgaEwKvofttvGZ3oBAlPf1+le/jlIdhSgLXvLsy7GlMwwDjawyX3W0+V3FC/L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711939455; c=relaxed/simple;
	bh=CqvANtSqj2dAczzKxUmwXXfmVD/4FBw49M01Ycj7jN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfMUck19OtxPtkk+Pez7fIkqsxj9pNSS54xEytGWl5SoFCxRiMbQdLM2yCIJbJvCpXRRzF1lVrw5q125kA+nts0XqTMXNwUEut718umqQKNdh6izOJZ5Y+H9PBrxX+Nw8B1iQycyae3Wdhq0CKw/XQGk3Kd4Vg9EC2a2o/FCnbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 12991 invoked by uid 109); 1 Apr 2024 02:44:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Apr 2024 02:44:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14335 invoked by uid 111); 1 Apr 2024 02:44:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 31 Mar 2024 22:44:15 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 31 Mar 2024 22:44:11 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "Nude F. Ninja" <nudefninja@gmail.com>, git@vger.kernel.org
Subject: Re: :/regex syntax picks stash entries over regular commits
Message-ID: <20240401024411.GA2639525@coredump.intra.peff.net>
References: <CAOSCdbFg8jY1_0JE0+xf8oxrJjx-Kj0Cb0pPg3oUAXMN5q=kzw@mail.gmail.com>
 <xmqqy19ydmro.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy19ydmro.fsf@gitster.g>

On Sun, Mar 31, 2024 at 04:06:35PM -0700, Junio C Hamano wrote:

> "Nude F. Ninja" <nudefninja@gmail.com> writes:
> 
> > What did you do before the bug happened? (Steps to reproduce your issue)
> > I ran git stash push, which created the stash entry "On main: dark
> > mode". Then I committed changes before noticing an oversight with the
> > previous commit. I wrote the fix and ran git commit --fixup :/dark
> 
> It is natural that there are multiple commits that match the pattern
> you give in your repository.
> 
> One trick I learned that is effective is to explicitly state where
> to start searches, e.g. "--fixup 'HEAD^{/dark mode}'", which would
> be very much in line to what --fixup wants to do.  The commit to be
> fixed up in a later rebase session by definition must be an ancestor
> of the current HEAD.

Yeah, the "traverse all commits" aspect of ":/" is well known and
confusing, and why we introduced the rev ^{/} syntax. But I still wonder
if it would be better to limit ":/" to something more sensible. Finding
"refs/stash" or "refs/notes/*" is downright confusing (stash especially
because we don't walk the reflog, so it sees only stash@{0}, and not the
others!).

It would be pretty easy to do the equivalent of "--branches --tags
--remotes":

diff --git a/object-name.c b/object-name.c
index 523af6f64f..5285903f78 100644
--- a/object-name.c
+++ b/object-name.c
@@ -2002,7 +2002,9 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 
 			cb.repo = repo;
 			cb.list = &list;
-			refs_for_each_ref(get_main_ref_store(repo), handle_one_ref, &cb);
+			refs_for_each_ref_in(get_main_ref_store(repo), "refs/heads/", handle_one_ref, &cb);
+			refs_for_each_ref_in(get_main_ref_store(repo), "refs/tags/", handle_one_ref, &cb);
+			refs_for_each_ref_in(get_main_ref_store(repo), "refs/remotes/", handle_one_ref, &cb);
 			refs_head_ref(get_main_ref_store(repo), handle_one_ref, &cb);
 			commit_list_sort_by_date(&list);
 			return get_oid_oneline(repo, name + 2, oid, list);

Or alternatively to skip known-confusing parts of the namespace like
refs/stash.

I dunno. I have long ago written off :/ as useless, so maybe trying to
make it slightly less confusing is a fool's errand. Maybe we'd be better
off putting a note in its documentation that rev^{/} is more likely to
do what you want.

-Peff
