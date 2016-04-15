From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/21] bisect: add test for the bisect algorithm
Date: Fri, 15 Apr 2016 14:13:42 -0700
Message-ID: <xmqqlh4ea83d.fsf@gitster.mtv.corp.google.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-7-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Apr 15 23:13:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arB3m-0005BG-MC
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 23:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbcDOVNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 17:13:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52794 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750914AbcDOVNq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 17:13:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ACDB213BFF;
	Fri, 15 Apr 2016 17:13:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XZhBA1MZDouLzOo0pjKYFp6Nw5g=; b=rYR8S/
	Q1JmZY9GOnt/6oPJv+dc1IbmkJmAhYut+25JT+A2fnm9T/YBy832S+pIaCTLGKmJ
	E14STfcEgveM/zgBgCaTv+Ceyv/ziWjBVNNYpkihxRsroZ6NpwVibHsXtaCAUpD3
	6qlDKhGFW6qpEzm/ksOaLdu4a+boXeRBfEnKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FZFqfUMyAlGoW+mpY2Zkf5Jv4v8/Y4FU
	1h0tEnYUjbdBVNSD6Ma9RVExdr6UTIJGvk+arLGcvv5rY+TqWKlKdmCO5zwHRMav
	tVzynEo4JYOPqPGk/qfpuRRegFTMukFnzxbpyRaf2CTNQlUC/zDZWoVk2p8onPiW
	98y7DxZrLLQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A483613BFD;
	Fri, 15 Apr 2016 17:13:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D17413BFA;
	Fri, 15 Apr 2016 17:13:43 -0400 (EDT)
In-Reply-To: <1460294354-7031-7-git-send-email-s-beyer@gmx.net> (Stephan
	Beyer's message of "Sun, 10 Apr 2016 15:18:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EF6DB608-034E-11E6-82D6-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291662>

Stephan Beyer <s-beyer@gmx.net> writes:

> +test_expect_success 'bisect algorithm works in linear history with an odd number of commits' '
> +	git bisect start A7 &&
> +	git bisect next &&
> +	test_cmp_rev HEAD A3 A4
> +'
> +
> +test_expect_success 'bisect algorithm works in linear history with an even number of commits' '
> +	git bisect reset &&
> +	git bisect start A8 &&
> +	git bisect next &&
> +	test_cmp_rev HEAD A4
> +'
> +
> +test_expect_success 'bisect algorithm works with a merge' '
> +	git bisect reset &&
> +	git bisect start Bmerge &&
> +	git bisect next &&
> +	test_cmp_rev HEAD A5 &&
> +	git bisect good &&
> +	test_cmp_rev HEAD A8 &&
> +	git bisect good &&
> +	test_cmp_rev HEAD B1 B2
> +'
> +
> +#                   | w  min | w  min | w  min | w  min |
> +# B---.    BCDmerge | 18  0  | 9    0 | 5    0 | 3    0 |
> +# |\ \ \            |        |        |        |        |
> +# | | | *  D2       | 5   5  | 2    2 | 2    2*| good   |
> +# | | | *  D1       | 4   4  | 1    1 | 1    1 | good   |
> +# | | * |  C3       | 10  8  | 1    1 | 1    1 | 1    1*|
> +# | | * |  C2       | 9   9 *| good   | good   | good   |
> +# | | * |  C1       | 8   8  | good   | good   | good   |
> +# | * | |  B3       | 8   8  | 3    3 | 1    1 | 1    1*|
> +# * | | |  Bmerge   | 11  7  | 4    4*| good   | good   |
> +# |\ \ \ \          |        |        |        |        |
> +# | |/ / /          |        |        |        |        |
> +# | * | |  B2       | 7   7  | 2    2 | good   | good   |
> +# | * | |  B1       | 6   6  | 1    1 | good   | good   |
> +# * | | |  A8       | 8   8  | 1    1 | good   | good   |
> +# | |/ /            |        |        |        |        |
> +# |/| |             |        |        |        |        |
> +# * | |   A7        | 7   7  | good   | good   | good   |
> +# * | |   A6        | 6   6  | good   | good   | good   |
> +# |/ /              |        |        |        |        |
> +# * |     A5        | 5   5  | good   | good   | good   |
> +# * |     A4        | 4   4  | good   | good   | good   |
> +# |/                |        |        |        |        |
> +# *       A3        | 3   3  | good   | good   | good   |
> +# *       A2        | 2   2  | good   | good   | good   |
> +# *       A1        | 1   1  | good   | good   | good   |

Nice drawing.  With this, it is easy to see how the first three
examples above are testing the right thing, too.  It is not
immediately clear what these asterisks in the table are trying to
say, though (the same comment applies to the other drawing below).

> +test_expect_success 'bisect algorithm works with octopus merge' '
> +	git bisect reset &&
> +	git bisect start BCDmerge &&
> +	git bisect next &&
> +	test_cmp_rev HEAD C2 &&
> +	git bisect good &&
> +	test_cmp_rev HEAD Bmerge &&
> +	git bisect good &&
> +	test_cmp_rev HEAD D2 &&
> +	git bisect good &&
> +	test_cmp_rev HEAD B3 C3 &&
> +	git bisect good &&
> +	test_cmp_rev HEAD C3 B3 &&
> +	git bisect good > output &&
> +	grep "$(git rev-parse BCDmerge) is the first bad commit" output
> +'
> +
> +# G 5a6bcdf        D3       | w  min | w  min |
> +# | B 02f2eed      A9       | 14  0  | 7   0  |
> +# | *---. 6174c5c  BCDmerge | 13  1  | 6   1  |
> +# | |\ \ \                  |        |        |
> +# | |_|_|/                  |        |        |
> +# |/| | |                   |        |        |
> +# G | | | a6d6dab  D2       | good   | good   |
> +# * | | | 86414e4  D1       | good   | good   |
> +# | | | * c672402  C3       | 7   7 *| good   |
> +# | | | * 0555272  C2       | 6   6  | good   |
> +# | | | * 28c2b2a  C1       | 5   5  | good   |
> +# | | * | 4b5a7d9  B3       | 5   5  | 3   3 *|
> +# | * | | a419ab7  Bmerge   | 8   6  | 4   3 *|
> +# | |\ \ \                  |        |        |
> +# | | |/ /                  |        |        |
> +# | | * | 4fa1e39  B2       | 4   4  | 2   2  |
> +# | | * | 92a014d  B1       | 3   3  | 1   1  |
> +# | * | | 79158c7  A8       | 5   5  | 1   1  |
> +# | | |/                    |        |        |
> +# | |/|                     |        |        |
> +# | * | 237eb73    A7       | 4   4  | good   |
> +# | * | 3b2f811    A6       | 3   3  | good   |
> +# | |/                      |        |        |
> +# | * 0f2b6d2      A5       | 2   2  | good   |
> +# | * 1fcdaf0      A4       | 1   1  | good   |
> +# |/                        |        |        |
> +# * 096648b        A3       | good   | good   |
> +# * 1cf01b8        A2       | good   | good   |
> +# * 6623165        A1       | good   | good   |
> +
> +test_expect_success 'bisect algorithm works with good commit on unrelated branch' '
> +	git bisect reset &&
> +	git bisect start A9 D3 &&
> +	test_cmp_rev HEAD "$(git merge-base A9 D3)" &&
> +	test_cmp_rev HEAD D2 &&
> +	git bisect good &&
> +	test_cmp_rev HEAD C3 &&
> +	git bisect good &&
> +	test_cmp_rev HEAD B3 Bmerge
> +'
> +
> +test_done
