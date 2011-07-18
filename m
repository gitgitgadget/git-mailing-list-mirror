From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/48] t6036: tests for criss-cross merges with various
 directory/file conflicts
Date: Mon, 18 Jul 2011 16:40:35 -0700
Message-ID: <7v39i3b1jg.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <1307518278-23814-11-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 01:40:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QixQd-0003Wr-ES
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 01:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928Ab1GRXkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 19:40:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38409 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897Ab1GRXkh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 19:40:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ECB24216;
	Mon, 18 Jul 2011 19:40:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=j5EjqmnYWJ3n4mcZOc/tYwd1e1E=; b=DlFLmLBBeu5htihcLrom
	1CFqpRXj3bFDo8uSb+XCE4g2vER9yILIXuYD/t8sbWTxNduoV/mMHaqXoujLi3Hh
	7lExLYHPirW4MRYh75nvcM+M0eiY1atPX1rimKgdQ9u0IespK5xMIbZf0roYj0nY
	lvIEND/H9DjxGNbFLLCLciI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=gAxqtCUK5bcDfmt4Pw2v4nxpK0S3NNpiJNLk6ahlWZfKCt
	ssJWlA+GKit2gxkPWVhPA2Ut9wq900VSrjuUzVaYy8tFr2haEJ8SQdgXUD24MfpN
	mVth3P12l3gq1PdFS3JLE6OsEODH1IK5czCeZ1YBAlhqn5EYENHm81dRRBD1I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36C734215;
	Mon, 18 Jul 2011 19:40:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64FD94214; Mon, 18 Jul 2011
 19:40:36 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56202A8E-B197-11E0-AEA7-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177427>

Elijah Newren <newren@gmail.com> writes:

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t6036-recursive-corner-cases.sh |  149 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 149 insertions(+), 0 deletions(-)
>
> diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
> index dab52a4..4993f67 100755
> --- a/t/t6036-recursive-corner-cases.sh
> +++ b/t/t6036-recursive-corner-cases.sh
> @@ -397,4 +397,153 @@ test_expect_failure 'git detects conflict w/ criss-cross+contrived resolution' '
>  	test $(git rev-parse :3:file) = $(git rev-parse E:file)
>  '
>  
> +#
> +# criss-cross + d/f conflict via add/add:
> +#   Commit A: Neither file 'a' nor directory 'a/' exist.
> +#   Commit B: Introduce 'a'
> +#   Commit C: Introduce 'a/file'
> +# Two different later cases:
> +#   Commit D1: Merge B & C, keeping 'a' and deleting 'a/'
> +#   Commit E1: Merge B & C, deleting 'a' but keeping 'a/file'

Where does the content of a/file (or a) go?  Discarded?

> +#   Commit D2: Merge B & C, keeping a modified 'a' and deleting 'a/'
> +#   Commit E2: Merge B & C, deleting 'a' but keeping a modified 'a/file'

What "modification" is there to be made?  Are these evil merges?

> +#   Note: D == D1.

If you are not building nor testing D2, do not bring it up in the above
description. Otherwise, use D1 and D2 throughout the test and description.

> +# Finally, someone goes to merge D1&E1 or D1&E2 or D2&E1.  What happens?

State what _should_ happen here.  We are not wasting brainwave for mental
masturbation but are trying to solve real problems for real projects here.

Also aren't we interested in what should happen when D2 and E2 are merged?
If not why not?

> +#      B   D1 or D2
> +#      o---o			(file)
> +#     / \ / \
> +#  A o   X   ? F
> +#     \ / \ /
> +#      o---o
> +#      C   E1 or E2		(dir)
> +#

> +test_expect_failure 'git detects conflict and handles merge of D & E1 correctly' '
> +	git reset --hard &&
> +	git reset --hard &&
> +	git clean -fdqx &&
> +	git checkout D^0 &&

Why do you need to reset twice?  Superstition (you have a commented one
introduced later in the series --- perhaps this shows a bug in reset)?

"Start with a clean state at this commit (in this case D^0)" needs a
helper shell function to make everything below easier to read.

> +	# FIXME: If merge-base could keep both a and a/file in its tree, then
> +	# we could this merge would actually be able to succeed.

What exactly do you refer to in the above sentence with "merge-base"?

> +	test_must_fail git merge -s recursive E1^0 &&
> +
> +	test 2 -eq $(git ls-files -s | wc -l) &&
> +	test 1 -eq $(git ls-files -u | wc -l) &&
> +	test 0 -eq $(git ls-files -o | wc -l) &&
> +
> +	test $(git rev-parse :2:a) = $(git rev-parse B:a)
> +'

What is expected here? "a" at stage #2 ("a" from B) is being tested, and
what is the other entry?  "a/file" at stage #3 ("a/file" from E1) or
something else? What should the working tree have?

> +test_expect_failure 'git detects conflict and handles merge of E1 & D correctly' '

Instead of saying "correctly", state what you think should happen, in
other words, what your definition of "correct" is, because in these
made-up cases what is expected could be vastly different from people to
people.

This is the same merge in the opposite direction, right?
