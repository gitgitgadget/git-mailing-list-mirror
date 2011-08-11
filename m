From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/6] revert: Parse instruction sheet more cautiously
Date: Thu, 11 Aug 2011 14:47:08 -0500
Message-ID: <20110811194708.GG2277@elie.gateway.2wire.net>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
 <1313088705-32222-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 21:47:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrbDq-0005dI-4R
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 21:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914Ab1HKTrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 15:47:13 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64374 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168Ab1HKTrM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 15:47:12 -0400
Received: by ywf7 with SMTP id 7so1550901ywf.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 12:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WHSH8zb+LIf/TLLlQdUeNVYhvi8Atw8d33QX1Ty7Nww=;
        b=x2TmfzLzPPfR7AxCw/KqYejGNUIULa2wUtsnU2J8z86YTdn5ZKd3c9Wai5sNlHAzYv
         Dg7Hp7z9DkGsdBEAPYIrsLFORvJdGHuhtvZGj6Ku0JfvBgT9qIDR+fyxjTiF8Tg102bj
         2lcDTEVsvBr0hBv9bzu+FgtgsEmuZ/BWWQDBE=
Received: by 10.236.193.106 with SMTP id j70mr142670yhn.86.1313092031713;
        Thu, 11 Aug 2011 12:47:11 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-69-68.dsl.chcgil.sbcglobal.net [69.209.69.68])
        by mx.google.com with ESMTPS id c63sm2531679yhe.18.2011.08.11.12.47.10
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 12:47:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313088705-32222-4-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179138>

Ramkumar Ramachandra wrote:

> Fix a buffer overflow bug by checking that parsed SHA-1 hex will fit
> in the buffer we've created for it.

Nit: it seems best to either describe the behavior or the code change.
So, for example:

	Do not overflow a buffer when the second word in a "pick"
	or "revert" line in .git/sequencer/todo is very long.

Or:

	Check that the commit name argument to a "pick" or "revert"
	action is not too long, to avoid overflowing an on-stack
	buffer.

It would also be comforting to readers to mention when the bug was
introduced, so they don't start worrying about protecting their
installations against privilege escalation:

	This fixes a regression introduced by <...>, which has not
	escaped into the wild yet, luckily.

Could we have a test for this?

> Also change the instruction sheet format

How is this "Also" part related to the earlier bit?  Does one make the
other easier, or is it more of a "While we're changing this code" kind
of thing?

> subtly so that a description of the commit after the object
> name is optional.  So now, an instruction sheet like this is perfectly
> valid:
>
>   pick 35b0426
>   pick fbd5bbcbc2e
>   pick 7362160f

Sounds convenient. :)  Thanks.

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -697,26 +697,24 @@ static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
>  	unsigned char commit_sha1[20];
>  	char sha1_abbrev[40];
>  	enum replay_action action;
> -	int insn_len = 0;
> -	char *p, *q;
> +	char *p = start, *q, *end = strchrnul(start, '\n');

By the way, why are these non-const?  (Not about this patch.)

I don't know why, but I would be more comfortable reading something
like this:

	const char *p, *q;

	p = start;
	if (!prefixcmp(p, "pick ")) {
		action = CHERRY_PICK;
		p += strlen("pick ");
	} else if (...) {
		...
	} ...

	q = p + strcspn(p, " \n");
	if (q - p + 1 > sizeof(...))
		...
	...

Maybe because I can imagine how the pointers move, always forward and
never past the end of the line.

> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -211,4 +211,33 @@ test_expect_success 'malformed instruction sheet 2' '
>  	test_must_fail git cherry-pick --continue
>  '
>  
> +test_expect_success 'missing commit descriptions in instruction sheet' '

What assertion does this test check?  "commit descriptions in insn
sheet are optional"?

> +	pristine_detach initial &&
> +	test_must_fail git cherry-pick base..anotherpick &&

A failed cherry-pick.

> +	echo "c" >foo &&
> +	git add foo &&
> +	git commit &&

Resolving the conflict.

> +	cut -d" " -f1,2 .git/sequencer/todo >new_sheet &&
> +	cp new_sheet .git/sequencer/todo &&

Mucking about with the insn sheet.

> +	git cherry-pick --continue &&

Continuing.

> +	test_path_is_missing .git/sequencer &&
> +	{
> +		git rev-list HEAD |
> +		git diff-tree --root --stdin |
> +		sed "s/$_x40/OBJID/g"
> +	} >actual &&
> +	cat >expect <<-\EOF &&
> +	OBJID
> +	:100644 100644 OBJID OBJID M	foo
> +	OBJID
> +	:100644 100644 OBJID OBJID M	foo
> +	OBJID
> +	:100644 100644 OBJID OBJID M	unrelated
> +	OBJID
> +	:000000 100644 OBJID OBJID A	foo
> +	:000000 100644 OBJID OBJID A	unrelated
> +	EOF
> +	test_cmp expect actual

Checking that the cherry-pick succeeded and the resulting list of
commits.  How is this expected to potentially fail?  Maybe something
like

	git rev-list HEAD >commits &&
	test_line_count = 4 commits

or

	git diff --exit-code <something>

would make what this is intended to check clearer.  As hinted above,
some blank lines or comments might make the earlier part easier to
read.

Thanks, this patch does two good things.  For what it's worth, with
the changes hinted at above and a split into two patches if that seems
sensible,
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
