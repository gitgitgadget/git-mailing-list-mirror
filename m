From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] prepare_packed_git(): find more garbage
Date: Tue, 15 Dec 2015 18:09:57 -0500
Message-ID: <20151215230957.GA30353@sigill.intra.peff.net>
References: <CAGZ79kaCNT06mAGQbHNgZmdBQUyxGFTFA2Y2FXvG2UG+P7s2kg@mail.gmail.com>
 <1448518529-2659-1-git-send-email-dougk.ff7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sbeller@google.com, gitster@pobox.com
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 00:10:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8yjP-0000HF-8r
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 00:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933834AbbLOXKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 18:10:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:42647 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932463AbbLOXKA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 18:10:00 -0500
Received: (qmail 18190 invoked by uid 102); 15 Dec 2015 23:10:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Dec 2015 17:10:00 -0600
Received: (qmail 21003 invoked by uid 107); 15 Dec 2015 23:10:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Dec 2015 18:10:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Dec 2015 18:09:57 -0500
Content-Disposition: inline
In-Reply-To: <1448518529-2659-1-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282505>

On Thu, Nov 26, 2015 at 12:15:29AM -0600, Doug Kelly wrote:

> diff --git a/builtin/count-objects.c b/builtin/count-objects.c
> index ba92919..5197b57 100644
> --- a/builtin/count-objects.c
> +++ b/builtin/count-objects.c
> @@ -17,19 +17,15 @@ static off_t loose_size;
>  
>  static const char *bits_to_msg(unsigned seen_bits)
>  {
> -	switch (seen_bits) {
> -	case 0:
> -		return "no corresponding .idx or .pack";
> -	case PACKDIR_FILE_GARBAGE:
> +	if (seen_bits ==  PACKDIR_FILE_GARBAGE)
>  		return "garbage found";

It seems weird to use "==" on a bitfield. I think it is the case now
that we would never see GARBAGE alongside anything else, but I wonder if
we should future-proof that as:

  if (seen_bits & PACKDIR_FILE_GARBAGE)

Specifically, I am wondering what would happen if we had "foo.pack" and
"foo.bogus", where we do not know about the latter at all.

> -	case PACKDIR_FILE_PACK:
> +	else if (seen_bits & PACKDIR_FILE_PACK && !(seen_bits & PACKDIR_FILE_IDX))
>  		return "no corresponding .idx";
> -	case PACKDIR_FILE_IDX:
> +	else if (seen_bits & PACKDIR_FILE_IDX && !(seen_bits & PACKDIR_FILE_PACK))
>  		return "no corresponding .pack";
> -	case PACKDIR_FILE_PACK|PACKDIR_FILE_IDX:
> -	default:
> -		return NULL;
> -	}
> +	else if (seen_bits == 0 || !(seen_bits & (PACKDIR_FILE_IDX|PACKDIR_FILE_PACK)))
> +		return "no corresponding .idx or .pack";
> +	return NULL;

This bottom conditional is interesting. I understand the second half: we
saw something pack-like, but there is not matching .idx or .pack at all
(if we saw one but not the other, we would have caught it above).

But when will we get an empty seen_bits? What did we see that triggered
this function, but didn't trigger a bit (even GARBAGE)?

I don't mind if the answer is "nothing, this is future-proofing", but am
mostly curious.

> diff --git a/sha1_file.c b/sha1_file.c
> index 3d56746..5f939e4 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1225,6 +1225,15 @@ static void report_helper(const struct string_list *list,
>  	if (seen_bits == (PACKDIR_FILE_PACK|PACKDIR_FILE_IDX))
>  		return;
>  
> +	if (seen_bits == (PACKDIR_FILE_PACK|PACKDIR_FILE_IDX|PACKDIR_FILE_BITMAP))
> +		return;
> +
> +	if (seen_bits == (PACKDIR_FILE_PACK|PACKDIR_FILE_IDX|PACKDIR_FILE_KEEP))
> +		return;
> +
> +	if (seen_bits == (PACKDIR_FILE_PACK|PACKDIR_FILE_IDX|PACKDIR_FILE_BITMAP|PACKDIR_FILE_KEEP))
> +		return;
> +

It seems like we're enumerating a lot of cases here that will explode if
we get even one more file type (e.g., we add "pack-XXX.foo" in the
future). If I understand this function correctly, we're just trying to
get rid of "boring" cases that do not need to be reported.

Isn't any case that has both a pack and an idx boring (no matter if it
has a .bitmap or .keep)?

IOW, can these four conditionals just become:

  unsigned pack_with_idx = PACKDIR_FILE_PACK | PACKDIR_FILE_IDX;

  if ((seen_bits & pack_with_idx) == pack_with_idx)
	return;

?

-Peff
