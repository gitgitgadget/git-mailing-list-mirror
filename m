From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote: handle pushremote config in any order order
Date: Mon, 24 Feb 2014 09:55:12 -0800
Message-ID: <xmqqvbw49z0f.fsf@gitster.dls.corp.google.com>
References: <CAMYxyaUwPXXdvGv786_p5n7-biMLOFbur-gQ1pxXOttc0R0=eg@mail.gmail.com>
	<20140224085903.GA10698@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jack Nagel <jacknagel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 24 18:55:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHzkc-0003FS-5U
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 18:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbaBXRzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 12:55:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35674 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753241AbaBXRzR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 12:55:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 989DF6BC16;
	Mon, 24 Feb 2014 12:55:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3e/GmWCWOssCvtQ3qcBd3uTy2HU=; b=HUa0Q9
	xS+JrKwYyBoQHGrVl/B28sWKbppKc2hm3vfmVrH612CyoEug65L49RCgmji/2Ssy
	zbylsqKl/yLWFVmKG5j+KmIAnYtkIdgvn80Q3C93V19RRV3aq99o/mLBGZQyf0EW
	2MenFmmfBn7JCQrYbrg/Y+4V2Vhrnr6qWG2Io=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pRxwZfo1wjkA0pc8WoPdTuhhvAdLmIcQ
	JggqqnxPSDVhgxy1dnTAi22WhCL7SPE9BpdXZnujtP1BvPjhROPYzuOYpXAcRDeY
	RYqiOdQwKp3VN/V3bMrHcvCaY3cfnDQ9SNm7Jj1S3xgfKr3I9NKYSqVD41SCnrtK
	0iStGxmQBCs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 820CF6BC15;
	Mon, 24 Feb 2014 12:55:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82ACC6BC14;
	Mon, 24 Feb 2014 12:55:14 -0500 (EST)
In-Reply-To: <20140224085903.GA10698@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 24 Feb 2014 03:59:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D02E4F62-9D7C-11E3-843A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242621>

Jeff King <peff@peff.net> writes:

> Yes, with a few exceptions, we usually try to make the ordering in the
> config file irrelevant. This is a bug. The patch below should fix it.

Looks good.  Thanks.

> -- >8 --
> Subject: remote: handle pushremote config in any order
>
> The remote we push can be defined either by
> remote.pushdefault or by branch.*.pushremote for the current
> branch. The order in which they appear in the config file
> should not matter to precedence (which should be to prefer
> the branch-specific config).
>
> The current code parses the config linearly and uses a
> single string to store both values, overwriting any
> previous value. Thus, config like:
>
>   [branch "master"]
>   pushremote = foo
>   [remote]
>   pushdefault = bar
>
> erroneously ends up pushing to "bar" from the master branch.
>
> We can fix this by storing both values and resolving the
> correct value after all config is read.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  remote.c              |  7 ++++++-
>  t/t5516-fetch-push.sh | 12 ++++++++++++
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/remote.c b/remote.c
> index e41251e..7232a33 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -49,6 +49,7 @@ static int branches_nr;
>  
>  static struct branch *current_branch;
>  static const char *default_remote_name;
> +static const char *branch_pushremote_name;
>  static const char *pushremote_name;
>  static int explicit_default_remote_name;
>  
> @@ -352,7 +353,7 @@ static int handle_config(const char *key, const char *value, void *cb)
>  			}
>  		} else if (!strcmp(subkey, ".pushremote")) {
>  			if (branch == current_branch)
> -				if (git_config_string(&pushremote_name, key, value))
> +				if (git_config_string(&branch_pushremote_name, key, value))
>  					return -1;
>  		} else if (!strcmp(subkey, ".merge")) {
>  			if (!value)
> @@ -492,6 +493,10 @@ static void read_config(void)
>  			make_branch(head_ref + strlen("refs/heads/"), 0);
>  	}
>  	git_config(handle_config, NULL);
> +	if (branch_pushremote_name) {
> +		free(pushremote_name);
> +		pushremote_name = branch_pushremote_name;
> +	}
>  	alias_all_urls();
>  }
>  
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 926e7f6..1309c4d 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -536,6 +536,18 @@ test_expect_success 'push with config branch.*.pushremote' '
>  	check_push_result down_repo $the_commit heads/master
>  '
>  
> +test_expect_success 'branch.*.pushremote config order is irrelevant' '
> +	mk_test one_repo heads/master &&
> +	mk_test two_repo heads/master &&
> +	test_config remote.one.url one_repo &&
> +	test_config remote.two.url two_repo &&
> +	test_config branch.master.pushremote two_repo &&
> +	test_config remote.pushdefault one_repo &&
> +	git push &&
> +	check_push_result one_repo $the_first_commit heads/master &&
> +	check_push_result two_repo $the_commit heads/master
> +'
> +
>  test_expect_success 'push with dry-run' '
>  
>  	mk_test testrepo heads/master &&
