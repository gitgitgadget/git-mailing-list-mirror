From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: handle stray $dotest directory case
Date: Thu, 13 Jun 2013 10:09:30 -0700
Message-ID: <7v61xivsxh.fsf@alter.siamese.dyndns.org>
References: <1371133031-28049-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 19:09:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnB1m-0004bI-Ne
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 19:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755008Ab3FMRJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 13:09:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39667 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814Ab3FMRJd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 13:09:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01E64271F4;
	Thu, 13 Jun 2013 17:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q8o0FcbWK3pdqimQzbh51bgWoQM=; b=aImSMm
	mOH6ojIju5Rw40KMfiMD/xNT2wA6EfkdEbS3fVTZpJX7QiHxjbNf43zyRYEATQOa
	Gvib6NnKYVog7Q6yw2KWTmE/9ZvAiUuxzxmJdGS2VMbpJTpCXBGHlYWj0lZADNrx
	+CBqKt2x3nTsjRHdy1C/pc+1JkOSV7ICCZWrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uFcEzXTC/N1Mfg/BPfXvhopv57s7rxA9
	xSxP28lb4rTh4C02dUrDRfrs8mJdcTMbUb+Tcr/XFTe8A6g171o11VxpKJ1tJAYc
	VQ3Uvjs0B2TOzj8NrAPWh8scnwebbKzUeFrsAb2vnI+mK0MPgeMPCzAixPgKiDD/
	664R3Eht0CI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9F4E271F3;
	Thu, 13 Jun 2013 17:09:32 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F679271EC;
	Thu, 13 Jun 2013 17:09:32 +0000 (UTC)
In-Reply-To: <1371133031-28049-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Thu, 13 Jun 2013 19:47:11 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03E8927C-D44C-11E2-8C25-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227749>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> The following bug has been observed since rr/rebase-autostash:
>
>   $ git am  # no input file
>   ^C
>   $ git am --abort
>   Resolve operation not in progress, we are not resuming.
>
> This happens because the following test fails:
>
>   test -d "$dotest" && test -f "$dotest/last" && test -f "$dotest/next"
>
> and am precludes the possibility of a stray $dotest directory
> existing (when $dotest/{last,next} are not present).

Why did the original code sequence that read:

	if test -d "$dotest"
        then
		... handle skip, resolved, abort, because
                ... these can be run ONLY when we know we have
                ... started an "am" session.
		... catch new "git am mbox" invocation and error
                ... out, because that should not be allowed when
                ... we know we have started an "am" session.

had to change its guarding condition to

	if test -d "$dotest" && test -f "$dotest/last" && test -f "$dotest/next"

in the first place?  Perhaps _that_ guarding condition is what needs
to be fixed, by reverting it back to just "does $dotest exist?"

Adding a single case workaround smells like a band-aid to me.

> Fix the bug by checking for a stray $dotest directory explicitly and
> removing it on --abort.
>
> Reported-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  git-am.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/git-am.sh b/git-am.sh
> index 1cf3d1d..f46a123 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -506,6 +506,11 @@ then
>  	esac
>  	rm -f "$dotest/dirtyindex"
>  else
> +	# Possible stray $dotest directory
> +	if test -d "$dotest" && test t = "$abort"; then
> +		clean_abort
> +	fi
> +
>  	# Make sure we are not given --skip, --resolved, nor --abort
>  	test "$skip$resolved$abort" = "" ||
>  		die "$(gettext "Resolve operation not in progress, we are not resuming.")"
