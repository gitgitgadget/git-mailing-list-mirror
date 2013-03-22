From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v3 3/4] t7800: modernize tests
Date: Fri, 22 Mar 2013 10:00:30 +0000
Message-ID: <20130322100030.GH2283@serenity.lan>
References: <1361419428-22410-1-git-send-email-davvid@gmail.com>
 <1361419428-22410-2-git-send-email-davvid@gmail.com>
 <1361419428-22410-3-git-send-email-davvid@gmail.com>
 <514985FB.8080806@viscovery.net>
 <CAJDDKr4O-OU57j0f7F2E2_4EvtCTE1gFP5uLv+fvD6VcpPiifg@mail.gmail.com>
 <514AB9A5.3050601@viscovery.net>
 <514C04AA.6030305@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 22 11:01:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIymg-0008AJ-5S
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 11:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465Ab3CVKAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 06:00:45 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:38715 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab3CVKAo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 06:00:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 5B0C8CDA5DB;
	Fri, 22 Mar 2013 10:00:43 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0riaTv6xJEHr; Fri, 22 Mar 2013 10:00:42 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 5DA93CDA594;
	Fri, 22 Mar 2013 10:00:32 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <514C04AA.6030305@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218787>

On Fri, Mar 22, 2013 at 08:13:46AM +0100, Johannes Sixt wrote:
> Am 3/21/2013 8:41, schrieb Johannes Sixt:
> > Am 3/20/2013 23:59, schrieb David Aguilar:
> >> I started digging in and the @worktree_files (aka @worktree above)
> >> is populated from the output of "git diff --raw ...".
> >>
> >> Seeing the "output" filename in "diff --raw" implies that one of the
> >> tests added "output" to the index somehow.  I do not see that
> >> happening anywhere, though, so I do not know how it would end up in
> >> the @worktree array if it is not reported by "diff --raw".
> >>
> >>
> >> My current understanding of how it could possibly be open twice:
> >>
> >> 1. via the >output redirect
> >> 2. via the copy() perl code which is fed by @worktree
> >>
> >> So I'm confused.  Why would we get different results on Windows?
> > 
> > I tracked down the difference between Windows and Linux, and it is...
> > 
> > 	for my $file (@worktree) {
> > 		next if $symlinks && -l "$b/$file";
> > 
> > ... this line in sub dir_diff. On Linux, we take the short-cut, but on
> > Windows we proceed through the rest of the loop,
> 
> And that is likely by design. From the docs:
> 
> --symlinks
> --no-symlinks
> 
>     git difftool's default behavior is create symlinks to the working
>     tree when run in --dir-diff mode.
> 
>     Specifying `--no-symlinks` instructs 'git difftool' to create
>     copies instead.  `--no-symlinks` is the default on Windows.
> 
> And indeed, we have this initialization:
> 
> 	my %opts = (
> 		...
> 		symlinks => $^O ne 'cygwin' &&
> 				$^O ne 'MSWin32' && $^O ne 'msys',
> 		...
> 	);
> 
> Can the --dir-diff tests case pass on Cygwin when neither --symlinks nor
> --no-symlinks is passed?
> 
> Perhaps the right solution is this:

We already have tests that explicitly pass '--symlinks'.  I wonder if it
would be better to change "output" to ".git/output", which should avoid
the problem by moving the output file out of the working tree.

> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index c6d6b1c..19238f6 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -328,14 +328,16 @@ test_expect_success PERL 'setup change in subdirectory' '
>  	git commit -m "modified both"
>  '
>  
> -test_expect_success PERL 'difftool -d' '
> -	git difftool -d --extcmd ls branch >output &&
> +# passing --symlinks helps Cygwin, which defaults to --no-symlinks
> +
> +test_expect_success PERL,SYMLINKS 'difftool -d' '
> +	git difftool -d --symlinks --extcmd ls branch >output &&
>  	stdin_contains sub <output &&
>  	stdin_contains file <output
>  '
>  
> -test_expect_success PERL 'difftool --dir-diff' '
> -	git difftool --dir-diff --extcmd ls branch >output &&
> +test_expect_success PERL,SYMLINKS 'difftool --dir-diff' '
> +	git difftool --dir-diff --symlinks --extcmd ls branch >output &&
>  	stdin_contains sub <output &&
>  	stdin_contains file <output
>  '
> @@ -362,16 +364,16 @@ test_expect_success PERL,SYMLINKS 'difftool --dir-diff --symlink without unstage
>  	test_cmp actual expect
>  '
>  
> -test_expect_success PERL 'difftool --dir-diff ignores --prompt' '
> -	git difftool --dir-diff --prompt --extcmd ls branch >output &&
> +test_expect_success PERL,SYMLINKS 'difftool --dir-diff ignores --prompt' '
> +	git difftool --dir-diff --symlinks --prompt --extcmd ls branch >output &&
>  	stdin_contains sub <output &&
>  	stdin_contains file <output
>  '
>  
> -test_expect_success PERL 'difftool --dir-diff from subdirectory' '
> +test_expect_success PERL,SYMLINKS 'difftool --dir-diff from subdirectory' '
>  	(
>  		cd sub &&
> -		git difftool --dir-diff --extcmd ls branch >output &&
> +		git difftool --dir-diff --symlinks --extcmd ls branch >output &&
>  		stdin_contains sub <output &&
>  		stdin_contains file <output
>  	)
> 
> (Only tested on MinGW, which skips the tests.) I leave it to you
> to write --no-symlinks tests.
> 
> -- Hannes
