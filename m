From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] get_sha1: don't die() on bogus search strings
Date: Wed, 10 Feb 2016 13:52:51 -0800
Message-ID: <xmqq1t8kz0zw.fsf@gitster.mtv.corp.google.com>
References: <20160210211206.GA5755@sigill.intra.peff.net>
	<20160210211925.GC5799@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 10 22:53:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTch9-0006FO-Ed
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 22:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbcBJVxC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 16:53:02 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51936 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751410AbcBJVw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 16:52:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 67B5E43605;
	Wed, 10 Feb 2016 16:52:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OIkA6jJpuqyqO2qdeGYSAjdFM7Y=; b=CEIk2H
	VuYyEKAj1TfPJpf6NntckZwADlTNguqrk8+J+KOTShIcz0kR9WfByHDqnP4QtGaW
	wORUHQ8+vgn56/PYd0XvWkKYmgOISi9R8+fzpo2lkmT6IBsKJNqkEvWbkaUdW1Wi
	kaFUzhAI2zJL4ZLyIN0l0xC/VFvXXvj7UGit8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N0jb1ea1KF1o3XdhUkUscrXfM/+GZQ7M
	3BXtQ92axXs1ojePyOyf2RzvrmTfxX+Pz8MRo+ftgb41TOlQrG6HzGgsFeV9ccwy
	griIoWszF9Bblq+aJNJModBfvhwsP2luDpqlDtNlLSAoVb1SSmWrjVEv8NuPqQJe
	c2ejoelM7CY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5FA0443604;
	Wed, 10 Feb 2016 16:52:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D9F8143603;
	Wed, 10 Feb 2016 16:52:52 -0500 (EST)
In-Reply-To: <20160210211925.GC5799@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 10 Feb 2016 16:19:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A298BF6C-D040-11E5-B0D7-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285935>

Jeff King <peff@peff.net> writes:

> The get_sha1() function generally returns an error code
> rather than dying, and we sometimes speculatively call it
> with something that may be a revision or a pathspec, in
> order to see which one it might be.
>
> If it sees a bogus ":/" search string, though, it complains,
> without giving the caller the opportunity to recover. We can
> demonstrate this in t6133 by looking for ":/*.t", which
> should mean "*.t at the root of the tree", but instead dies

Slight nit.  It means "'*.t at anywhere in the tree" aka "pretend as
if you gave this pathspec while at the root level of the working
tree".

> because of the invalid regex (the "*" has nothing to operate
> on).
>
> We can fix this by returning an error rather than calling
> die(). Unfortunately, the tradeoff is that the error message
> is slightly worse in cases where we _do_ know we have a rev.
> E.g., running "git log ':/*.t' --" before yielded:
>
>   fatal: Invalid search pattern: *.t
>
> and now we get only:
>
>   fatal: bad revision ':/*.t'

I do not think the latter is necessarily worse, though.  It is being
consistent with these:

    $ git log mext --			;# no such branch
    fatal: bad revision 'mext'
    $ git log ':/xxxt' --		;# no commit matches that pattern
    fatal: bad revision ':/xxxt'

so I would not even mind if somebody argued that the current
"invalid search pattern" is a bug, and gave us this patch as a fix
for the inconsistency.

> To be honest, I'm not sure this is worth it. Part of me wants to say
> that get_sha1() is simply wrong for dying. And it is, but given how
> infrequently this would come up, it's perhaps a practical tradeoff to
> get the more accurate error message.

I am on the fence, too, and part of me wants to say the same thing.
I however happen to view the "practical tradeoff" a bit differently,
so I am slightly inclined to take this.

> And while it does confuse ":/*.t", which is obviously a pathspec, that's
> just one specific case, that works because of the bogus regex. Something
> like ":/foo.*" could mean "find foo.* at the root" or it could mean
> "find a commit message with foo followed by anything", and we literally
> do not know which.
>
> We're likely to treat that one as a rev (assuming you use "foo" in your
> commit messages, but who doesn't?). So you'd need to use "--" in the
> general case anyway.

Yeah, I agree it probably would not make much practical difference.

>  sha1_name.c                  |  4 ++--
>  t/t6133-pathspec-rev-dwim.sh | 10 ++++++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 892db21..d61b3b9 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -882,12 +882,12 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
>  
>  	if (prefix[0] == '!') {
>  		if (prefix[1] != '!')
> -			die ("Invalid search pattern: %s", prefix);
> +			return -1;
>  		prefix++;
>  	}
>  
>  	if (regcomp(&regex, prefix, REG_EXTENDED))
> -		die("Invalid search pattern: %s", prefix);
> +		return -1;
>  
>  	for (l = list; l; l = l->next) {
>  		l->item->object.flags |= ONELINE_SEEN;
> diff --git a/t/t6133-pathspec-rev-dwim.sh b/t/t6133-pathspec-rev-dwim.sh
> index 8e5b338..a290ffc 100755
> --- a/t/t6133-pathspec-rev-dwim.sh
> +++ b/t/t6133-pathspec-rev-dwim.sh
> @@ -35,4 +35,14 @@ test_expect_success '@{foo} with metacharacters dwims to rev' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success ':/*.t from a subdir dwims to a pathspec' '
> +	mkdir subdir &&
> +	(
> +		cd subdir &&
> +		git log -- ":/*.t" >expect &&
> +		git log    ":/*.t" >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_done
