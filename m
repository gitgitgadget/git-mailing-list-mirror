From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] rebase: implement --[no-]autostash and rebase.autostash
Date: Sun, 12 May 2013 23:28:10 -0700
Message-ID: <7vd2svqtqd.fsf@alter.siamese.dyndns.org>
References: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
	<1368359801-28121-8-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 08:28:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbmF8-00088H-9t
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 08:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084Ab3EMG2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 02:28:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50229 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013Ab3EMG2N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 02:28:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21DC71AAF2;
	Mon, 13 May 2013 06:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tBekbMduo2FTey2Bu2eK/f8plac=; b=TZn+nN
	3S9oK7FYVBnOTtxtGcJc1BA/6PWU7WrLnZc6px4lvZBAmoXnOzVNMGJVggiBx8YU
	n1xuupSIWj47P2+fGP+ZLCF+IbZ7awTV1SeNEaVWQ1Vk2y6ArjBmb1aa/2ATge0a
	wJWIbmlMV+9l8wPEYoPV0PqvY10mihgGm7KYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GpoNb7ekqjPYePpADvC6KEgMGltazXNk
	bml1/ODsIzn18MBxEdUPdNqlBlUHCYODH8XOFoDV01dkxK3Pk9MCCgxsJLjg8s4r
	1zAMZEYosI0tuAPfpbqqDnN/0TzQgVwgRHEmI96VQqnYG2wowJDMsmha7bljDIiQ
	SEtDNntkj1A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 160DF1AAF0;
	Mon, 13 May 2013 06:28:12 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BEF41AAEB;
	Mon, 13 May 2013 06:28:11 +0000 (UTC)
In-Reply-To: <1368359801-28121-8-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sun, 12 May 2013 17:26:41 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48D34842-BB96-11E2-B680-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224092>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> +finish_rebase () {
> +	if test -f "$state_dir/autostash"
> +	then
> +		stash_sha1=$(cat "$state_dir/autostash")
> +		if git stash apply $stash_sha1 2>&1 >/dev/null
> +		then
> +			echo "Applied autostash"
> +		else
> +			ref_stash=refs/stash &&
> +			: >>"$GIT_DIR/logs/$ref_stash" &&
> +			git update-ref -m "autostash" $ref_stash $stash_sha1 \
> +				|| die "$(eval_gettext 'Cannot store $stash_sha1')"

Writing it like this:

			ref_stash=refs/stash &&
			: >>"$GIT_DIR/logs/$ref_stash" &&
			git update-ref -m "autostash" $ref_stash $stash_sha1 ||
			die "$(eval_gettext 'Cannot store $stash_sha1')"

with a blank line before the next "echo", it would be more readable.

As I said in a separate message, having a code that knows where
"stash" is and how it is organized outside the implementation of
"git stash" is less than ideal.  It probably makes more sense to
let programs like this to say:

			git stash store -m "autostash" $stash_sha1 || exit


> +			echo "
> +$(gettext 'Applying autostash resulted in conflicts.
> +Your changes are safe in the stash.
> +You can apply or drop it at any time.')"

This feels funny.  Why not

			gettext "$msg"

without an extra command substitution with an echo?
