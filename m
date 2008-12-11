From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] submodule: Allow tracking of the newest revision of
 a branch in a submodule
Date: Thu, 11 Dec 2008 15:24:53 +0100
Message-ID: <494122B5.5060409@viscovery.net>
References: <1229001361-9301-1-git-send-email-git@fabian-franz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: FabianFranz@gmx.de, git@vger.kernel.org, hjemli@gmail.com
To: Fabian Franz <git@fabian-franz.de>
X-From: git-owner@vger.kernel.org Thu Dec 11 15:26:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAmUg-0006uT-S0
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 15:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755858AbYLKOZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 09:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755735AbYLKOZE
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 09:25:04 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:18241 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755569AbYLKOZB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 09:25:01 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LAmTI-0005Kl-KY; Thu, 11 Dec 2008 15:24:57 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 191D654D; Thu, 11 Dec 2008 15:24:53 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <1229001361-9301-1-git-send-email-git@fabian-franz.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102798>

Fabian Franz schrieb:
> Submodules currently only allow tracking a specific revision
> and each update in a submodule leads to a new commit in the
> master repository. However some users may want to always track
> the newest revision of a specific (named) tag or branch or HEAD.
> For example the user might want to track a staging branch in all
> submodules.

Personally, I don't particularly like this feature (but then, nobody
forces me to use it ;) In which situation do you need this?

By tieing a project commit to a particular submodule commit the committer
gives the guarantee: "I've tested this with this module version, and it
works; all is ok." With this new feature, this guarantee vanishes, because
the committer has no control over which version of the module will
ultimately be used; it could be newer or it could be older.

I've reviewed the patch just from a shell code writer's point of view.

> +	[ -n "$track" ] && echo "160000 0000000000000000000000000000000000000000\t$path" | git update-index --index-info

We tend to use "test" instead of "[ ]".
You cannot rely on that echo or the shell translates "\t"; use printf.

	test "$track" && printf '160000
0000000000000000000000000000000000000000\t%s\n' "$path" | git update-index
--index-info

(The line-wrapping is from my MUA; sorry.)

> @@ -327,10 +339,12 @@ cmd_update()
>  			say "Maybe you want to use 'update --init'?"
>  			continue
>  		fi
> +		track=$(git config submodule."$name".track)

You don't need $track *here*, do you?

>  		if ! test -d "$path"/.git -o -f "$path"/.git
>  		then
>  			module_clone "$path" "$url" || exit
> +
>  			subsha1=

And this extra blank line is an accident, isn't it?

> +				[ -z "$track" ] && track="HEAD"

Instead of this you can use a shell trick (but I don't know if it's portable):
				: "${track:=HEAD}"

And I think you can even spare the quotes.

> +				# if the local branch does not yet exist, create it
> +				( unset GIT_DIR; cd "$path"; git-show-ref --heads --tags -q "$track" || git branch --track "$track" "origin/$track" )

Ugh! A *branch* named "HEAD"?? I think you should reconsider this decision.

> +			if [ "$pull" = "1" ]

			if test "$pull"

> +			then
> +				# Now pull new updates from origin
> +				( unset GIT_DIR; cd "$path"; git-pull )

Wow! Creating new commits on the fly while doing a "git submodule update"!
Error check is missing here.

> @@ -596,7 +627,10 @@ cmd_status()
>  		set_name_rev "$path" "$sha1"
>  		if git diff-files --quiet -- "$path"
>  		then
> -			say " $sha1 $path$revname"
> +			track=$(git config submodule."$name".track)
> +			tracking=
> +			[ -n "$track" ] && tracking=" (tracking $track)"
> +			say " $sha1 $path$revname$tracking"

The last three lines can be shortened to this:

	say " $sha1 $path$revname${track:+ (tracking "$track")}"

-- Hannes
