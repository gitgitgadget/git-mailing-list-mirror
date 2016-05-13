From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t3404 static check of bad SHA-1 failure
Date: Fri, 13 May 2016 12:52:44 -0700
Message-ID: <xmqqwpmx91mb.fsf@gitster.mtv.corp.google.com>
References: <CALR6jEiH6oxq=KXfz1pqOue9VKnkp=S8zNqC4OFmbuhRFFxoMw@mail.gmail.com>
	<20160513182325.GB30700@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 13 21:52:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1J8m-0004UX-Er
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 21:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbcEMTws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 15:52:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63984 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932211AbcEMTws (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 15:52:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 11A231784F;
	Fri, 13 May 2016 15:52:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5zUqsQUw3/a24Ox85rjmxzsCmas=; b=HeUG5S
	2KQyqej7/fVv4gQIYoPXeZdA4EfnTQnmU4FFGhuOAxfvvvnj60q7LdZY1ncc767j
	RBD9ovq6XbZTozjQZS+nwsC6C15xyBmqMf2vkZMFNwxUa5TqbwClcy8Cqc+z6to+
	WuQv+rFZnk3QfQwzHQoTSNezhpo06kSTbnieA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=usQpm6MP2b126et1mN1Ei4oeHBMBaUGH
	sODynw85D6wjjXCLeTmoi+0Yl6wUxK+YYBAk3Tenkc9p2z8+33dsr5ozCzclc9BR
	BE5OjyLcU/sOFIZU+yfjwor75mrovJgvAvXl62CLqA81PiIu5EESWt620i4lbIhm
	A7VDLTONpm0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 09A5A1784E;
	Fri, 13 May 2016 15:52:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 82A961784D;
	Fri, 13 May 2016 15:52:46 -0400 (EDT)
In-Reply-To: <20160513182325.GB30700@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 13 May 2016 14:23:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 43B04B6C-1944-11E6-961A-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294566>

Jeff King <peff@peff.net> writes:

> On Fri, May 13, 2016 at 06:09:35PM +0200, Armin Kunaschik wrote:
>
>> in t3404 test 91 - static check of bad SHA-1 fails (with ksh) with a
>> syntax error in git-rebase.
>> git-rebase[6]: test: argument expected
>
> Here's a fix that covers these and another I found:
>
> -- >8 --
> Subject: [PATCH] always quote arguments to "test -z" in shell
>
> Modern shells are pretty forgiving about us doing:
>
>   test -z $foo
>
> If $foo is indeed empty, the test command will see only:
>
>   test -z
>
> and treat the missing argument as "yes, this is empty". But
> some older shells, reportedly ksh88, complain about the
> missing argument. We can be more portable by spelling this
> as:
>
>   test -z "$foo"
>
> so that "test" sees an empty argument, not a missing one.
>
> This covers all cases detected by:
>
>   git grep 'test -z [^"]'
>
> (though note that has a few false positives for tests which
> need an extra layer of quoting to do '\"').
>
> Reported-by: Armin Kunaschik <megabreit@googlemail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Actually, this misses the case in t4151 which already has a fix queued
> on pu. Arguably these should all just be squashed together (and I am
> happy, Junio, if you want to do so and leave Armin as the author of the
> new commit).

I _think_ "test -z" should succeed according to POSIX, because

 (1) it is not "test -z string" because it lacks string,

 (2) it is not any of the other "test -<option> thing" because -z,
    and

 (3) the only thing it matches in the supported form of "test" is
     "test <string>" that tests if the <string> is not the null
     string, and "-z" indeed is not the null string.

For the same reason, "test -n" succeeds.

But working around older/broken shells is easy and the resulting
script it more readable, so let's take this.  It makes the resulting
code easier to understand even when we know we run it under POSIX
shell.

Thanks.

>  git-rebase--interactive.sh | 4 ++--
>  git-stash.sh               | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 9ea3075..470413b 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -866,12 +866,12 @@ add_exec_commands () {
>  # $3: the input filename
>  check_commit_sha () {
>  	badsha=0
> -	if test -z $1
> +	if test -z "$1"
>  	then
>  		badsha=1
>  	else
>  		sha1_verif="$(git rev-parse --verify --quiet $1^{commit})"
> -		if test -z $sha1_verif
> +		if test -z "$sha1_verif"
>  		then
>  			badsha=1
>  		fi
> diff --git a/git-stash.sh b/git-stash.sh
> index c7c65e2..57f9dc1 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -185,7 +185,7 @@ store_stash () {
>  
>  	git update-ref --create-reflog -m "$stash_msg" $ref_stash $w_commit
>  	ret=$?
> -	test $ret != 0 && test -z $quiet &&
> +	test $ret != 0 && test -z "$quiet" &&
>  	die "$(eval_gettext "Cannot update \$ref_stash with \$w_commit")"
>  	return $ret
>  }
