From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] t7006: GIT_DIR/config should be honored in subdirs
 of toplevel
Date: Wed, 14 Apr 2010 13:50:39 -0700
Message-ID: <7v4ojdpxls.fsf@alter.siamese.dyndns.org>
References: <20100413021153.GA3978@progeny.tock>
 <20100413021355.GA4118@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 22:50:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O29Y2-0000ZV-2f
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 22:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756747Ab0DNUux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 16:50:53 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41007 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755749Ab0DNUuw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 16:50:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8312AAA66F;
	Wed, 14 Apr 2010 16:50:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cFGTHRByqtMsfUG8uwM5VtT1S1g=; b=dot1lR
	CyJgetal9s9VXnZLUBR1qRLRVKR4FXduVOYLMo88d6TCAa7wnoQmR/tZvl6OFlqc
	ra1ihBZL4ymz/hU/chxFgbq0M0XQHJTRJTbp0Ad0d465U6JVkk9QHT4Sh0dpDcCi
	ii6jeuItiExEU6hz5asKKOu0t94AA+O0GsQWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KPHUuVpzNMDfTycaNDywDLLtyza13z+R
	ZnZPfNwJyFkkuFQ+evS8ZUmw0h0ype+M8k+7yBXchXiEOIM3qJKCBdYTJVkICbhv
	XRLq59Hkj+Y2co9eWqp9VbDJ+/H2gpZCE6cxwqQsfV7h3U6um3d4uB2NWoko2n6n
	CeQQoNExsNU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BB74AA665;
	Wed, 14 Apr 2010 16:50:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F8ECAA65B; Wed, 14 Apr
 2010 16:50:41 -0400 (EDT)
In-Reply-To: <20100413021355.GA4118@progeny.tock> (Jonathan Nieder's message
 of "Mon\, 12 Apr 2010 21\:13\:56 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 663AC14A-4807-11DF-B981-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144913>

Jonathan Nieder <jrnieder@gmail.com> writes:

> +unset GIT_PAGER
> +rm -f core.pager_used
> +rm -fr sub

Why do you have these outside the test itself?

> +test_expect_success TTY 'core.pager in subdir' '
> +	PAGER=wc &&
> +	stampname=$(pwd)/core.pager_used &&
> +	export PAGER stampname &&
> +	git config core.pager "wc > \"\$stampname\"" &&
> +	mkdir sub &&
> +	(
> +		cd sub &&
> +		test_terminal git log
> +	) &&
> +	test -e "$stampname"
> +'

They are reasonable clean-up steps to start the real test (starting from
setting and exporting the pager) in a known good state, and as long as you
write them not to fail I don't see any reason to have them outside the
test.  You _might_ want to "unset GIT_PAGER" immediately after the test
that does "export PAGER", so that it won't contaminate the environment the
test script itself runs, but even for that purpose, it would probably be
better to run the parts that depend on the exported value in a subshell.
