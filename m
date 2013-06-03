From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/7] add simple tests of consistency across rebase types
Date: Mon, 03 Jun 2013 15:28:28 -0700
Message-ID: <7v1u8ide2b.fsf@alter.siamese.dyndns.org>
References: <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
	<1370292135-1236-1-git-send-email-martinvonz@gmail.com>
	<1370292135-1236-2-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 00:28:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjdF0-0000CJ-LM
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 00:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759088Ab3FCW2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 18:28:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63964 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758645Ab3FCW2d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 18:28:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67FAA24BA4;
	Mon,  3 Jun 2013 22:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g2L83eMY16C7heNbYlQmz12qh6E=; b=BtvQsi
	amwgWCK5EpdEFutOKhR5F6JJ9owGmHnQuRUr0IyAbReC8KYFqSbW6tldct9a81wh
	v1AC8Ll7tfl4luFKQj4bw+PS1vWRIZelUXJtxgreZpn+V74zUcYiBRta32OD3DmK
	2dlJ6YUa2DN2Y+t2RjpAFO2TpCSVm/bLqUheI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XxC1iihpIj6O+R2MmLh3pUDuLib6qD9R
	9ZLTNDU32ZfHzTsAXpq0EI/UFP3TSH0X9qaIEnskPT0TC3597E0mqfAjFbk9Ds9z
	8Ll7oYCmt242+8eoS+d2ZTk5roGeGBSz2JYSvRstC6+cK0v5bJp0GRhvc8nM3cqd
	TGk2RLsyO+w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56D9724BA3;
	Mon,  3 Jun 2013 22:28:32 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82DE024B93;
	Mon,  3 Jun 2013 22:28:30 +0000 (UTC)
In-Reply-To: <1370292135-1236-2-git-send-email-martinvonz@gmail.com> (Martin
	von Zweigbergk's message of "Mon, 3 Jun 2013 13:42:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB14286C-CC9C-11E2-8FE7-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226302>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> Helped-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  t/lib-rebase.sh                   | 15 ++++++++
>  t/t3421-rebase-topology-linear.sh | 78 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 93 insertions(+)
>  create mode 100755 t/t3421-rebase-topology-linear.sh
>
> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> index 6ccf797..62b3887 100644
> --- a/t/lib-rebase.sh
> +++ b/t/lib-rebase.sh
> @@ -65,3 +65,18 @@ EOF
>  	test_set_editor "$(pwd)/fake-editor.sh"
>  	chmod a+x fake-editor.sh
>  }
> +
> +# checks that the revisions in "$2" represent a linear range with the
> +# subjects in "$1"
> +test_linear_range () {
> +	! { git log --format=%p "$2" | sane_grep " " ;} &&

An interesting way to spell:

    test $(git rev-list --merges "$2" | wc -l) = 0

I think I am fine with either, though.

> +	expected=$1
> +	set -- $(git log --reverse --format=%s "$2")
> +	test "$expected" = "$*"

OK.

> +}
> +
> +reset_rebase () {
> +	git rebase --abort # may fail; ignore exit code

test_might_fail to catch unusual exit codes?

> +	git reset --hard &&
> +	git clean -f
> +}
> diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
> new file mode 100755
> index 0000000..c4b32db
> --- /dev/null
> +++ b/t/t3421-rebase-topology-linear.sh
> @@ -0,0 +1,78 @@
> +#!/bin/sh
> +
> +test_description='basic rebase topology tests'
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-rebase.sh
> +
> +# a---b---c
> +#      \
> +#       d---e
> +test_expect_success 'setup' '
> +	test_commit a &&
> +	test_commit b &&
> +	test_commit c &&
> +	git checkout b &&
> +	test_commit d &&
> +	test_commit e
> +'
> +
> +test_run_rebase () {
> +	result=$1
> +	shift
> +	test_expect_$result "simple rebase $*" "
> +		reset_rebase &&
> +		git rebase $* c e &&
> +		test_cmp_rev c HEAD~2 &&
> +		test_linear_range 'd e' c..
> +	"
> +}
> +test_run_rebase success ''
> +test_run_rebase success -m
> +test_run_rebase success -i
> +test_run_rebase success -p
> +
> +test_run_rebase () {
> +	result=$1
> +	shift
> +	test_expect_$result "rebase $* is no-op if upstream is an ancestor" "
> +		reset_rebase &&
> +		git rebase $* b e &&
> +		test_cmp_rev e HEAD
> +	"
> +}
> +test_run_rebase success ''
> +test_run_rebase success -m
> +test_run_rebase success -i
> +test_run_rebase success -p
> +
> +test_run_rebase () {
> +	result=$1
> +	shift
> +	test_expect_$result "rebase $* -f rewrites even if upstream is an ancestor" "
> +		reset_rebase &&
> +		git rebase $* -f b e &&

Asking to rebase the history leading to e from b on top of the merge
base (which happens to be b) may be no-op or force-create a new
history that is parallel.  OK.

> +		! test_cmp_rev e HEAD &&
> +		test_cmp_rev b HEAD~2 &&
> +		test_linear_range 'd e' b..
> +	"
> +}
> +test_run_rebase success ''
> +test_run_rebase success -m
> +test_run_rebase success -i
> +test_run_rebase failure -p
> +
> +test_run_rebase () {
> +	result=$1
> +	shift
> +	test_expect_$result "rebase $* fast-forwards if an ancestor of upstream" "

The description is a non-sentence, and while I can tell what it
wants to say, I do not have a good suggestion for rephrasing this.

This is asking to rebase the history leading to b on top of e, but e
already includes everything in b, so it just turns into a no-op of
not moving from e.  So it is not even a fast-forward.

> +		reset_rebase &&
> +		git rebase $* e b &&
> +		test_cmp_rev e HEAD
> +	"
> +}
> +test_run_rebase success ''
> +test_run_rebase success -m
> +test_run_rebase success -i
> +test_run_rebase success -p
> +
> +test_done
