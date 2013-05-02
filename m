From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] upload-pack: ignore 'shallow' lines with unknown obj-ids
Date: Thu, 02 May 2013 09:54:06 -0700
Message-ID: <7vk3nh1fwx.fsf@alter.siamese.dyndns.org>
References: <1367506567-36828-1-git-send-email-mheemskerk@atlassian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Heemskerk <mheemskerk@atlassian.com>
X-From: git-owner@vger.kernel.org Thu May 02 18:54:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXwlr-0007sq-TI
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 18:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760500Ab3EBQyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 12:54:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32931 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759204Ab3EBQyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 12:54:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2AD91968D;
	Thu,  2 May 2013 16:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EwM9yYk/8o5oUPNWkPh+zj03Ei8=; b=u61WIE
	Hft7JMWgT79o+WShMIe6CbXE6Isixvn5VX+X8qgoWPnIQnVrhkZjSqSyKppU4LWu
	BkM3zQhiqgWuUIGcIFqtDXdAYyiwEWL5o89JqEQHTzj9pzgUzArEVnPL6bjQcxBe
	HxYeGYoKMtsr09+h8N65FJYnLXbfQSq9XnTvg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cSHdedZ9dBZsQY2r3pdvwPA7MWDdkVuR
	BW2t6rLsCOQLqx1CXa34BkSl91YrKL53/Dl931wqJvw+yvizaZgR1TFzflJF/B8d
	aLK/hRGO9TNPkAjtlpMJ5X7q/j6/o7MtTVCBuyQGNmEhlHZe6dZhskCCZhfi/OAr
	CYu11hOsHnk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA1E81968C;
	Thu,  2 May 2013 16:54:08 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5020E1968B;
	Thu,  2 May 2013 16:54:08 +0000 (UTC)
In-Reply-To: <1367506567-36828-1-git-send-email-mheemskerk@atlassian.com>
	(Michael Heemskerk's message of "Fri, 3 May 2013 00:56:07 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7D9B878-B348-11E2-B80D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223221>

Michael Heemskerk <mheemskerk@atlassian.com> writes:

> When the client sends a 'shallow' line for an object that the server does
> not have, the server currently dies with the error: "did not find object
> ...
>  Documentation/technical/pack-protocol.txt |  3 +--
>  t/t5500-fetch-pack.sh                     | 13 +++++++++++++
>  upload-pack.c                             |  2 +-
>  3 files changed, 15 insertions(+), 3 deletions(-)

Thanks.

The previous one (without the test) is already in 'next' so I'll
pick only the test part and queue it as an update to the series.

> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index d574085..3f0ca10 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -373,6 +373,19 @@ test_expect_success 'clone shallow with packed refs' '
>  	test_cmp count8.expected count8.actual
>  '
>  
> +test_expect_success 'fetch in shallow repo unreachable shallow objects' '
> +	(
> +		git clone --bare --branch B --single-branch "file://$(pwd)/." no-reflog &&
> +		git clone --depth 1 "file://$(pwd)/no-reflog" shallow9 &&
> +		cd no-reflog &&
> +		git tag -d TAGB1 TAGB2 &&
> +		git update-ref refs/heads/B B~~ &&
> +		git gc --prune=now &&
> +		cd ../shallow9 &&
> +		git fetch origin
> +	)
> +'
> +
>  test_expect_success 'setup tests for the --stdin parameter' '
>  	for head in C D E F
>  	do
