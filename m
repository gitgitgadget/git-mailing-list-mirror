From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: respect core.commentchar
Date: Mon, 11 Feb 2013 12:17:01 -0800
Message-ID: <7vzjzali6a.fsf@alter.siamese.dyndns.org>
References: <aa1deab1de2e0f998b9ac0bc8c2d76557429a46b.1360610368.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Feb 11 21:17:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4zoh-00030R-2n
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 21:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759908Ab3BKURG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 15:17:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45032 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759853Ab3BKURE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 15:17:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68267C20E;
	Mon, 11 Feb 2013 15:17:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mMQYu9Tmx+QDF3KFJXUc0dqHDa0=; b=dih6jY
	z3jn+Jai6rwXmPiSNTqPnspLC7HOM2goyqtVXpGVLjlOjJU6bvuYjAyWJFs8uxFn
	IEPyBE1jJPmK2XKG0oxjekeJAE2wQYk85jUA72XMcGuwEbF+/uk7l+Mw1yuJlJ0o
	a3m3EpPhU6YlfrDhrYFQkmDUi8t0BmX0mgGoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nFRosjcztA7HOYqZagDkvadCENHEO15b
	WAtBo03jAOhpONww2mwhF5sBms5HJ8GJbruqMXECojU4PDTjSQ/eEAGL2Uf+lfnS
	xC/RyVhMoKzUFANj/t9gn6E4fBn6PDNl/nSzzl78K6EklMwverZDluXQgnJdAbLD
	BtcldYu0isE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D48BC20D;
	Mon, 11 Feb 2013 15:17:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 650E4C20C; Mon, 11 Feb 2013
 15:17:03 -0500 (EST)
