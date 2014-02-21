From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] demonstrate git-commit --dry-run exit code behaviour
Date: Fri, 21 Feb 2014 12:21:13 -0800
Message-ID: <xmqqa9dk43pi.fsf@gitster.dls.corp.google.com>
References: <1393010214-32306-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 21 21:21:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGwb5-0005bU-SB
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 21:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbaBUUVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 15:21:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60371 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752769AbaBUUVS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 15:21:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AEB76C071;
	Fri, 21 Feb 2014 15:21:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KCEo/TZb5Ekc0wKdVgjziK3HYFE=; b=NYBPQu
	4evT+lCFBhMFllM68vjA2w5Oa2osK6ZG/LH0Fpa4MqETWacGoOv7NWadN3VOwQRY
	CxWCWt/oyZNoIMJWOPnQIVUUZBmjjDe6a0X/yHCWXBEWLgb0DdMhfmkUzBo7i5Z/
	awKAayDX89ikGRhuIo0w1VO4Su8udk8WmzOb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cMWHQHlbawoCgda81r37TrEYsNTWGEuL
	jy076nGwtLTAfcVs79FV2XJCy1gxU2ayCUhofwDtfMnVZsD6v5dsAujGHcYlqZuV
	D0JPp8mysk3b2NiHG+FZzS0su1N/uuXTs1IiAmYthRQQETLbm+Q4XukPIcGrk21i
	TR9XtMYKNg8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AD626C070;
	Fri, 21 Feb 2014 15:21:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F1946C06E;
	Fri, 21 Feb 2014 15:21:15 -0500 (EST)
In-Reply-To: <1393010214-32306-1-git-send-email-rctay89@gmail.com> (Tay Ray
	Chuan's message of "Sat, 22 Feb 2014 03:16:54 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B6F90404-9B35-11E3-B66E-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242492>

Tay Ray Chuan <rctay89@gmail.com> writes:

> In particular, show that --short and --porcelain, while implying
> --dry-run, do not return the same exit code as --dry-run. This is due to
> the wt_status.commitable flag being set only when a long status is
> requested.

I am not sure if --short/--porcelain should even be accepted by "git
commit" in the first place.  It used to be that "git status" and
"git commit" were the same program in a different guise and "git
status <anything>" were merely a "git commit --dry-run <anything>",
but the recent push is in the direction of making them totally
separate in the end-user's minds.  So if we want a proper fix, I
would actually think that these options should *error out* at the
command line parser level, way before checking if there is anything
to commit.

> No fix is provided here; with [1], it should be trivial to fix though -
> just a matter of calling wt_status_mark_commitable().
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/242489
>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
>  t/t7501-commit.sh | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
> index 94eec83..d58b097 100755
> --- a/t/t7501-commit.sh
> +++ b/t/t7501-commit.sh
> @@ -61,11 +61,47 @@ test_expect_success 'nothing to commit' '
>  	test_must_fail git commit -m initial
>  '
>  
> +test_expect_success '--dry-run fails with nothing to commit' '
> +	test_must_fail git commit -m initial --dry-run
> +'
> +
> +test_expect_success '--short fails with nothing to commit' '
> +	test_must_fail git commit -m initial --short
> +'
> +
> +test_expect_success '--porcelain fails with nothing to commit' '
> +	test_must_fail git commit -m initial --porcelain
> +'
> +
> +test_expect_success '--long fails with nothing to commit' '
> +	test_must_fail git commit -m initial --long
> +'
> +
>  test_expect_success 'setup: non-initial commit' '
>  	echo bongo bongo bongo >file &&
>  	git commit -m next -a
>  '
>  
> +test_expect_success '--dry-run with stuff to commit returns ok' '
> +	echo bongo bongo bongo >>file &&
> +	git commit -m next -a --dry-run
> +'
> +
> +test_expect_failure '--short with stuff to commit returns ok' '
> +	echo bongo bongo bongo >>file &&
> +	git commit -m next -a --short
> +'
> +
> +test_expect_failure '--porcelain with stuff to commit returns ok' '
> +	echo bongo bongo bongo >>file &&
> +	git commit -m next -a --porcelain
> +'
> +
> +test_expect_success '--long with stuff to commit returns ok' '
> +	echo bongo bongo bongo >>file &&
> +	git commit -m next -a --long
> +'
> +
>  test_expect_success 'commit message from non-existing file' '
>  	echo more bongo: bongo bongo bongo bongo >file &&
>  	test_must_fail git commit -F gah -a
