From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] clone: add `--shallow-submodules` flag
Date: Tue, 26 Apr 2016 10:46:37 -0700
Message-ID: <xmqqtwiogt4y.fsf@gitster.mtv.corp.google.com>
References: <1461633147-23131-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jacob.keller@gmail.com, larsxschneider@gmail.com,
	git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:46:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av74Q-00048L-IE
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 19:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbcDZRqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 13:46:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62246 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752305AbcDZRqm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 13:46:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6584D15657;
	Tue, 26 Apr 2016 13:46:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d4YWibsrb5Rgc+5bldCIoyeiJjA=; b=EXhC5s
	jrV6RDe7hXB+LwB648wPL7VsfWBYANK8qbjQp1ZWNIpj+Yz4p5GNwHmP7lGKvOmO
	2UIzv98wBWi/G9aT1pQjHjm6gIuKqNAvLb6xdzZz01s0KpCjrUJvhKkzSDgteK26
	Lcv5w4WhuY3antdGig/qr8jlrVyffYurqgyFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ctbNAUmkVvvbymnMwXEd8xZU724R8v4I
	8bDMrCV2drGl22xlJ94aHCrk6o6Sbd5o3DEoJ5gEVJPCgCZmh/Auc4uGFkd+EqHX
	UTmKps9kT3c0Gw+5NNDXj1M85VnC8eCFkerYFW0YaEdsiLSk6DCBkIe8Ie/IDQE5
	LOPoxkwBgJA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DCA615656;
	Tue, 26 Apr 2016 13:46:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 97A7E15652;
	Tue, 26 Apr 2016 13:46:38 -0400 (EDT)
In-Reply-To: <1461633147-23131-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 25 Apr 2016 18:12:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D3D66C6A-0BD6-11E6-94E5-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292627>

Stefan Beller <sbeller@google.com> writes:

>  I did not rebase this on 85705cfb (Merge branch 'ss/clone-depth-single-doc',
>  2016-01-20) or later, but worked on it with the base unchanged.

Thanks, will replace.

> diff --git a/t/t5614-clone-submodules.sh b/t/t5614-clone-submodules.sh
> new file mode 100755
> index 0000000..62044c5
> --- /dev/null
> +++ b/t/t5614-clone-submodules.sh
> @@ -0,0 +1,85 @@
> +#!/bin/sh
> +
> +test_description='Test shallow cloning of repos with submodules'
> +
> +. ./test-lib.sh
> +
> +pwd=$(pwd)
> +
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
> +	git submodule add "file://$pwd/sub" sub &&
> +	git commit -m "add submodule"
> +'
> +
> +test_expect_success 'nonshallow clone implies nonshallow submodule' '
> +	test_when_finished "rm -rf super_clone" &&
> +	git clone --recurse-submodules "file://$pwd/." super_clone &&

All of these "$path/." made me wonder one thing.  I know these URLs
that ends with slash-dot ought to work, but shouldn't they work
without them, too?  The "consistency" in this test that ends
anything that would have ended with "$pwd" with "$pwd/." somewhat
bothered me.
