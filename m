From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: auto-squash commits
Date: Wed, 17 Jun 2009 22:21:07 -0700
Message-ID: <7vvdmu15j0.fsf@alter.siamese.dyndns.org>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
	<43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>
	<7vvdmurfao.fsf@alter.siamese.dyndns.org>
	<20090618063348.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 07:21:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHA3s-00020r-CD
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 07:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873AbZFRFVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 01:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752561AbZFRFVI
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 01:21:08 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:43154 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbZFRFVH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 01:21:07 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090618052109.UPMP17670.fed1rmmtao101.cox.net@fed1rmimpo03.cox.net>;
          Thu, 18 Jun 2009 01:21:09 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 5HM81c0014aMwMQ04HM8aQ; Thu, 18 Jun 2009 01:21:08 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=y44SSOj0rWsA:10 a=UQnXkbzPAAAA:8
 a=4By4JyK3aZWFsyGMUeMA:9 a=W4REcnukGyRAAYkvkjQ5EAbck-UA:4 a=Q21-j9j7q-gA:10
X-CM-Score: 0.00
In-Reply-To: <20090618063348.6117@nanako3.lavabit.com> (Nanako Shiraishi's message of "Thu\, 18 Jun 2009 06\:33\:48 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121792>

Nanako Shiraishi <nanako3@lavabit.com> writes:

>       pick 1/3 Clean up ...
>       pick 2/3 Lay the groundwork
>       pick 3/3 Implement
>       pick 4/3 squash to "clean up"
>   
>   that I'll change to 
>   
>       pick 1/3 Clean up ...
>       squash 4/3 squash to "clean up"
>       pick 2/3 Lay the groundwork
>       pick 3/3 Implement
>   
>   and then I'll need to edit the commit message for the first two combined.
>
> How about this patch?  It does not let you say 'squash to "clean up"'
> but other people who are more skillfull than me can enhance such details.

I have to admit that I wished to see something like this for more than
once.  It would have been nicer if the patch went one step further and did
"squash the patch, but use the log message from the commit that is
squashed into, without even asking for a consolidated message", but I
think it is a reasonable start.

But as Dscho already objected to, this is a new feature that is
potentially dangerous --- there is a risk of matching a commit that was
not intended for squashing, albeit small.  We may want an explicit option
to enable it.  On the other hand, you may be able to argue that use of
"interactive" rebase is already a sign that the user is likely to want
such a convenience, though.

>  git-rebase--interactive.sh   |   31 +++++++++++++++++++++++++++++++
>  t/t3414-rebase-autosquash.sh |   36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+), 0 deletions(-)
>  create mode 100755 t/t3414-rebase-autosquash.sh
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index f96d887..0832164 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -482,6 +482,35 @@ get_saved_options () {
>  	test -f "$DOTEST"/rebase-root && REBASE_ROOT=t
>  }
>  
> +# Rearrange the todo list that has both "pick sha1 msg" and
> +# "pick sha1 squash to msg" in it, so that the latter comes
> +# immediately after the former, and change "pick" to "squash".
> +rearrange_squash () {
> +	sed -n -e 's/^pick \([0-9a-f]*\) squash to /\1 /p' "$1" >"$1.sq"
> +	test -s "$1.sq" || return
> +
> +	used=
> +	while read pick sha1 message
> +	do
> +		case " $used" in
> +		*" $sha1 "*) continue ;;
> +		esac
> +		echo "$pick $sha1 $message"
> +		while read squash msg
> +		do
> +			case "$message" in
> +			"$msg"*)

I guess we could even loosen this "must match the leading substring
exactly" restriction if we can expose Dscho's Levenstein to Porcelain
writers.

> +				echo "squash $squash to $msg"
> +				used="$used$squash "
> +				break
> +				;;

Do you really want to break here?  What happens if I have more than one
fixup patches to the same commit?

> +			esac
> +		done <"$1.sq"
> +	done <"$1" >"$1.rearranged"
> +
> +	cat "$1.rearranged" >"$1"
> +}
> +
>  while test $# != 0
>  do
>  	case "$1" in
> @@ -746,6 +776,7 @@ first and then run 'git rebase --continue' again."
>  		fi
>  
>  		test -s "$TODO" || echo noop >> "$TODO"
> +		rearrange_squash "$TODO"
>  		cat >> "$TODO" << EOF
>  
>  # Rebase $SHORTREVISIONS onto $SHORTONTO
> diff --git a/t/t3414-rebase-autosquash.sh b/t/t3414-rebase-autosquash.sh
> new file mode 100755
> index 0000000..ddb0daf
> --- /dev/null
> +++ b/t/t3414-rebase-autosquash.sh
> @@ -0,0 +1,36 @@
> +#!/bin/sh
> +
> +test_description='auto squash'
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +	echo 0 > file0
> +	git add .
> +	test_tick
> +	git commit -m "initial commit"
> +	echo 0 > file1
> +	echo 2 > file2
> +	git add .
> +	test_tick
> +	git commit -m "first commit"
> +	echo 3 > file3
> +	git add .
> +	test_tick
> +	git commit -m "second commit"
> +'

These tests want to be stringed together with && to catch possible
breakages during the setup.  The same for the real test below.

> +test_expect_success 'auto squash' '
> +	echo 1 > file1
> +	git add -u
> +	test_tick
> +	git commit -m "squash to first"
> +	git tag final
> +	test_tick
> +	git rebase -i HEAD^^^
> +	git log --oneline >actual
> +	test 3 = $(wc -l <actual) &&

Not just count, but you would want to make sure that the rewritten "first
commit" now has the desired tree ("1" instead of "0" in file1, if I am
reading the test correctly).

> +	git diff --exit-code final
> +'
> +
> +test_done
