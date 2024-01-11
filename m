Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AC01C2D
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pb9ziMNE"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 14E921D3A80;
	Thu, 11 Jan 2024 17:33:23 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Yl7wC+HBh3spxMkDoCADMRhQVwYzAqCDRKXxN0
	3vle8=; b=Pb9ziMNESZkN//Ms01KNbTO2PTR/hDLMGGl47qhsCLipBIJJuvCZv+
	x9yxzPT/UGK87aGu6uEphdAxvRfBEg4ixCgIv0QenL0pwaNtBNje9tY4hHDJShL2
	GDQOnIhH5OrqdUm29bg4nR7HkGBrPn3+BQWKrHIILYW0ggF8E8UPQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D7661D3A7F;
	Thu, 11 Jan 2024 17:33:23 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6CAB21D3A7D;
	Thu, 11 Jan 2024 17:33:22 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Benji Kay via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Benji Kay <okaybenji@gmail.com>
Subject: Re: [PATCH] push: improve consistency of output when "up to date"
In-Reply-To: <CAPig+cRr0V2ecnmxk1H_yF24dwSFA6niPxYXGH0MZ+wGP9m9UA@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 11 Jan 2024 16:43:01 -0500")
References: <pull.1638.git.1705008449995.gitgitgadget@gmail.com>
	<CAPig+cRr0V2ecnmxk1H_yF24dwSFA6niPxYXGH0MZ+wGP9m9UA@mail.gmail.com>
Date: Thu, 11 Jan 2024 14:33:21 -0800
Message-ID: <xmqqjzofec0e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6D5E1638-B0D1-11EE-A2FC-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> Thanks. This particular change is proposed periodically...
>
>> diff --git a/transport.c b/transport.c
>> @@ -1467,7 +1467,7 @@ int transport_push(struct repository *r,
>>         else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
>> -               fprintf(stderr, "Everything up-to-date\n");
>> +               fprintf(stderr, "Everything up to date.\n");
>
> ... but has not been considered desirable.
>
> See, for instance, this email thread explaining the rationale for
> avoiding such a change:
> https://lore.kernel.org/git/pull.1298.git.1658908927714.gitgitgadget@gmail.com/T/

Looking at the "grep" hits:

$ git grep -e 'up-to-date.*"' \*.c
builtin/rm.c:	OPT__FORCE(&force, N_("override the up-to-date check"), PARSE_OPT_NOCOMPLETE),
builtin/send-pack.c:		fprintf(stderr, "Everything up-to-date\n");
http-push.c:				fprintf(stderr, "'%s': up-to-date\n", ref->name);
http-push.c:				      "Maybe you are not up-to-date and "
transport.c:		fprintf(stderr, "Everything up-to-date\n");

it is true that these are not marked for translation, which should
be a clue enough that we want them to be exactly the way they are
spelled.  However, they are going to the standard error stream.  Is
it reasonable to expect third-party tools scraping it to find the
string "up-to-date"?

In any case, a safe first step is to add a short comment to each of
these that should not be translated.  Perhaps something along this
line.


------- >8 ------------- >8 ------------- >8 -------
Subject: [PATCH] messages: mark some strings with "up-to-date" not to touch

The treewide clean-up of "up-to-date" strings done in 7560f547
(treewide: correct several "up-to-date" to "up to date", 2017-08-23)
deliberately left some out, but unlike the lines that were changed
by the commit, the lines that were deliberately left untouched by
the commit is impossible to ask "git blame" to link back to the
commit that did not touch them.

Let's do the second best thing, leave a short comment near them, to
make it possible for those who are motivated enough to find out why
we decided to tell them "do not modify".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin/send-pack.c | 1 +
 http-push.c         | 2 ++
 transport.c         | 1 +
 3 files changed, 4 insertions(+)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index b7183be970..ac7ec1e643 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -333,6 +333,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!ret && !transport_refs_pushed(remote_refs))
+		/* do not modify this string */
 		fprintf(stderr, "Everything up-to-date\n");
 
 	return ret;
diff --git a/http-push.c b/http-push.c
index b4d0b2a6aa..e4c6645cc2 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1851,6 +1851,7 @@ int cmd_main(int argc, const char **argv)
 
 		if (oideq(&ref->old_oid, &ref->peer_ref->new_oid)) {
 			if (push_verbosely)
+				/* do not modify this string */
 				fprintf(stderr, "'%s': up-to-date\n", ref->name);
 			if (helper_status)
 				printf("ok %s up to date\n", ref->name);
@@ -1871,6 +1872,7 @@ int cmd_main(int argc, const char **argv)
 				 * commits at the remote end and likely
 				 * we were not up to date to begin with.
 				 */
+				/* do not modify this string */
 				error("remote '%s' is not an ancestor of\n"
 				      "local '%s'.\n"
 				      "Maybe you are not up-to-date and "
diff --git a/transport.c b/transport.c
index bd7899e9bf..c9f39d45f1 100644
--- a/transport.c
+++ b/transport.c
@@ -1467,6 +1467,7 @@ int transport_push(struct repository *r,
 	if (porcelain && !push_ret)
 		puts("Done");
 	else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
+		/* do not modify this string */
 		fprintf(stderr, "Everything up-to-date\n");
 
 done:
-- 
2.43.0-283-ga54a84b333

