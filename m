From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/18] fsck: Add a simple test for receive.fsck.*
Date: Wed, 21 Jan 2015 00:59:13 -0800
Message-ID: <xmqqd268y0f2.fsf@gitster.dls.corp.google.com>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
	<cover.1421682369.git.johannes.schindelin@gmx.de>
	<ba5b133ec7dfad799107f041489f693022f0fcc8.1421682369.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 09:59:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDr8C-0006bq-RD
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 09:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbbAUI7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 03:59:17 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57573 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750889AbbAUI7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 03:59:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F52226A62;
	Wed, 21 Jan 2015 03:59:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zSZWRwWJfrev8WzgYvcbuEmWePM=; b=w10P7b
	QH4fJdoDjHI2E9Z9hqYRP3yYE16Pu045+QXHIWw2x9jycaHRSLQfw2yLx1Nqo4kH
	w2QfXMPZK+9M/ZPJ7oJ5HGrFNzt6c3KlIbObiFe/2avK2Emi/vwXtMgd3mAh0eC0
	aRPkEyP+sJLOrWoWVZVgLytbltI+m/DejS7Wc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EuhLyShEHX1mwuAPME14gr/VsXs0vD9x
	aAZPmsAHnEVjVHJnqK3Q/bgZ9nRr3gN/jyNUuQ17tSYsqr2EbNNPld4zqxGuAr01
	2xBg4e0C3FJH4ebg3lr9trksToDdM1rlG9sW84eoOL1wm6njSTai6PxDOdt941je
	uaDRzVgAh0Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 863F226A61;
	Wed, 21 Jan 2015 03:59:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0CDDD26A5F;
	Wed, 21 Jan 2015 03:59:14 -0500 (EST)
In-Reply-To: <ba5b133ec7dfad799107f041489f693022f0fcc8.1421682369.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 19 Jan 2015 16:51:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C65DF2DE-A14B-11E4-B098-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262719>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t5504-fetch-receive-strict.sh | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
> index 69ee13c..d491172 100755
> --- a/t/t5504-fetch-receive-strict.sh
> +++ b/t/t5504-fetch-receive-strict.sh
> @@ -115,4 +115,24 @@ test_expect_success 'push with transfer.fsckobjects' '
>  	test_cmp exp act
>  '
>  
> +cat >bogus-commit << EOF

"cat >bogus-commit <<\EOF", to reduce the mental burden of readers.

> +tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
> +author Bugs Bunny 1234567890 +0000
> +committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
> +
> +This commit object intentionally broken
> +EOF
> +
> +test_expect_success 'push with receive.fsck.warn = missing-email' '
> +	commit="$(git hash-object -t commit -w --stdin < bogus-commit)" &&
> +	git push . $commit:refs/heads/bogus &&
> +	rm -rf dst &&
> +	git init dst &&
> +	git --git-dir=dst/.git config receive.fsckobjects true &&
> +	test_must_fail git push --porcelain dst bogus &&
> +	git --git-dir=dst/.git config receive.fsck.warn missing-email &&
> +	git push --porcelain dst bogus >act 2>&1 &&
> +	grep "missing-email" act
> +'
> +
>  test_done
