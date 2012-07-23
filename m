From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/5] difftool: Eliminate global variables
Date: Sun, 22 Jul 2012 23:21:39 -0700
Message-ID: <CAJDDKr7oDc2CxoiWqUMri93FM3WHecanCYBkezLYY1A_BZXdxw@mail.gmail.com>
References: <1343014940-16439-1-git-send-email-davvid@gmail.com>
	<1343014940-16439-2-git-send-email-davvid@gmail.com>
	<500CEB9F.4030406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 08:21:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StC1Z-00009p-5S
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 08:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022Ab2GWGVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 02:21:40 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:34759 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890Ab2GWGVj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 02:21:39 -0400
Received: by vbbff1 with SMTP id ff1so4360313vbb.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 23:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6Po9HL4Lq2M0MGdS2Go3Lph0BSrEan/D2D1BRK40Rgw=;
        b=J7MhGVt7PopW9cRxnXYm/W5iLzj85UtbzN0SqfkB7pZ5TqyPSgC5yVRYsTx3zWmABM
         FlG9CxSotUrL4hnp80eVzJiGfo9YSdr2+PLa7zSDlwZCfm5r5pEe0ansYCz0GRPrqTT3
         8fxn6Gj+vV2fp7kOWLn6frkQ8MEk2IVBuDkTPzO8+36Fa0cNLbcO2k/xMG5TsQZu9x9v
         5y+W9NAf6ofModxdZR5FyrtcHW9lIILZnPCkRFidhm49q2gR+QvbSfRQYEGDEpRq1EFQ
         NYDC8yc4bwJCvbTWx+zIIO1cQpAkcDSZF0a6Qm5Bc8xCOchxhwYwE04aVQYT/ROGmNMu
         S55Q==
Received: by 10.52.72.99 with SMTP id c3mr10097396vdv.54.1343024499205; Sun,
 22 Jul 2012 23:21:39 -0700 (PDT)
Received: by 10.52.114.67 with HTTP; Sun, 22 Jul 2012 23:21:39 -0700 (PDT)
In-Reply-To: <500CEB9F.4030406@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201907>

On Sun, Jul 22, 2012 at 11:13 PM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> On 23.07.2012 05:42, David Aguilar wrote:
>
>> Organize the script so that it has a single main() function which
>> calls out to dir_diff() and file_diff() functions. This eliminates
>> "dir-diff"-specific variables that do not need to be calculated when
>> performing a regular file-diff.
>
>
> Funny, I just have prepared a patch along the same lines so that one can
> call git-difftool -h and --tool-help also outside a repository, see below.
> Does you patch offer the same? If so, I'll drop mine.

It *should*. I did not consider this case but that is indeed the
desired behavior.

What my patch did not offer was a test to ensure this behavior...


>
> ---
>  git-difftool.perl | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/git-difftool.perl b/git-difftool.perl
> index ae1e052..e7b71c9 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -25,8 +25,9 @@ use Git;
>  my @tools;
>  my @working_tree;
>
>  my $rc;
> -my $repo = Git->repository();
> -my $repo_path = $repo->repo_path();
> +my $repo;
> +my $repo_path;
> +my $workdir;
>
>  sub usage
>  {
> @@ -62,8 +63,6 @@ sub find_worktree
>
>         return $worktree;
>  }
>
> -my $workdir = find_worktree();
> -
>  sub filter_tool_scripts
>  {
>         if (-d $_) {
> @@ -293,6 +292,11 @@ if (defined($help)) {
>  if (defined($tool_help)) {
>         print_tool_help();
>  }
> +
> +$repo = Git->repository();
> +$repo_path = $repo->repo_path();
> +$workdir = find_worktree();
> +
>  if (defined($difftool_cmd)) {
>         if (length($difftool_cmd) > 0) {
>                 $ENV{GIT_DIFF_TOOL} = $difftool_cmd;
> --
> 1.7.11.msysgit.2



-- 
David
