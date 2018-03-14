Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 137CA1FAE2
	for <e@80x24.org>; Wed, 14 Mar 2018 07:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753291AbeCNHUs (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 03:20:48 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:4982 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751470AbeCNHUr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 03:20:47 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 401NRc14cRz5tlK;
        Wed, 14 Mar 2018 08:20:43 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 685C33A1;
        Wed, 14 Mar 2018 08:20:43 +0100 (CET)
Subject: Re: [PATCH 3/3] Makefile: optionally symlink libexec/git-core
 binaries to bin/git
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Daniel Jacques <dnj@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, Stan Hu <stanhu@gmail.com>,
        Richard Clamp <richardc@unixbeard.net>
References: <20180313203935.5084-1-avarab@gmail.com>
 <20180313203935.5084-4-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <1cabf9c0-674e-c2b3-9977-9c74b929a86d@kdbg.org>
Date:   Wed, 14 Mar 2018 08:20:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180313203935.5084-4-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.03.2018 um 21:39 schrieb Ævar Arnfjörð Bjarmason:
> Add a INSTALL_SYMLINKS option which if enabled, changes the default
> hardlink installation method to one where the relevant binaries in
> libexec/git-core are symlinked back to ../../bin, instead of being
> hardlinked.
> 
> This new option also overrides the behavior of the existing
> NO_*_HARDLINKS variables which in some cases would produce symlinks
> within to libexec/, e.g. "git-add" symlinked to "git" which would be
> copy of the "git" found in bin/, now "git-add" in libexec/ is always
> going to be symlinked to the "git" found in the bin/ directory.

It is important to leave the default at hard-linking the binaries, 
because on Windows symbolic links are second class citizens (they 
require special privileges and there is a distinction between link 
targets being files or directories). Hard links work well.

> 
> This option is being added because:
> 
>   1) I think it makes what we're doing a lot more obvious. E.g. I'd
>      never noticed that the libexec binaries were really just hardlinks
>      since e.g. ls(1) won't show that in any obvious way. You need to
>      start stat(1)-ing things and look at the inodes to see what's
>      going on.
> 
>   2) Some tools have very crappy support for hardlinks, e.g. the Git
>      shipped with GitLab is much bigger than it should be because
>      they're using a chef module that doesn't know about hardlinks, see
>      https://github.com/chef/omnibus/issues/827
> 
>      I've also ran into other related issues that I think are explained

s/ran/run/

>      by this, e.g. compiling git with debugging and rpm refusing to
>      install a ~200MB git package with 2GB left on the FS, I think that
>      was because it doesn't consider hardlinks, just the sum of the
>      byte size of everything in the package.
> 
> As for the implementation, the "../../bin" noted above will vary given
> some given some values of "../.." and "bin" depending on the depth of

s/given some//

> the gitexecdir relative to the destdir, and the "bindir" target,
> e.g. setting "bindir=/tmp/git/binaries gitexecdir=foo/bar/baz" will do
> the right thing and produce this result:
> 
>      $ file /tmp/git/foo/bar/baz/git-add
>      /tmp/git/foo/bar/baz/git-add: symbolic link to ../../../binaries/git
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   Makefile | 46 +++++++++++++++++++++++++++++++---------------
>   1 file changed, 31 insertions(+), 15 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index ee0b6c8940..ac7616422d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -329,6 +329,13 @@ all::
>   # when hardlinking a file to another name and unlinking the original file right
>   # away (some NTFS drivers seem to zero the contents in that scenario).
>   #
> +# Define INSTALL_SYMLINKS if you prefer to have everything that can be
> +# symlinked between bin/ and libexec/ to use relative symlinks between
> +# the two. This option overrides NO_CROSS_DIRECTORY_HARDLINKS and

s/ between the two//

> +# NO_INSTALL_HARDLINKS which will also use symlinking by indirection
> +# within the same directory in some cases, INSTALL_SYMLINKS will
> +# always symlink to the final target directly.

"the final target"? Do you mean "the git executable installed in 
$bindir" or something like this?

> +#
>   # Define NO_CROSS_DIRECTORY_HARDLINKS if you plan to distribute the installed
>   # programs as a tar, where bin/ and libexec/ might be on different file systems.
>   #
> @@ -2594,35 +2601,44 @@ endif
>   
>   	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
>   	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
> +	destdir_from_execdir_SQ=$$(echo '$(gitexecdir_relative_SQ)' | sed -e 's|[^/][^/]*|..|g') && \
>   	{ test "$$bindir/" = "$$execdir/" || \
>   	  for p in git$X $(filter $(install_bindir_programs),$(ALL_PROGRAMS)); do \
>   		$(RM) "$$execdir/$$p" && \
> -		test -z "$(NO_INSTALL_HARDLINKS)$(NO_CROSS_DIRECTORY_HARDLINKS)" && \
> -		ln "$$bindir/$$p" "$$execdir/$$p" 2>/dev/null || \
> -		cp "$$bindir/$$p" "$$execdir/$$p" || exit; \
> +		test -n "$(INSTALL_SYMLINKS)" && \
> +		ln -s "$$destdir_from_execdir_SQ/$(bindir_relative_SQ)/$$p" "$$execdir/$$p" || \
> +		{ test -z "$(NO_INSTALL_HARDLINKS)$(NO_CROSS_DIRECTORY_HARDLINKS)" && \
> +		  ln "$$bindir/$$p" "$$execdir/$$p" 2>/dev/null || \
> +		  cp "$$bindir/$$p" "$$execdir/$$p" || exit; } \

I think that it is unnecessary to place the later options in {} brackets 
because && and || have equal precedence in shell scripts. That is:

	want symlinks? &&
	make symlinks ||
	want hard links? &&
	make hard links ||
	make copies ||
	exit

Of course, it means that when symlinking fails, it falls back to hard 
links (if permitted) or copies, whichever works. But that also happens 
with your version.

(Ditto in the rest of the hunk, which I don't repeat here.)

-- Hannes
