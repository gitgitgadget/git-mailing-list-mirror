From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t5704: Fix the test that checks for excluded tags
Date: Mon, 04 Aug 2014 13:08:54 -0700
Message-ID: <xmqqzjfkqap5.fsf@gitster.dls.corp.google.com>
References: <1406968747-16100-1-git-send-email-git@cryptocrack.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Lukas Fleischer <git@cryptocrack.de>
X-From: git-owner@vger.kernel.org Mon Aug 04 22:09:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEOZE-0000JI-9f
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 22:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbaHDUJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 16:09:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61009 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750714AbaHDUJG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 16:09:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 524782FA85;
	Mon,  4 Aug 2014 16:09:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vg179vBVUG6CoFYEcwYt2X3VdIY=; b=xxqUSa
	wq/Y+22aOYwXlN0rkAukaVxBuGFgYvfCr+RPvLMl+cUkeaZQhb+J/YGpXJemZCog
	E1cWE9wqj04ipTPMuDUy4QL3XBnUC17RPa2msU1NHB/xpWuDeZE9I4chnFPpRivK
	1A3xR1qOzvxle2FBKsy7QZIeFlyJCqgBS1f/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iDJmJLU7p0QLCGk6CMHEWv2s5OnahoPz
	ZZnXgKXmnByRLpLzcNzoqQ0ZzEWogprfLHuaIYrjRNM5/eu7d96d1Ke4aZxgMG+1
	3tdx4HOe1s7s3AvCAfPuQ5Pzl/GOWq+kEpKaglDAdo93h7DcziJJwBIHG4r1Goni
	3DPaKcSOlCY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4807F2FA83;
	Mon,  4 Aug 2014 16:09:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8B4282FA61;
	Mon,  4 Aug 2014 16:08:55 -0400 (EDT)
In-Reply-To: <1406968747-16100-1-git-send-email-git@cryptocrack.de> (Lukas
	Fleischer's message of "Sat, 2 Aug 2014 10:39:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2999312E-1C13-11E4-9E9A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254773>

Lukas Fleischer <git@cryptocrack.de> writes:

> In c9a42c4 (bundle: allow rev-list options to exclude annotated tags,
> 2009-01-02), we added a test to check whether annotated tags, which fall
> outside the specified date range, are excluded from bundles. However,
> when initializing the repository, a command to create a lightweight tag
> was used. Fix this by replacing `git tag` by `git tag -a`. Furthermore,
> explicitly mention in the test message that an annotated tag is created
> and also test whether tags within the specified date range are included
> properly.
>
> Note that this fix reveals that the annotated tag exclusion actually
> does not work. Therefore, the test is marked expect-failure for now.
>
> Signed-off-by: Lukas Fleischer <git@cryptocrack.de>
> ---
>  t/t5704-bundle.sh | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
> index a45c316..2f063ea 100755
> --- a/t/t5704-bundle.sh
> +++ b/t/t5704-bundle.sh
> @@ -6,7 +6,7 @@ test_description='some bundle related tests'
>  test_expect_success 'setup' '
>  	test_commit initial &&
>  	test_tick &&
> -	git tag -m tag tag &&
> +	git tag -am tag tag &&

I'd prefer to see this spelled as "-a -m tag", but anyway,
this suggests to me that a request to create a light-weight tag
should be made to error out when -m is given, or automatically
promote itself to create an annotated tag, perhaps?  That is in line
with what happens when you do "git tag -F <file> tagname".

Oh, wait.

	$ git tag -d foo
        $ git rev-parse refs/tags/foo --
        fatal: bad revision 'refs/tags/foo'
        $ git tag -m msg foo
        $ git cat-file -t refs/tags/foo
        tag
        $ git cat-file tag refs/tags/foo
        object d84843c...
        type commit
        tag foo
        tagger Junio ....

	msg
	$ git version
        git version 2.1.0-rc0-247-g66c8a75

The output from "git blame -L'/^int cmd_tag/,/^}/' builtin/tag.c"
seems to indicate that we automatically turned annotate on when a
message is given via -m or -F since the very first version of "git
tag" that was re-implemented in C, i.e. 62e09ce9 (Make git tag a
builtin., 2007-07-20).

Your analysis starts to sound fishy.  What version of Git are you
talking about?

>  	test_commit second &&
>  	test_commit third &&
>  	git tag -d initial &&
> @@ -14,7 +14,10 @@ test_expect_success 'setup' '
>  	git tag -d third
>  '
>  
> -test_expect_success 'tags can be excluded by rev-list options' '
> +test_expect_failure 'annotated tags can be excluded by rev-list options' '
> +	git bundle create bundle --all --since=7.Apr.2005.15:14:00.-0700 &&
> +	git ls-remote bundle > output &&
> +	grep tag output &&
>  	git bundle create bundle --all --since=7.Apr.2005.15:16:00.-0700 &&
>  	git ls-remote bundle > output &&
>  	! grep tag output
