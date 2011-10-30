From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Display change history as a diff between two dirs
Date: Sat, 29 Oct 2011 23:09:59 -0700
Message-ID: <7vty6rrow8.fsf@alter.siamese.dyndns.org>
References: <4EAC6765.4030003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Roland Kaufmann <rlndkfmn+git@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 30 07:10:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKOb1-0002dX-DG
	for gcvg-git-2@lo.gmane.org; Sun, 30 Oct 2011 07:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563Ab1J3GKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Oct 2011 02:10:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60104 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980Ab1J3GKG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2011 02:10:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 485383936;
	Sun, 30 Oct 2011 02:10:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=opBVHhI6HEeCyuQY2dMg3RovWHU=; b=RywXj6
	utcU3jU8IZhqekIJVgh7E5f0DTu0QtSPfLzsQdfuv2XVvVOs2I6mvJlT+Ofw1tl2
	MT3PGtFh+YzomQ1IUbeNiAPjBZh7VAlVI3xtCwKVRppw/v1RUW8v7BGTUOTw+FKb
	VrpiDdEPW8eBRCvh5SIM2KdUUsG78yJTm22mw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jhYXSMDtYZ/Dhk5D2jfZxCyy26/lN0lJ
	l9rY9KXzXe3wwAPgsh2PGCP8egaY6UdDaA/vLdPXuwyJ8PMYBudYnMaoYJt8x+8n
	lMmV2StM/niUli05G6IsJ0I1aO64GV3S644JshfsfAVeQml3lqKnjCuAolx15xL3
	EZ1i6GpHIr4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C0493935;
	Sun, 30 Oct 2011 02:10:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D2BF3931; Sun, 30 Oct 2011
 02:10:01 -0400 (EDT)
In-Reply-To: <4EAC6765.4030003@gmail.com> (Roland Kaufmann's message of "Sat,
 29 Oct 2011 22:51:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD6FA908-02BD-11E1-8860-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184462>

Roland Kaufmann <rlndkfmn+git@gmail.com> writes:

> diff --git a/git-dirdiff--helper.sh b/git-dirdiff--helper.sh
> new file mode 100755
> index 0000000..bc0b49d
> --- /dev/null
> +++ b/git-dirdiff--helper.sh
> @@ -0,0 +1,28 @@
> ...
> +# bail out if there is any problems copying
> +set -e

I do not think any of our scripted Porcelains use "set -e"; rather they
try to catch errors and produce messages that are more appropriate for
specific error sites.

> +# check that we are called by git-dirdiff
> +if [ -z $__GIT_DIFF_DIR ]; then
> +  echo Error: Do not call $(basename $0) directly 1>&2
> +  exit 1
> +fi

(style)

	if test -z "$__GIT_DIFF_DIR"
        then
        	echo >&2 "..."
		exit 1
	fi

If this were to become part of the main Porcelain set, you would probably
source in the git-sh-setup helper near the beginning with

	. git-sh-setup

and use "die" instead of "echo && exit 1".

> diff --git a/git-dirdiff.sh b/git-dirdiff.sh
> new file mode 100755
> index 0000000..4e75eda
> --- /dev/null
> +++ b/git-dirdiff.sh
> @@ -0,0 +1,34 @@
> ...
> +# create a temporary directory to hold snapshots of changed files
> +__GIT_DIFF_DIR=$(mktemp --tmpdir -d git-dirdiff.XXXXXX)
> +export __GIT_DIFF_DIR

I do not think any of our scripted Porcelains use "mktemp" especially
"mktemp -d". How portable is it?

> +git diff --raw "$@" > $__GIT_DIFF_DIR/toc
> +
> +# let the helper script accumulate them into the temporary directory
> +cut -f 2- -s $__GIT_DIFF_DIR/toc | while read f; do
> +  GIT_EXTERNAL_DIFF=git-dirdiff--helper git --no-pager diff "$@" $f
> +done

(style)

	... upstream command ... |
        while read f
	do
		...
	done

It also is not clear what could be used in "$@". Obviously you would not
want things like "-U20" and "--stat" fed to the first "list of paths"
phase, but there may be some options you may want to give to the inner
"external diff" thing.

It is not clear to me why you need to grab the list of paths in toc and
iterate over them one by one. IOW, why isn't this sufficient?

    # dirdiff--helper will copy the files in the temporary directory
    GIT_EXTERNAL_DIFF=git-dirdiff--helper git --no-pager diff "$@"

    # Now the temporary old/ and new/ are populated, compare them
    git-difftool--helper - .....

Overall, I found it interesting, but I am not convinced yet that this
should be in the set of main Porcelains.  It seems to be a hack to work
around the design of the current external diff interface that specifically
targets tools that are about comparing single pair of paths at a time.

If "compare two sets of files, each extracted in its own temporary
directory" turns out to be sufficiently useful thing to do (which I
suspect is true), we would probably want to make it an option to "git
diff" itself, and not a separate git subcommand like "dirdiff". I can see
"git diff" (and possibly even things like "git log -p") populating two
temporary directories (your old/ and new/) and running a custom program
specified by GIT_EXTERNAL_TREEDIFF environment variable, instead of doing
any textual diff generation internally.

I wouldn't mind carrying a polished version of this in contrib/ for a
cycle or two in order to let people try it out and get kinks out of its
design.

For example, how well does this approach work with -M/-C (I do not think
it would do anything useful, but I haven't thought things through).  It
would be nice if we gave the hint to the external program that compares
the populated temporary directories how paths in the preimage tree and
postimage tree correspond to each other.
