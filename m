From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 07/28] Added test cases for "guilt fold".
Date: Tue, 6 May 2014 15:40:26 -0400
Message-ID: <20140506194026.GK1655@meili.valhalla.31bits.net>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
 <1395387126-13681-8-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Tue May 06 22:02:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhlE5-0001TJ-OB
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 21:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbaEFTk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 15:40:26 -0400
Received: from josefsipek.net ([64.9.206.49]:1639 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047AbaEFTkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 15:40:25 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 160E955654;
	Tue,  6 May 2014 15:40:23 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1395387126-13681-8-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248229>

On Fri, Mar 21, 2014 at 08:31:45AM +0100, Per Cederqvist wrote:
> Test that we can combine any combination of patches with empty and
> non-empty messages, both with and without guilt.diffstat.  (All
> patches are empty.)

I feel like we should have *some* content there - most of the time, I care
more about the diffs getting folded than the commit message :)

> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  regression/t-035.out | 659 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  regression/t-035.sh  |  88 +++++++
>  2 files changed, 747 insertions(+)
>  create mode 100644 regression/t-035.out
>  create mode 100755 regression/t-035.sh
> 
> diff --git a/regression/t-035.out b/regression/t-035.out
> new file mode 100644
> index 0000000..04af146
> --- /dev/null
> +++ b/regression/t-035.out
> @@ -0,0 +1,659 @@
> +% setup_repo
> +% git config guilt.diffstat true
> +%% empty + empty (diffstat=true)
> +% guilt new empty-1
> +% guilt pop
> +All patches popped.
> +% guilt push
> +Applying patch..empty-1
> +Patch applied.
> +% guilt new empty-2
> +% guilt pop
> +Now at empty-1.
> +% guilt push
> +Applying patch..empty-2
> +Patch applied.
> +% guilt pop
> +Now at empty-1.
> +% guilt fold empty-2
> +% guilt pop
> +All patches popped.
> +% guilt push
> +Applying patch..empty-1
> +Patch applied.
> +% list_files
> +d .git/patches
> +d .git/patches/master
> +d .git/refs/patches
> +d .git/refs/patches/master
> +f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
> +f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
> +f 4ea806e306f0228a8ef41f186035e7b04097f1f2  .git/patches/master/status
> +f 7d261b8caad0f161c21daf5de65eeb521ff8c067  .git/patches/master/empty-1
> +f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
> +f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
> +f d28d87b88c1e24d637e390dc3603cfa7c1715711  .git/patches/master/series
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
> +r bde3d337af70f36836ad606c800d194006f883b3  .git/refs/patches/master/empty-1
> +% git log -p

Strictly speaking, git log isn't necessary since list_files prints the
hashes of each of the files as well as the refs for all the applied patches.
If anything mismatches, the hashes will catch it.  I'm ok with keeping the
git log here as long as people can't mess up the formatting with git
config/etc.

...
> diff --git a/regression/t-035.sh b/regression/t-035.sh
> new file mode 100755
> index 0000000..aed3ef2
> --- /dev/null
> +++ b/regression/t-035.sh
> @@ -0,0 +1,88 @@
> +#!/bin/bash
> +#
> +# Test the fold code
> +#
> +
> +source "$REG_DIR/scaffold"
> +
> +cmd setup_repo
> +
> +function fixup_time_info
> +{
> +	cmd guilt pop
> +	touch -a -m -t "$TOUCH_DATE" ".git/patches/master/$1"
> +	cmd guilt push
> +}
> +
> +function test_fold
> +{
> +    using_diffstat=$1
> +
> +    cmd git config guilt.diffstat $using_diffstat
> +
> +    # Empty message + empty message = empty message.
> +    echo "%% empty + empty (diffstat=$using_diffstat)"
> +    cmd guilt new empty-1
> +    fixup_time_info empty-1
> +    cmd guilt new empty-2
> +    fixup_time_info empty-2
> +    cmd guilt pop
> +    cmd guilt fold empty-2
> +    fixup_time_info empty-1
> +    cmd list_files
> +    cmd git log -p
> +    cmd guilt pop
> +    cmd guilt delete -f empty-1
> +    cmd list_files
> +
> +    # Empty message + non-empty message
> +    echo "%% empty + non-empty (diffstat=$using_diffstat)"
> +    cmd guilt new empty
> +    fixup_time_info empty
> +    cmd echo test > a

I see these redirected echos... what are they for?

> +    cmd guilt new -f -s -m "A commit message." non-empty
> +    fixup_time_info non-empty
> +    cmd guilt pop
> +    cmd guilt fold non-empty
> +    fixup_time_info empty
> +    cmd list_files
> +    cmd git log -p
> +    cmd guilt pop
> +    cmd guilt delete -f empty
> +    cmd list_files

Maybe make two helper functions.. one to make a patch with an empty message
and one to make a patch with a non-empty message.  Then each of these blocks
would look a bit cleaner.

	echo "%% empty + non-empty (diffstat=$using_diffstat)"
	empty_patch empty
	nonempty_patch non-empty
	cmd guilt pop non-empty
	cmd guilt fold non-empty
	fixup_time_info empty
	cmd list_files
	cleanup empty
	cmd list_files

cleanup()
{
	guilt pop $1
	guilt delete -f $1
}

Eh, it's not as clean as I thought it would be, but I think it's still a
bit better.  Ok, how about:

for using_diffstat in true false ; do
	for patcha in empty nonempty ; do
		for patchb in empty nonempty ; do
			echo "%% $patcha + $patchb (diffstat=$using_diffstat)"
			${patcha}_patch $patcha
			${patchb}_patch $patchb
			cmd guilt pop $patchb
			cmd guilt fold $patchb
			fixup_time_info $patcha
			cmd list_files
			cleanup $patcha
			cmd list_files
		done
	done
done

Aha!  That's better, IMO.

Adding the non-empty diff is a matter of another loop, but I'm ok with just
testing the headers (for now) :)

Jeff.

-- 
I abhor a system designed for the "user", if that word is a coded pejorative
meaning "stupid and unsophisticated."
		- Ken Thompson
