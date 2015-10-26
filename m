From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use pop_commit() for consuming the first entry of a struct commit_list
Date: Mon, 26 Oct 2015 14:33:49 -0700
Message-ID: <xmqqfv0xfh6q.fsf@gitster.mtv.corp.google.com>
References: <562BB00B.1000704@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 26 22:34:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqpOx-0003tk-Le
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 22:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbbJZVdz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Oct 2015 17:33:55 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58562 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751824AbbJZVdw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2015 17:33:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9EFCA26CC0;
	Mon, 26 Oct 2015 17:33:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=M8tGOYi+DrVu
	pB1LOIcfzS+9QEY=; b=adCWgsA+KNxxCTX5lP17e/O0XyQP+DFuBHhETWMtCXg/
	bZ+Iu7Z1wp415qUtDXsHiItrMrx3E8FtW4Do7fdRgbP8AvUjUbhxdkpyEFP6BB3z
	P/Ec0CqWxM0wWnVzVf5hg0sKjLR66kt0rqNmfr1ppRoVzlSauGgRBYwzNVnXDvM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FYuJRI
	2a6knDg7mNtQbDQ4cNxFFYB0OMyg+rbwpldyZQ02Kie2WtIHXY5qOapUp1Ve6lxf
	XRaVbk2LbnEZIXEuXclLMiMPamc+3Ugx2Frxp/VKiSLLCr96XTb8P6xjVfcpvqM8
	cq8ZI+VPZ83fVX46odP3AFDuKka54QFKqXFO4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 96F6926CBF;
	Mon, 26 Oct 2015 17:33:51 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F335926CBE;
	Mon, 26 Oct 2015 17:33:50 -0400 (EDT)
In-Reply-To: <562BB00B.1000704@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Sat, 24
	Oct 2015 18:21:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3FC61800-7C29-11E5-9065-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280225>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Instead of open-coding the function pop_commit() just call it.  This
> makes the intent clearer and reduces code size.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  builtin/fmt-merge-msg.c |  9 +++------
>  builtin/merge.c         | 12 +++++-------
>  builtin/reflog.c        |  6 +-----
>  builtin/rev-parse.c     |  7 ++-----
>  builtin/show-branch.c   | 17 +++--------------
>  commit.c                | 27 +++++++--------------------
>  remote.c                |  6 ++----
>  revision.c              | 27 +++++----------------------
>  shallow.c               |  6 +-----
>  upload-pack.c           |  6 ++----
>  10 files changed, 31 insertions(+), 92 deletions(-)

While I appreciate this kind of simplification very much, I also
hate to review this kind of simplification at the same time, as it
is very easy to make and miss simple mistakes.

Let me try to go through it very carefully.

> diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
> index 4ba7f28..846004b 100644
> --- a/builtin/fmt-merge-msg.c
> +++ b/builtin/fmt-merge-msg.c
> @@ -537,7 +537,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out=
)
>  static void find_merge_parents(struct merge_parents *result,
>  			       struct strbuf *in, unsigned char *head)
>  {
> -	struct commit_list *parents, *next;
> +	struct commit_list *parents;
>  	struct commit *head_commit;
>  	int pos =3D 0, i, j;
> =20
> @@ -576,13 +576,10 @@ static void find_merge_parents(struct merge_par=
ents *result,
>  	parents =3D reduce_heads(parents);
> =20
>  	while (parents) {
> +		struct commit *cmit =3D pop_commit(&parents);
>  		for (i =3D 0; i < result->nr; i++)
> -			if (!hashcmp(result->item[i].commit,
> -				     parents->item->object.sha1))
> +			if (!hashcmp(result->item[i].commit, cmit->object.sha1))
>  				result->item[i].used =3D 1;
> -		next =3D parents->next;
> -		free(parents);
> -		parents =3D next;

OK, I would have called it "commit" not "cmit", but this is
trivially equivalent to the original.

> diff --git a/builtin/merge.c b/builtin/merge.c
> index a0a9328..31241b8 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1019,7 +1019,7 @@ static struct commit_list *reduce_parents(struc=
t commit *head_commit,
>  					  int *head_subsumed,
>  					  struct commit_list *remoteheads)
>  {
> -	struct commit_list *parents, *next, **remotes =3D &remoteheads;
> +	struct commit_list *parents, **remotes;

Interesting.  I viewed the result of applying this patch with "git
show -U32" to make sure that this initialization of remotes was
unnecessary.

> @@ -1033,16 +1033,14 @@ static struct commit_list *reduce_parents(str=
uct commit *head_commit,
>  	/* Find what parents to record by checking independent ones. */
>  	parents =3D reduce_heads(remoteheads);
> =20
> -	for (remoteheads =3D NULL, remotes =3D &remoteheads;
> -	     parents;
> -	     parents =3D next) {
> -		struct commit *commit =3D parents->item;
> -		next =3D parents->next;
> +	remoteheads =3D NULL;
> +	remotes =3D &remoteheads;
> +	while (parents) {
> +		struct commit *commit =3D pop_commit(&parents);
>  		if (commit =3D=3D head_commit)
>  			*head_subsumed =3D 0;
>  		else
>  			remotes =3D &commit_list_insert(commit, remotes)->next;
> -		free(parents);
>  	}
>  	return remoteheads;
>  }

Trivially equivalent.  Good.  I'll stop saying this if there is
nothing noteworthy from now on.

> diff --git a/builtin/show-branch.c b/builtin/show-branch.c
> index 092b59b..ac5141d 100644
> --- a/builtin/show-branch.c
> +++ b/builtin/show-branch.c
> @@ -53,17 +53,6 @@ static struct commit *interesting(struct commit_li=
st *list)
>  	return NULL;
>  }
> =20
> -static struct commit *pop_one_commit(struct commit_list **list_p)
> -{
> -	struct commit *commit;
> -	struct commit_list *list;
> -	list =3D *list_p;
> -	commit =3D list->item;
> -	*list_p =3D list->next;
> -	free(list);
> -	return commit;
> -}
> -

Interesting.  We had our own implementation that is less lenient
than the global one.  And this one is newer by two months!  Good
riddance.

> @@ -2733,10 +2726,7 @@ static void simplify_merges(struct rev_info *r=
evs)
>  		yet_to_do =3D NULL;
>  		tail =3D &yet_to_do;
>  		while (list) {
> -			commit =3D list->item;
> -			next =3D list->next;
> -			free(list);
> -			list =3D next;
> +			commit =3D pop_commit(&list);
>  			tail =3D simplify_one(revs, commit, tail);
>  		}
>  	}

Any conversion in this set that does not eliminate the intermediate
variable "next" (or named similarly but differently in some
contexts) is suspect, but this is correct.  The variable is used in
an earlier loop to walk a list in an non-destructive way (strictly
speaking, I do not think that loop needs 'next' variable, though).

> diff --git a/shallow.c b/shallow.c
> index d49a3d6..4dcb454 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -401,13 +401,9 @@ static void paint_down(struct paint_info *info, =
const unsigned char *sha1,
>  	commit_list_insert(c, &head);
>  	while (head) {
>  		struct commit_list *p;
> -		struct commit *c =3D head->item;
> +		struct commit *c =3D pop_commit(&head);
>  		uint32_t **refs =3D ref_bitmap_at(&info->ref_bitmap, c);
> =20
> -		p =3D head;
> -		head =3D head->next;
> -		free(p);
> -
>  		/* XXX check "UNINTERESTING" from pack bitmaps if available */
>  		if (c->object.flags & (SEEN | UNINTERESTING))
>  			continue;

Again, 'p' is used in another loop in the same scope, and the
conversion is correct.

> diff --git a/upload-pack.c b/upload-pack.c
> index 89e832b..d0bc3ca 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -316,10 +316,8 @@ static int reachable(struct commit *want)
> =20
>  	commit_list_insert_by_date(want, &work);
>  	while (work) {
> -		struct commit_list *list =3D work->next;
> -		struct commit *commit =3D work->item;
> -		free(work);
> -		work =3D list;
> +		struct commit_list *list;
> +		struct commit *commit =3D pop_commit(&work);
> =20
>  		if (commit->object.flags & THEY_HAVE) {
>  			want->object.flags |=3D COMMON_KNOWN;

Likewise, "list" is used in the same scope for different purposes,
and the conversion is correct.

Thanks, will apply.
