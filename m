From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/3] t7800: fix tests when difftool uses --no-symlinks
Date: Fri, 22 Mar 2013 23:27:25 +0100
Message-ID: <514CDACD.6030306@kdbg.org>
References: <20130322115352.GI2283@serenity.lan> <cover.1363980749.git.john@keeping.me.uk> <5fc134f6c4a88232c78240539084e9d35db3a6cb.1363980749.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Mar 22 23:27:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJARI-0003rd-SZ
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 23:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423375Ab3CVW13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 18:27:29 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:31703 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1422648Ab3CVW13 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 18:27:29 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C930BA7EB0;
	Fri, 22 Mar 2013 23:27:26 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 581D319F542;
	Fri, 22 Mar 2013 23:27:26 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <5fc134f6c4a88232c78240539084e9d35db3a6cb.1363980749.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218858>

Am 22.03.2013 20:36, schrieb John Keeping:
> When 'git difftool --dir-diff' is using --no-symlinks (either explicitly
> or implicitly because it's running on Windows), any working tree files
> that have been copied to the temporary directory are copied back after
> the difftool completes.  This includes untracked files in the working
> tree.
> 
> During the tests, this means that the following sequence occurs:
> 
> 1) the shell opens "output" to redirect the difftool output
> 2) difftool copies the empty "output" to the temporary directory

But this should not happen, should it?

> 3) difftool runs "ls" which writes to "output"
> 4) difftool copies the empty "output" file back over the output of the
>    command
> 5) the output files doesn't contain the expected output, causing the
>    test to fail
> 
> Avoid this by writing the output into .git/ which will not be copied or
> overwritten.

Isn't this just painting over the bug that "output" is incorrectly copied?

> In the longer term, difftool probably needs to learn to warn the user
> instead of overwrite any changes that have been made to the working tree
> file.

Sure, but this is an independent issue.

> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index e694972..1eed439 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -319,29 +319,29 @@ test_expect_success PERL 'setup change in subdirectory' '
>  '
>  
>  test_expect_success PERL 'difftool -d' '
> -	git difftool -d --extcmd ls branch >output &&
> -	grep sub output &&
> -	grep file output
> +	git difftool -d --extcmd ls branch >.git/output &&
> +	grep sub .git/output &&
> +	grep file .git/output
>  '
> ...
