From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/3] diff: Let "git diff -O" read orderfile from any file, fail properly
Date: Mon, 16 Dec 2013 13:09:28 -0800
Message-ID: <xmqq4n68o647.fsf@gitster.dls.corp.google.com>
References: <1387224586-10169-1-git-send-email-naesten@gmail.com>
	<1387224586-10169-3-git-send-email-naesten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>
To: Samuel Bronson <naesten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 16 22:09:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsfQ1-0001TL-Mg
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 22:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624Ab3LPVJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 16:09:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52444 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129Ab3LPVJd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 16:09:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C56DC5B881;
	Mon, 16 Dec 2013 16:09:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3lJxBWC06JnPOI6naYsNLigJSt4=; b=ShUx+y
	+a1lmYa+8WuEwVRo2MysfGjkkABsRuOhwVBwtWpcNxqA5Z82xTVqmrC5hqJhhSIK
	T9OgWEKeDav9VPz7VOkp+ksGaGPxm69RTAL0t0kNUi6q/Jw9NpEqjLDCLx28TlPA
	bcmS6X0Hd23OkO+2SvGojRqiFARhmlDlja10Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Onpx8FiMjBYewqnlmDeA9pFOcT938/W8
	1gRYMQqvpNED3xeKPEGXPREbgK6AK+DOfwO+4KdNcovxAceMwvmQdgAHfGioLQis
	H8WUjqDC6jJJKvqkCLPQ7dnW3jQmvsJoIif8m7QQboapttlKdhDj3nuEP9N4pmHc
	qc1Ql68kM/k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2B3F5B880;
	Mon, 16 Dec 2013 16:09:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E11C65B87E;
	Mon, 16 Dec 2013 16:09:30 -0500 (EST)
In-Reply-To: <1387224586-10169-3-git-send-email-naesten@gmail.com> (Samuel
	Bronson's message of "Mon, 16 Dec 2013 15:09:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5B0301B4-6696-11E3-A99A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239368>

Samuel Bronson <naesten@gmail.com> writes:

> diff --git a/t/t4056-diff-order.sh b/t/t4056-diff-order.sh
> index 398b3f6..eb471e7 100755
> --- a/t/t4056-diff-order.sh
> +++ b/t/t4056-diff-order.sh
> @@ -61,12 +61,35 @@ test_expect_success "no order (=tree object order)" '
>  	test_cmp expect_none actual
>  '
>  
> +test_expect_success 'missing orderfile' '
> +	rm -f bogus_file &&
> +	test_must_fail git diff -Obogus_file --name-only HEAD^..HEAD
> +'
> +
> +test_expect_success 'unreadable orderfile' '
> +	touch unreadable_file &&
> +	chmod -r unreadable_file &&

Two points:

  - Unless your primary interest is to change the file timestamp, do
    not use "touch"; using ">unreadable_file" or something instead
    would tell the readers that you only want to make sure it exists
    and do not care about the file timestamp.

  - this test probably needs restricted to people with sane
    filesystems; I think POSIXPERM prerequisite and also SANITY
    prerequisite are needed, at least.

> +	test_must_fail git diff -Ounreadable_file --name-only HEAD^..HEAD
> +'
> +
> +test_expect_success 'orderfile is a directory' '
> +	test_must_fail git diff -O/ --name-only HEAD^..HEAD
> +'
> +
>  for i in 1 2
>  do
>  	test_expect_success "orderfile using option ($i)" '
>  	git diff -Oorder_file_$i --name-only HEAD^..HEAD >actual &&
>  	test_cmp expect_$i actual
>  '
> +
> +	test_expect_success PIPE "orderfile is fifo ($i)" '
> +	rm -f order_fifo &&
> +	mkfifo order_fifo &&
> +	cat order_file_$i >order_fifo &
> +	git diff -O order_fifo --name-only HEAD^..HEAD >actual &&
> +	test_cmp expect_$i actual
> +'
>  done
>  
>  test_done
