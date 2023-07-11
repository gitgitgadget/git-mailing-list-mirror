Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1ECEB64DC
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 21:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjGKVPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 17:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGKVPd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 17:15:33 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5FC133
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 14:15:31 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 64787279DD;
        Tue, 11 Jul 2023 17:15:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=/cBCaz8XPUMEH6WW6K7rE/M8r
        mNv8u8LAPdYB09aZws=; b=M73tpxJr6/CHUy+9KSlexwWdNWHKhmH367lc+OQKD
        OVrVdfRTSCPo3BFhHpoKwCBbu/2TDVEL86aIpQjEJKDfAAwWHWtiQhIx07H408R3
        v9Q09SH2h3JWx2sHXSDzVA6BFkv9nzYtEZjopNpvSogH5yCPTeYuh1tyR2DNg23i
        QY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5CAC3279DC;
        Tue, 11 Jul 2023 17:15:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E80DE279DB;
        Tue, 11 Jul 2023 17:15:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com
Subject: Re: [PATCH v3 1/3] attr.c: read attributes in a sparse directory
References: <20230707151839.504494-1-cheskaqiqi@gmail.com>
        <20230711133035.16916-1-cheskaqiqi@gmail.com>
        <20230711133035.16916-2-cheskaqiqi@gmail.com>
Date:   Tue, 11 Jul 2023 14:15:25 -0700
Message-ID: <xmqqjzv6w3o2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0E8C4C9C-2030-11EE-AC84-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

> 'git check-attr' cannot currently find attributes of a file within a
> sparse directory. This is due to .gitattributes files are irrelevant in
> sparse-checkout cone mode, as the file is considered sparse only if all
> paths within its parent directory are also sparse.

I do not quite understand what these two sentences want to say.  If
the attribute files are truly irrelevant then "cannot find" does not
matter, because there is no point in finding irrelevant things that
by definition will not affect the outcome of any commands at all,
no?

> In addition,
> searching for a .gitattributes file causes expansion of the sparse
> index, which is avoided to prevent potential performance degradation.

Does this sentence want to say that there is a price to pay, in
order to read an attribute file that is not part of the cones of
interest, that you first need to expand the sparse index?  I think
that is a given and I am not sure what the point of saying it is.

> However, this behavior can lead to missing attributes for files inside
> sparse directories, causing inconsistencies in file handling.

I agree.  Not reading attribute files correctly will lead to a bug.

Let me rephase what (I think) you wrote below to see if I understand
what you are doing correctly.

Suppose that sub1/.gitattributes need to be read, when the calling
command wants to know about attributes of sub1/file.  Imagine that
sub1/ and sub2/ are both outside the cones of interest. It would be
better not to expand sub2/ even though we need to expand sub1/.  Not
calling ensure_full_index() upfront and instead expanding the
necessary subdirectories on demand would be a good way to solve it.

Is that what going on?

> To resolve this, revise 'git check-attr' to allow attribute reading for
> files in sparse directories from the corresponding .gitattributes files=
:
>
> 1.Utilize path_in_cone_mode_sparse_checkout() and index_name_pos_sparse
> to check if a path falls within a sparse directory.
>
> 2.If path is inside a sparse directory, employ the value of
> index_name_pos_sparse() to find the sparse directory containing path an=
d
> path relative to sparse directory. Proceed to read attributes from the
> tree OID of the sparse directory using read_attr_from_blob().
>
> 3.If path is not inside a sparse directory=EF=BC=8Censure that attribut=
es are
> fetched from the index blob with read_blob_data_from_index().
>
> Helped-by: Victoria Dye <vdye@github.com>
> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
> ---
>  attr.c | 47 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 19 deletions(-)

Thanks.

