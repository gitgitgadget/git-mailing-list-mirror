From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/12] commit: add tests of commit races
Date: Thu, 12 Feb 2015 11:36:23 -0800
Message-ID: <xmqqoaoysz0o.fsf@gitster.dls.corp.google.com>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
	<1423739543-1025-7-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 12 20:36:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLzYs-0006Gv-DH
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 20:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbbBLTg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 14:36:27 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55214 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751978AbbBLTg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 14:36:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 354863738E;
	Thu, 12 Feb 2015 14:36:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/830gCDGXJRq+Mr7MWfu7XOEid0=; b=X0Hv5l
	0WInWK4t647g80cKOpjXq5GR1Fmb3+EIaUI+9afgDAs0zyNbjbNRnX8haukApImI
	jf/tJm6CYSwQCClYaDvwdZN1WO264RWCxCNjUOvogObyvciXpoarvA/5wEslEd3d
	dABvnAd4V2lRw7fzy8gcLoI2orqN8W1j70Dx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v5ORMFjhOw7ZEjVavbE2S1W7JJCOKP8g
	yBY2gDeIzblDD1TthviWNtGBJjhPrPsKYIF9/6PBroBHishuIZ1S5oafsetEMU45
	TBlwESmmfD01fo2bntiUVb417QB1OMCylSuhE21zYuHAULvVycEfCNoyI2ssrh5D
	VDS1WiNAOKw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 25BD63738C;
	Thu, 12 Feb 2015 14:36:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 88ECA3738B;
	Thu, 12 Feb 2015 14:36:24 -0500 (EST)
In-Reply-To: <1423739543-1025-7-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Thu, 12 Feb 2015 12:12:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6E0ED094-B2EE-11E4-9154-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263753>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> diff --git a/t/t7516-commit-races.sh b/t/t7516-commit-races.sh
> new file mode 100755
> index 0000000..08e6a6c
> --- /dev/null
> +++ b/t/t7516-commit-races.sh
> @@ -0,0 +1,33 @@
> +#!/bin/sh
> +
> +test_description='git commit races'
> +. ./test-lib.sh
> +
> +test_tick
> +
> +test_expect_success 'set up editor' '
> +	write_script editor <<-\EOF
> +	git commit --allow-empty -m hare
> +	echo tortoise >"$1"
> +	EOF
> +'
> +
> +test_expect_failure 'race to create orphan commit' '
> +	test_must_fail env EDITOR=./editor git commit --allow-empty &&
> +	git show -s --pretty=format:%s >subject &&
> +	grep -q hare subject &&

Why "grep -q" in the test?  Normal invocation of the tests will hide
the output anyway, no?

Wouldn't letting "sh tDDDD-name-of-test.sh -v" show the output
better for those who are hunting for breakages to see at which step
of the &&-chain things break?

> +	test -z "$(git show -s --pretty=format:%P)"
> +'

> +test_expect_success 'race to create non-orphan commit' '
> +	git checkout --orphan branch &&
> +	git commit --allow-empty -m base &&
> +	git rev-parse HEAD >base &&
> +	test_must_fail env EDITOR=./editor git commit --allow-empty &&
> +	git show -s --pretty=format:%s >subject &&
> +	grep -q hare subject &&

Can we use a token different from hare and tortoise here?  If the
previous one worked correctly, the main "commit" process would have
failed to add 'tortoise' on top of 'hare' that raced from sideways
(which is simulated by making 'hare' from the editor), so the tip of
the history would be 'hare' when this test starts.  Expecting 'hare'
here makes it unclear if you are expecting _both_ of the competing
processes to fail (i.e. the main 'commit' fails to add 'tortoise'
and the racing 'commit' fails to do 'hare'), leaving the 'hare' the
previous test left at the tip of the history, or if you are expecting
that the competing one that tries to create the second 'hare' on top
of the existing 'hare' to win.

> +	git rev-parse HEAD^ >parent &&
> +	test_cmp base parent
> +'
> +
> +test_done
