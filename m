From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revert.c: defer writing CHERRY_PICK_HEAD till it is safe
 to do so
Date: Thu, 06 Oct 2011 10:02:09 -0700
Message-ID: <7vty7m12b2.fsf@alter.siamese.dyndns.org>
References: <1317911641-47660-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, nicolas.dichtel@6wind.com,
	Jeff King <peff@peff.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 19:02:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBrKt-00043w-Qy
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 19:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166Ab1JFRCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 13:02:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51765 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965161Ab1JFRCO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 13:02:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28F2E5D7F;
	Thu,  6 Oct 2011 13:02:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j3vprXElbvhFrOOFk8VFDzTd4kE=; b=X4UsDm
	F5iD60anicnVzjEuXHKlJbPNgWDZdDsnGpBIseMxFUajcIaKt92niG+gnURYlXnT
	9OY1wd4Iucl5cUgz90Ks++gyXxhscKgzSV9ZZlxY1uN9od+37cJjjy7aq1qwMNoM
	gE5KCh31g2gGssgZzKw0kWkyiR5uNj+54Cg3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PRcssISD5teHdMHcQj4oqRpk8mcU51Ms
	Oc5ql6z0lnk2j4WS1Uv6qDkZkBUWPIjy+laRQpqdk9ChKyXmBm34uNZqY+j/RLhF
	BBitVaAWHFRxShJBQ2fGa7meSId20R4U5BMKZtfsXuVnJ9jj2+Va3fu4+Ys3ATSI
	HrQQfuRzyCM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E65F5D7B;
	Thu,  6 Oct 2011 13:02:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D12B5D73; Thu,  6 Oct 2011
 13:02:10 -0400 (EDT)
In-Reply-To: <1317911641-47660-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Thu, 6 Oct 2011 10:34:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EE253D36-F03C-11E0-B209-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182983>

Jay Soffian <jaysoffian@gmail.com> writes:

> do_pick_commit() writes out CHERRY_PICK_HEAD before invoking merge (either
> via do_recursive_merge() or try_merge_command()) on the assumption that if
> the merge fails it is due to conflict. However, if the tree is dirty, the
> merge may not even start, aborting before do_pick_commit() can remove
> CHERRY_PICK_HEAD.
>
> Instead, defer writing CHERRY_PICK_HEAD till after merge has returned.
> At this point we know the merge has either succeeded or failed due
> to conflict. In either case, we want CHERRY_PICK_HEAD to be written
> so that it may be picked up by the subsequent invocation of commit.

I think do_recursive_merge() would die() when the merge cannot even start
(i.e. the local changes after the cherry-pick exits are the ones from the
time before such a failed cherry-pick started), but I suspect that the
other codepath uses try_merge_command() to drive strategies other than
recursive and it does not die() there in such a case. Can you make sure
this patch is sufficient in such a case as well?

Other than that I think this is better than the previous rounds.

Thanks.

> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
>  builtin/revert.c                |    6 +++++-
>  t/t3507-cherry-pick-conflict.sh |    7 +++++++
>  2 files changed, 12 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 3117776c2c..48526e1ef1 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -384,6 +384,7 @@ static int do_pick_commit(void)
>  	char *defmsg = NULL;
>  	struct strbuf msgbuf = STRBUF_INIT;
>  	int res;
> +	int record_cherry_pick_head = 0;
>  
>  	if (no_commit) {
>  		/*
> @@ -477,7 +478,7 @@ static int do_pick_commit(void)
>  			strbuf_addstr(&msgbuf, ")\n");
>  		}
>  		if (!no_commit)
> -			write_cherry_pick_head();
> +			record_cherry_pick_head = 1;
>  	}
>  
>  	if (!strategy || !strcmp(strategy, "recursive") || action == REVERT) {
> @@ -498,6 +499,9 @@ static int do_pick_commit(void)
>  		free_commit_list(remotes);
>  	}
>  
> +	if (record_cherry_pick_head)
> +		write_cherry_pick_head();
> +
>  	if (res) {
>  		error(action == REVERT
>  		      ? _("could not revert %s... %s")
> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
> index 212ec54aaf..29890bf5ac 100755
> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -77,6 +77,13 @@ test_expect_success 'cherry-pick --no-commit does not set CHERRY_PICK_HEAD' '
>  	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
>  '
>  
> +test_expect_success 'cherry-pick w/dirty tree does not set CHERRY_PICK_HEAD' '
> +	pristine_detach initial &&
> +	echo foo > foo &&
> +	test_must_fail git cherry-pick base &&
> +	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
> +'
> +
>  test_expect_success 'GIT_CHERRY_PICK_HELP suppresses CHERRY_PICK_HEAD' '
>  	pristine_detach initial &&
>  	(
