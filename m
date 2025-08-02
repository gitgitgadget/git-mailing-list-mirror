Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A027D1DDA1E
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754123929; cv=none; b=KoxJ4W3lGaUIGyp+XlZ7yqgfFEtwBoZlwY6fxF9xQVcLrVuWBuB7MvAntsK67GwS5wkCW0VceK1ZnfyXB+nCqTybUrKFZ1GoLqqanX14XlD+qh3mtzBbAXPYwEQLSAW+tT6jbviBc76kiIq4MvFsZMyZeSL+6g24j0KWJaHan1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754123929; c=relaxed/simple;
	bh=3QsfJ+sqV9HYNyFWL6+4r2aDbyPS/8cLf5ZY+va2rP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNb+6ZBkDwImyrT8CQFCAdGFRbUDuqk1yRTAmUbf8JrFFMVXdZrvOjg1xfns6eMcJcUisNwmjdtPhn35qO2+MqTZvHcsNMRw603tTGqv5FsUDgL3X7xn4DVQG/6p6cFI3idMl/PzGDjEs8tMiMJ4HiBPLUOqhzlvcNmCq6OQyEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PHxX1RwV; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PHxX1RwV"
Received: (qmail 8690 invoked by uid 109); 2 Aug 2025 08:38:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3QsfJ+sqV9HYNyFWL6+4r2aDbyPS/8cLf5ZY+va2rP0=; b=PHxX1RwVjl5wRIBbPBACaN/Wq+/Qimgf3S5CyFG4AIfi1wOGcQdcrKAUZoiV+3GTesBw1GaY5yMwDQTDA97Yqn16UM4ExGcLtXM/mK/mETv3L/mP0Ae2FszzCOxnKgzGFkuHqA77JByq6C1cRkkWtD18L1uDpjjdeXDM0r7JlQ293AbFVomc8dso8xID/PY/1oinJeuOgA1dK6Vv22UZ6Yly4CSLBUc6G9ILxsm57heFQYwManEYV74aW/HKtDqSaRTS0ik+U7eIKsPIF2g1oxSdpGeQk3uuRSa1fy8heQu1SUQzQlk8c9ZKNjv3opUqqQsE01zRhdRKeei9UBClkg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 02 Aug 2025 08:38:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10755 invoked by uid 111); 2 Aug 2025 08:38:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 02 Aug 2025 04:38:51 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 2 Aug 2025 04:38:46 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 02/11] clean: do not pass strbuf by value
Message-ID: <20250802083846.GC3711639@coredump.intra.peff.net>
References: <20250731074154.2835370-1-gitster@pobox.com>
 <20250731225433.4028872-1-gitster@pobox.com>
 <20250731225433.4028872-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250731225433.4028872-3-gitster@pobox.com>

On Thu, Jul 31, 2025 at 03:54:24PM -0700, Junio C Hamano wrote:

> This is a catastrophe waiting to happen.  If the callee causes the
> strbuf to be reallocated, the buf[] the caller has will become
> dangling, and when the caller does strbuf_release(), it would result
> in double-free.
> 
> Stop calling the function with misleading call-by-value with strbuf.

This is definitely an improvement, though I wonder if we could go
further.

When I saw the original version of this patch, my first thought was: if
we are passing a strbuf that is not modified, then why not just pass a
const string pointer? It is more flexible for the caller and makes our
intention more clear. (A careful reader will note that this does not
pass in the length, so it is different if we expect embedded NULs, but I
don't think that is the case here).

But it does not quite work in this case because of this:

>  	if (is_single) {
> -		choice_list = strbuf_split_max(&input, '\n', 0);
> +		choice_list = strbuf_split_max(input, '\n', 0);
>  	} else {
> -		char *p = input.buf;
> +		char *p = input->buf;
>  		do {
>  			if (*p == ',')
>  				*p = ' ';
>  		} while (*p++);
> -		choice_list = strbuf_split_max(&input, ' ', 0);
> +		choice_list = strbuf_split_max(input, ' ', 0);
>  	}

We do modify the string! However, that code goes away in your next patch
when we are able to switch to a split function that handles multiple
delimiters. You do still do an in-place split, but isn't strictly
needed.

If we swapped patches 2 and 3 in this series, then the strbuf cleanup
can just become:

diff --git a/builtin/clean.c b/builtin/clean.c
index a01d130f62..e4b075df70 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -477,17 +477,17 @@ static int find_unique(const char *choice, struct menu_stuff *menu_stuff)
  */
 static int parse_choice(struct menu_stuff *menu_stuff,
 			int is_single,
-			struct strbuf input,
+			const char *input,
 			int **chosen)
 {
-	struct string_list choice = STRING_LIST_INIT_NODUP;
+	struct string_list choice = STRING_LIST_INIT_DUP;
 	struct string_list_item *item;
 	int nr = 0;
 	int i;
 
-	string_list_split_in_place_f(&choice, input.buf,
-				     is_single ? "\n" : ", ", -1,
-				     STRING_LIST_SPLIT_TRIM);
+	string_list_split_f(&choice, input,
+			    is_single ? "\n" : ", ", -1,
+			    STRING_LIST_SPLIT_TRIM);
 
 	for_each_string_list_item(item, &choice) {
 		const char *string;
@@ -626,7 +626,7 @@ static int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff)
 
 		nr = parse_choice(stuff,
 				  opts->flags & MENU_OPTS_SINGLETON,
-				  choice,
+				  choice.buf,
 				  &chosen);
 
 		if (opts->flags & MENU_OPTS_SINGLETON) {

I dunno. Maybe it is nitpicking, but I think "don't take a strbuf if you
only need a string" is a good general rule. Of course there is only one
caller here, so flexibility is probably not that important.

-Peff
