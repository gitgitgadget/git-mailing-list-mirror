From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH v3 4/5] difftool: Use symlinks when diffing against the worktree
Date: Tue, 24 Jul 2012 09:35:36 -0400
Message-ID: <CAFouethz=7Ed-=AsnC2Fh+-hZcpjzmSLB9aCWd4tBw8GvH1K-w@mail.gmail.com>
References: <7vzk6rnkgq.fsf@alter.siamese.dyndns.org>
	<1343023530-31463-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 15:35:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StfH4-00030A-MC
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 15:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244Ab2GXNfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 09:35:37 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:65367 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab2GXNfh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 09:35:37 -0400
Received: by weyx8 with SMTP id x8so5067689wey.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 06:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KL+ZhXk1gj+HFwwcfg0x1CijqOUhn8VjJnZt/PlFY6g=;
        b=UAQcxwclXyUb3LxyF4znQIp24ed6j8VDngMsqtI8zQZUe68OK0+u7c8D+EgkFuGgOu
         1BcC5xU85bWSeosnHqqqV6dF7eTTuo48jw1anI2cMEGJqLWs1SVOIngErQKUWXL+WO2X
         SkJwc6hyMM3+NF56ox/HEWHyGvKIdGlUGJ9ps3Y/wCdQ28N7/H9aWAYeAXfAX3aj3Epd
         0vOPYo/5aiK8l2GwhaUgO39qtuJEpB7tG5ummHn5cIWN6X/VAeL4D2DQuvBDl3Iuq5nr
         auN59pXYg/AhmSJKvjrfxrJdw0fe69JNLF18HhAlWrMCHc7uJ7W+vujTCa5IP8po8fn/
         5zhg==
Received: by 10.216.237.161 with SMTP id y33mr9875529weq.62.1343136936118;
 Tue, 24 Jul 2012 06:35:36 -0700 (PDT)
Received: by 10.216.182.140 with HTTP; Tue, 24 Jul 2012 06:35:36 -0700 (PDT)
In-Reply-To: <1343023530-31463-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202039>

I'm sorry I am so late to see and comment on this...I am just getting
caught up after a few busy weeks due to $dayjob and vacation.


On Mon, Jul 23, 2012 at 2:05 AM, David Aguilar <davvid@gmail.com> wrote:
>
> diff --git a/git-difftool.perl b/git-difftool.perl
> index 2ae344c..a5b371f 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
>
> @@ -271,6 +276,7 @@ sub main
>                 gui => undef,
>                 help => undef,
>                 prompt => undef,
> +               symlinks => $^O ne 'MSWin32' && $^O ne 'msys',

Should this test for cygwin as well?


> @@ -342,13 +350,18 @@ sub dir_diff
>
>         # If the diff including working copy files and those
>         # files were modified during the diff, then the changes
> -       # should be copied back to the working tree
> -       for my $file (@working_tree) {
> -               if (-e "$b/$file" && compare("$b/$file", "$workdir/$file")) {
> +       # should be copied back to the working tree.
> +       # Do not copy back files when symlinks are used and the
> +       # external tool did not replace the original link with a file.
> +       for my $file (@worktree) {
> +               next if $symlinks && -l "$b/$file";
> +               if (-f "$b/$file" && compare("$b/$file", "$workdir/$file")) {

compare returns '-1' if an error is encountered while reading a file.
In this (unlikely) case, should it still overwrite the working copy
file?  I think the answer is 'yes', but thought it was worth
mentioning.
