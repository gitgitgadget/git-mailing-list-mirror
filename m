Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071931BC4A
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932172; cv=none; b=Wxnrgg5fznsU6xFdoT0xB8yNjCZKRTne0qun+l+Mz2rJa0Eh8UD3+mKStg7AiwWcp+x3/SCApk4h1oGKX2XW+P0aVOfeMPaUxJW036lJQHwR2jIXHRrpx5wsohRbxhbcgeY685xK3yHHVJBL8hEsBYGn1X8tKaTNUlv2f8iNcmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932172; c=relaxed/simple;
	bh=89lI9sdqijFJ38iDmG2XhSYrLmgYlE6jZfezSWrK8sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPfkGpZ8rGxpa2HHtC+EoqpyGH7f2TY1nPuVoe0L40ifzRqZWEhCj/hEg9pz2T9J172J7y9SjdJMhOoolHXgVw4uVdejZn9hOI4SXLv10fA7y22gNuN0vk6tUppKzyUmruBn2PVwOB9KoHZHByOg2ZiSKGaBAKcxe5qNJGU1jmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19417 invoked by uid 109); 26 Feb 2024 07:22:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 26 Feb 2024 07:22:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 374 invoked by uid 111); 26 Feb 2024 07:22:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Feb 2024 02:22:53 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 26 Feb 2024 02:22:48 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UGF3ZcWC?= Dominiak <dominiak.pawel@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Bug: diff --no-index with cachetextconv crashes
Message-ID: <20240226072248.GC780982@coredump.intra.peff.net>
References: <CACeVQwQ4MELjB8nZyeu9QDTtgwhhw0oOsL8BHdm_rxTj1vMy+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACeVQwQ4MELjB8nZyeu9QDTtgwhhw0oOsL8BHdm_rxTj1vMy+A@mail.gmail.com>

On Mon, Feb 26, 2024 at 08:03:04AM +0100, Paweł Dominiak wrote:

> That's my first bug report for git and my first email to a mailing
> list in general, I hope for understanding :)

Hi, welcome, and thanks for a clear bug report. :)

> [Steps to reproduce your issue]
> 
> Global .gitattributes:
> 
> *.txt diff=test
> 
> Global .gitconfig:
> 
> [diff "test"]
>     textconv = cat
>     cachetextconv = true
> 
> Called command:
> 
> git --no-pager diff --no-index foo.txt bar.txt

OK, I would say that this failing is semi-expected. :) The caching
system works using "git notes", which are stored in refs in the
repository. And since you are running "diff --no-index" outside of a
repository, there is nowhere to put them.

And so this BUG call makes sense:

> BUG: refs.c:2095: attempting to get main_ref_store outside of repository

We tried to load notes but there's no ref store at all, and the
low-level ref code caught this.

Of course any time we see a BUG something has gone wrong. What I think
_should_ happen is that we should quietly disable the caching (which,
after all, is just an optimization) and otherwise complete the command.

So we'd probably want something like this:

diff --git a/userdiff.c b/userdiff.c
index e399543823..fce3a31efa 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -3,6 +3,7 @@
 #include "userdiff.h"
 #include "attr.h"
 #include "strbuf.h"
+#include "environment.h"
 
 static struct userdiff_driver *drivers;
 static int ndrivers;
@@ -460,7 +461,8 @@ struct userdiff_driver *userdiff_get_textconv(struct repository *r,
 	if (!driver->textconv)
 		return NULL;
 
-	if (driver->textconv_want_cache && !driver->textconv_cache) {
+	if (driver->textconv_want_cache && !driver->textconv_cache &&
+	    have_git_dir()) {
 		struct notes_cache *c = xmalloc(sizeof(*c));
 		struct strbuf name = STRBUF_INIT;
 

-Peff
