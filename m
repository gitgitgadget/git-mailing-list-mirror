From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 4/4] git-difftool: use git-mergetool--lib for "--tool-help"
Date: Thu, 24 Jan 2013 21:29:58 -0800
Message-ID: <CAJDDKr4ZpQr029FW0v8LzwvhXZYmvAONbbZNuOq_E=Q1UzufvA@mail.gmail.com>
References: <cover.1359057056.git.john@keeping.me.uk>
	<b791e866c02b0c118f08bde1d7ca6c41d6239989.1359057056.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jan 25 06:30:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tybrq-0003Hs-JS
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 06:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018Ab3AYFaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 00:30:01 -0500
Received: from mail-ee0-f53.google.com ([74.125.83.53]:46199 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909Ab3AYF37 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 00:29:59 -0500
Received: by mail-ee0-f53.google.com with SMTP id e53so5120181eek.40
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 21:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=O8zQVmxlbV9AHV/A8SCN0GRrweufZ3O5fV2z9PFmpUY=;
        b=KsxZb7DJXhgUeyu/7LAiptHMugxwD7Su2t3VIhIym6kv1oaKZKvkZw8f8B3q761wk8
         nF9lxerXpzyYaTkiWKilRU+KsoNooDXH+D0lBQObKsXuBG5pKJqvogIYzUWL+vhNxJCq
         K+uV+Za4sBRRfalY6ke/oF0lhxubsHesVNM2toCq78vGyojFhG6MMAVTEI/lEkmiNzRi
         j2k3+oYR4tbFplGT625wWCqz6ZEIe4fuLzn5XmvyC2Ym2ebhFC9B3ujLW+gbJTztPE1s
         tEE6KY3YrSODqKSJXjsiVHzjbmq9HDYfZIXDDIaKXAyojYY5RToTHSOfLxh0GD7RtWPm
         C+nw==
X-Received: by 10.14.219.72 with SMTP id l48mr14239833eep.37.1359091798432;
 Thu, 24 Jan 2013 21:29:58 -0800 (PST)
Received: by 10.14.125.135 with HTTP; Thu, 24 Jan 2013 21:29:58 -0800 (PST)
In-Reply-To: <b791e866c02b0c118f08bde1d7ca6c41d6239989.1359057056.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214500>

On Thu, Jan 24, 2013 at 11:55 AM, John Keeping <john@keeping.me.uk> wrote:
> The "--tool-help" option to git-difftool currently displays incorrect
> output since it uses the names of the files in
> "$GIT_EXEC_PATH/mergetools/" rather than the list of command names in
> git-mergetool--lib.
>
> Fix this by simply delegating the "--tool-help" argument to the
> show_tool_help function in git-mergetool--lib.

Very nice.

One thought I had was that the unified show_tool_help should
probably check TOOL_MODE=diff and skip over the
!can_diff entries.

The current output of "git difftool --tool-help" before your
patches has the problem that it will list tools such as
"tortoisemerge" as "valid but not available" because it
does not differentiate between missing and !can_diff.


> diff --git a/git-difftool.perl b/git-difftool.perl
> index edd0493..0a90de4 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -59,57 +59,16 @@ sub find_worktree
>         return $worktree;
>  }
>
> -sub filter_tool_scripts
> -{
> -       my ($tools) = @_;
> -       if (-d $_) {
> -               if ($_ ne ".") {
> -                       # Ignore files in subdirectories
> -                       $File::Find::prune = 1;
> -               }
> -       } else {
> -               if ((-f $_) && ($_ ne "defaults")) {
> -                       push(@$tools, $_);
> -               }
> -       }
> -}
> -
>  sub print_tool_help
>  {
> -       my ($cmd, @found, @notfound, @tools);
> -       my $gitpath = Git::exec_path();
> -
> -       find(sub { filter_tool_scripts(\@tools) }, "$gitpath/mergetools");
> -
> -       foreach my $tool (@tools) {
> -               $cmd  = "TOOL_MODE=diff";
> -               $cmd .= ' && . "$(git --exec-path)/git-mergetool--lib"';
> -               $cmd .= " && get_merge_tool_path $tool >/dev/null 2>&1";
> -               $cmd .= " && can_diff >/dev/null 2>&1";
> -               if (system('sh', '-c', $cmd) == 0) {
> -                       push(@found, $tool);
> -               } else {
> -                       push(@notfound, $tool);
> -               }
> -       }

This is where we conflated can_diff with "is the tool available?".
The nice thing is that the old code did actually check can_diff,
but since it conflated these things it ended up putting them
in the @notfound list.  It should ignore those completely, IMO.

That could be a nice follow-up patch.  What do you think?
-- 
David
