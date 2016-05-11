From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] Add a perf test for rebase -i
Date: Wed, 11 May 2016 14:17:15 -0700
Message-ID: <xmqqr3d8jnvo.fsf@gitster.mtv.corp.google.com>
References: <cover.1462894344.git.johannes.schindelin@gmx.de>
	<cover.1462955446.git.johannes.schindelin@gmx.de>
	<96acc54c20962376d5438f8d9613dc9c8a6d5d1c.1462955446.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 11 23:17:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0bVg-0000qN-Ec
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 23:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbcEKVRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 17:17:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59044 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751400AbcEKVRU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 17:17:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 887FA19417;
	Wed, 11 May 2016 17:17:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8fzNYnm58Y+kPCrS1EOFfDZwBH4=; b=TGsnjx
	GV+mqnyAFKmBXc7CgS6YiLexIuduzDsMPx2z50rQ0TP1gH2pZcujCFbYuiYV1T5M
	tBdbwWwEu/cTtkEO19HEa71ayX+kUEdFCf3jXaW8Aq0Eh9CnoWhVlPgGdyThjYxy
	gA5IdwYIlWoMb5sRjCE/OlaXqgHmR5X7WubE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vu6V/cv26wWhXZLJfIN6rinOXaAPWwuJ
	bQRU5317T16fKf+wXRY3Q6df5loGFe6NHUSoiYra5b5RATesvxHWyP1gR/rQUmMV
	omw1bRaHcSLk17NRA9OlVz40kqta+ltnbbiOpM/IQUEuSzpm65R5LKCVCoBIDByU
	mHxWdyY613s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F0D519416;
	Wed, 11 May 2016 17:17:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DE7C119413;
	Wed, 11 May 2016 17:17:17 -0400 (EDT)
In-Reply-To: <96acc54c20962376d5438f8d9613dc9c8a6d5d1c.1462955446.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 11 May 2016 10:42:34 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BDA3C0BC-17BD-11E6-BF1A-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294365>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/t/perf/p3404-rebase-interactive.sh b/t/perf/p3404-rebase-interactive.sh
> new file mode 100755
> index 0000000..382163c
> --- /dev/null
> +++ b/t/perf/p3404-rebase-interactive.sh
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +
> +test_description='Tests rebase -i performance'
> +. ./perf-lib.sh
> +
> +test_perf_default_repo
> +
> +# This commit merges a sufficiently long topic branch for reasonable
> +# performance testing
> +branch_merge=ba5312d
> +export branch_merge

t/perf/README mentions the possibility to use your own repository as
a test data via GIT_PERF_REPO, but doing so would obviously break
this test.

I wonder if there is a way to say "running this perf script with
custom GIT_PERF_REPO is not supported" and error out.  That may
help other existing tests that (incorrectly) assume that their test
data is this project (if there is any).

> +
> +write_script swap-first-two.sh <<\EOF
> +case "$1" in
> +*/COMMIT_EDITMSG)
> +	mv "$1" "$1".bak &&
> +	sed -e '1{h;d}' -e 2G <"$1".bak >"$1"
> +	;;
> +esac
> +EOF
> +
> +test_expect_success 'setup' '
> +	git config core.editor "\"$PWD"/swap-first-two.sh\" &&
> +	git checkout -f $branch_merge^2
> +'
> +
> +test_perf 'rebase -i' '
> +	git rebase -i $branch_merge^
> +'
> +
> +test_done
