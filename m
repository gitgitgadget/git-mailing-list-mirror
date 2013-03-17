From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Sun, 17 Mar 2013 16:35:59 -0700
Message-ID: <7vd2uxppk0.fsf@alter.siamese.dyndns.org>
References: <20130317235040.4cdc9ef2@hoelz.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, josh@joshtriplett.org
To: Rob Hoelz <rob@hoelz.ro>
X-From: git-owner@vger.kernel.org Mon Mar 18 00:36:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHN7y-0001fx-34
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 00:36:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756673Ab3CQXgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 19:36:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44603 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755851Ab3CQXgF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 19:36:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 658B1C337;
	Sun, 17 Mar 2013 19:36:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A35RUns94iFTz02iKt9X3UKAVsU=; b=SF3Eei
	fz1ZPtlxv/piFS4JvO8fOhwlPswqpowqnAJh3lHcYDwR32kEQ3ROc/zo0U2GlnvQ
	ZowIG2ot+7fb98hz/FUf/AtjMZ4IOyjpoDYls9Olq0OdCvNXvNYB7w39t+Jqt4Pg
	wnb8dCjfo73CXuWNOzA81QVItleGa35SeAx80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E1OxI2oURNUZDLtqC+kgHl7rV8UGrOkI
	Cnd2zEG+5lvbgLUlzbow0GyKzY+7z9BJGIQiOUbjtyyAdNXJzHYWbyvgVsYMhRy2
	uPMQdhDb9dpdB1MvMRrYZmfAnWsgzDJLfE8+i16BCfBfp533NwNOEZEeu8Wk/AzY
	r/czglGACso=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D78DC335;
	Sun, 17 Mar 2013 19:36:03 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55A6BC331; Sun, 17 Mar 2013
 19:36:01 -0400 (EDT)
In-Reply-To: <20130317235040.4cdc9ef2@hoelz.ro> (Rob Hoelz's message of "Sun,
 17 Mar 2013 23:50:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6DED31D6-8F5B-11E2-B04D-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218384>

Rob Hoelz <rob@hoelz.ro> writes:

> git push currently doesn't consider pushInsteadOf when
> using pushurl; this tests and fixes that.
>
> If you use pushurl with an alias that has a pushInsteadOf configuration
> value, Git does not take advantage of it.  For example:
>
> [url "git://github.com/"]
>     insteadOf = github:
> [url "git://github.com/myuser/"]
>     insteadOf = mygithub:
> [url "git@github.com:myuser/"]
>     pushInsteadOf = mygithub:
> [remote "origin"]
>     url     = github:organization/project
>     pushurl = mygithub:project

Incomplete sentence?  For example [this is an example configuration]
and then what happens?  Something like "with the sample
configuration, 'git push origin' should follow pushurl and then turn
it into X, but instead it ends up accessing Y".

If there is no pushInsteadOf, does it still follow insteadOf?  Is it
tested already?

Wouldn't you want to cover all the combinations to negative cases
(i.e. making sure the codepath to support a new case does not affect
behaviour of the code outside the new case)?  A remote with and
without pushurl (two combinations) and a pseudo URL scheme with and
without pushInsteadOf (again, two combinations) will give you four
cases.


Thanks.

>
> Signed-off-by: Rob Hoelz <rob@hoelz.ro>
> ---
>  remote.c              |  2 +-
>  t/t5516-fetch-push.sh | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/remote.c b/remote.c
> index ca1f8f2..de7a915 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -465,7 +465,7 @@ static void alias_all_urls(void)
>  		if (!remotes[i])
>  			continue;
>  		for (j = 0; j < remotes[i]->pushurl_nr; j++) {
> -			remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j], &rewrites);
> +			remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j], &rewrites_push);
>  		}
>  		add_pushurl_aliases = remotes[i]->pushurl_nr == 0;
>  		for (j = 0; j < remotes[i]->url_nr; j++) {
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index b5417cc..272e225 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -244,6 +244,26 @@ test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf
>  	)
>  '
>  
> +test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf does rewrite in this case)' '
> +	mk_empty &&
> +	TRASH="$(pwd)/" &&
> +	mkdir ro &&
> +	mkdir rw &&
> +	git init --bare rw/testrepo &&
> +	git config "url.file://$TRASH/ro/.insteadOf" ro: &&
> +	git config "url.file://$TRASH/rw/.pushInsteadOf" rw: &&
> +	git config remote.r.url ro:wrong &&
> +	git config remote.r.pushurl rw:testrepo &&
> +	git push r refs/heads/master:refs/remotes/origin/master &&
> +	(
> +		cd rw/testrepo &&
> +		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
> +		test "z$r" = "z$the_commit" &&
> +
> +		test 1 = $(git for-each-ref refs/remotes/origin | wc -l)
> +	)
> +'
> +
>  test_expect_success 'push with matching heads' '
>  
>  	mk_test heads/master &&
