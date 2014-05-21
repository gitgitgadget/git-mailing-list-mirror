From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] format-patch --signature-file <file>
Date: Wed, 21 May 2014 14:13:06 -0700
Message-ID: <xmqq61kyq1i5.fsf@gitster.dls.corp.google.com>
References: <1400634170-18266-1-git-send-email-jmmahler@gmail.com>
	<1400634170-18266-2-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 23:13:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnDp6-0000oP-TV
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 23:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbaEUVNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 17:13:13 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51691 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752629AbaEUVNM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 17:13:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0AE3619357;
	Wed, 21 May 2014 17:13:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5XLHrSmiOKVmJwcAIAhLMe7P3rE=; b=qq63hE
	SGP9NOychkNVlzr0ZgO7EcTmZQJ3VQy/hjCiWnK37uDFkHw7nx2mPGSmD8icILQi
	S04M/uHXFZQNa2PxeYBTYQYnQ6eM1el3PT0nA0nB1M7kkn2PNJJST89YP3eMYg9n
	RKwNpNnEE5eM+6tWPo6D+PEitZwjoDMFs5uFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qMGY3eM8d1KO8ITjCirjSNxGFOXnbwnR
	eANsinhY2muKWjeNxR9oQHc82SB9j5L+g5xqV9POGjWkBWIf6A78t8aMLXG4PMVg
	IDJg1C5y5CtPFR5WZp+rsb6C5x47TtLw/CnAUmFSW0ifLZxm6o1oORHFKU1dcUnn
	vdj+qy6RK7c=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EEE1219356;
	Wed, 21 May 2014 17:13:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EBB4119353;
	Wed, 21 May 2014 17:13:07 -0400 (EDT)
In-Reply-To: <1400634170-18266-2-git-send-email-jmmahler@gmail.com> (Jeremiah
	Mahler's message of "Tue, 20 May 2014 18:02:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B4D2A6D4-E12C-11E3-A730-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249832>

Jeremiah Mahler <jmmahler@gmail.com> writes:

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 9c80633..049493d 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -762,6 +762,38 @@ test_expect_success 'format-patch --signature="" suppresses signatures' '
>  	! grep "^-- \$" output
>  '
>  
> +cat >expect <<-\EOF
> +
> +Test User <test.email@kernel.org>
> +http://git.kernel.org/cgit/git/git.git
> +
> +git.kernel.org/?p=git/git.git;a=summary
> +
> +EOF

We have been trying not to do the above in recent test updates.  It
would be nice if this set-up did not have to be outside of the usual
test_expect_success structure.

> +test_expect_success 'format-patch --signature-file=file' '
> +	git format-patch --stdout --signature-file=expect -1 >output &&
> +	check_patch output &&
> +	sed -n -e "/^-- $/,\$p" <output | sed -e "1 d" | sed -e "\$d" | sed -e "\$d" >output2 &&

Overlong line.  If we can't make this pipeline shorter, at least
fold it to a reasonable length, e.g.

	sed -n -e ... <output |
        sed -e '1d' -e "\$d" |
        sed -e "\$d" >output2 &&

or something.

The SP between the address "1" and insn "d" looks somewhat funny and
ugly, especially given that you write the other one "$d" without
such a SP.  Was there a specific reason why it was needed?

I would further think that renaming a few files and updating the way
the check is done may make the whole thing easier to understand.

 * rename the input for --signature-file to "mail-signature".

 * keep the name "output" to hold the format-patch output, i.e.

     git format-patch -1 --stdout --signature-file=mail-signature >output

 * Instead of munging the "mail signature" part of the output too
   excessively to match the input, formulate the expected output
   using "mail-signature" as an input, i.e.

     sed -e '1,/^-- $/d' <output >actual &&
     {
	cat mail-signature && echo && echo
     } >expect &&
     test_cmp expect actual

Alternatively, the third-bullet point above may want to be further
future-proofed by using stripspace, e.g.

    sed -e '1/^-- $/d' <output | git stripspace >actual &&
    git stripspace <mail-signature >expect &&
    test_cmp expect actual

Thanks.
