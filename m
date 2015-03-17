From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4/GSoC/MICRO] revision: forbid combining --graph and --no-walk
Date: Tue, 17 Mar 2015 16:18:28 -0700
Message-ID: <xmqq4mpjmcvv.fsf@gitster.dls.corp.google.com>
References: <1425632110-31863-1-git-send-email-dongcan.jiang@gmail.com>
	<c6c08cdbbc0060c6d834c86d13a142cde290dc5c.1426039099.git.dongcan.jiang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com, l.s.r@web.de
To: Dongcan Jiang <dongcan.jiang@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 00:18:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YY0ku-0006Ii-F4
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 00:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384AbbCQXSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 19:18:31 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54122 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752963AbbCQXSb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 19:18:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A75C13FC56;
	Tue, 17 Mar 2015 19:18:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EIntMyHTm6cPAP+2i2FfiTNoAcM=; b=L4XsMJ
	0wK0TrysyX1r0FVlfAnDxCmkozj3Ua7Jp1x16ZwXPwbBKzdlwY5w4YxJvDcXmUQh
	+IVutCKCxkMFx8NNvoWNQQKHLSM5qu1sv9X+XCnH8asvey3KR0kJdZu9ChmjLmZK
	JiZ5xwvkqcYFSed654ArEwsTdqjQPaTjXhih0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gqNlb0kL+ZYOBlhmLCfUJWZFWwY++aC2
	Bd2gLNx8gdkBzvrioyARGryh213jCGkgqv1W8VyzwkYmpuEvd8lAZZ/DFTeAT9Rz
	X1j2jbekL88ps+xvm6L6mlI0AnWbH7shw/kRug4I5IP6llgXpxDZj8OY2SOOMMPg
	ZdqjiquiJBk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A07703FC55;
	Tue, 17 Mar 2015 19:18:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 109953FC53;
	Tue, 17 Mar 2015 19:18:29 -0400 (EDT)
In-Reply-To: <c6c08cdbbc0060c6d834c86d13a142cde290dc5c.1426039099.git.dongcan.jiang@gmail.com>
	(Dongcan Jiang's message of "Wed, 11 Mar 2015 10:13:02 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EC463642-CCFB-11E4-ABE9-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265676>

Dongcan Jiang <dongcan.jiang@gmail.com> writes:

> Because "--graph" is about connected history while --no-walk
> is about discrete points, it does not make sense to allow
> giving these two options at the same time. [1]
>
> This change makes a few calls to "show --graph" fail in
> t4052, but asking to show one commit with graph is a
> nonsensical thing to do. Thus, tests on "show --graph" in
> t4052 have been removed. [2,3] Same tests on "show" without
> --graph option have already been tested in 4052.

This looks almost perfect.
>
> diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
> index b68afef..a989e8f 100755
> --- a/t/t4052-stat-output.sh
> +++ b/t/t4052-stat-output.sh
> @@ -99,7 +99,7 @@ do
>  		test_cmp "$expect" actual
>  	'
>  
> -	test "$cmd" != diff || continue
> +	test "$cmd" != diff -a "$cmd" != show || continue

I think we avoid -a and -o used with test (don't we have a write-up
on this somewhere?).  Write it like this

	test "$cmd" != diff &&
        test "$cmd" != show || continue

or perhaps like this

	case "$cmd" in diff|show) continue ;; esac

Other than that I do not see anything objectionable.

Thanks, good job.
