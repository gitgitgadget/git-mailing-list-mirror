From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCHv3] submodule update: allow custom update command
Date: Tue, 02 Jul 2013 18:56:44 +0200
Message-ID: <51D3064C.80901@web.de>
References: <7vehbii6un.fsf@alter.siamese.dyndns.org> <1372759974-19765-1-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, iveqy@iveqy.com,
	stefan.naewe@atlas-elektronik.com, hvoigt@hvoigt.net,
	gitster@pobox.com
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 18:57:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu3t5-0001PK-Dk
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 18:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548Ab3GBQ5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 12:57:03 -0400
Received: from mout.web.de ([212.227.15.3]:51491 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752370Ab3GBQ5B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 12:57:01 -0400
Received: from [192.168.178.41] ([79.193.89.81]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MLgQp-1UtEff2W2N-000q8n; Tue, 02 Jul 2013 18:56:53
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <1372759974-19765-1-git-send-email-judge.packham@gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V03:K0:YCCt6FOvqbUiZWQX1AAeLu3D0PfO0sIGxl9V23E9nlm4n+kC1Ev
 EbNCMwhfayKZyUyc/7w5Q0+7TR9AcoPlnF7dGhwuRg9i2KQAByS/mr8qZfrYEwfACStA9Ts
 CD0K26zqFWbCWfiErDOyyCLVE5iSOQsFV5HLqn1UlTkTMxoyvBM6faZzfBavKgouBuaDxh+
 QjRCnMNgGeEFcns9MNiDQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229401>

Am 02.07.2013 12:12, schrieb Chris Packham:
> Users can set submodule.$name.update to '!command' which will cause
> 'command' to be run instead of checkout/merge/rebase.  This allows the
> user some finer grained control over how the update is done. The primary
> motivation for this was interoperability with stgit however being able
> to intercept the submodule update process may prove useful for
> integrating or extending other tools.
> 
> Signed-off-by: Chris Packham <judge.packham@gmail.com>
> ---
> v3 updated as per Junio's review.

Thanks, a few comments below.

> Still needs tests. Any suggestions? I've been manually testing by setting
> submodule.$name.update to '!echo'. I haven't looked to see if there are
> existing 'submodule update' tests yet.

t7406-submodule-update.sh should be the right place.

>  Documentation/git-submodule.txt | 5 ++++-
>  git-submodule.sh                | 6 ++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index e576713..0befc20 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -159,7 +159,9 @@ update::
>  	This will make the submodules HEAD be detached unless `--rebase` or
>  	`--merge` is specified or the key `submodule.$name.update` is set to
>  	`rebase`, `merge` or `none`. `none` can be overridden by specifying
> -	`--checkout`.
> +	`--checkout`. Setting the key `submodule.$name.update` to `!command`
> +	will cause `command` to be run. `command` can be any arbitrary shell
> +	command that takes a single argument, namely the sha1 to update to.
>  +
>  If the submodule is not yet initialized, and you just want to use the
>  setting as stored in .gitmodules, you can automatically initialize the
> @@ -172,6 +174,7 @@ If `--force` is specified, the submodule will be checked out (using
>  `git checkout --force` if appropriate), even if the commit specified in the
>  index of the containing repository already matches the commit checked out in
>  the submodule.
> ++
>  
>  summary::
>  	Show commit summary between the given commit (defaults to HEAD) and

I'm not sure this change is necessary ;-)

> diff --git a/git-submodule.sh b/git-submodule.sh
> index eb58c8e..a7c2375 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -799,6 +799,12 @@ Maybe you want to use 'update --init'?")"
>  				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': merged in '\$sha1'")"
>  				must_die_on_failure=yes
>  				;;
> +			!*)
> +				command="${update_module#!}"
> +				die_msg="$(eval_gettext "Unable to exec '\$command \$sha1' in submodule path '\$prefix\$sm_path'")"

Hmm, "Unable to exec" does not quite cut it, as the command was executed
but returned an error, right? Maybe something like this:

   Execution of '\$command \$sha1' failed in submodule  path '\$prefix\$sm_path'

> +				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': '\$command \$sha1'")"
> +				must_die_on_failure=yes
> +				;;
>  			*)
>  				command="git checkout $subforce -q"
>  				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$prefix\$sm_path'")"
> 
