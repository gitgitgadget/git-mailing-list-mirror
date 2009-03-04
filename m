From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-clone: Add option --branch to override initial
 branch
Date: Tue, 03 Mar 2009 22:55:30 -0800
Message-ID: <7vbpsh93q5.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0903030047130.10279@pacific.mpi-cbg.de>
 <1236040414-19089-1-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Tor Arne =?utf-8?Q?Vestb=C3=B8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 07:57:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lel2U-00048h-GO
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 07:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbZCDGzm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2009 01:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbZCDGzm
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 01:55:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55293 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbZCDGzl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2009 01:55:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 86760338B;
	Wed,  4 Mar 2009 01:55:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 72C353389; Wed, 
 4 Mar 2009 01:55:33 -0500 (EST)
In-Reply-To: <1236040414-19089-1-git-send-email-torarnv@gmail.com> (Tor Arne
 =?utf-8?Q?Vestb=C3=B8's?= message of "Tue, 3 Mar 2009 01:33:34 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 780DDD1C-0889-11DE-9AC9-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112185>

Tor Arne Vestb=C3=B8 <torarnv@gmail.com> writes:

> The options --branch and -b allow the user to override the initial
> branch created and checked out by git-clone (normally this is the
> active branch of the remote repository).
>
> If the selected branch is not found the operation aborts.
>
> Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>

The semantics and desirability of the new feature have been already
discussed, and I am not convinced that it is necessary, in the sense th=
at
I do not think I likely ever use this myself, but I am just one of git
users so that is not a strong basis for rejection.

I'll let others discuss more about the design issues, and will only tal=
k
about code in this message.

> diff --git a/builtin-clone.c b/builtin-clone.c
> index c338910..5fc01ce 100644
> --- a/builtin-clone.c
> +++ b/builtin-clone.c
> @@ -38,6 +38,7 @@ static int option_quiet, option_no_checkout, option=
_bare, option_mirror;
>  static int option_local, option_no_hardlinks, option_shared;
>  static char *option_template, *option_reference, *option_depth;
>  static char *option_origin =3D NULL;
> +static char *option_branch =3D NULL;

I see this was copied from the line immediately above, but please do no=
t
initialize static variables to 0 or NULL.  BSS will take care of it.

> @@ -372,7 +375,9 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
>  	const char *repo_name, *repo, *work_tree, *git_dir;
>  	char *path, *dir;
>  	int dest_exists;
> -	const struct ref *refs, *head_points_at, *remote_head, *mapped_refs=
;
> +	const struct ref *refs, *mapped_refs;
> +	const struct ref *remote_head =3D NULL;
> +	const struct ref *head_points_at =3D NULL;
>  	struct strbuf key =3D STRBUF_INIT, value =3D STRBUF_INIT;
>  	struct strbuf branch_top =3D STRBUF_INIT, reflog_msg =3D STRBUF_INI=
T;
>  	struct transport *transport =3D NULL;
> @@ -545,12 +550,31 @@ int cmd_clone(int argc, const char **argv, cons=
t char *prefix)
> =20
>  		mapped_refs =3D write_remote_refs(refs, &refspec, reflog_msg.buf);
> =20
> -		head_points_at =3D locate_head(refs, mapped_refs, &remote_head);
> +		if (option_branch) {
> +		    const int offset =3D 11;
> +		    const char *branch =3D option_branch;

One indent level in git code equals a HT, i.e. 8 places.

> +		    if (!prefixcmp(branch, "refs/heads/"))
> +			branch +=3D offset;

I suspect that you are trying to protect your code against somebody
miscounting the length of "refs/heads/" (perhaps when updating this
codepath in git version 47 that keeps local branches somewhere else, su=
ch
as "refs/local-heads/"), but this "const int offset" does not buy you
anything.  He will likely to leave "offset" to 11 just the same.

It is a different story if it were done like this:

		static const char heads_prefix[] =3D "refs/heads/";
                if (!prefixcmp(branch, heads_prefix))
                	branch +=3D strlen(heads_prefix);

to let the compiler notice heads_prefix is a constant and optimize the
strlen() out, but I personally think it is overkill.

> +		    const struct ref *r;

We do not tolerate decl-after-statement.

> +		    for (r =3D mapped_refs; r; r =3D r->next) {
> +			if (!strcmp(r->name + offset, branch)) {
> +			    /* Override initial branch */
> +			    head_points_at =3D r;
> +			    remote_head =3D r;
> +			    break;
> +			}
> +		    }

This duplicates major part of what locate_head() does but with a differ=
ent
target other than "master", doesn't it?

You would want to refactor this, but I think 'next/pu' already has some
refactoring of the locate_head() logic, so you may want to look at it a=
nd
either build your changes on top of it, or wait until that other topic =
to
stabilize.

> +		    if (!head_points_at)
> +			die("remote has no branch named '%s'.", option_branch);
> +
> +		} else {
> +		    head_points_at =3D locate_head(refs, mapped_refs, &remote_head=
);
> +		}

This falls into more personal taste than coding guideline, but it often=
 is
easier to read to arrange your code:

	if (... condition ...) {
        	shorter codepath
	} else {
        	much
                longer
                code
                path
	}

=46or one thing, it is much easier to miss a short "else" clause hangin=
g at
the end of loooong "if" part.
