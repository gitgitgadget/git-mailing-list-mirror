From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/7] replace: add test for --graft
Date: Wed, 02 Jul 2014 13:49:26 -0700
Message-ID: <xmqqy4wbfpux.fsf@gitster.dls.corp.google.com>
References: <20140628171731.5687.30308.chriscool@tuxfamily.org>
	<20140628181117.5687.23923.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Jul 02 22:49:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2RTI-00035Y-2B
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 22:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756863AbaGBUtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 16:49:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51573 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756856AbaGBUte (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 16:49:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8304922E21;
	Wed,  2 Jul 2014 16:49:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wbUjbGKeIIOPu5fuonVdfffKzqw=; b=pcOUPv
	lMzDsMkIzsBaZgaG0FD5MBroRMsdvVaR7vV9y9XOo6Cb/enUi6FblVkm2l1pTgMk
	+1v7UFybXEjMnyxAtmpZTq+zAV/7M0vKMR3Iy4LnOkpY01eEY2DIYV8tQXMCufgV
	/P7IwwWglkmeeXmPZ9hJGLSAsteITxdlRwbzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hQmF6br309O8Br0sX4Z9YrrtARnIHElY
	Qn+Ec0mBEEUmwnEP0BcodasLaLAeIRwX0ukRbl4kY5lksy18dKohM0Qoml3LZfnt
	wBYKGHD7Txw5tJxpenW9dRTfZ96bV05fw1XQrJoaMpTWaUvaHzCn9VfK736FOfDk
	tjSBcQyN7uc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4E29D22E20;
	Wed,  2 Jul 2014 16:49:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F16A122E0D;
	Wed,  2 Jul 2014 16:49:16 -0400 (EDT)
In-Reply-To: <20140628181117.5687.23923.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sat, 28 Jun 2014 20:11:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5548B7D4-022A-11E4-883F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252839>

Christian Couder <chriscool@tuxfamily.org> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t6050-replace.sh | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> index 68b3cb2..ca45a84 100755
> --- a/t/t6050-replace.sh
> +++ b/t/t6050-replace.sh
> @@ -351,4 +351,16 @@ test_expect_success 'replace ref cleanup' '
>  	test -z "$(git replace)"
>  '
>  
> +test_expect_success '--graft with and without already replaced object' '
> +	test $(git log --oneline | wc -l) = 7 &&
> +	git replace --graft $HASH5 &&
> +	test $(git log --oneline | wc -l) = 3 &&
> +	git cat-file -p $HASH5 | test_must_fail grep parent &&

Please do not run non-git command under test_must_fail.

> +	test_must_fail git replace --graft $HASH5 $HASH4 $HASH3 &&
> +	git replace --force -g $HASH5 $HASH4 $HASH3 &&
> +	git cat-file -p $HASH5 | grep "parent $HASH4" &&
> +	git cat-file -p $HASH5 | grep "parent $HASH3" &&
> +	git replace -d $HASH5
> +'
> +
>  test_done

For all these "git cat-file -p $commit | grep ...", I would think
you should add "commit_has_parents" helper function to allow a bit
more careful testing.  As written, the test will mistake a commit
with string "parent $HASHx" anywhere, not in the header part, and
the test does not ensure that $HASH{3,4} is the {first,second}
parent.

	commit_has_parents $HASH5 $HASH4 $HASH3

would then may be implemented like:

	commit_has_parents () {
		git cat-file commit "$1" >payload &&
                sed -n -e '/^$/q' -e 's/^parent //p' <payload >actual &&
		shift &&
                printf 'parent %s\n' "$@" >expect &&
		test_cmp expect actual
	}
