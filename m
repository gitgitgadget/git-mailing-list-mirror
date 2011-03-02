From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v2 1/7] fetch/pull: recurse into submodules when necessary
Date: Wed, 02 Mar 2011 10:42:59 -0500
Message-ID: <4D6E6583.8090202@xiplink.com>
References: <4D6D7A50.5090802@web.de> <4D6D7AB2.4010509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 02 16:42:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuoC2-0003d8-NS
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 16:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215Ab1CBPmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 10:42:20 -0500
Received: from smtp112.iad.emailsrvr.com ([207.97.245.112]:48357 "EHLO
	smtp112.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab1CBPmU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 10:42:20 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp51.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 58394202DC;
	Wed,  2 Mar 2011 10:42:19 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp51.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 0848020CFB;
	Wed,  2 Mar 2011 10:42:18 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <4D6D7AB2.4010509@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168313>

On 11-03-01 06:01 PM, Jens Lehmann wrote:
> To be able to access all commits of populated submodules referenced by the
> superproject it is sufficient to only then let "git fetch" recurse into a
> submodule when the new commits fetched in the superproject record new
> commits for it. Having these commits present is extremely useful when
> using the "--submodule" option to "git diff" (which is what "git gui" and
> "gitk" do since 1.6.6), as all submodule commits needed for creating a
> descriptive output can be accessed. Also merging submodule commits (added
> in 1.7.3) depends on the submodule commits in question being present to
> work. Last but not least this enables disconnected operation when using
> submodules, as all commits necessary for a successful "git submodule
> update -N" will have been fetched automatically. So we choose this mode as
> the default for fetch and pull.
> 
> Before a new or changed ref from upstream is updated in update_local_ref()
> "git rev-list <new-sha1> --not --branches --remotes" is used to determine
> all newly fetched commits. These are then walked and diffed against their
> parent(s) to see if a submodule has been changed. If that is the case, its
> path is stored to be fetched after the superproject fetch is completed.
> 
> Using the "--recurse-submodules" or the "--no-recurse-submodules" option
> disables the examination of the fetched refs because the result will be
> ignored anyway.
> 
> There is currently no infrastructure for storing deleted and new
> submodules in the .git directory of the superproject. Thats why fetch and
> pull for now only fetch submodules that are already checked out and are
> not renamed.
> 
> In t7403 the "--no-recurse-submodules" argument had to be added to "git
> pull" to avoid failure because of the moved upstream submodule repo.
> 
> Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
> Thanks-to: Heiko Voigt <hvoigt@hvoigt.net>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
>  Documentation/fetch-options.txt |   11 ++++
>  builtin/fetch.c                 |   25 ++++++---
>  submodule.c                     |  106 +++++++++++++++++++++++++++++++++++---
>  submodule.h                     |    9 +++
>  t/t5526-fetch-submodules.sh     |  109 +++++++++++++++++++++++++++++++++++++++
>  t/t7403-submodule-sync.sh       |    2 +-
>  6 files changed, 245 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index f37276e..ae22f75 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -73,6 +73,17 @@ ifndef::git-pull[]
>  	Prepend <path> to paths printed in informative messages
>  	such as "Fetching submodule foo".  This option is used
>  	internally when recursing over submodules.
> +
> +--submodule-default=[yes|on-demand]::
> +	This option is used internally to set the submodule recursion default
> +	to either a boolean configuration value representing "true" (for
> +	unconditonal recursion) or to "on-demand" (when only those submodules
> +	should be fetched of which new commits have been fetched in its
> +	superproject).
> +	This option will be overridden by the 'fetch.recurseSubmodules' and
> +	'submodule.<name>.fetchRecurseSubmodules' settings in
> +	linkgit:gitmodules[5] and linkgit:git-config[1] while all of them
> +	are ignored when the "--[no-]recurse-submodules" option is given.
>  endif::git-pull[]

Rolling out the bike...

I think the option name and it's explanation need to be a little clearer:

--recurse-submodules-default=[yes|on-demand]::
	This option is used internally to temporarily provide a
	non-negative default value for the --recurse-submodules
	option.  All other methods of configuring fetch's submodule
	recursion (such as settings in linkgit:gitmodules[5] and
	linkgit:git-config[1]) override this option, as does
	specifying --[no-]recurse-submodules directly.


		M.
