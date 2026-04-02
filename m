Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E87360722
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 04:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103301; cv=none; b=eH270KK7gw7BmVUbKItOQtG3p7kVk9m5JFXbN02XUkWeAGR4egqyN0hDLMLKtL1oylaLeeAmKq3itn3yLm/jT0Q75N8iruGi8+AmqyUcTMUTnuEshYpe/lMhQD8ZePhifLN+cZp0CS4e4JjENmkkjsfqRZi3owlFBrGnJGJrUe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103301; c=relaxed/simple;
	bh=u7IKrQOhO3ico9/S6st0NtssR1XPi9+lfXh2SwbfSok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hn2ET/79x2XpRhyVL2B1F9htG7btaIxSPRbDe9n7XJaUOQBnJZq44zH9holcod45Xlbj2vlX10NStw8zjPE5d/1ZOa7lSlhsj1e+hawEJ4GJv0QCUmU0iSUjnHN3hJ22kgB9nrKeXimbS2+ZC1Metln65/4Dfn+ImUlbHNQhwEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SK4Nxj4l; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SK4Nxj4l"
Received: (qmail 218818 invoked by uid 106); 2 Apr 2026 04:14:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=u7IKrQOhO3ico9/S6st0NtssR1XPi9+lfXh2SwbfSok=; b=SK4Nxj4lbm2Ujy/5RJoVaQpsmP8hkPMzLfd0RTOkOSSio75Ju09WXkhCeSGpDLjRMyXpwbNL6vYj/aPBylJtyk1YkdGwaeZjIjHTc4o3HMUi3MkY8ZfNXQcdma+NKCjDDg7ACwKg0SrScXz8BNORRaNGnvDo8sPI5KuAwR7buNMlqHOOUGB6Q6ZkmoD7z1ME1JDR45uwZR9mb9RYkaw3wcKKwJIsT31OYX6qrzGBk1PXXPp8QFJhNEJ7HFP+VvymIeQmggE3qwIM9Sh+4NpBfpbQ4gFxmcCn4DyRnllSZYBt9DpOvwlZYJgbjiLHE1yT2G7OHgq11WJNlQ31FjQeCA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Apr 2026 04:14:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 349722 invoked by uid 111); 2 Apr 2026 04:14:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Apr 2026 00:14:59 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Apr 2026 00:14:58 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Collin Funk <collin.funk1@gmail.com>,
	Michael J Gruber <git@grubix.eu>
Subject: [PATCH v2 04/12] pager: explicitly cast away strchr() constness
Message-ID: <20260402041458.GD3501239@coredump.intra.peff.net>
References: <20260402041433.GA3501120@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402041433.GA3501120@coredump.intra.peff.net>

When we do:

  char *cp = strchr(argv[i], '=');

it implicitly removes the constness from argv[i]. We need "cp" to remain
writable (since we overwrite it with a NUL). In theory we should be able
to drop the const from argv[i], because it is a sub-pointer into our
duplicated pager_env variable.

But we get it from split_cmdline(), which uses the traditional "const
char **" type for argv. This is overly limiting, but changing it would
be awkward for all the other callers of split_cmdline().

Let's do an explicit cast with a note about why it is OK. This is enough
to silence compiler warnings about the implicit const problems.

Signed-off-by: Jeff King <peff@peff.net>
---
 pager.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/pager.c b/pager.c
index 5531fff50e..35b210e048 100644
--- a/pager.c
+++ b/pager.c
@@ -108,10 +108,11 @@ const char *git_pager(struct repository *r, int stdout_is_tty)
 
 static void setup_pager_env(struct strvec *env)
 {
-	const char **argv;
+	char **argv;
 	int i;
 	char *pager_env = xstrdup(PAGER_ENV);
-	int n = split_cmdline(pager_env, &argv);
+	/* split_cmdline splits in place, so we know the result is writable */
+	int n = split_cmdline(pager_env, (const char ***)&argv);
 
 	if (n < 0)
 		die("malformed build-time PAGER_ENV: %s",
-- 
2.53.0.1172.ge9e20b5838

