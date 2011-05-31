From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] submodule add: improve message when resolving a relative
 url fails
Date: Tue, 31 May 2011 16:57:00 -0400
Message-ID: <4DE5561C.3010200@xiplink.com>
References: <1306792280-12768-1-git-send-email-marcnarc@xiplink.com> <4DE541EC.7010202@web.de> <4DE548C4.2010600@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue May 31 22:57:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRW0G-0007Vz-D1
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 22:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463Ab1EaU5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 16:57:08 -0400
Received: from smtp182.iad.emailsrvr.com ([207.97.245.182]:60700 "EHLO
	smtp182.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932093Ab1EaU5H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 16:57:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp28.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 426EBE0548;
	Tue, 31 May 2011 16:57:06 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp28.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id DCC11E0174;
	Tue, 31 May 2011 16:57:05 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110424 Thunderbird/3.1.10
In-Reply-To: <4DE548C4.2010600@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174827>

On 11-05-31 04:00 PM, Jens Lehmann wrote:
> A "git submodule add ../sub" interprets "../sub" relative to the default
> remote of the superproject. To be able to do that, a url for that remote
> has to be set in the superprojects .git/config. If that is not the case

Nit: superprojects --> superproject's

> the command fails with:
> 	"remote (origin) does not have a url defined in .git/config"
> 
> This neither mentions the relative repository nor that the .git/config of
> the superproject is the one with the missing url. And as a novice user
> could assume that relative paths would work just like absolute paths do
> in the filesystem and run into this by accident, the message is not very
> helpful.
> 
> So change that to
> 	"Cannot resolve "../sub" relative to remote (origin), its url
> 	 is not set in .git/config"
> to give the user a clue that "git submodule add" interprets a relative
> path as being relative to its default remote, not the work tree.

Thanks for the cogent explanation & patch.  I think the message could be
improved a bit:

	Cannot resolve "../sub" relative to this repository's "origin"
	remote: The remote's URL is not set in .git/config

However, overall I think this is a pretty fragile way to handle relative
paths.  Consider:

 - The super-repo must be a clone in order for this to work at all.

 - The super-repo cannot be checked out on a detached HEAD.

 - The current code rewrites the URL so that any relative path is either
   rejected or munged into an absolute remote URL.

It seems to me that this feature will only work in a fairly narrow set of
circumstances, and even when it does work it's likely to do something
unexpected (think of a super-repo with several remotes).

Back when Junio accepted the original patch, he said "If you maintain and
serve a set related projects you need to give the users a single URL (per
where the user is and how to reach the server)."  I'm not sure I understand
that:  Why would the users be adding their own submodules to the
superproject?  Wouldn't the superproject define the submodules in for them?

I think it would be better to either just reject relative paths entirely, or
accept any relative path as-is and display a warning that the submodule is
only valid on the local machine.  (Perhaps one day receive-pack could even be
taught to reject any pushes with a .gitmodules file containing a relative URL.)

		M.


> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
> 
> Am 31.05.2011 21:30, schrieb Jens Lehmann:
>> Am 30.05.2011 23:51, schrieb Marc Branchaud:
>>> Patch 1 tests the case where "submodule add" fails if the path to the
>>> submodule repo is relative (i.e. starts with "../").  This currently fails
>>> with "remote (origin) does not have a url defined in .git/config".  Maybe
>>> there's a reason to fail?  If so, a better error message would be appreciated.
>>
>> I stumbled across this behavior now and then too, but according to the
>> commit it added (f31a522a2d) it is intended that adding a relative path
>> behaves differently than using an absolute path (it resolves relative to
>> the superproject's origin, not the filesystem, and to be able to do that
>> the superproject's .git/config has to have an url defined for it). But
>> you are right about the error message, it really isn't that helpful ...
> 
> What about this patch?
> 
> 
>  git-submodule.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index d189a24..14ef1d4 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -34,7 +34,7 @@ resolve_relative_url ()
>  {
>  	remote=$(get_default_remote)
>  	remoteurl=$(git config "remote.$remote.url") ||
> -		die "remote ($remote) does not have a url defined in .git/config"
> +		die "Cannot resolve \"$1\" relative to remote ($remote), its url is not set in .git/config"
>  	url="$1"
>  	remoteurl=${remoteurl%/}
>  	sep=/
