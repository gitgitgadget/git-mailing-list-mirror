Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FE519AD73
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 11:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730374940; cv=none; b=ZdRpFacOq7BYANKi37HO7rxTePiAAqPxMczDAs4E/t/suWSSpHTou2OYvZM+upEbtg73ZsCeEFC5Lbhev+oLt2pi2/DQBGauXjCLKEppaoQKNzyzhPsMb01ICORqGrSMfX2dICTy4sgs/YtOtowKOwqPwm4gNVvJHu8J47rCq10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730374940; c=relaxed/simple;
	bh=cVVRcU+P8ZGqLgExz0weQRByb+6+IgTbUCtNjAVQhHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1CM4RJKozVwdOhFOYe8RL3CadvEL1pEkd0Q7Jgq6ZCWuAUjA0hUYKNvlHJ+uRz/v+W4nYwADYqGKwo7jS0XJol5Gct7nY5sW62IHLVUMxy8lhkZv2Cw6W9oOl0AiSIx1NQDjNppXD5f0Yfgh1tO0x03X95DGw/bmzSi+k6ttX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fwxKkXyz; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fwxKkXyz"
Received: (qmail 18595 invoked by uid 109); 31 Oct 2024 11:42:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=cVVRcU+P8ZGqLgExz0weQRByb+6+IgTbUCtNjAVQhHM=; b=fwxKkXyziyAut/7iaXZpMaJ9YrGrd6FnqlxMnpfUmk7mm1Z6vESj/oVdOh9BYj1g/caCuy1BiLQVGoiW4Zti4YhvBvyJrOOQRfDo8P42JkbqsiXGyqeV1TCv3hBgJd1GpSRwnyeY2kQabITSTuX+QcctW9dMupPADG9oS9Wj16USiC7LNGOKVVbfiR4A/q++pJnKVBT2//KVcoIPg+3TIs3k38eQ+xmYYhjSITfZL92FYLrO4KCXt8fSU+wvCsEYL6MgQSNHxsIC4Z/LBgDlGQI5mj9euQ7ZC6RT9FAPWqzpt0Qrjci76ZjW19VuW/TVOciazMse0W1NqNbK545xXQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Oct 2024 11:42:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31677 invoked by uid 111); 31 Oct 2024 11:42:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Oct 2024 07:42:10 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 31 Oct 2024 07:42:10 -0400
From: Jeff King <peff@peff.net>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	git@vger.kernel.org
Subject: Re: [PATCH] setlocalversion: Add workaround for "git describe"
 performance issue
Message-ID: <20241031114210.GA593548@coredump.intra.peff.net>
References: <309549cafdcfe50c4fceac3263220cc3d8b109b2.1730337435.git.jpoimboe@kernel.org>
 <87bjz0k17c.fsf@prevas.dk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bjz0k17c.fsf@prevas.dk>

On Thu, Oct 31, 2024 at 11:37:27AM +0100, Rasmus Villemoes wrote:

> and that "gave up" commit is v4.18-rc4, the eleventh commit
> encountered. That also explains why you have to add a "dummy" second
> --match to make --candidates=1 have the expected behaviour.
> 
> Perhaps the logic should instead be that as soon as match_cnt hits
> max_candidates (i.e. all the tags we're going to consider have actually
> been visited), we break out. That is, the last "else" above should
> instead be replaced by
> 
>   if (match_cnt == max_candidates) {
>     ... /* ? , gave_up_on is now a misnomer */
>     break;
>   }

Yes, I agree that is the right direction. Replacing the "else" entirely
feels a little weird, because it is part of the:

  if (!tags && !all && n->prio < 2)
	...
  else if (match_cnt < max_candidates)
	...
  else
	...

So we'd now run that check even if we triggered the first block. But I
don't think it should matter in practice. We only increment match_cnt in
the else-if here. So the "else" block could go away, and the check for
giving up could go inside the else-if.

It does seem like gave_up_on is now pointless, but I'm not sure I
understand all of the code here. I assumed that it was only used to
report "this is where we gave up", and to give you the extra bit of
information that there _were_ other candidates that we omitted (and not
just exactly max_candidates). Of course we don't show that without
--debug. So it seems silly to spend a bunch of extra CPU for that.

But the plot thickens.

What I was going to suggest is that if we wanted to retain that one bit
of information, what we could do instead is: independent of
max_candidates, see if we've found all of the possible names we expanded
from --match. Then max_candidates would work as it does now, but we'd
avoid fruitlessly searching when there are no more names to find.

Counting the number of expanded names is a little weird. We use them to
annotate the commits, but of course multiple names can point to a single
commit, and there's a priority override system. I think the final number
we can find is the number of entries in the "names" hash.

So I expected this to work:

diff --git a/builtin/describe.c b/builtin/describe.c
index 7330a77b38..70a11072de 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -380,6 +380,9 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 				c->object.flags |= t->flag_within;
 				if (n->prio == 2)
 					annotated_cnt++;
+
+				if (match_cnt == hashmap_get_size(&names))
+					break;
 			}
 			else {
 				gave_up_on = c;

but it's still slow! If we set "gave_up_on = c", then it gets fast. I'm
not sure why that is. Later we do:

        if (gave_up_on) {
                commit_list_insert_by_date(gave_up_on, &list);
                seen_commits--;
        }
        seen_commits += finish_depth_computation(&list, &all_matches[0]);

but I don't at all understand why adding gave_up_on lets that finish
sooner. So I'm worried we're missing something about how it is used.

One hack is to just, like the max_candidates case, let us look at one
_more_ commit before bailing. Like this:

diff --git a/builtin/describe.c b/builtin/describe.c
index 7330a77b38..177c8232f6 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -365,6 +365,11 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 		struct commit_list *parents = c->parents;
 		struct commit_name **slot;
 
+		if (match_cnt == hashmap_get_size(&names)) {
+			gave_up_on = c;
+			break;
+		}
+
 		seen_commits++;
 		slot = commit_names_peek(&commit_names, c);
 		n = slot ? *slot : NULL;


That works, but I have a feeling that figured out what the heck is going
on with gave_up_on might produce a more elegant solution.

> Then as a further DWIM aid, wherever the initialization logic is could
> be updated so that, after expanding all the --match= wildcards, if the
> number of tags is less than max_candidates, automatically lower
> max_candidates to that number (which in the setlocalversion case will
> always be 1 because we're not actually passing a wildcard).

Yeah, I had the same thought (though if we do a separate hashmap check
as above, it wouldn't be needed).

-Peff
