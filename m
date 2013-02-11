From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] rebase -i: respect core.commentchar
Date: Mon, 11 Feb 2013 21:39:00 +0000
Message-ID: <20130211213900.GE2270@serenity.lan>
References: <aa1deab1de2e0f998b9ac0bc8c2d76557429a46b.1360610368.git.john@keeping.me.uk>
 <7vzjzali6a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 22:39:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5166-0002EY-Sh
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 22:39:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605Ab3BKVjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 16:39:11 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:37583 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759938Ab3BKVjK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 16:39:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 4E567CDA58B;
	Mon, 11 Feb 2013 21:39:09 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ELXyf8yCs3us; Mon, 11 Feb 2013 21:39:07 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id B7D55CDA330;
	Mon, 11 Feb 2013 21:39:02 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vzjzali6a.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216094>

On Mon, Feb 11, 2013 at 12:17:01PM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> > +comment_char=$(git config --get core.commentchar 2>/dev/null | cut -c1)
> > +: ${comment_char:=#}
> 
> Hmm, somewhat ugly.  I wonder if we can do this without pipe and cut.

Yeah, but I can't see a better way of doing this if we want to mimic the
behaviour of the C code in taking only the first character of the
configured value.

> > @@ -105,8 +108,8 @@ mark_action_done () {
> >  	sed -e 1q < "$todo" >> "$done"
> >  	sed -e 1d < "$todo" >> "$todo".new
> >  	mv -f "$todo".new "$todo"
> > -	new_count=$(sane_grep -c '^[^#]' < "$done")
> > -	total=$(($new_count+$(sane_grep -c '^[^#]' < "$todo")))
> > +	new_count=$(sane_grep -c "^[^${comment_char}]" < "$done")
> > +	total=$(($new_count+$(sane_grep -c "^[^${comment_char}]" < "$todo")))
> 
> I do not think we would want to worry about comment_char being a
> funny character that can possibly interfere with regexp.  Can't we
> do this with "git stripspace" piped to "wc -l" or something?

I didn't know about "git stripspace", it does make a lot of this
significantly safer.  I'll work up a new version that uses that instead
of grep and with printf used where necessary.

> > @@ -116,19 +119,19 @@ mark_action_done () {
> >  }
> >  
> >  append_todo_help () {
> > -	cat >> "$todo" << EOF
> > -#
> > -# Commands:
> > -#  p, pick = use commit
> > -#  r, reword = use commit, but edit the commit message
> > -#  e, edit = use commit, but stop for amending
> > -#  s, squash = use commit, but meld into previous commit
> > -#  f, fixup = like "squash", but discard this commit's log message
> > -#  x, exec = run command (the rest of the line) using shell
> > -#
> > -# These lines can be re-ordered; they are executed from top to bottom.
> > -#
> > -# If you remove a line here THAT COMMIT WILL BE LOST.
> > +	sed -e "s/^/$comment_char /" >>"$todo" <<EOF
> 
> When $comment_char is slash or backslash this will break.
> Perhaps "stripspace --comment-lines" can be used here.

Not in this case - this is adding the comment char in front of each
line.  Is there a better option than this?

	while read -r line
	do
		printf '%s %s\n' "$comment_char" "$line"
	done >> "$todo" <<EOF
	...
	EOF

> > +
> > +Commands:
> > + p, pick = use commit
> > + r, reword = use commit, but edit the commit message
> > + e, edit = use commit, but stop for amending
> > + s, squash = use commit, but meld into previous commit
> > + f, fixup = like "squash", but discard this commit's log message
> > + x, exec = run command (the rest of the line) using shell
> > +
> > +These lines can be re-ordered; they are executed from top to bottom.
> > +
> > +If you remove a line here THAT COMMIT WILL BE LOST.
> >  EOF
> >  }
> >  
> > @@ -179,7 +182,7 @@ die_abort () {
> >  }
> >  
> >  has_action () {
> > -	sane_grep '^[^#]' "$1" >/dev/null
> > +	sane_grep "^[^${comment_char}]" "$1" >/dev/null
> 
> Likewise.
> 
> > @@ -363,10 +366,10 @@ update_squash_messages () {
> >  	if test -f "$squash_msg"; then
> >  		mv "$squash_msg" "$squash_msg".bak || exit
> >  		count=$(($(sed -n \
> > -			-e "1s/^# This is a combination of \(.*\) commits\./\1/p" \
> > +			-e "1s/^. This is a combination of \(.*\) commits\./\1/p" \
> 
> This one is safe.
> 
> >  			-e "q" < "$squash_msg".bak)+1))
> >  		{
> > -			echo "# This is a combination of $count commits."
> > +			echo "$comment_char This is a combination of $count commits."
> 
> But you need to do "printf" to be safe here, I think, for comment_char='\'.
> 
> > @@ -375,8 +378,8 @@ update_squash_messages () {
> >  		commit_message HEAD > "$fixup_msg" || die "Cannot write $fixup_msg"
> >  		count=2
> >  		{
> > -			echo "# This is a combination of 2 commits."
> > -			echo "# The first commit's message is:"
> > +			echo "$comment_char This is a combination of 2 commits."
> > +			echo "$comment_char The first commit's message is:"
> 
> Likewise.
> 
> > @@ -385,21 +388,21 @@ update_squash_messages () {
> >  	squash)
> >  		rm -f "$fixup_msg"
> >  		echo
> > -		echo "# This is the $(nth_string $count) commit message:"
> > +		echo "$comment_char This is the $(nth_string $count) commit message:"
> 
> Likewise.
> 
> >  		echo
> >  		commit_message $2
> >  		;;
> >  	fixup)
> >  		echo
> > -		echo "# The $(nth_string $count) commit message will be skipped:"
> > +		echo "$comment_char The $(nth_string $count) commit message will be skipped:"
> >  		echo
> > -		commit_message $2 | sed -e 's/^/#	/'
> > +		commit_message $2 | sed -e "s/^/$comment_char	/"
> 
> Likewise.

Again this is adding $comment_char in front of each line, so it may need
a loop like above again.

> >  peek_next_command () {
> > -	sed -n -e "/^#/d" -e '/^$/d' -e "s/ .*//p" -e "q" < "$todo"
> > +	sed -n -e "/^$comment_char/d" -e '/^$/d' -e "s/ .*//p" -e "q" < "$todo"
> >  }
> 
> Likewise.
> 
> > @@ -464,7 +467,7 @@ do_next () {
> >  	rm -f "$msg" "$author_script" "$amend" || exit
> >  	read -r command sha1 rest < "$todo"
> >  	case "$command" in
> > -	'#'*|''|noop)
> > +	$comment_char*|''|noop)
> 
> This is OK.
> 
> > @@ -803,15 +806,15 @@ skip)
> >  	do_rest
> >  	;;
> >  edit-todo)
> > -	sed -e '/^#/d' < "$todo" > "$todo".new
> > +	sed -e "/^$comment_char/d" < "$todo" > "$todo".new
> 
> Unsafe.
> 
> >  	mv -f "$todo".new "$todo"
> >  	append_todo_help
> > -	cat >> "$todo" << EOF
> > -#
> > -# You are editing the todo file of an ongoing interactive rebase.
> > -# To continue rebase after editing, run:
> > -#     git rebase --continue
> > -#
> > +	sed -e "s/^/$comment_char /" >>"$todo" <<EOF
> 
> Unsafe.
> 
> > +
> > +You are editing the todo file of an ongoing interactive rebase.
> > +To continue rebase after editing, run:
> > +    git rebase --continue
> > +
> >  EOF
> >  
> >  	git_sequence_editor "$todo" ||
> > @@ -881,7 +884,7 @@ do
> >  
> >  	if test -z "$keep_empty" && is_empty_commit $shortsha1 && ! is_merge_commit $shortsha1
> >  	then
> > -		comment_out="# "
> > +		comment_out="$comment_char "
> 
> OK.
> 
> >  	else
> >  		comment_out=
> >  	fi
> > @@ -942,20 +945,20 @@ test -s "$todo" || echo noop >> "$todo"
> >  test -n "$autosquash" && rearrange_squash "$todo"
> >  test -n "$cmd" && add_exec_commands "$todo"
> >  
> > -cat >> "$todo" << EOF
> > -
> > -# Rebase $shortrevisions onto $shortonto
> > +echo >>"$todo"
> > +sed -e "s/^/$comment_char /" >> "$todo" << EOF
> 
> Unsafe.
> 
> > +Rebase $shortrevisions onto $shortonto
> >  EOF
> >  append_todo_help
> > -cat >> "$todo" << EOF
> > -#
> > -# However, if you remove everything, the rebase will be aborted.
> > -#
> > +sed -e "s/^/$comment_char /" >> "$todo" << EOF
> 
> Unsafe.
> 
> > +
> > +However, if you remove everything, the rebase will be aborted.
> > +
> >  EOF
> >  
> >  if test -z "$keep_empty"
> >  then
> > -	echo "# Note that empty commits are commented out" >>"$todo"
> > +	echo "$comment_char Note that empty commits are commented out" >>"$todo"
> >  fi
> >  
> >  
> > diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> > index 8462be1..1043cdc 100755
> > --- a/t/t3404-rebase-interactive.sh
> > +++ b/t/t3404-rebase-interactive.sh
> > @@ -934,4 +934,20 @@ test_expect_success 'rebase --edit-todo can be used to modify todo' '
> >  	test L = $(git cat-file commit HEAD | sed -ne \$p)
> >  '
> >  
> > +test_expect_success 'rebase -i respects core.commentchar' '
> > +	git reset --hard &&
> > +	git checkout E^0 &&
> > +	git config core.commentchar \; &&
> 
> Try setting it to '\' or '/' or '-'; they may catch some more breakages.
> 
> > +	test_when_finished "git config --unset core.commentchar" &&
> > +	cat >comment-lines.sh <<EOF &&
> > +#!$SHELL_PATH
> > +sed -e "2,\$ s/^/;/" "\$1" >"\$1".tmp
> > +mv "\$1".tmp "\$1"
> > +EOF
> > +	chmod a+x comment-lines.sh &&
> > +	test_set_editor "$(pwd)/comment-lines.sh" &&
> > +	git rebase -i B &&
> > +	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
> > +'
> > +
> >  test_done
