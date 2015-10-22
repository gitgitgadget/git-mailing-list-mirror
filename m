From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] Add test to describe expectation of blame --reverse with branched history
Date: Wed, 21 Oct 2015 21:19:45 -0700
Message-ID: <xmqqk2qfttzy.fsf@gitster.mtv.corp.google.com>
References: <1445485872-21453-1-git-send-email-max@max630.net>
	<1445485872-21453-2-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Thu Oct 22 06:19:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zp7M0-0005QH-AP
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 06:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbbJVETs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 00:19:48 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59043 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750767AbbJVETr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 00:19:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E3482267F7;
	Thu, 22 Oct 2015 00:19:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wj9kj5owCA5gM7+oAXjvrUO84dQ=; b=gIoUi4
	na0ZQFNdYCPTYojdr3q6wdNSKe01rDT3TPEhBWO+BzygTRLOJ95766clXfp/vSxL
	56thIBm228QwgfUaTUwaFDqcOhbc30lEvi0c/E+pnjga+JP75eRn1CQW3zHt6TLa
	lMF60vDJWE55PPrS3wXTBdB5R2El7+qavN29c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=broWFkFeDcEaIODsgudEHaHy1rqHEfkJ
	er9JYq2O6wMnl9rjtJzLkWcCSx/zTtQe24QerFiBZ3geb0adee3OJlePolHl4C0X
	9C6/851olHGhZJk4X7a9NBzHFlW4/RDrXQ/Fj9X04BhaOOygvD5TqdVtS9oxXW5Z
	YnXYgxqTkNY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D9C1F267F6;
	Thu, 22 Oct 2015 00:19:46 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 50DD7267F5;
	Thu, 22 Oct 2015 00:19:46 -0400 (EDT)
In-Reply-To: <1445485872-21453-2-git-send-email-max@max630.net> (Max
	Kirillov's message of "Thu, 22 Oct 2015 06:51:11 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 20A850FE-7874-11E5-9B28-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280038>

Max Kirillov <max@max630.net> writes:

> If history contains merges from feature branches, `blame --reverse`
> reports not the commit when the line was actually edited, but head of
> the last merged branch which was created before the edit.
>
> As a workaround, `blame --reverse --first-parent` could be used to find
> the merge of branch containing the edit, but it was disabled in
> 95a4fb0eac, because incorrectly specified range could produce in
> unexpected and meaningless result.
>
> Add tests which describe ideal functionality with and without
> `--first-parent`.
>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
>  t/t8009-blame-reverse.sh | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100755 t/t8009-blame-reverse.sh
>
> diff --git a/t/t8009-blame-reverse.sh b/t/t8009-blame-reverse.sh
> new file mode 100755
> index 0000000..9f40613
> --- /dev/null
> +++ b/t/t8009-blame-reverse.sh
> @@ -0,0 +1,34 @@
> +#!/bin/sh
> +
> +test_description='git blame reverse'
> +. ./test-lib.sh
> +

If you are going to dedicate the whole test script for this test,
could you draw the topology of the commit DAG here, so that readers
can more easily follow what is going on?

> +test_expect_success setup '
> +	test_commit A0 file.t line0 &&
> +	test_commit A1 &&
> +	git reset --hard A0 &&
> +	test_commit B1 &&
> +	test_commit B2 file.t line0changed &&
> +	git reset --hard A1 &&
> +	test_merge A2 B2 &&
> +	git reset --hard A1 &&
> +	test_commit C1 &&
> +	git reset --hard A2 &&
> +	test_merge A3 C1
> +	'

Let me try.

 (1) for merges, an edge with '*' denotes the one to the first
     parent.
 (2) a commit that touches file.t are in capital

           c1---a3
          /    *
         /    /
   A0---a1--*a2
     \      /
      b1---B2

Did I draw it correctly?


> +test_expect_failure 'blame --reverse finds B1, not C1' '
> +	git blame --porcelain --reverse A0..A3 -- file.t >actual_full &&
> +	head -1 <actual_full | sed -e "sX .*XX" >actual &&

"head -n 1" is more POSIXy way to spell this.

Don't get cute with sXXX in sed script when the usual s/// suffices;
the only effect of the cuteness is to waste readers' time, who have
to wonder if there is something interesting going on.

> +	git rev-parse B1 >expect &&
> +	test_cmp expect actual
> +	'
> +
> +test_expect_failure 'blame --reverse --first-parent finds A1' '
> +	git blame --porcelain --reverse --first-parent A0..A3 -- file.t >actual_full &&
> +	head -1 <actual_full | sed -e "sX .*XX" >actual &&
> +	git rev-parse A1 >expect &&
> +	test_cmp expect actual
> +	'
> +
> +test_done
