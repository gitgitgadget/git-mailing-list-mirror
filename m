From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] bisect: add support for bisecting bare
 repositories
Date: Tue, 09 Aug 2011 10:26:10 -0700
Message-ID: <7vty9qsdhp.fsf@alter.siamese.dyndns.org>
References: <1312855914-610-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 19:26:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qqq4I-0006Gv-Hn
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 19:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964Ab1HIR0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Aug 2011 13:26:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54095 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab1HIR0M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 13:26:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 683364A33;
	Tue,  9 Aug 2011 13:26:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BCSq85d3CYy1MRIyER+N3XiSUlU=; b=qn3Ekg
	tsr8cIBij5UHJQhY1CEY9BV2ADs8Ft+dpAV5qWgc79dbKYfKl5UhOdjHHmp6O5Q9
	nUUZWIX9y5y1jPgV9P8/9fEnOE5/YlnHev2XOILoUNMl20KL2QiqFp/izhFJIVIy
	FrGs5P5Ya/kv8G5wY1hh4kUBcRxRLOOIR/t3g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vdy0/kd+6M3lkCpfYmWaL5inahbP9R78
	LVsy8SJDZd/SshXzgmjhuOkRKmFQkpNhHTFDmjjoVvh2zaeH0MwjFheWeZdXCtUG
	2fJoK22l7ofUMn2Nbe3jkh8W+eK43AXxlbqoVguoaSUScDvJkaJVZqdJzmcHCzTS
	v1lDdmXc5fQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FF7A4A32;
	Tue,  9 Aug 2011 13:26:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C31C64A31; Tue,  9 Aug 2011
 13:26:11 -0400 (EDT)
In-Reply-To: <1312855914-610-1-git-send-email-jon.seymour@gmail.com> (Jon
 Seymour's message of "Tue, 9 Aug 2011 12:11:54 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD47E326-C2AC-11E0-A0CB-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179035>

Jon Seymour <jon.seymour@gmail.com> writes:

> This extension to js/bisect-no-checkout adds support for bisecting bare repositories.
>
> It does this by relaxing the requirement that git bisect is invoked in a repository with a working tree and by defaulting to --no-checkout in the case of a bare repository.
>
> Two tests are included to demonstrate this behaviour.

I'd wrap the long line myself but next time please be careful.

> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index 4fb7d11..62125ec 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -592,6 +592,37 @@ test_expect_success 'erroring out when using bad path parameters' '
>  	grep "bad path parameters" error.txt
>  '
>  
> +test_expect_success 'test bisection on bare repo - --no-checkout specified' '
> +	git clone --bare . bare.nocheckout &&
> +	(
> +		cd bare.nocheckout &&
> +		git bisect start --no-checkout &&
> +		git bisect good $HASH1 &&
> +		git bisect bad $HASH4 &&
> +		git bisect run eval \
> +			"test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=1 | wc -l) = 0" \
> +			>../nocheckout.log &&
> +		git bisect reset
> +	) &&
> +	grep "$HASH3 is the first bad commit" nocheckout.log
> +'

git-bisect does not have any cd_to_toplevel so with a working tree you can
run a bisection from a subdirectory, it seems. I wonder what would happen
if you did "cd bare.nocheckout/objects" or something silly like that.

Just wondering...
