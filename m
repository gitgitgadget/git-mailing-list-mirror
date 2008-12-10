From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] diff: fix handling of binary rewrite diffs
Date: Wed, 10 Dec 2008 00:34:49 -0800
Message-ID: <7vvdts1l92.fsf@gitster.siamese.dyndns.org>
References: <20081209081227.GA19626@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 10 09:36:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAKYK-0002kH-4k
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 09:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649AbYLJIe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 03:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754701AbYLJIe4
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 03:34:56 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59976 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272AbYLJIey (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 03:34:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5435885A6A;
	Wed, 10 Dec 2008 03:34:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5F31F85A64; Wed,
 10 Dec 2008 03:34:51 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6B48A5FC-C695-11DD-9CC5-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102673>

Jeff King <peff@peff.net> writes:

> Instead, if we have binary files, then let's just skip emit_rewrite_diff
> altogether. We will already have shown the "dissimilarity index" line,
> so it is really about the diff contents. If binary diffs are turned off,
> the "Binary files a/file and b/file differ" message should be the same
> in either case. If we do have binary patches turned on, there isn't much
> point in making a less-efficient binary patch that does a total rewrite;
> no human is going to read it, and since binary patches don't apply with
> any fuzz anyway, the result of application should be the same.

Makes sense.

>  diff.c                         |    4 ++-
>  t/t4031-diff-rewrite-binary.sh |   42 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 1 deletions(-)
>  create mode 100755 t/t4031-diff-rewrite-binary.sh
>
> diff --git a/diff.c b/diff.c
> index f644947..ea958a2 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1376,7 +1376,9 @@ static void builtin_diff(const char *name_a,
>  		 */
>  		if ((one->mode ^ two->mode) & S_IFMT)
>  			goto free_ab_and_return;
> -		if (complete_rewrite) {
> +		if (complete_rewrite &&
> +		    !diff_filespec_is_binary(one) &&
> +		    !diff_filespec_is_binary(two)) {
>  			emit_rewrite_diff(name_a, name_b, one, two, o);
>  			o->found_changes = 1;
>  			goto free_ab_and_return;

And looks correct.

> diff --git a/t/t4031-diff-rewrite-binary.sh b/t/t4031-diff-rewrite-binary.sh
> new file mode 100755
> index 0000000..4b522f7
> --- /dev/null
> +++ b/t/t4031-diff-rewrite-binary.sh
> @@ -0,0 +1,42 @@
> +#!/bin/sh
> +
> +test_description='rewrite diff on binary file'
> +
> +. ./test-lib.sh
> +
> +# We must be large enough to meet the MINIMUM_BREAK_SIZE
> +# requirement.
> +make_file() {
> +	for i in 1 2 3 4 5 6 7 8 9 10; do
> +		for j in 1 2 3 4 5 6 7 9 10; do
> +			for k in 1 2 3 4 5; do
> +				printf "$1\n"
> +			done
> +		done
> +	done >file
> +}
> +
> +test_expect_success 'create binary file with changes' '
> +	make_file "\\0" &&
> +	git add file &&
> +	make_file "\\01"
> +'

Hmm... "1 2 3 4 5 6 7 9 10"?
