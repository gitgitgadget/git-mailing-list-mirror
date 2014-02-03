From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] tests: add checking that combine-diff emits only correct paths
Date: Mon, 03 Feb 2014 15:10:08 -0800
Message-ID: <xmqqzjm7bxny.fsf@gitster.dls.corp.google.com>
References: <cover.1391430523.git.kirr@mns.spb.ru>
	<9ee3e17af9a8da1f47423a74171d5cb95293f677.1391430523.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Tue Feb 04 00:10:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WASeq-0003Gw-N4
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 00:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326AbaBCXKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 18:10:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63877 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752160AbaBCXKR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 18:10:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F22D699BD;
	Mon,  3 Feb 2014 18:10:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bNRGsNT8LpIikOaY2skraMqgTTs=; b=awh1nu
	zF8lgGddL2t8smHFPxhw9my2oVstixe4IQPHNY3dqoCfSZrIbLVDaVla0r86T+BV
	ETekrw9PmRxUWJey9nqxtuVicHy/1lFUVrJWgGUtOUrhxCLstJDLixIFJqJxLzoz
	wiv0Fl95PtM8eIu4YiHMO0dgOWPf8XU+nPpUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FECH/8oTeRWUYFFE0M+EfamopSJg4Z1X
	Ex3Pma+/rhFplqKGbSscDZxS2r2o/RUCPyhRsjpeHigysXWbc9D+qNUPp5QL9kP5
	I03D+U4Is+uIJlQT6fPRdMPJwWs3zLmIInhqv/CpLSgxPi1c06iNTZXc267F0T6A
	JMfNTfCJvB4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D885699BB;
	Mon,  3 Feb 2014 18:10:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 98957699B9;
	Mon,  3 Feb 2014 18:10:11 -0500 (EST)
In-Reply-To: <9ee3e17af9a8da1f47423a74171d5cb95293f677.1391430523.git.kirr@mns.spb.ru>
	(Kirill Smelkov's message of "Mon, 3 Feb 2014 16:47:16 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 550CE2EE-8D28-11E3-A9A9-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241490>

Kirill Smelkov <kirr@mns.spb.ru> writes:

> where "correct paths" stands for paths that are different to all
> parents.
>
> Up until now, we were testing combined diff only on one file, or on
> several files which were all different (t4038-diff-combined.sh).
>
> As recent thinko in "simplify intersect_paths() further" showed, and
> also, since we are going to rework code for finding paths different to
> all parents, lets write at least basic tests.

Thanks.  Some nitpicks.

>
> Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
> ---
>  t/t4057-diff-combined-paths.sh | 106 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100755 t/t4057-diff-combined-paths.sh
>
> diff --git a/t/t4057-diff-combined-paths.sh b/t/t4057-diff-combined-paths.sh
> new file mode 100755
> index 0000000..e6e457d
> --- /dev/null
> +++ b/t/t4057-diff-combined-paths.sh
> @@ -0,0 +1,106 @@
> +#!/bin/sh
> +
> +test_description='combined diff show only paths that are different to all parents'
> +
> +. ./test-lib.sh
> +
> +# verify that diffc.expect matches output of
> +# `git diff -c --name-only HEAD HEAD^ HEAD^2`
> +diffc_verify() {

Style: SP before (), i.e.

	diffc_verify () {

> +	git diff -c --name-only HEAD HEAD^ HEAD^2 >diffc.actual &&
> +	test_cmp diffc.expect diffc.actual
> +}
> +
> +test_expect_success 'trivial merge - combine-diff empty' '
> +	for i in `test_seq 1 9`

Style: prefer $() over ``

> +	do
> +		echo $i >$i.txt	&&
> +		git add $i.txt

Quiz.  What happens when this "git add" fails with an earlier value
of $i?

> +	done &&
