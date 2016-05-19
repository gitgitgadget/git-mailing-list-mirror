From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv8 5/5] pathspec: allow querying for attributes
Date: Thu, 19 May 2016 12:37:56 -0700
Message-ID: <xmqqa8jlj0tn.fsf@gitster.mtv.corp.google.com>
References: <20160519010935.27856-1-sbeller@google.com>
	<20160519010935.27856-6-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 19 21:38:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Tlm-0006rA-B9
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 21:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754686AbcESTiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 15:38:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754679AbcESTiA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 15:38:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C615C1D3DA;
	Thu, 19 May 2016 15:37:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QHCBKXHAHcoRccwjyjNIKKUlRe8=; b=GzAcyd
	VYKVl81Ud3g8Er4GnZCcyhdXuB51iPezXDY5gk4rVruBE0LB6lSINQ3dCKwPZs26
	DwFEeZ5W9mwogjjZ4/xlQD38krLU2HTOd51LjkjYUqU/xENWdDYp6ixzzWan9U69
	4nc4pyzHf29qEowYqcPMWig32Q3zJuNX4lqDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gaq67R+KUmHD2amyWKWZN1sf/QdQJY/9
	cADMDlsqlQPsmjb7FUrw0yqqMM6ps8+Vn0ZGml2EdeEwWduIGMVebnWnXJg2+Wjn
	+SLbhrAKID4+f4YXhhZSplPxHkFFupb69T3VvS5stbrfsQ4ze2lNZ73bF10UIfoi
	rJkNZI9/9NM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BDA6A1D3D9;
	Thu, 19 May 2016 15:37:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FAC21D3D8;
	Thu, 19 May 2016 15:37:58 -0400 (EDT)
In-Reply-To: <20160519010935.27856-6-sbeller@google.com> (Stefan Beller's
	message of "Wed, 18 May 2016 18:09:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 30B6B50A-1DF9-11E6-8AA0-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295093>

Stefan Beller <sbeller@google.com> writes:

> +test_expect_success 'setup a tree' '
> +	mkdir sub &&
> +	for p in fileA fileB fileC fileAB fileAC fileBC fileNoLabel fileUnsetLabel fileSetLabel fileValue fileWrongLabel; do
> +		: >$p &&
> +		git add $p &&
> +		: >sub/$p
> +		git add sub/$p
> +	done &&
> +	git commit -m $p &&

What does this $p refer to?

> +	git ls-files >actual &&
> +	cat <<EOF >expect &&
> +fileA
> +fileAB
> +fileAC
> +fileB
> +fileBC
> +fileC
> +fileNoLabel
> +fileSetLabel
> +fileUnsetLabel
> +fileValue
> +fileWrongLabel
> +sub/fileA
> +sub/fileAB
> +sub/fileAC
> +sub/fileB
> +sub/fileBC
> +sub/fileC
> +sub/fileNoLabel
> +sub/fileSetLabel
> +sub/fileUnsetLabel
> +sub/fileValue
> +sub/fileWrongLabel
> +EOF
> +	test_cmp expect actual
> +'

If I were doing this, I'd prepare the list of paths (i.e. expect)
first and then create these paths using that list, i.e.

test_expect_success 'setup a tree' '
	cat <<-\EOF >expect &&
	fileA
	fileAB
	...
	sub/fileWrongLabel
	EOF
	mkdir sub &&
	while read path
	do
		: >$path &&
		git add $path || return 1
	done <expect &&
	git commit -m initial &&
	git ls-files >actual &&
	test_cmp expect actual
'
