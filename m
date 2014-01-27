From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/9] am: add the --gpg-sign option
Date: Mon, 27 Jan 2014 15:26:41 -0800
Message-ID: <xmqqppndm2fi.fsf@gitster.dls.corp.google.com>
References: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
	<1390524666-51274-5-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Vigier <boklm@mars-attacks.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Jan 28 00:26:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7vZr-0000yS-DZ
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 00:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372AbaA0X0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 18:26:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35287 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754112AbaA0X0q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 18:26:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FBB167F36;
	Mon, 27 Jan 2014 18:26:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lm6cPvPVeZkYCJ5q4UihNztm3bc=; b=MNX8qv
	D3sJfw+KO1noSHRF8btfilEfim6xQge8xsYHRAJ2r7SoSlQETRMq//Ox7dxaBkZz
	SA2X8SAfgVj/+FAlHnOp0WiXAe1pQQAhuFQqM+3slVpVSgOzmR/yCZKlrSWcvqOC
	2iYbyS+yf/gbZomb1IMcsKSWAfCGAe61SFzuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MsmAubvhmsVKVdP1UwnvFrIB5cj8XIcb
	7mnm///aKcSWR5L7C4XYM61bq+bFHa9wym+fz3YsEvN+MrUAe6SzD/LpXoQCvTy3
	SjXGHDV+K/+nc2DjIXfzyPtT+HjhNuOX0jL2D75wwqVq6ULaHaAoZ6+GkupxZM3i
	wMnoizd7wDY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EBEF67F35;
	Mon, 27 Jan 2014 18:26:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 318D167F34;
	Mon, 27 Jan 2014 18:26:45 -0500 (EST)
In-Reply-To: <1390524666-51274-5-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Fri, 24 Jan 2014 00:51:01 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7C610B6E-87AA-11E3-9499-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241166>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> @@ -900,7 +906,8 @@ did you forget to use 'git add'?"
>  			GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"
>  			export GIT_COMMITTER_DATE
>  		fi &&
> -		git commit-tree $tree ${parent:+-p} $parent <"$dotest/final-commit"
> +		git commit-tree ${gpg_sign_opt:+"$gpg_sign_opt"} $tree ${parent:+-p} $parent \
> +			<"$dotest/final-commit"

Yuck.  This is unsightly.

It used to be that "commit-tree" was an oddball that took a
mandatory argument $tree always as its first thing, and required
zero or more "-p $parent" after and it did not take any other
options (no -m, no -F, no -S, no nothing).

The original is written in such a way that honors that odd
tradition, because it was how it was written originally, and it did
not need to pass any other option to require the new style
invocation (see "git commit-tree --help" and look at the SYNOPSIS
section).

Now you are passing dash-options to the command, I think it is time
to update the call to the modern style even in the default, non-signed
case.

	git commit-tree ${parent:+-p} $parent ${gpg_sign_opt:+"$gpg_sign_opt"} $tree




>  	) &&
>  	git update-ref -m "$GIT_REFLOG_ACTION: $FIRSTLINE" HEAD $commit $parent ||
>  	stop_here $this
