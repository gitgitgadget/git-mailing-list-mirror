From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] git submodule add: Fix naming clash handling
Date: Fri, 12 Sep 2008 19:24:12 -0700
Message-ID: <7v63p0n5pv.fsf@gitster.siamese.dyndns.org>
References: <20080912210817.31628.69014.stgit@localhost>
 <20080912210924.31628.61593.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>,
	Lars Hjemli <hjemli@gmail.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Sep 13 04:25:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeKpF-0005Ss-Ak
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 04:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596AbYIMCYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 22:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755824AbYIMCYV
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 22:24:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62381 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755099AbYIMCYU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 22:24:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3466660041;
	Fri, 12 Sep 2008 22:24:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 684A66003D; Fri, 12 Sep 2008 22:24:14 -0400 (EDT)
In-Reply-To: <20080912210924.31628.61593.stgit@localhost> (Petr Baudis's
 message of "Fri, 12 Sep 2008 23:09:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 11C2D826-813B-11DD-AA3E-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95788>

Petr Baudis <pasky@suse.cz> writes:

> This patch fixes git submodule add behaviour when we add submodule
> living at a same path as logical name of existing submodule. This
> can happen e.g. in case the user git mv's the previous submodule away
> and then git submodule add's another under the same name.

In short, name "example" was used to name the submodule bound at path
"init" in earlier tests, and the new one adds another submodule whose name
and path are both "example" and makes sure they do not get mixed up (and
the original code did mix them up).

>  git-submodule.sh           |   15 ++++++++++++---
>  t/t7400-submodule-basic.sh |   11 +++++++++++
>  2 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 1c39b59..3e4d839 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -201,10 +201,19 @@ cmd_add()
>  	git add "$path" ||
>  	die "Failed to add submodule '$path'"
>  
> -	git config -f .gitmodules submodule."$path".path "$path" &&
> -	git config -f .gitmodules submodule."$path".url "$repo" &&
> +	name="$path"
> +	if git config -f .gitmodules submodule."$name".path; then
> +		name="$path~"; i=1;
> +		while git config -f .gitmodules submodule."$name".path; do
> +			name="$path~$i"
> +			i=$((i+1))
> +		done
> +	fi
> +
> +	git config -f .gitmodules submodule."$name".path "$path" &&
> +	git config -f .gitmodules submodule."$name".url "$repo" &&
>  	git add .gitmodules ||
> -	die "Failed to register submodule '$path'"
> +	die "Failed to register submodule '$path' (name '$name')"
>  }

The logic of the fix seems to be correct, but shouldn't the test be like
this instead?

	if git config -f .gitmodules "submodule.$name.path" >/dev/null
        then

The same thing for "git config" used in the "while" loop.

Also I am not sure if name="$path~" is a good idea for two reasons:

 - name suffixed with tilde and number looks too much like revision
   expression.

 - A, A~, A~1, A~2... looks ugly; A, A-0, A-1, A-2,... (or start counting
   from 1 or 2) I would understand.

By the way, I noticed that cmd_add does not seem to cd_to_toplevel, and
accesses .gitmodules in the current working directory.  Isn't this a bug?
How should "git submodule add" work from inside a subdirectory?
