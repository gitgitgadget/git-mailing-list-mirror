From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: fix run_specific_rebase's use of "return" on FreeBSD
Date: Mon, 09 Sep 2013 08:44:59 -0700
Message-ID: <xmqqzjrm3sp0.fsf@gitster.dls.corp.google.com>
References: <1378716795-5420-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, avg@FreeBSD.org, christoph.mallon@gmx.de,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Sep 09 17:45:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ3eX-0004Ds-1w
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 17:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497Ab3IIPpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 11:45:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62116 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751196Ab3IIPpU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 11:45:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7788D3EAAB;
	Mon,  9 Sep 2013 15:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nt61FUMf5q/fkhcw4AUFsWIEIuE=; b=C+keZX
	/PtnPThBnk5hEWzCtRdHpXBpNJ/rtHIjef+owFaLdWGe4FQj4aroGVZEPG5ul5u5
	aMEUrgcTd72LzmI9F48VSTah/43yUyBGRsh7+y/4RD88ErP9qe4r84KV0TDxME1y
	RUgLNN9ufrrnnHhJPw3JtjD0gwDzxIzaKgHGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NYOiulnUDW1Bb35AE39Cfjk3UZui4Zau
	oa9cGwY2Jv7S/YrJqnYIi/fj9ztL830838vsxhojqJZbmhzbgHMIxIgfy6X44/1I
	SAL2x2MA9G1Ws37Bl7w99spLvmgPqQhpf4VOqOgdHi0psM+bVdgtLeUyuxw23nIY
	8KfcS56m0t0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 514E83EAAA;
	Mon,  9 Sep 2013 15:45:19 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D92983EA9A;
	Mon,  9 Sep 2013 15:45:16 +0000 (UTC)
In-Reply-To: <1378716795-5420-1-git-send-email-Matthieu.Moy@imag.fr> (Matthieu
	Moy's message of "Mon, 9 Sep 2013 10:53:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D31F57BA-1966-11E3-9A8C-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234348>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Since a1549e10, git-rebase--am.sh uses the shell's "return" statement, to
> mean "return from the current file inclusion", which is POSIXly correct,
> but badly interpreted on FreeBSD, which returns from the current
> function, hence skips the finish_rebase statement that follows the file
> inclusion.
>
> Make the use of "return" portable by using the file inclusion as the last
> statement of a function.
>
> Reported-by: Christoph Mallon <christoph.mallon@gmx.de>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> I sent the patch inline in a conversation and got no feedback.
> Resending as a proper patch.

I'll replace mm/rebase-continue-freebsd-WB with this version, but it
would be nice to hear from FreeBSD folks that this is sufficient for
their platform to work around the issue (e.g. there could be other
"return"s unfixed outside the codepath this patch fixes).

Thanks.

>  git-rebase.sh | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 8d7659a..226752f 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -167,13 +167,22 @@ You can run "git stash pop" or "git stash drop" at any time.
>  	rm -rf "$state_dir"
>  }
>  
> -run_specific_rebase () {
> +run_specific_rebase_internal () {
>  	if [ "$interactive_rebase" = implied ]; then
>  		GIT_EDITOR=:
>  		export GIT_EDITOR
>  		autosquash=
>  	fi
> +	# On FreeBSD, the shell's "return" returns from the current
> +	# function, not from the current file inclusion.
> +	# run_specific_rebase_internal has the file inclusion as a
> +	# last statement, so POSIX and FreeBSD's return will do the
> +	# same thing.
>  	. git-rebase--$type
> +}
> +
> +run_specific_rebase () {
> +	run_specific_rebase_internal
>  	ret=$?
>  	if test $ret -eq 0
>  	then
