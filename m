From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/6] t7810-grep: test multiple --author with
 --all-match
Date: Thu, 13 Sep 2012 13:47:51 -0700
Message-ID: <7vmx0t7iq0.fsf@alter.siamese.dyndns.org>
References: <7v7grzdue6.fsf@alter.siamese.dyndns.org>
 <cover.1347544259.git.git@drmicha.warpmail.net>
 <8fd93bb87098298677426735dd354fa4f64abc17.1347544259.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 13 22:48:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCGKR-00082r-Qe
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 22:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758821Ab2IMUrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 16:47:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53780 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752419Ab2IMUry (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 16:47:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B700A9CDF;
	Thu, 13 Sep 2012 16:47:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GIyboAK0I/JsUweBEqaSEMIVzn4=; b=yEI5Iq
	Mh6mSUVkI74ydyxBIHgYcCs7imZ9PcY1RUnn2EgDxbtBj67/CgldHv4aITmrkA3/
	2nwOr+gmwgvF5j0V/3xBfCjpYdLeGp6O5H/QVYp+mw0dd8LgX2QQciOTpJdtUB5I
	/sfhbsTbEETicHmthmjpgAOQboV0eh01tgeB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pXJuvCzr+2qKcq61loxvR6L/06HNBOMz
	mOnjfomlJIQS2jS5LrYLmVVIiYeb+6Zl80By8z7JK9hpUELUNb9vkv9MqGpGFC0a
	pfcLNDomzB2IwRZ/aa2epoTgmhveLb22UboxPl1MkjCKnPTBDwWPy6DbFsM61tY+
	yZkOOeIFJoo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4D9F9CDE;
	Thu, 13 Sep 2012 16:47:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A60FE9CDC; Thu, 13 Sep 2012
 16:47:52 -0400 (EDT)
In-Reply-To: <8fd93bb87098298677426735dd354fa4f64abc17.1347544259.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Thu, 13 Sep 2012 16:04:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4997BAB2-FDE4-11E1-80DE-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205419>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> --all-match is ignored for author matching on purpose.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---

What the added test expects is correct, but I do not think the above
description is correct.  "all-match" is implicitly turned on when
you use header match.

When you say

	git log --grep=Linus --grep=Junio

you will get

    (or
     pattern_body<body>Junio
     pattern_body<body>Linus
    )

but when you say

	git log --author=Linus --author=Junio

you will get

    [all-match]
    (or
     (or
      pattern_head<head 0>Linus
      pattern_head<head 0>Junio
     )
     true
    )

instead.  Notice that there is one extra level of "OR" node, so that
two OR nodes on the top-level backbone (think of these as cons cells
with car and cdr) are "author is either Linus or junio" and "True".
Because "all-match" is about rejecting a document as non-matching
unless all the OR nodes on the top-level backbone have fired, this
allows commit that is authored either by Linus or by Junio to match,
and "on purpose" part in your message is correct.

But

	git log --author=Linus --author=Junio --grep=commit

will be parsed to

    [all-match]
    (or
     pattern_body<body>commit
     (or
      (or
       pattern_head<head 0>Linus
       pattern_head<head 0>Junio
      )
      true
     )
    )

to have three OR nodes on the backbone: "the log message must have commit",
"authored by either Linus or Junio", and "true".  All three must
match somewhere in the "git cat-file commit" output for the commit
to be considered a match (but obviously they do not have to match on
the same line).

So what is giving commits made by Linus, even though it is not
authored by Junio, with "--author=Linus --author=Junio" is not the
lack of --all-match.  In fact, --all-match is implicitly set for
other things, so that the last example finds commits that mention
"commit" authored by one of these two people.  Commits that do
mention "commit" but are done by other people are excluded.  Commits
that do not mention "commit" are excluded even if they were done by
Linus or Junio.

	git log --committer=Linus --author=Junio

turns into

    [all-match]
    (or
     pattern_head<head 1>Linus
     (or
      pattern_head<head 0>Junio
      true
     )
    )

which has "committed by Linus", "authored by Junio" on the top-level
backbone, so both has to be true for a commit to match.

Adding --grep=commit makes it

    [all-match]
    (or
     pattern_body<body>commit
     (or
      pattern_head<head 1>Linus
      (or
       pattern_head<head 0>Junio
       true
      )
     )
    )

which has "committed by Linus", "authored by Junio", "mentions
commit" on the top-level, and all three has to be true.

	git log --committer=Linus --author=Junio --grep=commit --grep=tag

groups the "mentions commit" and "mentions tag" under a new
top-level OR node, i.e.

    [all-match]
    (or
     (or
      pattern_body<body>commit
      pattern_body<body>tag
     )
     (or
      pattern_head<head 1>Linus
      (or
       pattern_head<head 0>Junio
       true
      )
     )
    )

so the top-level backbone "all-match" works on becomes

 - Mentions either commit or tag,
 - Committed by Linus,
 - Authored by Junio

One possible improvement we can make is to parse the command line in
the last example with "--all-match" to

    [all-match]
    (or
     pattern_body<body>commit
     (or
      pattern_body<body>tag
      (or
       pattern_head<head 1>Linus
       (or
        pattern_head<head 0>Junio
        true
       )
      )
     )
    )

so that the backbone becomes

 - Mentions commit,
 - Mentions tag,
 - Committed by Linus,
 - Authored by Junio

to require that both commit and tag are mentioned in the message.

>  t/t7810-grep.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 1db3dcb..9bc63a3 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -580,6 +580,14 @@ test_expect_success 'log with multiple --author uses union' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'log --all-match with multiple --author still uses union' '
> +	git log --all-match --author="Thor" --author="Aster" --format=%s >actual &&
> +	{
> +	    echo third && echo second && echo initial
> +	} >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'log with --grep and multiple --author uses all-match' '
>  	git log --author="Thor" --author="Night" --grep=i --format=%s >actual &&
>  	{
