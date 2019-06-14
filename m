Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A63921F462
	for <e@80x24.org>; Fri, 14 Jun 2019 16:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbfFNQHa (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 12:07:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:55294 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725789AbfFNQHa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 12:07:30 -0400
Received: (qmail 17339 invoked by uid 109); 14 Jun 2019 16:07:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jun 2019 16:07:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28240 invoked by uid 111); 14 Jun 2019 16:08:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 14 Jun 2019 12:08:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jun 2019 12:07:28 -0400
Date:   Fri, 14 Jun 2019 12:07:28 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] rev-list: teach --oid-only to enable piping
Message-ID: <20190614160728.GA30083@sigill.intra.peff.net>
References: <20190607225900.89299-1-emilyshaffer@google.com>
 <20190613215102.44627-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190613215102.44627-1-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 13, 2019 at 02:51:03PM -0700, Emily Shaffer wrote:

> It didn't appear that using an existing --pretty string would do the
> trick, as the formatting options for --pretty apply specifically to
> commit objects (you can specify the commit hash and the tree hash, but
> I didn't see a way to more generally pretty-print all types of objects).

Right, it would be a big change to start custom-formatting the
non-commits. I think this is a good step in the right direction.

> rev-list doesn't appear to use parse-options-h, so I added a new option
> as simply as I could see without breaking existing style; it seemed
> wrong to add a flag to the `struct rev_list_info` as the definition of
> struct and flag values alike are contained in bisect.h. There are a
> couple other options to rev-list which are stored as globals.

I think that's reasonable. This is definitely a rev-list option (not a
revision.c one). The interaction between bisect.h and rev-list is a bit
funny, but it's probably simpler not to try solving it here.

> +	if (arg_oid_only && revs.commit_format != CMIT_FMT_UNSPECIFIED)
> +		die(_("cannot combine --oid-only and --pretty or --header"));

As you've implemented it here, I definitely agree that this conflicts
with --pretty. But I think it also interacts badly with other options,
like "--graph".

TBH, I am not sure that "rev-list --graph --objects" is all that useful,
because the non-commit objects are not prefixed with the graph lines.
And without "--objects", this new option is not useful because the
default is already to show only the oid.

But I wonder if things would be simpler if we did not touch the commit
code path at all. I.e., if this were simply "--no-object-names", and it
touched only show_object(). And then you do not have to worry about
funny interactions with commit formatting at all. It would be valid to
do:

  git rev-list --pretty=raw --objects --no-object-names HEAD

if you really wanted to (though I admit I do not have an immediate use
for it).

> @@ -255,6 +262,10 @@ static void show_object(struct object *obj, const char *name, void *cb_data)
>  	display_progress(progress, ++progress_counter);
>  	if (info->flags & REV_LIST_QUIET)
>  		return;
> +	if (arg_oid_only) {
> +		printf("%s\n", oid_to_hex(&obj->oid));
> +		return;
> +	}
>  	show_object_with_name(stdout, obj, name);
>  }
>  

A minor style point, but I think this might be easier to follow without
the early return, since we are really choosing to do A or B. Writing:

  if (arg_oid_only)
	printf(...);
  else
	show_object_with_name(...);

shows that more clearly, I think.

> [...]

Otherwise, this looks good, including the tests. One thing I did notice
in the tests:

> +test_expect_success 'rev-list --objects --oid-only is usable by cat-file' '
> +	git rev-list --objects --oid-only --all >list-output &&
> +	git cat-file --batch-check <list-output >cat-output &&
> +	! grep missing cat-output
> +'

Usually we prefer to look for the expected output, rather than making
sure we did not find the unexpected. But I'm not sure if that might be
burdensome in this case (i.e., if there's a bunch of cruft coming out of
"rev-list" that would be annoying to match, and might even change as
people add more tests). So I'm OK with it either way.

-Peff
