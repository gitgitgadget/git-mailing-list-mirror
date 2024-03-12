Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E578E78285
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235029; cv=none; b=BFm/mD1uVQvPertbDBQKVKees82kr0Bf4/AsT06m8FNWE2Herj9yMxKxTkcQSSoKAfbA99S2aBMYXaHZF3HKoYxYyNul+MjpHrnFPhaM0Tneb+j4sIVvuSO9knm2jf2nqcNZE70koIvnNwgYy90swJ20IRnjDOeglFchl+osBzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235029; c=relaxed/simple;
	bh=8/gaBe020pkfhuTohNqkA909omd7GHlXa6WsvM41NfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYG/aKbChYPeixoJjK9MXe2q7UWgdpY7pdaxWpdvtq+rCJQ1//w/izrdgKVDwjbS5uiGu1pMqPqbBMgo4MNCohD9SNIus+ap6U7MZETjfqoux/nPkMi6xbIEHXzR8xBuG5hiHCqrflnGa3apz70wWQajyA1ZJt1JO/t5hRdXQOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17425 invoked by uid 109); 12 Mar 2024 09:17:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Mar 2024 09:17:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27995 invoked by uid 111); 12 Mar 2024 09:17:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Mar 2024 05:17:11 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Mar 2024 05:17:06 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 01/16] config: forbid newline as core.commentChar
Message-ID: <20240312091706.GA95609@coredump.intra.peff.net>
References: <20240312091013.GA95442@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240312091013.GA95442@coredump.intra.peff.net>

Since we usually look for a comment char while parsing line-oriented
files, setting core.commentChar to a single newline can confuse our code
quite a bit. For example, using it with "git commit" causes us to fail
to recognize any of the template as comments, including it in the config
message. Which kind of makes sense, since the template content is on its
own line (so no line can "start" with a newline). In other spots I would
not be surprised if you can create more mischief (e.g., violating loop
assumptions) but I didn't dig into it.

Since comment characters are a local preference, to some degree this is
a case of "if it hurts, don't do it". But given that this would be a
silly and pointless thing to do, and that it makes it harder to reason
about code parsing comment lines, let's just forbid it.

There are other cases that are perhaps questionable (e.g., setting the
comment char to a single space), but they seem to behave reasonably (at
least a simple "git commit" will correctly identify and strip the
template lines). So I haven't worried about going on a hunt for every
stupid thing a user might do to themselves, and just focused on the most
confusing case.

Signed-off-by: Jeff King <peff@peff.net>
---
In the string version I suppose you could set it to "\nexec rm -rf /" if
you really wanted to treat yourself to a fun "git rebase". Again, this
is all local, but it's perhaps nice to know that core.commentChar is not
a vector for arbitrary code execution.

(That of course made me wonder if setting it to just "exec rm -rf / "
would work, as the rest of the template line would be ignored by "rm";
but that is self-defeating as we'd recognize the line as a comment and
remove it).

 config.c              | 2 ++
 t/t0030-stripspace.sh | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/config.c b/config.c
index 3cfeb3d8bd..f561631374 100644
--- a/config.c
+++ b/config.c
@@ -1566,6 +1566,8 @@ static int git_default_core_config(const char *var, const char *value,
 		else if (!strcasecmp(value, "auto"))
 			auto_comment_line_char = 1;
 		else if (value[0] && !value[1]) {
+			if (value[0] == '\n')
+				return error(_("core.commentChar cannot be newline"));
 			comment_line_char = value[0];
 			auto_comment_line_char = 0;
 		} else
diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index d1b3be8725..e399dd9189 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -401,6 +401,11 @@ test_expect_success 'strip comments with changed comment char' '
 	test -z "$(echo "; comment" | git -c core.commentchar=";" stripspace -s)"
 '
 
+test_expect_success 'newline as commentchar is forbidden' '
+	test_must_fail git -c core.commentChar="$LF" stripspace -s 2>err &&
+	grep "core.commentChar cannot be newline" err
+'
+
 test_expect_success '-c with single line' '
 	printf "# foo\n" >expect &&
 	printf "foo" | git stripspace -c >actual &&
-- 
2.44.0.481.gf1a6d20963

