From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Show number of commits being rebased interactively
Date: Tue, 09 Dec 2014 11:03:10 -0800
Message-ID: <xmqqbnncmys1.fsf@gitster.dls.corp.google.com>
References: <5460E893.7080003@gmx.net>
	<xmqq388tpyls.fsf@gitster.dls.corp.google.com>
	<5484BEFD.7060906@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Onno Kortmann <onno@gmx.net>
X-From: git-owner@vger.kernel.org Tue Dec 09 20:03:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyQ47-0002Gt-B7
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 20:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbaLITDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 14:03:15 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50836 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751464AbaLITDO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 14:03:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B2C4323B13;
	Tue,  9 Dec 2014 14:03:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9ywdcM0A+dfAZDWBB0j2ndIs52Q=; b=dGVpZf
	Utkqa/2ZzktmeXZ/KxikCgKj4O8tdFxMPMfTx503MReC7gnUQMsnsZ+iEj0tT+hP
	Enn5vKrOS1t75jVVs3IID7ONN6rgjTDguu5qQPzKlYEy/RcCD66jauWT5V6tqBsx
	Ijg0xhjoICvnkhl/acwOWsc7KyD1slMU+bCcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t7MWCI0aWOXnIcQpdzQYRiKaKDLKUsoj
	einohN/JYlG8BFN/NB1gWPolRs8LGF8GpxDw5zlbul8zxkPcZBog3/wulCfpVPgF
	cnC/6V92AmS/ojRaXMGwAY33R7Ak3FrS6VDy/xN/XSBmB5vJFlppyYn61ugZBYvI
	xyk6eMRJpJQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A093523B12;
	Tue,  9 Dec 2014 14:03:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0E05523B0E;
	Tue,  9 Dec 2014 14:03:11 -0500 (EST)
In-Reply-To: <5484BEFD.7060906@gmx.net> (Onno Kortmann's message of "Sun, 07
	Dec 2014 21:56:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 058AE3B4-7FD6-11E4-A88F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261143>

Onno Kortmann <onno@gmx.net> writes:

> Hi,
>
>> These lines above "---" will become the only log message text, which
>> is probably not what you intended.  Use "-- >8 --" marker instead
>> (that is a perforation line with a pair of scissors on it)?
> Thanks, hopefully fixed below.
>
>>> +commitcount=$(git stripspace --strip-comments <"$todo"  | wc -l)
>>
>> Does this count the number of commits?  I suspect it at least needs
>> to filter "x|exec" out.
> Very true - after reading this, I learned about the '-x' option
> to git-rebase -i :-)
> I changed the patch so it now properly looks for '^pick ' patterns. I

Hmm, is looking only for pick the right thing?

Stepping back a bit, I have to wonder what we want to count.  The
number of commits after the rebase is done, or the number of commits
in the input of the rebase operation?

The generation loop that reads from rev-list may add only "pick",
but then rearrange_squash will munge some into squash and fixup.  We
may even have some more automated editing of the insn sheet in the
future, just like add_exec_commands were added, so I think it is
more prudent to go from the full list of possible insn sheet
commands (that is, pick, reword, edit, squash, fixup and exec) and
count them, not just relying on "we know the rev-list loop happens
to add only pick commands".

> In the case of having 'exec' lines interspersed, the $commitcount
> becomes a lot less useful (no comparison to editor line numbers),
> though.

Hmph, interesting.  Then perhaps not filtering at all and instead
labelling this new piece of information not "commit(s)" a better
solution?  You are counting the number of instructions in the insn
sheet, so perhaps something like "($count todo items(s))" or
something?

> Onno
> 8< 8< 8< 8< 8< 8< 8< 8< 8<

That is not a scissors line, I suspect.

I didn't try running "git am" on this message, though.  Did you?

> Subject: [PATCH] Show number of commits being rebased interactively
>
> During 'rebase -i', one wrong edit in a long rebase session might
> inadvertently drop commits. This change shows the total number of
> commits in the comments below the commit list. After the rebase
> edit, the number can be quickly compared to the line number of
> the last commit - by scrolling to the last entry in the rebase
> TODO list. This gives peace of mind that no commits have been
> lost in the edit.
>
> Signed-off-by: Onno Kortmann <onno@gmx.net>
> ---
>  git-rebase--interactive.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index b64dd28..b26e5e6 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -1031,9 +1031,13 @@ test -s "$todo" || echo noop >> "$todo"
>  test -n "$autosquash" && rearrange_squash "$todo"
>  test -n "$cmd" && add_exec_commands "$todo"
>
> +commitcount=$(git stripspace --strip-comments <"$todo"  | \
> +	      sane_grep "^pick " | \
> +	      wc -l)

Just a scripting tip.  When a line ends with a vertical bar (pipe),
the shell parser knows that you haven't finished speaking, so there
is no need to have "\" there.

>  cat >>"$todo" <<EOF
>
> -$comment_char Rebase $shortrevisions onto $shortonto
> +$comment_char Rebase $shortrevisions onto $shortonto ($commitcount commit(s))
>  EOF
>  append_todo_help
>  git stripspace --comment-lines >>"$todo" <<\EOF