In-Reply-To: <aa1deab1de2e0f998b9ac0bc8c2d76557429a46b.1360610368.git.john@keeping.me.uk>
 (John Keeping's message of "Mon, 11 Feb 2013 19:21:15 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FFB850DA-7487-11E2-90A7-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216082>

John Keeping <john@keeping.me.uk> writes:

> Commit eff80a9 (Allow custom "comment char") introduced a custom comment
> character for commit messages but did not teach git-rebase--interactive
> to use it.
>
> Change git-rebase--interactive to read core.commentchar and use its
> value when generating commit messages and for the todo list.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---

It always is better late than never, but I would have appreciated
this was caught while the topic was still in 'next'.  That is the
whole point of cooking in-flight topics in 'next'.

Yikes....   and thanks.

>  git-rebase--interactive.sh    | 85 ++++++++++++++++++++++---------------------
>  t/t3404-rebase-interactive.sh | 16 ++++++++
>  2 files changed, 60 insertions(+), 41 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 8ed7fcc..8a37bc1 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -80,6 +80,9 @@ rewritten_pending="$state_dir"/rewritten-pending
>  GIT_CHERRY_PICK_HELP="$resolvemsg"
>  export GIT_CHERRY_PICK_HELP
>  
> +comment_char=$(git config --get core.commentchar 2>/dev/null | cut -c1)
> +: ${comment_char:=#}

Hmm, somewhat ugly.  I wonder if we can do this without pipe and cut.

> @@ -105,8 +108,8 @@ mark_action_done () {
>  	sed -e 1q < "$todo" >> "$done"
>  	sed -e 1d < "$todo" >> "$todo".new
>  	mv -f "$todo".new "$todo"
> -	new_count=$(sane_grep -c '^[^#]' < "$done")
> -	total=$(($new_count+$(sane_grep -c '^[^#]' < "$todo")))
> +	new_count=$(sane_grep -c "^[^${comment_char}]" < "$done")
> +	total=$(($new_count+$(sane_grep -c "^[^${comment_char}]" < "$todo")))

I do not think we would want to worry about comment_char being a
funny character that can possibly interfere with regexp.  Can't we
do this with "git stripspace" piped to "wc -l" or something?

> @@ -116,19 +119,19 @@ mark_action_done () {
>  }
>  
>  append_todo_help () {
> -	cat >> "$todo" << EOF
> -#
> -# Commands:
> -#  p, pick = use commit
> -#  r, reword = use commit, but edit the commit message
> -#  e, edit = use commit, but stop for amending
> -#  s, squash = use commit, but meld into previous commit
> -#  f, fixup = like "squash", but discard this commit's log message
> -#  x, exec = run command (the rest of the line) using shell
> -#
> -# These lines can be re-ordered; they are executed from top to bottom.
> -#
> -# If you remove a line here THAT COMMIT WILL BE LOST.
> +	sed -e "s/^/$comment_char /" >>"$todo" <<EOF

When $comment_char is slash or backslash this will break.
Perhaps "stripspace --comment-lines" can be used here.

> +
> +Commands:
> + p, pick = use commit
> + r, reword = use commit, but edit the commit message
> + e, edit = use commit, but stop for amending
> + s, squash = use commit, but meld into previous commit
> + f, fixup = like "squash", but discard this commit's log message
> + x, exec = run command (the rest of the line) using shell
> +
> +These lines can be re-ordered; they are executed from top to bottom.
> +
> +If you remove a line here THAT COMMIT WILL BE LOST.
>  EOF
>  }
>  
> @@ -179,7 +182,7 @@ die_abort () {
>  }
>  
>  has_action () {
> -	sane_grep '^[^#]' "$1" >/dev/null
> +	sane_grep "^[^${comment_char}]" "$1" >/dev/null

Likewise.

> @@ -363,10 +366,10 @@ update_squash_messages () {
>  	if test -f "$squash_msg"; then
>  		mv "$squash_msg" "$squash_msg".bak || exit
>  		count=$(($(sed -n \
> -			-e "1s/^# This is a combination of \(.*\) commits\./\1/p" \
> +			-e "1s/^. This is a combination of \(.*\) commits\./\1/p" \

This one is safe.

>  			-e "q" < "$squash_msg".bak)+1))
>  		{
> -			echo "# This is a combination of $count commits."
> +			echo "$comment_char This is a combination of $count commits."

But you need to do "printf" to be safe here, I think, for comment_char='\'.

> @@ -375,8 +378,8 @@ update_squash_messages () {
>  		commit_message HEAD > "$fixup_msg" || die "Cannot write $fixup_msg"
>  		count=2
>  		{
> -			echo "# This is a combination of 2 commits."
> -			echo "# The first commit's message is:"
> +			echo "$comment_char This is a combination of 2 commits."
> +			echo "$comment_char The first commit's message is:"

Likewise.

> @@ -385,21 +388,21 @@ update_squash_messages () {
>  	squash)
>  		rm -f "$fixup_msg"
>  		echo
> -		echo "# This is the $(nth_string $count) commit message:"
> +		echo "$comment_char This is the $(nth_string $count) commit message:"

Likewise.

>  		echo
>  		commit_message $2
>  		;;
>  	fixup)
>  		echo
> -		echo "# The $(nth_string $count) commit message will be skipped:"
> +		echo "$comment_char The $(nth_string $count) commit message will be skipped:"
>  		echo
> -		commit_message $2 | sed -e 's/^/#	/'
> +		commit_message $2 | sed -e "s/^/$comment_char	/"

Likewise.

>  peek_next_command () {
> -	sed -n -e "/^#/d" -e '/^$/d' -e "s/ .*//p" -e "q" < "$todo"
> +	sed -n -e "/^$comment_char/d" -e '/^$/d' -e "s/ .*//p" -e "q" < "$todo"
>  }

Likewise.

> @@ -464,7 +467,7 @@ do_next () {
>  	rm -f "$msg" "$author_script" "$amend" || exit
>  	read -r command sha1 rest < "$todo"
>  	case "$command" in
> -	'#'*|''|noop)
> +	$comment_char*|''|noop)

This is OK.

> @@ -803,15 +806,15 @@ skip)
>  	do_rest
>  	;;
>  edit-todo)
> -	sed -e '/^#/d' < "$todo" > "$todo".new
> +	sed -e "/^$comment_char/d" < "$todo" > "$todo".new

Unsafe.

>  	mv -f "$todo".new "$todo"
>  	append_todo_help
> -	cat >> "$todo" << EOF
> -#
> -# You are editing the todo file of an ongoing interactive rebase.
> -# To continue rebase after editing, run:
> -#     git rebase --continue
> -#
> +	sed -e "s/^/$comment_char /" >>"$todo" <<EOF

Unsafe.

> +
> +You are editing the todo file of an ongoing interactive rebase.
> +To continue rebase after editing, run:
> +    git rebase --continue
> +
>  EOF
>  
>  	git_sequence_editor "$todo" ||
> @@ -881,7 +884,7 @@ do
>  
>  	if test -z "$keep_empty" && is_empty_commit $shortsha1 && ! is_merge_commit $shortsha1
>  	then
> -		comment_out="# "
> +		comment_out="$comment_char "

OK.

>  	else
>  		comment_out=
>  	fi
> @@ -942,20 +945,20 @@ test -s "$todo" || echo noop >> "$todo"
>  test -n "$autosquash" && rearrange_squash "$todo"
>  test -n "$cmd" && add_exec_commands "$todo"
>  
> -cat >> "$todo" << EOF
> -
> -# Rebase $shortrevisions onto $shortonto
> +echo >>"$todo"
> +sed -e "s/^/$comment_char /" >> "$todo" << EOF

Unsafe.

> +Rebase $shortrevisions onto $shortonto
>  EOF
>  append_todo_help
> -cat >> "$todo" << EOF
> -#
> -# However, if you remove everything, the rebase will be aborted.
> -#
> +sed -e "s/^/$comment_char /" >> "$todo" << EOF

Unsafe.

> +
> +However, if you remove everything, the rebase will be aborted.
> +
>  EOF
>  
>  if test -z "$keep_empty"
>  then
> -	echo "# Note that empty commits are commented out" >>"$todo"
> +	echo "$comment_char Note that empty commits are commented out" >>"$todo"
>  fi
>  
>  
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 8462be1..1043cdc 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -934,4 +934,20 @@ test_expect_success 'rebase --edit-todo can be used to modify todo' '
>  	test L = $(git cat-file commit HEAD | sed -ne \$p)
>  '
>  
> +test_expect_success 'rebase -i respects core.commentchar' '
> +	git reset --hard &&
> +	git checkout E^0 &&
> +	git config core.commentchar \; &&

Try setting it to '\' or '/' or '-'; they may catch some more breakages.

> +	test_when_finished "git config --unset core.commentchar" &&
> +	cat >comment-lines.sh <<EOF &&
> +#!$SHELL_PATH
> +sed -e "2,\$ s/^/;/" "\$1" >"\$1".tmp
> +mv "\$1".tmp "\$1"
> +EOF
> +	chmod a+x comment-lines.sh &&
> +	test_set_editor "$(pwd)/comment-lines.sh" &&
> +	git rebase -i B &&
> +	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
> +'
> +
>  test_done
