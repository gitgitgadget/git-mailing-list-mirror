From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] fast-export: output reset command for commandline
 revs
Date: Sun, 6 Nov 2011 00:01:26 -0500
Message-ID: <20111106050126.GO27272@elie.hsd1.il.comcast.net>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
 <1320535407-4933-4-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 06:02:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMus8-0004p9-7v
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 06:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081Ab1KFFBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Nov 2011 01:01:37 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37758 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725Ab1KFFBh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 01:01:37 -0400
Received: by gyc15 with SMTP id 15so2928153gyc.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 22:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=AS3vTweDQ1ZRj4uWmcyRZxz/VlI9MS7GnNTJqCSunbM=;
        b=LN6snUPUd0tJiw3CwCP0P2QLntxISCGXSkZDskyiz6/KEjtf9IBn3wZLwNZdr2SWDr
         LSCSpLQSQoFEjDxAGQ8GIE0+sW/1iHXcE79TVj0sqNf0xmjPaILD3I6Vz/u67HXNqAnd
         enfhXUYL/aCMj5XyQxeo5wEwNUj3cqCdhbgQI=
Received: by 10.50.104.137 with SMTP id ge9mr28405945igb.38.1320555696425;
        Sat, 05 Nov 2011 22:01:36 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id hz1sm14481001igc.5.2011.11.05.22.01.34
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 22:01:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1320535407-4933-4-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184900>

Sverre Rabbelier wrote:

> When a revision is specified on the commandline we explicitly output
> a 'reset' command for it if it was not handled already. This allows
> for example the remote-helper protocol to use fast-export to create
> branches that point to a commit that has already been exported.
>
> Initial-patch-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>

Thanks.  I'd suggest squashing in the test from patch 1/3 for easy
reference (since each patch makes the other easier to understand).

> ---
>   The if statement dealing with tag_of_filtered_mode is not as
>   elegant as either me or Dscho would have liked, but we couldn't
>   find a better way to determine if a ref is a tag at this point
>   in the code.
>
>   Additionally, the elem->whence != REV_CMD_RIGHT case should really
>   check if REV_CMD_RIGHT_REF, but as this is not provided by the
>   ref_info structure this is left as is. A result of this is that
>   incorrect input will result in incorrect output, rather than an
>   error message. That is: `git fast-export a..<sha1>` will
>   incorrectly generate a `reset <sha1>` statement in the fast-export
>   stream.
>
>   The dwim_ref bit is a double work (it has already been done by the
>   caller of this function), but I decided it would be more work to
>   pass this information along than to recompute it for the few
>   commandline refs that were relevant.

These details seem like good details for the commit message, so the
next puzzled person looking at the code can see what behavior is
deliberate and what are the incidental side-effects.

The "git fast-export a..$(git rev-parse HEAD^{commit})" case sounds
worth a test.

> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -18,6 +18,8 @@
>  #include "parse-options.h"
>  #include "quote.h"
> 
> +#define REF_HANDLED (ALL_REV_FLAGS + 1)

Could TMP_MARK be used for this?

[...]
> @@ -541,10 +543,34 @@ static void handle_reset(const char *name, struct object *object)
>  		       sha1_to_hex(object->sha1));
>  }
>  
> -static void handle_tags_and_duplicates(struct string_list *extra_refs)
> +static void handle_tags_and_duplicates(struct rev_info *revs, struct string_list *extra_refs)
>  {
>  	int i;
>  
> +	/* even if no commits were exported, we need to export the ref */
> +	for (i = 0; i < revs->cmdline.nr; i++) {

Might be clearer in a new function.

> +		struct rev_cmdline_entry *elem = &revs->cmdline.rev[i];
> +
> +		if (elem->flags & UNINTERESTING)
> +			continue;
> +
> +		if (elem->whence != REV_CMD_REV && elem->whence != REV_CMD_RIGHT)
> +			continue;

Oh, neat.

> +
> +		char *full_name;

declaration-after-statement

> +		dwim_ref(elem->name, strlen(elem->name), elem->item->sha1, &full_name);
> +
> +		if (!prefixcmp(full_name, "refs/tags/") &&

What happens if dwim_ref fails, perhaps because a ref was deleted in
the meantime?

> +			(tag_of_filtered_mode != REWRITE ||
> +			!get_object_mark(elem->item)))
> +			continue;

Style nit: this would be easier to read if the "if" condition doesn't
line up with the code below it:

		if (!prefixcmp(full_name, "refs/tags/")) {
			if (tag_of_filtered_mode != REWRITE ||
			    !get_object_mark(elem->item))
				continue;
		}

If tag_of_filtered_mode == ABORT, we are going to die() soon, right?
So this seems to be about tag_of_filtered_mode == DROP --- makes
sense.

When does the !get_object_mark() case come up?

> +
> +		if (!(elem->flags & REF_HANDLED)) {
> +			handle_reset(full_name, elem->item);
> +			elem->flags |= REF_HANDLED;
> +		}

Just curious: is the REF_HANDLED handling actually needed?  What
would happen if fast-export included the redundant resets?

> +	}
[...]
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -446,7 +446,7 @@ from $(git rev-parse master)
>  
>  EOF
>  
> -test_expect_failure 'refs are updated even if no commits need to be exported' '
> +test_expect_success 'refs are updated even if no commits need to be exported' '
>  	git fast-export master..master > actual &&
>  	test_cmp expected actual
>  '

Thanks for a pleasant read.
