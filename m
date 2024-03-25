Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175B8153579
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 06:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711347302; cv=none; b=Ljad7PRDdwc6iTvj3xiHQ6hmU/LLVhnH9tGC5mazJL1vxFYT0n3CE2KzNO6X2keG1ps32WEGbYVnwC+iASSM2HwAUQzXJj0J5bU0mgcIKSQfwglE9/9ciKXS4PIUKbcp7Tdtp+YGqtYnlatnFCK+j73LP6rPP3+Z+UoeUBm5eaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711347302; c=relaxed/simple;
	bh=CAq+Wbp9t4HGu7QeW8BSncneiYzVzoZVFQBHVqvolt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFzj4Xs2/Xi9GnvYISqem1GvLwUyh2G+tDohalR1bckY7bgzSBvq8FKOckXbGFthEjXBBVo2ZBgPQNnTComxKE5bKsA2SIQlhylM2CnsCyEFfTQic4g0uvsU4TJJqpF51JaDy1vo3aYCNWzBSEwdytRGVl/pocBRVidomK0XVXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 10926 invoked by uid 109); 25 Mar 2024 06:14:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Mar 2024 06:14:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 845 invoked by uid 111); 25 Mar 2024 06:14:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Mar 2024 02:14:57 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 25 Mar 2024 02:14:52 -0400
From: Jeff King <peff@peff.net>
To: Brian Lyles <brianmlyles@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] pretty: find pretty formats case-insensitively
Message-ID: <20240325061452.GA242093@coredump.intra.peff.net>
References: <20240324214316.917513-1-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240324214316.917513-1-brianmlyles@gmail.com>

On Sun, Mar 24, 2024 at 04:43:09PM -0500, Brian Lyles wrote:

> User-defined pretty formats are stored in config, which is meant to use
> case-insensitive matching for names as noted in config.txt's 'Syntax'
> section:
> 
>     All the other lines [...] are recognized as setting variables, in
>     the form 'name = value' [...]. The variable names are
>     case-insensitive, [...].
> 
> When a user specifies one of their format aliases with an uppercase in
> it, however, it is not found.
> 
>     $ git config pretty.testAlias %h
>     $ git config --list | grep pretty
>     pretty.testalias=%h
>     $ git log --format=testAlias -1
>     fatal: invalid --pretty format: testAlias
>     $ git log --format=testalias -1
>     3c2a3fdc38

Yeah, I agree that case-insensitive matching makes more sense here due
to the nature of config keys, especially given this:

> This is true whether the name in the config file uses any uppercase
> characters or not.

I.e., the config code is going to normalize the variable names already,
so we must match (even if the user consistently specifies camelCase).

But...

>  static struct cmt_fmt_map *find_commit_format(const char *sought)
>  {
> +	struct cmt_fmt_map *result;
> +	char *sought_lower;
> +
>  	if (!commit_formats)
>  		setup_commit_formats();
>  
> -	return find_commit_format_recursive(sought, sought, 0);
> +	/*
> +	 * The sought name will be compared to config names that have already
> +	 * been normalized to lowercase.
> +	 */
> +	sought_lower = xstrdup_tolower(sought);
> +	result = find_commit_format_recursive(sought_lower, sought_lower, 0);
> +	free(sought_lower);
> +	return result;
>  }

The mention of "recursive" in the function we call made me what wonder
if we'd need more normalization. And I think we do. Try this
modification to your test:

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 321e305979..be549b1d4b 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -61,8 +61,9 @@ test_expect_success 'alias user-defined format' '
 
 test_expect_success 'alias user-defined format is matched case-insensitively' '
 	git log --pretty="format:%h" >expected &&
-	git config pretty.testalias "format:%h" &&
-	git log --pretty=testAlias >actual &&
+	git config pretty.testone "format:%h" &&
+	git config pretty.testtwo testOne &&
+	git log --pretty=testTwo >actual &&
 	test_cmp expected actual
 '
 

which fails because looking up "testOne" in the recursion won't work. So
I think we'd want to simply match case-insensitively inside the
function, like:

diff --git a/pretty.c b/pretty.c
index 50825c9d25..10f71ee004 100644
--- a/pretty.c
+++ b/pretty.c
@@ -147,7 +147,7 @@ static struct cmt_fmt_map *find_commit_format_recursive(const char *sought,
 	for (i = 0; i < commit_formats_len; i++) {
 		size_t match_len;
 
-		if (!starts_with(commit_formats[i].name, sought))
+		if (!istarts_with(commit_formats[i].name, sought))
 			continue;
 
 		match_len = strlen(commit_formats[i].name);

And then you would not even need to normalize it in
find_commit_format().

> +test_expect_success 'alias user-defined format is matched case-insensitively' '
> +	git log --pretty="format:%h" >expected &&
> +	git config pretty.testalias "format:%h" &&
> +	git log --pretty=testAlias >actual &&
> +	test_cmp expected actual
> +'

Modern style would be to use "test_config" here (or just "git -c"), but
I see the surrounding tests are too old to do so. So I'd be OK with
matching them (but cleaning up all of the surrounding ones would be
nice, too).

-Peff

PS The matching rules in find_commit_format_recursive() seem weird
   to me. We do a prefix match, and then return the entry whose name is
   the shortest? And break ties based on which came first? So:

     git -c pretty.abcd=format:one \
         -c pretty.abc=format:two \
         -c pretty.abd=format:three \
	 log -1 --format=ab

   quietly chooses "two". I guess the "shortest wins" is meant to allow
   "foo" to be chosen over "foobar" if you specify the whole name. But
   the fact that we don't flag an ambiguity between "abc" and "abd"
   seems strange.

   That is all orthogonal to your patch, of course, but just a
   head-scratcher I noticed while looking at the code.
