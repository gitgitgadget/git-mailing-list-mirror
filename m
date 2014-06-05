From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/11] test-lib: make it possible to override how test code is eval'd
Date: Thu, 05 Jun 2014 14:11:19 -0700
Message-ID: <xmqqk38vrrig.fsf@gitster.dls.corp.google.com>
References: <1401176460-31564-1-git-send-email-rhansen@bbn.com>
	<1401915687-8602-1-git-send-email-rhansen@bbn.com>
	<1401915687-8602-11-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 23:11:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wsex0-0008SP-QZ
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 23:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbaFEVL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 17:11:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57582 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751440AbaFEVLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 17:11:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5ACF41E468;
	Thu,  5 Jun 2014 17:11:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ULWHxHOdHrAXxJT91QCV/fe4hmk=; b=nIDWNT
	JKT6xgPLmwdE1emrlUxifPBy6pNEp+RW9E0gYfriEZMppUaUFu15VS6UjaCB0lbK
	yHa8imQLbsQlTYBA1tlFHzrL+z1fuxSvfENHKJdbEMEJRPOJQGoMRziAVj3NK5ZG
	oq3ANAdsLbrwhNoUbkIMYLbvdhiV/6Mn9yVSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CrPPnZ34ADhayafvS23ldYaR0QY9QQv/
	IStiVfxdWIghDoj3d69pYrKKVBzwzX2WX8pw8wVyEnDK0vJQhDrQpws9mBPiUUSA
	/3Z5WNMjtnR/NYv9UK/udvzs8PjxfGRgGvpS3gud68K3C3JPY1LkHGK7W0yoVfza
	IroDOhYZZik=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4E7021E467;
	Thu,  5 Jun 2014 17:11:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9AF471E465;
	Thu,  5 Jun 2014 17:11:20 -0400 (EDT)
In-Reply-To: <1401915687-8602-11-git-send-email-rhansen@bbn.com> (Richard
	Hansen's message of "Wed, 4 Jun 2014 17:01:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F10B917C-ECF5-11E3-9A94-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250863>

Richard Hansen <rhansen@bbn.com> writes:

> Because test_eval_ is defined while zsh is in sh emulation mode, the
> shell code passed as an argument to test_expect_success would normally
> be evaluated in sh emulation mode.  However, with this change, it is
> now possible to evaluate the test code in zsh mode by adding the
> following line to a zsh-based test script:
>
>     emulate -R zsh -c 'test_eval_override () { eval "$*"; }'
>
> With test_eval_override defined in zsh emulation mode, the call to
> test_eval_override from test_eval_ will temporarily cause zsh to
> switch from sh emulation mode to zsh emulation mode.

Micronit: aren't all "zsh emulation mode"s above "zsh native mode"s?

In any case, the above explanation confuses me somewhat.  test_eval_
is fed a scriptlet defined for various test_expect_success tests,
and they are written in POSIX shells, not zsh, so wouldn't it be
wrong to run them as if they are zsh native scripts, following
non-POSIX shell syntax rules?

Puzzled...

> Signed-off-by: Richard Hansen <rhansen@bbn.com>
> ---
>  t/test-lib.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index c081668..3779634 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -414,7 +414,12 @@ maybe_setup_valgrind () {
>  test_eval_ () {
>  	# This is a separate function because some tests use
>  	# "return" to end a test_expect_success block early.
> -	eval </dev/null >&3 2>&4 "$*"
> +	if command -v test_eval_override >/dev/null 2>&1
> +	then
> +		test_eval_override "$*"
> +	else
> +		eval "$*"
> +	fi </dev/null >&3 2>&4
>  }
>  
>  test_run_ () {
