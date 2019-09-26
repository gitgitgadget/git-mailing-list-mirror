Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E178E1F464
	for <e@80x24.org>; Thu, 26 Sep 2019 21:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfIZV5n (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 17:57:43 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:47039 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfIZV5m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 17:57:42 -0400
X-Originating-IP: 1.186.12.44
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id A5C3F20003;
        Thu, 26 Sep 2019 21:57:39 +0000 (UTC)
Date:   Fri, 27 Sep 2019 03:27:37 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Thomas Klaeger via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Klaeger <thklaeger@gmail.com>
Subject: Re: [PATCH 1/1] git-gui (Windows): use git-bash.exe if it is
 available
Message-ID: <20190926215737.aq4z2vhfrl6j634r@yadavpratyush.com>
References: <pull.360.git.gitgitgadget@gmail.com>
 <414cf2c89876fe122ee18f8d6533f083c2f65654.1569519977.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <414cf2c89876fe122ee18f8d6533f083c2f65654.1569519977.git.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/09/19 10:46AM, Thomas Klaeger via GitGitGadget wrote:
> From: Thomas Klaeger <thklaeger@gmail.com>
> 
> Git for Windows 2.x ships with an executable that starts the Git Bash
> with all the environment variables and what not properly set up. It is
> also adjusted according to the Terminal emulator option chosen when
> installing Git for Windows (while `bash.exe --login -i` would always
> launch with Windows' default console).
> 
> So let's use that executable (usually C:\Program Files\Git\git-bash.exe)
> instead of `bash.exe --login -i` if its presence was detected.
> 
> This fixes https://github.com/git-for-windows/git/issues/490
> 
> Signed-off-by: Thomas Kläger <thomas.klaeger@10a.ch>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  git-gui.sh | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index f9b323abff..5a1bfd736e 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -2700,10 +2700,18 @@ if {![is_bare]} {
>  }
  
This hunk is kind of hard to understand. I'm writing what I make of it. 
Please correct me if I read it wrong.

Since this is a 4 year old commit not even authored by you, you might 
not have all the answers. That's OK. But I'd still like to point these 
things out. I do have a question at the end so please read the entire 
thing :)

>  if {[is_Windows]} {
> +	# Use /git-bash.exe if available
> +	set normalized [file normalize $::argv0]

argv0 would be the location of git-gui. We get an absolute path for the 
git-gui executable in the variable normalized.

> +	regsub "/mingw../libexec/git-core/git-gui$" \
> +		$normalized "/git-bash.exe" cmdLine

This finds the install location of git-bash by doing a string 
substitution. I'm assuming the path before /mingw.. is the installation 
directory of git, and so that's where git-bash would reside. We put that 
directory in cmdLine.

Nitpick: most of the code here uses snake case. So s/cmdLine/cmd_line/

> +	if {$cmdLine != $normalized && [file exists $cmdLine]} {

Why the $cmdLine != $normalized? When would they be equal? The string 
substitution should always change $cmdLine.

> +		set cmdLine [list "Git Bash" $cmdLine &]
> +	} else {
> +		set cmdLine [list "Git Bash" bash --login -l &]
> +	}
>  	.mbar.repository add command \
>  		-label [mc "Git Bash"] \
> -		-command {eval exec [auto_execok start] \
> -					  [list "Git Bash" bash --login -l &]}
> +		-command {eval exec [auto_execok start] $cmdLine}
>  }
>  
>  if {[is_Windows] || ![is_bare]} {

The way of finding the path of git-bash is very hacky and would break as 
soon as there are any changes in the install locations. Plus, it is not 
at all easy to understand what's going on at first look.

Is there no better way of finding out git-bash's location? Is there 
something like the PATH environment variable in Windows that we can use 
to locate git-bash's executable? I have never developed in Windows so I 
have no idea how things work there.

On Linux for example, the exec() family of functions look into the PATH 
environment variable for the executable, so it is a pretty clean 
mechanism to execute programs.

-- 
Regards,
Pratyush Yadav
