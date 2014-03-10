From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: new option to post edit a squashed or fixed up commit
Date: Mon, 10 Mar 2014 12:47:20 -0700
Message-ID: <xmqqob1drg3b.fsf@gitster.dls.corp.google.com>
References: <1394334737-17406-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 20:47:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN6Ai-0005jP-JN
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 20:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013AbaCJTrc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Mar 2014 15:47:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48480 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752412AbaCJTrb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 15:47:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C2A773A84;
	Mon, 10 Mar 2014 15:47:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rfsPpx1dc++7
	UYDAkDy0Sv2S3mc=; b=V6q3onGt9aSh1GlS2AJgcp6x0nWQVonHxgw6VbhUMI0P
	rJAz9hSUvBYs0cyFAu0QxqfbweqguSU/hnQWxrPjDjLj6pMT2tO3hP7+ZbLa416D
	d29p8BUNNXJDAwRfeC/1X3YpqrgMzy6zbZ6zz6mD5YPqF3/i6hiSTVMEsvpqFpw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZFT8e5
	QPij1kHswlwlPI7BMoZjYE4XN45eu/RhAC1/a1CdccfZBBIBUmm2grCUjy1TBUeE
	qg3z6ZCRsZrmtyQCqTacNNwCRgdM6bqNH62HKhmLQ+9+SS4jTyPE5/mHR2O6/sp1
	73jMJlgrAU8Mmt2vIuZ31AIjlxnE9e0Qwholo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3403973A83;
	Mon, 10 Mar 2014 15:47:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6FF1373A7E;
	Mon, 10 Mar 2014 15:47:22 -0400 (EDT)
In-Reply-To: <1394334737-17406-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 9 Mar
 2014 10:12:17 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CC1E3D4A-A88C-11E3-9ADC-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243800>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> After squashing or fixing up, you may want to have a final look at th=
e
> commit, edit some more if needed or even do some testing. --postedit
> enables that. This is (to me) a paranoid mode so either I enable it
> for all squashes and fixups, or none. Hence a new option, not new tod=
o
> commands that give finer selection.

If we were to adopt Michael's (?) idea of allowing flags to each
insn in the insn sheet, would this restriction be easily lifted?

That is, instead of saying "squash", you say "squash --stop" or
something.

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index a1adae8..42061fc 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -571,6 +571,11 @@ do_next () {
>  			;;
>  		esac
>  		record_in_rewritten $sha1
> +		if test -n "$postedit"
> +		then
> +			warn "Stopped at $sha1... $rest"
> +			exit_with_patch $sha1 0
> +		fi
>  		;;

I would have expected that any new code would stop only at the last
squash (or fixup) in a series of squashes, but this appears to stop
even at an intermediate squashed result, which will not appear in
the final history.  Am I misreading the patch (or misunderstanding
the intent of the patch)?