> diff --git a/attr.c b/attr.c
> index 7d39ac4a29..be06747b0d 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -808,35 +808,44 @@ static struct attr_stack *read_attr_from_blob(str=
uct index_state *istate,
>  static struct attr_stack *read_attr_from_index(struct index_state *ist=
ate,
>  					       const char *path, unsigned flags)
>  {
> +	struct attr_stack *stack =3D NULL;
>  	char *buf;
>  	unsigned long size;
> +	int pos;
> =20
>  	if (!istate)
>  		return NULL;
> =20
>  	/*
> -	 * The .gitattributes file only applies to files within its
> -	 * parent directory. In the case of cone-mode sparse-checkout,
> -	 * the .gitattributes file is sparse if and only if all paths
> -	 * within that directory are also sparse. Thus, don't load the
> -	 * .gitattributes file since it will not matter.

Imagine that you have a tree with sub1/ outside the cones of
interest and sub2/ and sub9/ inside the cones of interest, and
further imagine that sub1/.gitattributes and sub2/.gitattributes
give attribute X to sub1/file and sub2/file respectively.  There
is no sub9/.gitattributes file.

Then "git ls-files ':(attr:X)sub[0-9]'" _could_ have two equally
sensible behaviours:

 (1) Only show sub2/file because sub1/ is outside the cones of
     interest and the user does not want to clutter the output
     from the parts of the tree they are not interested in.

 (2) Show both sub1/file and sub2/file, even though sub1/ is outside
     the cones of interest, in response to the fact that the mention
     of "sub[0-9]" on the command line is an explicit indication of
     interest by the user (it would become more and more interesting
     if the pathspec gets less specific, like ":(attr:X)" that is
     treewide, though).

The original comment seems to say that only behaviour (1) is
supported, but I wonder if we eventually want to support both,
choice made by the calling code (and perhaps options)?  In any case,
offering the choice of (2) is a good thing in the longer run.
Anyway...

> +	 * If the pos value is negative, it means the path is not in the inde=
x.=20
> +	 * However, the absolute value of pos minus 1 gives us the position w=
here the path=20
> +	 * would be inserted in lexicographic order. By subtracting another 1=
 from this=20
> +	 * value (pos =3D -pos - 2), we find the position of the last index e=
ntry=20
> +	 * which is lexicographically smaller than the provided path. This wo=
uld be=20
> +	 * the sparse directory containing the path.

That is true only if the directory containing the .gitattribute file
is sparsified (e.g. sub1/.gitattributes does not appear in the index
but sub1/ does; sub2/.gitattributes however does appear in the index
and there is no sub2/ in the index).

If not, there are two cases:

 * sub2/.gitattributes does appear in the index (and there is no
   sub2/ in the index).  "pos =3D - pos - 2" computes a nonsense
   number in this case; hopefully we can reject it early by noticing
   that the resulting pos is negative.

 * sub9/.gitattributes does not belong to the project.  The pos is
   negative and "- pos - 2" does not poihnt at sub9/ (as it is not
   sparse).  Depending on what other paths appear in sub9/., the
   path that appears at (-pos-2) may be inside or outside sub9/.  In
   the worst case, it could be a sparsified directory that sorts
   directly before sub9/ (say, there is sub8/ that is sparse, which
   may have .gitattributes in it).  Would the updated code
   mistakenly check S_ISSPARSEDIR() on sub8/ that has no relevance
   when we are dealing with sub9/.gitattributes that does not exist?

> -	if (!path_in_cone_mode_sparse_checkout(path, istate))
> -		return NULL;
> +	pos =3D index_name_pos_sparse(istate, path, strlen(path));
> +	pos =3D - pos - 2;
> =20
> -	buf =3D read_blob_data_from_index(istate, path, &size);
> -	if (!buf)
> -		return NULL;
> -	if (size >=3D ATTR_MAX_FILE_SIZE) {
> -		warning(_("ignoring overly large gitattributes blob '%s'"), path);
> -		return NULL;
> -	}
> +	if (!path_in_cone_mode_sparse_checkout(path, istate) && 0 <=3D pos) {
> +		if (!S_ISSPARSEDIR(istate->cache[pos]->ce_mode))
> +			return NULL;

So earlier, the code, given say sub1/.gitattributes, checked if that
path is outside the cones of interest and skipped reading it.  But
the updated code tries to check the same "is it outside or inside?"
condition for sub1/ directory itself.  Does it make a practical
difference that you can demonstrate with a test?

I do not know if the updated code does the right thing for
sub2/.gitattributes (exists in a non-sparse directory) and
sub9/.gitattributes (does not exist in non-sparse directory),
though.

> +		if (strncmp(istate->cache[pos]->name, path, ce_namelen(istate->cache=
[pos])) =3D=3D 0) {

Don't compare with "=3D=3D0", write !strncmp(...) instead.

> +			const char *relative_path =3D path + ce_namelen(istate->cache[pos])=
; =20
> +			stack =3D read_attr_from_blob(istate, &istate->cache[pos]->oid, rel=
ative_path, flags);
> +		}

If the earlier "- pos - 2" misidentified the parent sparse directory
entry in the index and the strncmp() noticed that mistake, we would
come here without reading any new attribute stack frame.  Don't we
need to fallback reading from the path in the correct directory that
is not at "- pos - 2"?

Let's imagine this case where sub/ is a directory outside the cones
of interest, and our sparse-index may or may not have it as a
directory in the index, and then the caller asks to read from the
"sub/sub1/.gitattributes" file.  Even when "sub/" is expanded in the
index, "sub/sub1/" may not and appear as a directory in the index.

The above "find relative_path and read from the tree object" code
would of course work when the direct parent directory of
".gitattributes" is visible in the index, but interestingly, it
would also work when it does not.  E.g. if "sub/" is represented as
a directory in the index, then asking for "sub1/.gitattributes"
inside the tree object of "sub/" would work as get_tree_entry() used
by read_attr_from_blob() would get to the right object recursively,
so that is nice.  If that is why "'- pos - 2' must be the directory
entry in the index that _would_ include $leadingpath/.gitattributes
regardless of how many levels of directory hierarchy there are
inside $leadingpath" idea was chosen, I'd have to say that it is
clever ;-)

I however find the "'- pos - 2' must be the directory entry in the
index" trick hard to reason about and explain.  I wonder if we write
this in a more straight-forward and stupid way, the result becomes
easier to read and less prone to future bugs...

Thanks.
