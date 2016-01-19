From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/1] contrib/subtree: Add a test for subtree rebase that loses commits
Date: Tue, 19 Jan 2016 09:41:35 -0800
Message-ID: <xmqqsi1tbh68.fsf@gitster.mtv.corp.google.com>
References: <CAPig+cS6ouc+kdJaz10M2AApPoDODDcgDX9Azz8ih=4zxxD2zg@mail.gmail.com>
	<3eb25268597083cdb10303e3d5790302e719a803.1453172369.git.greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com,
	davidw@realtimegenomics.com
To: David Greene <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Tue Jan 19 18:41:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLaHv-0006JX-Bm
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 18:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbcASRlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 12:41:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55695 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757208AbcASRlj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 12:41:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 932C23B6AA;
	Tue, 19 Jan 2016 12:41:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=94KmSI/SKz10+3lYXRxq+Dw6pvA=; b=QuA7bV
	uWZy5x+BitcfV9ldDe4SNgoTM353xvi+eYFOepnRCoquwUgysXz8cqwAAhcXz9OV
	KT+nHtjaBqrn31GFPWF42ynBWifLwDtVnmxYlteRNKuEvvg22KwFLu83Q+Y5qnrm
	Ztl+VOBhuQA2e1l8HfqoXJ+IjL4XHVDtgEpvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lprznU5haun9uILXN7spQ6N0XkmamEgp
	KP4MPkondOVSZf3ruTuGwLR+NxPOxn3BbEmabLjOs8X6CJ1wz8Uuqx/5nXg8AFC1
	UGg+WjPdEqWkKkO8NFjJ8dRdTWvSOP5JIp5o3lE73q8StegjUV3i+xtB4/iAfYNl
	AoZdcYdyLA8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7A1733B6A9;
	Tue, 19 Jan 2016 12:41:38 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8C8AD3B6A7;
	Tue, 19 Jan 2016 12:41:37 -0500 (EST)
In-Reply-To: <3eb25268597083cdb10303e3d5790302e719a803.1453172369.git.greened@obbligato.org>
	(David Greene's message of "Mon, 18 Jan 2016 20:59:38 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E3EE2908-BED3-11E5-A7CF-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284361>

David Greene <greened@obbligato.org> writes:

> From: David A. Greene <greened@obbligato.org>
>
> This test merges an external tree in as a subtree, makes some commits
> on top of it and splits it back out.  In the process the added commits
> are lost or the rebase aborts with an internal error.  The tests are
> marked to expect failure so that we don't forget to fix it.
>
> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---
>
> Notes:
>     Change History:
>     
>     v1 - Initial version
>     v2 - Additional tests and code cleanup
>     v3 - Remove check_equal, mark comments on failure and remove
>          test_debug statements
>     v4 - Send correct v3 test (botched v3)
>     v5 - Fix use of verbose

Thanks, both.  Will queue.

I have a couple of questions and comments, though.

> +test_expect_success 'setup' '
> +	test_commit README &&
> +...
> +	tree=$(git write-tree) &&
> +	head=$(git rev-parse HEAD) &&
> +	rev=$(git rev-parse --verify files-master^0) &&
> +	commit=$(git commit-tree -p $head -p $rev -m "Add subproject master" $tree) &&

I think at this point, your index and working tree states match that
of $commit.  So the next command ...

> +	git reset $commit &&

... made me wonder what its significance was.  I think you are doing
this solely to move the HEAD pointer to point at $commit, but then
it would be much better and more readable to use update-ref, i.e.
making this line to:

	git update-ref HEAD $commit &&

instead, as "write-tree && commit-tree && update-ref" is a familiar
pattern to reimplement "git commit" using the plumbing.  Ending that
three-command sequence with "reset" breaks the pattern.

> +	(
> +		cd files_subtree &&
> +		test_commit master4
> +	) &&
> +	test_commit files_subtree/master5

I understand that you are creating these two commits both in the
top-level repository (the one the history initially created in
"files" repository gets merged into), but you are creating them
slightly differently.  Is that significant?  I am not complaining
about the style of writing tests, but I am wondering if having these
two commits created differently has any effect on the bug you
observed, which may be a good starting point for anybody who wants
to fix it to start digging from.  IOW, would the resulting history
different if you did this instead?

	test_commit files_subtree/master4 &&
	test_commit files_subtree/master5

I also notice that files_subtree/master4 does not appear in any of
the verification in the three tests that use the history being
prepared here, i.e. if master4 is silently dropped while master5 is
kept, such a bug won't be caught by them.
