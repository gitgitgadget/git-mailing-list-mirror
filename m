From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Cache stat_tracking_info() for faster status and branch
 -v
Date: Fri, 19 Oct 2012 12:50:24 -0700
Message-ID: <7v7gqmjl6n.fsf@alter.siamese.dyndns.org>
References: <1350408967-13919-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 21:50:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPIaf-0002ZA-Na
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 21:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758346Ab2JSTua convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Oct 2012 15:50:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37768 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758161Ab2JSTu3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Oct 2012 15:50:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BA8A9FD4;
	Fri, 19 Oct 2012 15:50:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yI29DlMWs82Y
	H2a41g/e/ZQ86QE=; b=yb2rPuj/9mgNhiE+icesEs8bp4JJG1DPchPmOq5vj34R
	Oy8hs8jlnvbzWllVGiKYODODB2MfaG8RVZIO7edThOMLR+pUSNY1EJ9bVfhMsH9k
	Bvx5LpR4NbW2tddY6xTQbIUUJ8aCcRkKbnNzFP8btUrxI8F1cQ8GeNOKg1QX4bo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JEjeZ3
	6i7/Gb24bOMaLt+4DTEKYcxf9SWQTb4dkRdN28ceSUfWuElfy6qZYat5K2CeU158
	zj091tRwQp+LFvIVRL/fwKFLhj09m2NxCS1xaBsGar3sg97DbSWOZn0VQGsPd+Oc
	PZM0K9yMCI5S22+m1efx/PTpwky4TjROzuLaQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2876E9FD3;
	Fri, 19 Oct 2012 15:50:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A44E9FCF; Fri, 19 Oct 2012
 15:50:26 -0400 (EDT)
In-Reply-To: <1350408967-13919-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 17 Oct
 2012 00:36:07 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A578088-1A26-11E2-A114-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208055>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> stat_tracking_info() is used to calculated how many commits ahead or
> behind for a branch. Rev walking can be slow especially when the
> branch is way behind its remote end. By caching the results, we won't
> have to rev walk every time we need these information.
> stat_tracking_info() cost can be greatly reduced this way.
>
> This makes sure "git status" instant no matter how far behind HEAD
> is, except the first time after HEAD changes. This also makes
> "branch -v" usable (for me) as it's now also instant versus 3.5
> seconds in non-cache case on my machine.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  I wanted guaranteed-fast status for another reason, but it turns out
>  "branch -v" benefits even more. Recent commit walking is not
>  efficiently optimized even with Shawn's pack bitmaps. This may be
>  useful some people, I guess.

Not particularly interested in the cause, but not so strongly
against it to veto it.

The design looks questionable.

You can fork one or more branches off of a single branch.  You may
fork your 'frotz' branch off of remotes/origin/master but also
another 'xyzzy' branch may be forked from the same.

I understand that you are trying to optimize, given two commit
object names X and Y, the cost to learn the symmetric distances
between them.

Doesn't it make more sense to use a notes-cache that is keyed off of
the commit object name X of the remote?  You will have a single note
that stores a blob for the commit object remotes/origin/master, and
the blob tells you how far the commit at the tip of 'frotz' is from
it, and the same for 'xyzzy'.

You would obviouly need to run "gc" on such a notes-cache tree from
time to time, removing notes for commits that are not tip of any
branch that could be a fork point, and from the remaining notes
blobs, entries that describe commits that are not tip of any branch,
if you go that route.

>
>  remote.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/remote.c b/remote.c
> index 04fd9ea..db825b8 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1549,6 +1549,7 @@ int stat_tracking_info(struct branch *branch, i=
nt *num_ours, int *num_theirs)
>  	struct rev_info revs;
>  	const char *rev_argv[10], *base;
>  	int rev_argc;
> +	int fd;
> =20
>  	/*
>  	 * Nothing to report unless we are marked to build on top of
> @@ -1579,6 +1580,33 @@ int stat_tracking_info(struct branch *branch, =
int *num_ours, int *num_theirs)
>  	if (theirs =3D=3D ours)
>  		return 0;
> =20
> +	if (!access(git_path("stat_tracking_cache/%s",
> +			     branch->refname), R_OK)) {
> +		struct strbuf sb =3D STRBUF_INIT;
> +		unsigned char sha1_ours[20], sha1_theirs[20];
> +		int n1, n2;
> +		if ((fd =3D open(git_path("stat_tracking_cache/%s",
> +					branch->refname),
> +			       O_RDONLY)) !=3D -1 &&
> +		    strbuf_read(&sb, fd, 0) !=3D -1 &&
> +		    sb.len > (40 + 1) * 2 &&
> +		    !get_sha1_hex(sb.buf, sha1_ours) &&
> +		    sb.buf[40] =3D=3D '\n' &&
> +		    !get_sha1_hex(sb.buf + 41, sha1_theirs) &&
> +		    sb.buf[81] =3D=3D '\n' &&
> +		    !hashcmp(sha1_ours, ours->object.sha1) &&
> +		    !hashcmp(sha1_theirs, theirs->object.sha1) &&
> +		    sscanf(sb.buf + 82, "%d\n%d\n", &n1, &n2) =3D=3D 2) {
> +			*num_ours =3D n1;
> +			*num_theirs =3D n2;
> +			close(fd);
> +			strbuf_release(&sb);
> +			return 1;
> +		}
> +		close(fd);
> +		strbuf_release(&sb);
> +	}
> +
>  	/* Run "rev-list --left-right ours...theirs" internally... */
>  	rev_argc =3D 0;
>  	rev_argv[rev_argc++] =3D NULL;
> @@ -1608,6 +1636,20 @@ int stat_tracking_info(struct branch *branch, =
int *num_ours, int *num_theirs)
>  			(*num_theirs)++;
>  	}
> =20
> +	if (!safe_create_leading_directories(git_path("stat_tracking_cache/=
%s",
> +						      branch->refname)) &&
> +	    (fd =3D open(git_path("stat_tracking_cache/%s",
> +				branch->refname),
> +		       O_CREAT | O_TRUNC | O_RDWR, 0644)) !=3D -1) {
> +		struct strbuf sb =3D STRBUF_INIT;
> +		strbuf_addf(&sb, "%s\n", sha1_to_hex(ours->object.sha1));
> +		strbuf_addf(&sb, "%s\n", sha1_to_hex(theirs->object.sha1));
> +		strbuf_addf(&sb, "%d\n%d\n", *num_ours, *num_theirs);
> +		write(fd, sb.buf, sb.len);
> +		strbuf_release(&sb);
> +		close(fd);
> +	}
> +
>  	/* clear object flags smudged by the above traversal */
>  	clear_commit_marks(ours, ALL_REV_FLAGS);
>  	clear_commit_marks(theirs, ALL_REV_FLAGS);
