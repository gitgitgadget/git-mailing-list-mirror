From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: fix adding new files on i-t-a entries
Date: Tue, 23 Jun 2015 09:50:02 -0700
Message-ID: <xmqqoak6e5dx.fsf@gitster.dls.corp.google.com>
References: <CACfKtTAvH7FH2AkC5hUNFEQ620gF401SNYaULLy62iE8S55-7A@mail.gmail.com>
	<1435062855-26274-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, phiggins@google.com, snoksrud@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 18:50:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7ROn-000859-4q
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 18:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932861AbbFWQuI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jun 2015 12:50:08 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33304 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932350AbbFWQuG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 12:50:06 -0400
Received: by igbqq3 with SMTP id qq3so93525020igb.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 09:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=ZaWMximpIiWN4NNx4GLc98Xr3/mwliyYAJSC+uq98Yk=;
        b=yrJyBHtbZyE1EBtx3jTaLBLbcnUK2EpK1P+br/W9IonnL3W33sGPCciax90fazil4M
         K+BUr0+O0oNs+ZVF1eyix85SntEi4cNZv8ijAszvLpppxRSCEXmHcRMgW/I/ZspV6Uxn
         BEmt1Oa49XhaWplwL8zA3nlKvcE6P8s3nJ5qprEkEeZgCBj2X7r+uRwyhrxSHdkRoFK5
         1vLxXjm17er8JUJzA5zaePUgvnSGh66pZAzCNP7FZhwLJaIS8F8TX14+5lzMXXmSSNRz
         hERFF3M0tE0eQVkTaxnYyLuruTyGjx5souZVuyOGEcjFbSrtE5fBZL9VVH1pWKZsVADk
         1xwg==
X-Received: by 10.43.14.65 with SMTP id pp1mr8363393icb.40.1435078205610;
        Tue, 23 Jun 2015 09:50:05 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3c90:65f7:f86b:dfda])
        by mx.google.com with ESMTPSA id 137sm15422619ioo.29.2015.06.23.09.50.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jun 2015 09:50:04 -0700 (PDT)
In-Reply-To: <1435062855-26274-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 23
 Jun 2015 19:34:15 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272459>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Since d95d728 (diff-lib.c: adjust position of i-t-a entries in diff -
> 2015-03-16), a normal "git diff" on i-t-a entries would produce a dif=
f
> that _adds_ those files, not just adding content to existing and empt=
y
> files like before.
>
> This is correct. Unfortunately, applying such a patch on the same
> repository that has the same i-t-a entries will fail with message
> "already exists in index" because git-apply checks, sees those i-t-a
> entries and aborts. git-apply does not realize those are for
> bookkeeping only, they do not really exist in the index.

> This patch tightens the "exists in index" check, ignoring i-t-a
> entries. For fixing the above problem, only the change in
> check_to_create() is needed.

And the first thing I noticed and found a bit disturbing was that
this change (which I think is correct, and happens to match what I
sent out earlier) was the only thing necessary to make your new test
pass.  IOW, the other changes in this patch have no test coverage.

> For other changes,
>
>  - load_current(), reporting "not exists in index" is better than "do=
es
>    not match index"

Is that error reporting the only side effect from this change?

This is only used when falling back to three-way merge while
applying a creation patch.

>  - check_preimage(), similar to load_current(), but it may also use
>    ce_mode from i-t-a entry which is always zero

This is for the normal (non three-way) application and the idea is
the same as load_current() as you said above.

>  - get_current_sha1(), or actually build_fake_ancestor(), we should n=
ot
>    add i-t-a entries to the temporary index, at least not without als=
o
>    adding i-t-a flag back

This is part of "am" three-way fallback codepath.  I do not think
the merge-recursive three-way merge code knows and cares about, is
capable of handling, or would even want to deal with i-t-a entries
in the first place, so adding an entry as i-t-a bit would not help.
What the ultimate caller wants from us in this codepath is a tree
object, and that is written out from the temporary index---and that
codepath ignores i-t-a entries, so it is correct to omit them from
the temporary index in the first place.  Unlike the previous two
changes, I think this change deserves a new test.

>  I think I'm opening a can of worms with d95d728. There's nothing
>  wrong with that patch per se, but with this issue popping up, I need
>  to go over all {cache,index}_name_pos call sites and see what would =
be
>  the sensible behavior when i-t-a entries are involved.

Yeah, I agree that d95d728 should have been a part of a larger
series that changes the world order, instead of a single change that
brings inconsistency to the system.

I cannot offhand convince myself that "apply" is the only casualty;
assuming it is, I think a reasonable way forward is to keep d95d728
and adjust "apply" to the new world order.  Otherwise, i.e. if there
are wider fallouts from d95d728, we may instead want to temporarily
revert it off from 'master', deal with fallouts to "apply" and other
things, before resurrecting it.

Anything that internally uses "diff-index" is suspect, I think.

What do others think?  You seem to ...

>  So far blame, rm and checkout-entry and "checkout <paths>" are on my
>  to-think-or-fix list. But this patch can get in early to fix a real
>  regression instead of waiting for one big series. A lot more
>  discussions will be had before that series gets in good shape.

=2E.. think that the damage could be quite extensive, so I am inclined
to say that we first revert d95d728 before going forward.

>  builtin/apply.c       |  8 ++++----
>  cache.h               |  2 ++
>  read-cache.c          | 12 ++++++++++++
>  t/t2203-add-intent.sh | 10 ++++++++++
>  4 files changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 146be97..4f813ac 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -3344,7 +3344,7 @@ static int load_current(struct image *image, st=
ruct patch *patch)
>  	if (!patch->is_new)
>  		die("BUG: patch to %s is not a creation", patch->old_name);
> =20
> -	pos =3D cache_name_pos(name, strlen(name));
> +	pos =3D exists_in_cache(name, strlen(name));

Something that is named as if it would return yes/no that returns a
real value is not a very welcome idea.

> +/* This is the same as index_name_pos, except that i-t-a entries are=
 invisible */
> +int exists_in_index(const struct index_state *istate, const char *na=
me, int namelen)
> +{
> +	int pos =3D index_name_stage_pos(istate, name, namelen, 0);
> +
> +	if (pos < 0)
> +		return pos;
> +	if (istate->cache[pos]->ce_flags & CE_INTENT_TO_ADD)
> +		return -pos-1;

This is a useless complexity.  Your callers cannot use the returned
value like this:

	pos =3D exists_in_cache(...);
        if (pos < 0) {
        	if (active_cache[-pos-1]->ce_flags & CE_INTENT_TO_ADD)
			; /* ah it actually exists but it is i-t-a */
		else
                        ; /* no it does not really exist */
	} else {
        	; /* yes it is really there at pos */
	}

because they cannot tell two cases apart: (1) you do have i-t-a with
the given name, (2) you do not have the entry but the location you
would insert an entry with such a name is occupied by an unrelated
entry (i.e. with a name that sorts adjacent) that happens to be
i-t-a.

> +	return pos;
> +}
