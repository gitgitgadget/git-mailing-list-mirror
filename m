From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/8] merge-recursive: allow storing conflict hunks in index
Date: Tue, 09 Sep 2014 10:47:01 -0700
Message-ID: <xmqqd2b4lm96.fsf@gitster.dls.corp.google.com>
References: <cover.1409860234.git.tr@thomasrast.ch>
	<781fa77328ef04600c9ef7ad4f682e157c3aeefe.1409860234.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Tue Sep 09 19:47:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRPVb-0006RN-P5
	for gcvg-git-2@plane.gmane.org; Tue, 09 Sep 2014 19:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbaIIRrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 13:47:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55614 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765AbaIIRrK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 13:47:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2E2EF381C3;
	Tue,  9 Sep 2014 13:47:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JVZiw3hvVmVkT/NdNgs6oFjzScw=; b=BJSPdl
	cxofANgbgl9Vxbi/yTZ8mLhusVN5O5ulWXeCHTzdNUszfQxFJ9+8Y31pkgI3yJT9
	ISyKscsm4kHhtzKCh5SPi3P0vYrP+9Cdw94yEFyUQCk1gjlVd1ixHmRo0oX+eLh0
	FFiSo6PmTc0vvaiQi03oWjVxtDrxS0Ybu5ZSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NWQ5AHTMcmg0dQ4x4kcQdxkJ8Ph8t5KT
	1bkdj71imvBMoNKq/nX2kh4YtmmECQvtbxm+yUAivhCSR6eJG1GRB3t7juxeOjOC
	DaK7GDfob4vqtoPIpdgHzp56uRlJ9EClRlG/MMbg+fNSLZn7Et/y6RHcvnYG6vZs
	kni6RIUplmw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1A4B5381C2;
	Tue,  9 Sep 2014 13:47:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 87CA7381C0;
	Tue,  9 Sep 2014 13:47:03 -0400 (EDT)
In-Reply-To: <781fa77328ef04600c9ef7ad4f682e157c3aeefe.1409860234.git.tr@thomasrast.ch>
	(Thomas Rast's message of "Sat, 6 Sep 2014 19:57:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4EEA0622-3849-11E4-A2DA-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256697>

Thomas Rast <tr@thomasrast.ch> writes:

> diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
> index be07705..39841a9 100755
> --- a/t/t3030-merge-recursive.sh
> +++ b/t/t3030-merge-recursive.sh
> @@ -310,6 +310,26 @@ test_expect_success 'merge-recursive --index-only' '
>  	test_cmp expected-diff actual-diff
>  '
>  
> +test_expect_success 'merge-recursive --index-only --conflicts-in-index' '
> +	# first pass: do a merge as usual to obtain "expected"
> +	rm -fr [abcd] &&
> +	git checkout -f "$c2" &&
> +	test_expect_code 1 git merge-recursive "$c0" -- "$c2" "$c1" &&
> +	git add [abcd] &&
> +	git ls-files -s >expected &&
> +	# second pass: actual test
> +	rm -fr [abcd] &&
> +	git checkout -f "$c2" &&
> +	test_expect_code 1 \
> +		git merge-recursive --index-only --conflicts-in-index \
> +		"$c0" -- "$c2" "$c1" &&
> +	git ls-files -s >actual &&
> +	test_cmp expected actual &&

At this point what is the expected output from "git diff-files"?

> +	git diff HEAD >actual-diff &&
> +	: >expected-diff &&
> +	test_cmp expected-diff actual-diff
> +'
> +
>  test_expect_success 'fail if the index has unresolved entries' '
>  
>  	rm -fr [abcd] &&
