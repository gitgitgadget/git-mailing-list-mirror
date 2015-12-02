From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: Improve --recurse-submodules support
Date: Wed, 02 Dec 2015 15:21:13 -0800
Message-ID: <xmqqsi3k4ety.fsf@gitster.mtv.corp.google.com>
References: <20151202095451.GA22568@mcrowe.com>
	<1449050172-1119-1-git-send-email-mac@mcrowe.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Mike Crowe <mac@mcrowe.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 00:21:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4GiZ-0002q1-23
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 00:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757994AbbLBXVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 18:21:37 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63565 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759385AbbLBXVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 18:21:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 556342FADD;
	Wed,  2 Dec 2015 18:21:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=urMX8OlhGpWuAgj4YtEu7MPEY74=; b=D0h+GD
	iGowNuN+DZK/nOyOeVglQE3CpLVlsMaQRXP3QLFEz4VeReNtGXtEjCCQ6kHgy/ux
	Naa/e+OEkjBtGUi+V5q2oVngzdD/QAtD/fu5LMEQfsERixNoPE4Ss/tyPt7RWXsj
	XKDiXDWqogbgjFawW4qmB77+r9+quzafNZ/68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QYKvulB820HiPVtIv//47hfAAWfpOZGT
	JygBB5IvRxU8w5qwEBSCwgIPNzDwRZgAOy1XKOATo1SBLB78+5KNMrYpqg/RDq3N
	8kf+fOws50h22zEchTr1JsEMhhszwXOCWIviUnLckheyr9KWPkwy3KoTbxSL5Znb
	tHEHoac15fM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3D0A12FADC;
	Wed,  2 Dec 2015 18:21:15 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A4EB82FADB;
	Wed,  2 Dec 2015 18:21:14 -0500 (EST)
In-Reply-To: <1449050172-1119-1-git-send-email-mac@mcrowe.com> (Mike Crowe's
	message of "Wed, 2 Dec 2015 09:56:12 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 61C9DA6A-994B-11E5-B7BB-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281920>

Mike Crowe <mac@mcrowe.com> writes:

> b33a15b08131514b593015cb3e719faf9db20208 added support for the
> push.recurseSubmodules config option. After it was merged Junio C Hamano
> suggested some improvements:
>
>  - Declare recurse_submodules on a separate line.
>
>  - Accept multiple --recurse-submodules options on command line with the
>    last one winning. (This simplified the implementation too.)
>
> Also slightly improve one of the tests added in
> b33a15b08131514b593015cb3e719faf9db20208.

The above is overly verbose about how the commit materialized,
compared to the description of the merit of this update.

    push: fix --recurse-submodules breakage

    When b33a15b0 (push: add recurseSubmodules config option,
    2015-11-17) added push.recurseSubmodules configuration option,
    it also changed the command line parsing to allow
    --no-recurse-submodules to override configured default.
    However, the parsing of configuration variables and command line
    options did not follow the usual "last one wins" convention.
    Fix this.

    Also fix the declaration of the new file-scope global variable
    to put it on a separate line on its own.

or something?

Also describe what "slightly improve" really means.  What did the
old one not test that should have been tested?

Thanks.

> diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
> index 9fda7b0..9a637f5 100755
> --- a/t/t5531-deep-submodule-push.sh
> +++ b/t/t5531-deep-submodule-push.sh
> @@ -126,7 +126,7 @@ test_expect_success 'push succeeds if submodule commit not on remote but using o
>  	)
>  '
>  
> -test_expect_success 'push fails if submodule commit not on remote using check from cmdline overriding config' '
> +test_expect_success 'push recurse-submodules cmdline overrides config' '
>  	(
>  		cd work/gar/bage &&
>  		>recurse-check-on-command-line-overriding-config &&
> @@ -142,8 +142,38 @@ test_expect_success 'push fails if submodule commit not on remote using check fr
>  		git fetch ../pub.git &&
>  		git diff --quiet FETCH_HEAD master^ &&
>  		# Check that the submodule commit did not get there
> -		cd gar/bage &&
> -		git diff --quiet origin/master master^
> +		(cd gar/bage && git diff --quiet origin/master master^) &&

These days, you can do:

		git -C gar/bage --quiet origin/master master^

instead.
