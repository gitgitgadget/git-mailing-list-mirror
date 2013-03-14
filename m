From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/2] difftool --dir-diff: symlink all files matching the
 working tree
Date: Wed, 13 Mar 2013 20:41:29 -0700
Message-ID: <CAJDDKr5M4pqmd9HSVT8hDJB9AxgV2RexN6B6v6ccTS6raWY_Qg@mail.gmail.com>
References: <7vy5dr14mc.fsf@alter.siamese.dyndns.org>
	<cover.1363206651.git.john@keeping.me.uk>
	<796eafb6816b302c87873c8f4a1bd2225ce40c55.1363206651.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Mar 14 04:42:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFz3H-00007R-1M
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 04:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933470Ab3CNDlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 23:41:31 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:39332 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756572Ab3CNDla (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 23:41:30 -0400
Received: by mail-wg0-f47.google.com with SMTP id dr13so1588371wgb.26
        for <git@vger.kernel.org>; Wed, 13 Mar 2013 20:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=TQ5G/rLJ8N7eCedIzGNJqtdEdRnDl91+q6/azXW3xSA=;
        b=RvJVSslv+TcUmSUBqaoWKd2cGv+kkh6V0JfcGa+LNI4N96xAey5A0U8iprkbtkdtih
         DHTTk+M3xUbD7qyQsT9XVlv7okSowrEOLlBHY3lJwFS1d4B8800H2chMnGQJ8eRgvhnt
         QgKNXfCnPAqxTGaQ0gsks9gyLl2WsuADFDOi7AFTSYwHWlJvqAdDvBx6b3h2NqrXJl/p
         +NZYVUCRDap6nB9/zqMRTyRGn5iBGphJF6mYlnRjGsGoD4WHx21K1SpOLHrLHAqdYk+C
         jXjm8NLSRF6dKNdJciD4o9rsnIwjW+S7fcGtJDa84RX+wvvK29CLEknVq26nBNxvV9rW
         iXow==
X-Received: by 10.180.84.8 with SMTP id u8mr30932621wiy.1.1363232489267; Wed,
 13 Mar 2013 20:41:29 -0700 (PDT)
Received: by 10.194.13.129 with HTTP; Wed, 13 Mar 2013 20:41:29 -0700 (PDT)
In-Reply-To: <796eafb6816b302c87873c8f4a1bd2225ce40c55.1363206651.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218111>

On Wed, Mar 13, 2013 at 1:33 PM, John Keeping <john@keeping.me.uk> wrote:
> Some users like to edit files in their diff tool when using "git
> difftool --dir-diff --symlink" to compare against the working tree but
> difftool currently only created symlinks when a file contains unstaged
> changes.
>
> Change this behaviour so that symlinks are created whenever the
> right-hand side of the comparison has the same SHA1 as the file in the
> working tree.
>
> Note that textconv filters are handled in the same way as by git-diff
> and if a clean filter is not the inverse of its smudge filter we already
> get a null SHA1 from "diff --raw" and will symlink the file without
> going through the new hash-object based check.
>
> Reported-by: Matt McClure <matthewlmcclure@gmail.com>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  Documentation/git-difftool.txt |  4 +++-
>  git-difftool.perl              | 21 ++++++++++++++++++---
>  t/t7800-difftool.sh            | 14 ++++++++++++++
>  3 files changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
> index e575fea..8361e6e 100644
> --- a/Documentation/git-difftool.txt
> +++ b/Documentation/git-difftool.txt
> @@ -72,7 +72,9 @@ with custom merge tool commands and has the same value as `$MERGED`.
>  --symlinks::
>  --no-symlinks::
>         'git difftool''s default behavior is create symlinks to the
> -       working tree when run in `--dir-diff` mode.
> +       working tree when run in `--dir-diff` mode and the right-hand
> +       side of the comparison yields the same content as the file in
> +       the working tree.
>  +
>  Specifying `--no-symlinks` instructs 'git difftool' to create copies
>  instead.  `--no-symlinks` is the default on Windows.
> diff --git a/git-difftool.perl b/git-difftool.perl
> index 0a90de4..5f093ae 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -83,6 +83,21 @@ sub exit_cleanup
>         exit($status | ($status >> 8));
>  }
>
> +sub use_wt_file
> +{
> +       my ($repo, $workdir, $file, $sha1, $symlinks) = @_;
> +       my $null_sha1 = '0' x 40;
> +
> +       if ($sha1 eq $null_sha1) {
> +               return 1;
> +       } elsif (not $symlinks) {
> +               return 0;
> +       }
> +
> +       my $wt_sha1 = $repo->command_oneline('hash-object', "$workdir/$file");
> +       return $sha1 eq $wt_sha1;
> +}
> +
>  sub setup_dir_diff
>  {
>         my ($repo, $workdir, $symlinks) = @_;
> @@ -159,10 +174,10 @@ EOF
>                 }
>
>                 if ($rmode ne $null_mode) {
> -                       if ($rsha1 ne $null_sha1) {
> -                               $rindex .= "$rmode $rsha1\t$dst_path\0";
> -                       } else {
> +                       if (use_wt_file($repo, $workdir, $dst_path, $rsha1, $symlinks)) {
>                                 push(@working_tree, $dst_path);
> +                       } else {
> +                               $rindex .= "$rmode $rsha1\t$dst_path\0";
>                         }
>                 }
>         }
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index eb1d3f8..8102ce1 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -370,6 +370,20 @@ test_expect_success PERL 'difftool --dir-diff' '
>         echo "$diff" | stdin_contains file
>  '
>
> +write_script .git/CHECK_SYMLINKS <<\EOF &&

Tiny nit.  Is there any downside to leaving this file
at the root instead of inside the .git dir?

> +#!/bin/sh
> +test -L "$2/file" &&
> +test -L "$2/file2" &&
> +test -L "$2/sub/sub"
> +echo $?
> +EOF
> +
> +test_expect_success PERL,SYMLINKS 'difftool --dir-diff --symlink without unstaged changes' '
> +       result=$(git difftool --dir-diff --symlink \
> +               --extcmd "./.git/CHECK_SYMLINKS" branch HEAD) &&
> +       test "$result" = 0
> +'
> +

How about something like this?

+       echo 0 >expect &&
+       git difftool --dir-diff --symlink \
+               --extcmd ./CHECK_SYMLINKS branch HEAD >actual &&
+       test_cmp expect actual

(sans gmail whitespace damage) so that we can keep it chained with &&.
Ah.. it seems your branch is based on master, perhaps?

There's stuff cooking in next for difftool's tests.
I'm not sure if this patch is based on top of them.
Can you rebase the tests so that the chaining is done like it is in 'next'?
-- 
David
