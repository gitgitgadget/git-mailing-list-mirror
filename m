From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: add `--shallow-submodules` flag
Date: Mon, 25 Apr 2016 14:04:29 -0700
Message-ID: <xmqqd1pdjt7m.fsf@gitster.mtv.corp.google.com>
References: <1461609054-17118-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jacob.keller@gmail.com, larsxschneider@gmail.com,
	git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 23:04:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aungY-0001P2-7p
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 23:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965132AbcDYVEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 17:04:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51478 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964836AbcDYVEd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 17:04:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 07F8A16DAA;
	Mon, 25 Apr 2016 17:04:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pjkDgVW3kRBBsTwqTxu69V/V7qk=; b=F0AyNJ
	vRzaHsUQbO6raGftsb59JBkSTuqcww7Ws7kH4u3g4tAOyi1AKknAhc+6o5OvRsA/
	yHoQSmp7f5kmNpAdG4BRykL5bBCtgSMvWDOxK0Fmq341VYnJJKVT84fpVV9teTLL
	R5HqUZ+oIqCALinolIwxmLwc7CeW0gV8vBDkg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HcncLPcXjbrUA2DMQZYByqyXd0OflzNG
	k9cQe5JwPj8B1xfyqnclLZFJLzjUcdGFYvkw40RIxYmqKl89WpdLin7kw6IhYqcT
	ljK9Q/5YKkpfSAr0gxmqWbBsga91H5/tYULT0Ad1ac/IZFrG6Y3Vl4Z08AzHSndy
	XiAZLM/3gGM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 002D016DA8;
	Mon, 25 Apr 2016 17:04:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 68FAE16DA7;
	Mon, 25 Apr 2016 17:04:31 -0400 (EDT)
In-Reply-To: <1461609054-17118-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 25 Apr 2016 11:30:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4E2BBEF6-0B29-11E6-AD38-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292557>

Stefan Beller <sbeller@google.com> writes:

>   This replaces origin/sb/clone-shallow-passthru.
> @@ -190,7 +190,11 @@ objects from the source repository into a pack in the cloned repository.
>  
>  --depth <depth>::
>  	Create a 'shallow' clone with a history truncated to the
> -	specified number of revisions.
> +	specified number of revisions. Implies `--single-branch` unless
> +	`--no-single-branch` is given to fetch the histories near the
> +	tips of all branches. This implies `--shallow-submodules`. If
> +	you want to have a shallow superproject clone, but full submodules,
> +	also pass `--no-shallow-submodules`.

This is not wrong per-se but the early half of the new text seems to
come from 28a1b569 (docs: clarify that passing --depth to git-clone
implies --single-branch, 2016-01-06), which was merged to 'master'
some time ago.

I've resolved the conflicts coming from the duplicates, so no need
to resend, but the resulting history would become misleading.  I am
undecided if I should rebasing this on top of 85705cfb (Merge branch
'ss/clone-depth-single-doc', 2016-01-20) or later.

> diff --git a/t/t5614-clone-submodules.sh b/t/t5614-clone-submodules.sh
> new file mode 100755
> index 0000000..825f511
> --- /dev/null
> +++ b/t/t5614-clone-submodules.sh
> @@ -0,0 +1,85 @@
> +#!/bin/sh
> +
> +test_description='Test shallow cloning of repos with submodules'
> +
> +. ./test-lib.sh
> +
> +p=$(pwd)

A single-letter lower-case global that needs to stay constant for
the entire file looks like a ticking time bomb screaming to be
broken by future updates.  I see $D used for this purpose in many
scripts, $here and $top in some, and $TRASH in yet some others.
Perhaps $D may be more appropriate if we wanted to keep this
ultra-short-and-cryptic while mimicking existing ones.

> +test_expect_success 'setup' '
> +	git checkout -b master &&
> +	test_commit commit1 &&
> +	test_commit commit2 &&
> +	mkdir sub &&
> +	(
> +		cd sub &&
> +		git init &&
> +		test_commit subcommit1 &&
> +		test_commit subcommit2 &&
> +		test_commit subcommit3
> +	) &&
> +	git submodule add "file://$p/sub" sub &&
> +	git commit -m "add submodule"
> +'
> +
> +test_expect_success 'nonshallow clone implies nonshallow submodule' '
> +	test_when_finished "rm -rf super_clone" &&
> +	git clone --recurse-submodules "file://$p/." super_clone &&
> +	(
> +		cd super_clone &&
> +		git log --oneline >lines &&
> +		test_line_count = 3 lines
> +	) &&
> +	(
> +		cd super_clone/sub &&
> +		git log --oneline >lines &&
> +		test_line_count = 3 lines
> +	)
> +'
> +
> +test_expect_success 'shallow clone implies shallow submodule' '
> +	test_when_finished "rm -rf super_clone" &&
> +	git clone --recurse-submodules --depth 2 "file://$p/." super_clone &&
> +	(
> +		cd super_clone &&
> +		git log --oneline >lines &&
> +		test_line_count = 2 lines
> +	) &&
> +	(
> +		cd super_clone/sub &&
> +		git log --oneline >lines &&
> +		test_line_count = 1 lines
> +	)
> +'
> +
> +test_expect_success 'shallow clone with non shallow submodule' '
> +	test_when_finished "rm -rf super_clone" &&
> +	git clone --recurse-submodules --depth 2 --no-shallow-submodules "file://$p/." super_clone &&
> +	(
> +		cd super_clone &&
> +		git log --oneline >lines &&
> +		test_line_count = 2 lines
> +	) &&
> +	(
> +		cd super_clone/sub &&
> +		git log --oneline >lines &&
> +		test_line_count = 3 lines
> +	)
> +'
> +
> +test_expect_success 'non shallow clone with shallow submodule' '
> +	test_when_finished "rm -rf super_clone" &&
> +	git clone --recurse-submodules --no-local --shallow-submodules "file://$p/." super_clone &&
> +	(
> +		cd super_clone &&
> +		git log --oneline >lines &&
> +		test_line_count = 3 lines
> +	) &&
> +	(
> +		cd super_clone/sub &&
> +		git log --oneline >lines &&
> +		test_line_count = 1 lines
> +	)
> +'
> +
> +test_done
