From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCHv2] rebase [-i --exec | -ix] <CMD>...
Date: Thu, 07 Jun 2012 10:25:10 +0200
Message-ID: <4FD06566.5010709@in.waw.pl>
References: <1338817674-22877-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <1338978856-26838-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 07 10:25:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScY2D-00080B-1h
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 10:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755962Ab2FGIZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 04:25:26 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:38098 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752032Ab2FGIZT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 04:25:19 -0400
Received: from 69-mo7-2.acn.waw.pl ([85.222.93.69] helo=[192.168.0.150])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1ScY1t-0001cq-DM; Thu, 07 Jun 2012 10:25:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <1338978856-26838-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199380>

On 06/06/2012 12:34 PM, Lucien Kong wrote:
> This patch provides a way to automatically add these "exec" lines
> between each commit applications. For instance, running 'git rebase -i
> --exec "make test"' lets you check that intermediate commits are
> compilable. It is also compatible with the option --autosquash. At
> this point, you can't use --exec without the interactive mode (-i).
> 
> Tests about this new command are also added in
> t3404-rebase-interactive.sh.
> 
> Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
> Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
> Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
> Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
> Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> ---
> The part of --onto in the documentation is changed to be consistent
> with the other options. The exec line, when using the option --autosquash,
> is now only added after the squash/fixup series.
> 
>  Documentation/git-rebase.txt  |   54 +++++++++++++++--
>  git-rebase--interactive.sh    |   19 ++++++
>  git-rebase.sh                 |   20 ++++++-
>  t/t3404-rebase-interactive.sh |  124 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 207 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 147fa1a..1dd95c4 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -8,9 +8,9 @@ git-rebase - Forward-port local commits to the updated upstream head
>  SYNOPSIS
>  --------
>  [verse]
> -'git rebase' [-i | --interactive] [options] [--onto <newbase>]
> +'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <newbase>]
>  	[<upstream>] [<branch>]
> -'git rebase' [-i | --interactive] [options] --onto <newbase>
> +'git rebase' [-i | --interactive] [options] [--exec <cmd>] --onto <newbase>
>  	--root [<branch>]
>  'git rebase' --continue | --skip | --abort
>  
> @@ -210,11 +210,29 @@ rebase.autosquash::
>  
>  OPTIONS
>  -------
> -<newbase>::
> -	Starting point at which to create the new commits. If the
> -	--onto option is not specified, the starting point is
> -	<upstream>.  May be any valid commit, and not just an
> -	existing branch name.
> +-x <cmd>::
> +--exec <cmd>::
> +	Automatically add "exec" followed by <cmd> between each commit
> +	applications. Using this option along with --autosquash adds
> +	the exec line after the squash/fixeup series only. <cmd>
> +	stands for shell commands. The --exec option has to be
> +	specified. (see INTERACTIVE MODE below)
Hi,
this still doesn't seem right:
- "exec" is added *after* other lines, not *between*
- --exec is not mandatory

Maybe something along these lines:
-x <cmd>::
--exec <cmd>::
  Append "exec <cmd>" after each commit application line. <cmd> will
  be interpreted as one or more shell commands.
  +
  If --autosquash is used, the "exec" lines will not be appended for
  the intermediate commits, and will only appear at the end of each
  squash/fixup series.

> ++
> +This has to be used along with the `--interactive` option explicitly.
This sentence is very unclear. (E.g. is 'this'?)

> +You may execute several commands between each commit applications.
> +For this, you can use one instance of exec:
> +	git rebase -i --exec "cmd1; cmd2; ...".
> +You can also insert several instances of exec, if you wish to
> +only have one command per line for example:
> +	git rebase -i --exec "cmd1" --exec "cmd2" ...
s/per line for example/per line. For example/ ?

> +
> +--onto <newbase>::
> +	With this option, git rebase takes all commits from <branch>,
> +	that are not in <upstream>, and transplant them on top of
> +	<newbase>. <newbase> is the starting point at which to create
> +	the new commits. If the --onto option is not specified, the
> +	starting point is <upstream>.  May be any valid commit, and
> +	not just an existing branch name.
Shouldn't this chunk be a separate patch?

s/transplant/transplants/

--
Zbyszek
