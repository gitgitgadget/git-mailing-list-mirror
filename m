From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Accept tags in HEAD or MERGE_HEAD
Date: Thu, 18 Aug 2011 11:54:43 -0700
Message-ID: <7vd3g2a431.fsf@alter.siamese.dyndns.org>
References: <1313545369-7096-1-git-send-email-pclouds@gmail.com>
 <1313674994-22902-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 21:54:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu8fE-00025K-T5
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 21:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630Ab1HRTx7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 15:53:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43865 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752333Ab1HRTx4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2011 15:53:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F2A04B67;
	Thu, 18 Aug 2011 15:53:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=A8cLzC4omtx31CE0wyoWzyePZ
	O0=; b=qHb35yDJJyhsE7JZFbgfUd5jWWbw+e/UiL6mOPMsIqUYpgqGhblXsMjre
	zl0eeK2I2Z6mBKQlZMOfdoK09mxtK7HwQ72jnQEf31BOb4ni1E/9V4pdfHwRxB79
	1IFpDdXiqrSg51oh0bmyNn5J0+SFDxJh/tFj6s1oWueqoMytI8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=uz44Ah7RDknH4PFV0MJ
	hoOsVafRLV1qPebsWceUQWxxL8Dqxm9FSg7FBKcuQLuMx1FAPByVMf7dXL6RAIqE
	3XlP1+2NsMl4UI6J4hEvZRh0dtOL3GiDQqYsOLsVc+rbVppNeTHzk/Rn2P4xOCtU
	wSYHYJmRbqNFEgxBDppfwxuA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 364F34B66;
	Thu, 18 Aug 2011 15:53:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C4FB4B65; Thu, 18 Aug 2011
 15:53:55 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CE14E2F6-C9D3-11E0-A2B7-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179620>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> HEAD and MERGE_HEAD (among other branch tips) should never hold a
> tag. That can only be caused by broken tools and is cumbersome to fix
> by an end user with:
>
>   $ git update-ref HEAD $(git rev-parse HEAD^{commit})
>
> which may look like a magic to a new person.
>
> Be easy, warn users (so broken tools can be fixed) and move on.

We do not really fix broken tools; we just fix breakages caused by them=
=2E

> Be robust, if the given SHA-1 cannot be resolved to a commit object,
> die (therefore return value is always valid).

Makes sense.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index cb73857..f78b449 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -63,6 +63,7 @@ N_("The previous cherry-pick is now empty, possibly=
 due to conflict resolution.\
>  "Otherwise, please use 'git reset'\n");
> =20
>  static unsigned char head_sha1[20];
> +static struct commit *head_commit;

I was not happy with the file-scope global head_sha1[] already, and thi=
s
makes me even less happy. Was it too much trouble to keep them local to
cmd_commit() and pass them around as arguments where necessary?  If you
pass around head_commit, is_null_sha1(head_sha1) can be replaced with a
check !head_commit so we may even be able to lose the head_sha1[] globa=
l.

And actually removing head_sha1[] is a necessary step from the correctn=
ess
point of view. The repository may have given an object name for a tag i=
n
head_sha1[] and lookup_expect_commit() may have peeled it to a commit.
The code may want to add the "HEAD" as one of the parents of a new comm=
it,
and head_sha1[] is no longer the place to pick that information up afte=
r
your fix. The code needs to look at head_commit->object.sha1[] instead.
Losing the use of head_sha1[] variable and forcing the code to go to
head_commit->object.sha1[] reduces the risk of such confusion.

> @@ -1028,6 +1026,9 @@ static int parse_and_validate_options(int argc,=
 const char *argv[],
> =20
>  	if (get_sha1("HEAD", head_sha1))
>  		initial_commit =3D 1;
> +	else
> +		head_commit =3D lookup_expect_commit(head_sha1, "HEAD");

It may be just me, but the name feels a bit funny. The original name wa=
s
"look up" (verb) + "commit" (direct object of the verb), and what you a=
re
doing is lookup_and_expect_commit(), but it is too long.

Perhaps lookup_commit_or_die()?

To a na=C3=AFve reader of the caller, the function looks as if it would=
 do

	struct commit *lookup_expect_commit(unsigned char *head_sha1, char *na=
me)
        {
        	struct commit *c;
		if (get_sha1("HEAD", head_sha1) ||
	            !(c =3D lookup_commit(head_sha1))) die(...);
		return c;
	}

but in fact it does not use "HEAD" for anything other than error report=
ing
and it is the caller's responsibility to supply head_sha1[].

It is documented in the function declaration by making the memory
head_sha1 points at as a "const" (i.e. the function can't be calling
get_sha() on the refname), but it may also need a comment or two there.

> diff --git a/builtin/merge.c b/builtin/merge.c
> index 325891e..22e98e8 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -51,6 +51,7 @@ static int allow_trivial =3D 1, have_message;
>  static struct strbuf merge_msg;
>  static struct commit_list *remoteheads;
>  static unsigned char head[20], stash[20];
> +static struct commit* head_commit;

This is C, not C++; asterisk sticks to the variable, not type.

> @@ -1030,6 +1031,8 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
>  		branch +=3D 11;
>  	if (is_null_sha1(head))
>  		head_invalid =3D 1;
> +	else
> +		head_commit =3D lookup_expect_commit(head, "HEAD");
> =20
>  	git_config(git_merge_config, NULL);
> =20

The same comment as head[] vs head_commit->object.sha1[] redundancy
applies from builtin/commit.c here.

Overall, the changes to buitlin/merge.c look very nice, getting rid of =
the
repeated lookup_commit(head). In a separate patch after this fix gets
ready, we may want to further clean it up so that head_commit being NUL=
L
means head_invalid, losing a redundant variable.
