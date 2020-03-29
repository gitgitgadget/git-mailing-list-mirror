Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25730C43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 23:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032EB2074A
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 23:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgC2XYP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 19:24:15 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55440 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgC2XYO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 19:24:14 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 68CC11F49B;
        Sun, 29 Mar 2020 23:24:14 +0000 (UTC)
Date:   Sun, 29 Mar 2020 23:24:14 +0000
From:   Eric Wong <e@80x24.org>
To:     Lukas Pupka-Lipinski <lukas.pupkalipinski@lpl-mind.de>
Cc:     git@vger.kernel.org
Subject: Re: git-svn: Skip commit if all items of a commit are ignored by
 ignore configuration
Message-ID: <20200329232414.GA27925@dcvr>
References: <b20ed6ca-1283-fb6d-a00c-94557218e01c@lpl-mind.de>
 <1467670a-a9eb-f230-4ec0-bd6d54411a69@lpl-mind.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1467670a-a9eb-f230-4ec0-bd6d54411a69@lpl-mind.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lukas Pupka-Lipinski <lukas.pupkalipinski@lpl-mind.de> wrote:
> 
> I used the ignore-paths option to ignore a lot of stuff I don’t need. The
> ignore pattern works well, but it could and up in empty commits. So just the
> message without any modifications / changes. The patch below skip a commit
> if all changes are ignored by the ignore-paths option.

Hi Lukas, this seems like an incompatible change, but it also
matches the intent of the user if they use ignore-paths (which
AFAIK is a rarely-used feature).

I guess it's OK to make it the default behavior, but maybe
others have objections...

> Signed-off-by: Lukas Pupka-Lipinski <lukas.pupkalipinski@lpl-mind.de>

Thanks :>  More comments inline...

> diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
> index 56ad9870bc..a5a6c0b774 100644
> --- a/perl/Git/SVN/Ra.pm
> +++ b/perl/Git/SVN/Ra.pm
> @@ -457,13 +457,22 @@ sub gs_fetch_loop_common {
>              $find_trailing_edge = 0;
>          }
>          $SVN::Error::handler = $err_handler;
> -
> +

This patch (and your other) are both white-space damaged,
but there doesn't need to be a whitespace change, there.

I'm not sure which mail client you use, but
https://git-send-email.io/ documents git-send-email
as being shipped with Git-for-Windows.

Personally, I'm fine with attachments if they can go through
without whitespace damage (not speaking for the rest of
git@vger).  You can test by emailing yourself and trying
"git am" on it.

>          my %exists = map { $_->path => $_ } @$gsv;
>          foreach my $r (sort {$a <=> $b} keys %revs) {
>              my ($paths, $logged) = @{delete $revs{$r}};
> -

Again, no extraneous whitespace changes, please.

>              foreach my $gs ($self->match_globs(\%exists, $paths,
>                                                 $globs, $r)) {
> +
> +
> +                my $fetcher=Git::SVN::Fetcher->new($gs);

Initializing Git::SVN::Fetcher here and closing it is an
expensive operation since it calls git-config(1) many times.
This is especially bad for most users who do not use
--ignore-paths at all.

I know git-svn isn't fast, but I've been hoping to find spare
time to make it use fast-import and speed it up, eventually.

Instead, I think it's possible to bail out of Git::SVN::do_fetch
and still skip the commit without extra network traffic.  I
suggest you try that route, instead.

> +
> +                my $skip=$self->is_empty_commit($paths,$fetcher);
> +                if ($skip){
> +                    print "skip commit $r\n";
> +                    next;
> +                }
> +                $fetcher->close_edit();
>                  if ($gs->rev_map_max >= $r) {
>                      next;
>                  }

Style: put whitespace between operators for readability
and consistency with the rest of our code:

	my $skip = $self->is_empty_commit($paths, $fetcher);
        if ($skip) {
		print "skip commit $r\n";
		...

We also use hard tabs for indentation.

> @@ -506,6 +517,21 @@ sub gs_fetch_loop_common {
> Git::SVN::gc();
>  }
> 
> +sub is_empty_commit{
> +    my ($self, $paths,$fetcher) = @_;
> +    my $path="";
> +    foreach $path (keys %$paths){
> +        unless (defined $path && -d $path ){

The `-d' check is invalid.  "git-svn fetch" never touches the
working tree.

> +            my $ignored=$fetcher->is_path_ignored($path);
> +            if (!$ignored){
> +                return 0;
> +            }
> +        }
> +    }
> +    return 1;
> +}
> +
> +
>  sub get_dir_globbed {
>      my ($self, $left, $depth, $r) = @_;

Same style comments as before, and a single empty line
in-between subs is enough.  Thanks.
