From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] blame: can specify shas of commits to ignore on command
 line
Date: Tue, 04 May 2010 23:28:44 +0200
Message-ID: <4BE0918C.9090204@lsrfire.ath.cx>
References: <1272939687-17686-1-git-send-email-dgreid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dylan Reid <dgreid@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 04 23:29:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9Pg3-0006l7-Pc
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 23:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932968Ab0EDV3A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 May 2010 17:29:00 -0400
Received: from india601.server4you.de ([85.25.151.105]:35023 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932152Ab0EDV27 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 17:28:59 -0400
Received: from [10.0.1.100] (p57B7C751.dip.t-dialin.net [87.183.199.81])
	by india601.server4you.de (Postfix) with ESMTPSA id 54B022F8059;
	Tue,  4 May 2010 23:28:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <1272939687-17686-1-git-send-email-dgreid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146347>

Am 04.05.2010 04:21, schrieb Dylan Reid:
> Add the ability for git-blame to ignore changes that occur in
> certain commits.  The new "-I <sha>" argument can be used to specify
> a commit that should be ignored.  This is useful if you have a
> few commits that you know didn't cause a problem, for example you
> switched from "u8" to "uint8_t" and it messed up your history.

Only the long option --ignore-commit works with your patch, -I doesn't.

>    Allow multiple commits to be specified and store an array in the
> scoreboard structure so it is accessible.  Add should_ignore_commit
> function to check if a commit should be ignored. Call
> "should_ignore_commit" from blame_overlap and if the commit should
> be ignored then pass all the blame on to the parent of the ignored
> commit.  This is done by calling "pass_whole_blame" which has been
> relocated to a above blame_overlap, but is unchanged.
>=20
> Signed-off-by: Dylan Reid <dgreid@gmail.com>
> ---
>  Documentation/blame-options.txt |    6 ++
>  builtin/blame.c                 |  124 +++++++++++++++++++++++++++++=
----------
>  t/t8003-blame.sh                |   42 +++++++++++++
>  3 files changed, 141 insertions(+), 31 deletions(-)

Oh, nice!  And with tests and documentation! :)

> diff --git a/Documentation/blame-options.txt b/Documentation/blame-op=
tions.txt
> index d820569..eb9c825 100644
> --- a/Documentation/blame-options.txt
> +++ b/Documentation/blame-options.txt
> @@ -52,6 +52,12 @@ of lines before or after the line given by <start>=
=2E
>  --porcelain::
>  	Show in a format designed for machine consumption.
> =20
> +--ignore-commit <sha>::
> +	Ignore the specified commit when assigning blame.  This is
> +	useful if there are commits in the history that make non
> +	functional changes to the lines you are interested in
> +	finding blame for.
> +
>  --incremental::
>  	Show the result incrementally in a format designed for
>  	machine consumption.
> diff --git a/builtin/blame.c b/builtin/blame.c
> index fc15863..e4bd095 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -176,6 +176,14 @@ struct blame_entry {
>  };
> =20
>  /*
> + * List of any commits to ignore
> + */
> +struct ignore_commits {
> +	unsigned char (*ignore_shas)[20];
> +	unsigned num_ignore_shas;
> +};
> +
> +/*
>   * The current state of the blame assignment.
>   */
>  struct scoreboard {
> @@ -198,6 +206,9 @@ struct scoreboard {
>  	/* look-up a line in the final buffer */
>  	int num_lines;
>  	int *lineno;
> +
> +	/* List of the shas of commits that should be ignored */
> +	struct ignore_commits *ignored_commits;
>  };
> =20
>  static inline int same_suspect(struct origin *a, struct origin *b)
> @@ -653,6 +664,44 @@ static void decref_split(struct blame_entry *spl=
it)
>  }
> =20
>  /*
> + * The blobs of origin and porigin exactly match, so everything
> + * origin is suspected for can be blamed on the parent.
> + */
> +static void pass_whole_blame(struct scoreboard *sb,
> +			     struct origin *origin, struct origin *porigin)
> +{
> +   struct blame_entry *e;
> +
> +   if (!porigin->file.ptr && origin->file.ptr) {
> +      /* Steal its file */
> +      porigin->file =3D origin->file;
> +      origin->file.ptr =3D NULL;
> +   }
> +   for (e =3D sb->ent; e; e =3D e->next) {
> +      if (!same_suspect(e->suspect, origin))
> +	 continue;
> +      origin_incref(porigin);
> +      origin_decref(e->suspect);
> +      e->suspect =3D porigin;
> +   }
> +}

