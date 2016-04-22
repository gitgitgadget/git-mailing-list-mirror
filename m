From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/4] format-patch: add '--base' option to record base tree info
Date: Fri, 22 Apr 2016 14:39:28 -0700
Message-ID: <xmqqshydnx0v.fsf@gitster.mtv.corp.google.com>
References: <1461303756-25975-1-git-send-email-xiaolong.ye@intel.com>
	<1461303756-25975-3-git-send-email-xiaolong.ye@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Xiaolong Ye <xiaolong.ye@intel.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 23:39:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atinZ-0000ag-9U
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 23:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbcDVVjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 17:39:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53277 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751742AbcDVVjc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 17:39:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 84AAC1626E;
	Fri, 22 Apr 2016 17:39:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YnbCnngMt6ER7GrZumWA7KzRGEQ=; b=tUYqPu
	sZt/c+Owl0HgNt2FwiT2k2+yvcGfQympmMsWTVIapXwVGY9Er7wILQJzZHQBt8CJ
	XrWHNvkrfnKWXaG+fcbygNRlud0COklsPPFa6WiPndndVLKYlJk3TZlj1o0evzzu
	chIhIspi9m0Xo03eOiB2Z34d/JIzSe/b4Dg8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PeeOvrQt8k3EyQIqIoYmI5FvL0k9nUlP
	lJjnrWPNRKS+274LlESRAzMeSjnqlKH1CU0BJpk8UKeoJFCPTemGqKXehwM/W45H
	63BBDK2wS3AQnTuW5M4x51lg6tjWHFVW73O8I28dHsAQjTBaDtFQPdLwwAt0fRhv
	8dr3Fw7Ttws=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7982C1626D;
	Fri, 22 Apr 2016 17:39:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB5B81626C;
	Fri, 22 Apr 2016 17:39:29 -0400 (EDT)
In-Reply-To: <1461303756-25975-3-git-send-email-xiaolong.ye@intel.com>
	(Xiaolong Ye's message of "Fri, 22 Apr 2016 13:42:34 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B1ABA80A-08D2-11E6-859E-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292267>

Xiaolong Ye <xiaolong.ye@intel.com> writes:

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index eed2981..a6ce727 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1460,4 +1460,19 @@ test_expect_success 'format-patch -o overrides format.outputDirectory' '
>  	test_path_is_dir patchset
>  '
>  
> +test_expect_success 'format-patch --base' '
> +	git checkout side &&
> +	git format-patch --stdout --base=HEAD~~~ -1 >patch &&
> +	grep -e "^base-commit:" -A3 patch >actual &&
> +	echo "base-commit: $(git rev-parse HEAD~~~)" >expected &&

HEAD~3 would be easier to read (and HEAD~2 is easier than HEAD~~).

> +	echo "prerequisite-patch-id: $(git show --patch HEAD~~ | git patch-id --stable | awk "{print \$1}")" >>expected &&
> +	echo "prerequisite-patch-id: $(git show --patch HEAD~ | git patch-id --stable | awk "{print \$1}")" >>expected &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'format-patch --base error handling' '
> +	! git format-patch --base=HEAD~ -2 &&
> +	! git format-patch --base=HEAD~ -3
> +'

When making sure that "git" exits with a failure in a controlled way
(i.e. you want to consider "git" that segfaults as not passing the
test), do not use "! git cmd", but use "test_must_fail git cmd"
instead.

You now have a quite elaborate logic in base validation in this
round.  Is the topology of the history used in this test still
complex enough to make sure the logic is being tested?
