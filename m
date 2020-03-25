Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D81C2D0E5
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 20:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9A02074D
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 20:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCYUiY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 16:38:24 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52688 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbgCYUiY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 16:38:24 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id D8C3D1F487;
        Wed, 25 Mar 2020 20:38:23 +0000 (UTC)
Date:   Wed, 25 Mar 2020 20:38:23 +0000
From:   Eric Wong <e@80x24.org>
To:     Lukas Pupka-Lipinski <lukas.pupkalipinski@lpl-mind.de>
Cc:     git@vger.kernel.org, pjwhams@gmail.com
Subject: Re: [PATCH] added: Multi line support for ignore-paths configuration
Message-ID: <20200325203823.GA21913@dcvr>
References: <e5c78a24-e17f-c1bb-4ea7-3ddaa45abcf0@lpl-mind.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5c78a24-e17f-c1bb-4ea7-3ddaa45abcf0@lpl-mind.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lukas Pupka-Lipinski <lukas.pupkalipinski@lpl-mind.de> wrote:
> From 01d4e4dbc4e524db6188f41904a7274d1582d066 Mon Sep 17 00:00:00 2001

Hello Lukas and welcome to git hacker community!  It looks like
your first patch, so some details to point out, most of which
should be covered in `Documentation/SubmittingPatches'

> From: lukas.pupkalipinski@lpl-mind.de
> Date: Tue, 24 Mar 2020 13:47:27 +0100
> Subject: [PATCH] added: Multi line support for ignore-paths configuration

No need for a From/Date/Subject in the body of the email
(they're already in the subject), unless From or Subject differs
from what's already in the email header.

Since git-svn is a subsection, a better subject might be:

  Subject: git-svn: support multi-line ignore-paths in config

(but needs clarification, below)

> In addition we should add multi line support for include-paths.

Can you clarify whether this allows multi-line support is
intended to allow importing paths with newlines in them?

Or is this to support multiple values of include-paths?

(judging from the code below, it seem like the latter)

In any case, we prefer full sentence(s) in the commit message

> Signed-off-by: lukas.pupkalipinski@lpl-mind.de

Thanks, though S-o-b generally includes the full name, so:

  Signed-off-by: Lukas Pupka-Lipinski <lukas.pupkalipinski@lpl-mind.de>

is more appropriate

> Reported-by:
> Acked-by:
> Reviewed-by:
> Tested-by:

Empty fields aren't necessary, you can drop the above 4 lines.

> ---
>  perl/Git/SVN/Fetcher.pm | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
> index 64e900a0e9..1bcba49a76 100644
> --- a/perl/Git/SVN/Fetcher.pm
> +++ b/perl/Git/SVN/Fetcher.pm
> @@ -31,7 +31,8 @@ sub new {
>      # override options set in an [svn-remote "..."] section
>      $repo_id = $git_svn->{repo_id};
>      my $k = "svn-remote.$repo_id.ignore-paths";
> -    my $v = eval { command_oneline('config', '--get', $k) };
> +    my $v = eval { command('config', '--get-all', $k) };
> +    $v  =~ s/[\x0A\x0D]//g if (defined $v);
>      $self->{ignore_regex} = $v;
> 
>      $k = "svn-remote.$repo_id.include-paths";

That looks like it would munge the following:

	[svn-remote "foo"]
		ignore-paths = a
		ignore-paths = b

into "a\nb\n"

And finally into a regexp: /ab/

...Which doesn't seem correct, to me.

I suggest something like the following to retrieve values
from `git config --get-all' in array context and join the
values together into one regexp (totally untested):

	my @v = eval { command('config', '--get-all', $k) };
	chomp(@v); # get rid of trailing newlines
	$self->{ignore_regexp} = '(?:' . join('|', @v) . ')';

> 2.25.1.windows.1

I'm not sure how git-config or chomp() behaves on Windows systems
with CRLF line endings, though.

A possibility would be replacing chomp(@v) with:

	s/\r?\n\z//s for @v;

But that is more verbose and less readable (and slower).

Also, you had a second patch which didn't hit the list but got
into my inbox.  It contained an HTML part which vger rejects due
to processing costs and likelyhood of being spam.

Could you resend that as plain text?  Some of my comments above
would also apply to your second patch.  Thanks.