This function was moved from below, but it seems to be indented with
three spaces instead of tabs now.  Adding a declaration without moving
the function would avoid that and result in a smaller patch.

> +
> +/*
> + * Helper to determine if the given commit should be ignored
> + */
> +static unsigned should_ignore_commit(const struct scoreboard *sb,
> +				     struct commit *commit)
> +{
> +	unsigned i;
> +	unsigned num_shas =3D sb->ignored_commits->num_ignore_shas;
> +	for(i =3D 0; i < num_shas; i++)
> +		if(!hashcmp(commit->object.sha1,
> +			    sb->ignored_commits->ignore_shas[i]))
> +			return 1;
> +	return 0;
> +}
> +
> +/*
>   * Helper for blame_chunk().  blame_entry e is known to overlap with
>   * the patch hunk; split it and pass blame to the parent.
>   */
> @@ -660,12 +709,15 @@ static void blame_overlap(struct scoreboard *sb=
, struct blame_entry *e,
>  			  int tlno, int plno, int same,
>  			  struct origin *parent)
>  {
> -	struct blame_entry split[3];
> -
> -	split_overlap(split, e, tlno, plno, same, parent);
> -	if (split[1].suspect)
> -		split_blame(sb, split, e);
> -	decref_split(split);
> +	if(should_ignore_commit(sb, e->suspect->commit))
> +		pass_whole_blame(sb, e->suspect, parent);
> +	else {
> +		struct blame_entry split[3];
> +		split_overlap(split, e, tlno, plno, same, parent);
> +		if (split[1].suspect)
> +			split_blame(sb, split, e);
> +		decref_split(split);
> +	}
>  }
> =20
>  /*
> @@ -1105,29 +1157,6 @@ static int find_copy_in_parent(struct scoreboa=
rd *sb,
>  }
> =20
>  /*
> - * The blobs of origin and porigin exactly match, so everything
> - * origin is suspected for can be blamed on the parent.
> - */
> -static void pass_whole_blame(struct scoreboard *sb,
> -			     struct origin *origin, struct origin *porigin)
> -{
> -	struct blame_entry *e;
> -
> -	if (!porigin->file.ptr && origin->file.ptr) {
> -		/* Steal its file */
> -		porigin->file =3D origin->file;
> -		origin->file.ptr =3D NULL;
> -	}
> -	for (e =3D sb->ent; e; e =3D e->next) {
> -		if (!same_suspect(e->suspect, origin))
> -			continue;
> -		origin_incref(porigin);
> -		origin_decref(e->suspect);
> -		e->suspect =3D porigin;
> -	}
> -}
> -
> -/*
>   * We pass blame from the current commit to its parents.  We keep sa=
ying
>   * "parent" (and "porigin"), but what we mean is to find scapegoat t=
o
>   * exonerate ourselves.
> @@ -1540,8 +1569,14 @@ static void assign_blame(struct scoreboard *sb=
, int opt)
> =20
>  		/* Take responsibility for the remaining entries */
>  		for (ent =3D sb->ent; ent; ent =3D ent->next)
> -			if (same_suspect(ent->suspect, suspect))
> -				found_guilty_entry(ent);
> +			if (same_suspect(ent->suspect, suspect)) {
> +				if (should_ignore_commit(sb, commit) &&
> +				    ent->suspect->previous)
> +					pass_whole_blame(sb, ent->suspect,
> +							 ent->suspect->previous);
> +				else
> +					found_guilty_entry(ent);
> +		   }

An ignored commit can still be blamed if there is no other commit to
pass it on.  So e.g. the initial commit for the file could end up being
blamed for lines that were added by later commits which are being
ignored.  That may look confusing.

Would it make sense to pass the blame to some kind of null commit, i.e.
a special marker that says "I could tell you who is to blame for this
line but you said you don't want to know"?

Ren=E9
