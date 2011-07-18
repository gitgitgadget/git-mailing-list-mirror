From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/48] t6039: Add failing testcases for
 rename/rename/add-{source,dest} conflicts
Date: Mon, 18 Jul 2011 16:38:04 -0700
Message-ID: <7voc0rdusj.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <1307518278-23814-7-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 01:38:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QixO9-0002mU-Rh
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 01:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195Ab1GRXiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 19:38:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37238 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114Ab1GRXiH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 19:38:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF67241B6;
	Mon, 18 Jul 2011 19:38:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=78mSAKMzDQxo12cQns/3Xh8WsN4=; b=loGa8YHnzoa5uce6S34e
	HYAn3wW9PwQNNQBaBsDo5eRSD8xPUAI8jDruQ9Z5axuP6XuUSjaulRMxihztPdgC
	+GV4i+IPRfyohuxkdPU+rwuTrcwAKbASCLCn3QTl1wio8fofDXpOAHV8f8GQkvAl
	99s9fbl8E0yCvivLdC0k9Tg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Bydqkkhxga0QmQr96DwbdIjDb6TT28mDCd47dBCRbR+6xt
	7Y393UNLs9tGjZ4Ubv3CEbpmiFWyWsh1JJO7ehCneBSwOPeDSbu+Pn9Ngs2F9p/9
	hrwRr4jU6Ikt18o6fzpi9fyuF1KsV9msT6nUWGMib4COzpDbtEZJA49fO1bFc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B760041B5;
	Mon, 18 Jul 2011 19:38:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B22E41B3; Mon, 18 Jul 2011
 19:38:06 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC93C3E0-B196-11E0-90B4-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177415>

Elijah Newren <newren@gmail.com> writes:

> Add testcases that cover three failures with current git merge, all
> involving renaming one file on both sides of history:
>
> Case 1:
> ...
> Case 3:
> ...
>
> Signed-off-by: Elijah Newren <newren@gmail.com>

Very nicely described.

> +test_expect_failure 'detect conflict with rename/rename(1to2)/add-source merge' '
> +	git checkout B^0 &&
> +
> +	test_must_fail git merge -s recursive C^0 &&
> +
> +	test -f a &&
> +	test -f b &&
> +	test -f c

Please check the contents of the index here as well.  I think:

 - "a" should be at stage#0, with "something completely different" from C;
 - "b" should have stage #1 and #2, both with the original "a" from A; and
 - "c" should have stage #1 and #3, both with the original "a" from A

right?  The last test in this patch is nicely done in this regard.

> +test_expect_success 'setup rename/rename(1to2)/add-source resolvable conflict' '
> +	git rm -rf . &&
> +	git clean -fdqx &&
> +	rm -rf .git &&
> +	git init &&
> +
> +	>a &&
> +	git add a &&
> +	test_tick &&
> +	git commit -m base &&
> +	git tag A &&
> +
> +	git checkout -b B A &&
> +	git mv a b &&
> +	test_tick &&
> +	git commit -m one &&
> +
> +	git checkout -b C A &&
> +	git mv a b &&
> +	echo important-info >a &&
> +	test_tick &&
> +	git commit -m two
> +'
> +
> +test_expect_failure 'rename/rename/add-source still tracks new a file' '
> +	git checkout C^0 &&
> +	git merge -s recursive B^0 &&
> +
> +	test 2 -eq $(git ls-files -s | wc -l) &&

Instead of just checking the numbers, could you make the expected result a
bit more explicit? What do we expect here? Perhaps

 - "a" in the index is at stage #0, with "important-info";
 - "a" in the working tree is clean;
 - "b" in the index is at stage #0, with empty content; and
 - "b" in the working tree is clean.

Again, the last test in this patch is nicely done in this regard.

> +test_expect_success 'setup rename/rename(1to2)/add-dest conflict' '
> +	git rm -rf . &&
> +	git clean -fdqx &&
> +	rm -rf .git &&
> +	git init &&
> +
> +	echo stuff >a &&
> +	git add a &&
> +	test_tick &&
> +	git commit -m base &&
> +	git tag A &&
> +
> +	git checkout -b B A &&
> +	git mv a b &&
> +	echo precious-data >c &&
> +	git add c &&
> +	test_tick &&
> +	git commit -m one &&
> +
> +	git checkout -b C A &&
> +	git mv a c &&
> +	echo important-info >b &&
> +	git add b &&
> +	test_tick &&
> +	git commit -m two
> +'
> +
> +test_expect_failure 'rename/rename/add-dest merge still knows about conflicting file versions' '
> +	git checkout C^0 &&
> +	test_must_fail git merge -s recursive B^0 &&
> +
> +	test 5 -eq $(git ls-files -s | wc -l) &&
> +	test 2 -eq $(git ls-files -u b | wc -l) &&
> +	test 2 -eq $(git ls-files -u c | wc -l) &&
> +	test $(git rev-parse :2:b) = $(git rev-parse C:b) &&
> +	test $(git rev-parse :3:b) = $(git rev-parse B:b) &&
> +	test $(git rev-parse :2:c) = $(git rev-parse C:c) &&
> +	test $(git rev-parse :3:c) = $(git rev-parse B:c)

5 - 2 - 2 = 1 so we know that it is merged cleanly in the index, but we
would want to also test "a" in the working tree is merged and clean.

Thanks.
