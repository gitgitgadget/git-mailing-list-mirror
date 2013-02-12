From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rebase -i: respect core.commentchar
Date: Mon, 11 Feb 2013 16:13:31 -0800
Message-ID: <7vehgmjsno.fsf@alter.siamese.dyndns.org>
References: <aa1deab1de2e0f998b9ac0bc8c2d76557429a46b.1360610368.git.john@keeping.me.uk>
 <7vzjzali6a.fsf@alter.siamese.dyndns.org>
 <20130211213900.GE2270@serenity.lan>
 <7va9raldw8.fsf@alter.siamese.dyndns.org>
 <20130211230804.GF2270@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Feb 12 01:13:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U53VW-0000bP-L7
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 01:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932782Ab3BLANf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 19:13:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38621 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932675Ab3BLANe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 19:13:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 305F1B290;
	Mon, 11 Feb 2013 19:13:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Q6bmhuNgxKYRXCSq90wMSUWCgKY=; b=iWxPvwOaHt8OkA9ow8i3
	IvwVp2p4hKjygBECSwKZTJHcbrZ9qfOEj5ZAtDmgHvV53DJ6evxjiW760z9J2mAj
	5WhhteacI3C3Po3jfQsE7rxoKwsx261QHdcT2Fg3oYOAU8WHuk3z9mI85+8/2lEN
	jxEnLN9/L9MgadIiFXIA+mk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=iUhHFhvt/da5oo1+02yF8VmbhMfMCfrBecG6sqxcH7TaxA
	XuaAneuysjWAEe9PG6Lf4bxX1tcJC5TYtvq8NRf+MzMGbTRVZx5jGILb2uo1iuxC
	rfeGzJVStY9qeNhociR2cM7tUgcqpXRwRoFtfCP27T/0h98Ty2akQ5Esycdeg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2403BB28F;
	Mon, 11 Feb 2013 19:13:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 837D8B28C; Mon, 11 Feb 2013
 19:13:33 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 09B18356-74A9-11E2-9936-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216106>

John Keeping <john@keeping.me.uk> writes:

> @@ -179,7 +182,9 @@ die_abort () {
>  }
>  
>  has_action () {
> -	sane_grep '^[^#]' "$1" >/dev/null
> +	echo "space stripped actions:" >&2
> +	git stripspace --strip-comments <"$1" >&2
> +	test -n "$(git stripspace --strip-comments <"$1")"
>  }

I'll remove the debugging remnants while queuing.

>  	fixup)
>  		echo
> -		echo "# The $(nth_string $count) commit message will be skipped:"
> +		printf '%s\n' "$comment_char The $(nth_string $count) commit message will be skipped:"
>  		echo
> -		commit_message $2 | sed -e 's/^/#	/'
> +		# Change the space after the comment character to TAB:
> +		commit_message $2 | git stripspace --comment-lines | sed -e 's/ /	/'

I think this changes the behaviour but in a good way.  It used to
show an empty line in the incoming commit message to a hash followed
by a trailing HT before the end of line, but now it only emits the
comment char immediately followed by the end of line.

> @@ -942,20 +948,18 @@ test -s "$todo" || echo noop >> "$todo"
>  test -n "$autosquash" && rearrange_squash "$todo"
>  test -n "$cmd" && add_exec_commands "$todo"
>  
> -cat >> "$todo" << EOF
> -
> -# Rebase $shortrevisions onto $shortonto
> -EOF
> +echo >>"$todo"
> +printf '%s\n' "$comment_char Rebase $shortrevisions onto $shortonto" >>"$todo"

I think you can still do

	cat >>"$todo" <<EOF

	$comment_char Rebase $shortrevisions onto...
	EOF

here with any funny comment character.  Doing this with two separate
I/O does not hurt very much, but the resulting code may be easier to
scan if left as here-text with a single cat.

Please eyeball what is in 'pu' (I have a separate squashable fixup
on top of your patch) and let me know if I made mistakes.

Thanks for working on this.
