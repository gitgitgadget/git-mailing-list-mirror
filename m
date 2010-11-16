From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 02/10] unpack-trees: move all skip-worktree check back to unpack_trees()
Date: Tue, 16 Nov 2010 09:39:47 +0700
Message-ID: <AANLkTinpPyjd_Pr=XR9SkmQj1mPodQvG0OCeaxU8NjEp@mail.gmail.com>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
 <1289817410-32470-3-git-send-email-pclouds@gmail.com> <20101115160135.GA16385@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 03:41:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIBTn-0004zL-5G
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 03:41:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759182Ab0KPCkK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 21:40:10 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41937 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab0KPCkJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Nov 2010 21:40:09 -0500
Received: by wwa36 with SMTP id 36so227459wwa.1
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 18:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=XIFApAC29+WaXLVhj0lGz4BkMbu/fjqbPTKVkjQyzWk=;
        b=OQQr3n3coQH0rhqupK+e0yBzSCsXBZo7RQmxPXSgY5J8HHpRaJ56g5/Eq0l8+tE9LP
         XdmFiswjqAmoA8tFTn4QLtAJYF8MlVYIsWiT2aUVrFwFn+UCJlY/cXRWwcc/+wpGIYav
         y9Qp4r9YUqkXq0m6mHndO+nZmkLspWfnJ0UEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=e+XGr2pPg/7P/Hhpqe1zAjOKbPoZd6YfXiV/GVH/EUY2Yadkkgw9hYls3Co/NMAndi
         h3W7T/M9rsGIP95dy+CIgrQFfJo61lU0kWnRnrVbzNAJvXAGGAIRm6b2Xl4ach4gQDin
         falsoV/sNZ+ymAOU/4At5Z/EbOuG8icVMzRkY=
Received: by 10.216.175.73 with SMTP id y51mr4541359wel.41.1289875207217; Mon,
 15 Nov 2010 18:40:07 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Mon, 15 Nov 2010 18:39:47 -0800 (PST)
In-Reply-To: <20101115160135.GA16385@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161531>

2010/11/15 Jonathan Nieder <jrnieder@gmail.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> Earlier, the will_have_skip_worktree() checks are done in various pl=
aces:
>>
>> 1. in verify_* functions to prevent absent/uptodate checks outside
>> =C2=A0 =C2=A0worktree
>> 2. in merged_entry for new index entries
>> 3. in apply_sparse_checkout() for all entries
>>
>> In case all entries are added new ($GIT_DIR/index is missing) all th=
e
>> above checks will be done for all entries, which in the worst case c=
an
>> become cache_nr*el->nr*3 fnmatch() calls. Quite expensive.
>
> Does this mean something like:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Handling of sparse checkouts is slow.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[timings]
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0To fix this, we will do such-and-such. =C2=
=A0As a first step,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0we'll do such-and-such which does not chan=
ge semantics
> =C2=A0 =C2=A0 =C2=A0 =C2=A0and at least does not make it any slower.
>
> ?
>
> In other words, any commit message should make clear
>
> =C2=A01. The purpose.
> =C2=A02. The baseline of (sane or insane) behavior that is affected.
> =C2=A03. The intended resulting functionality.
>
> How the patch works and why it succeeds are just optional extras
> (nice, certainly, but in 90% of cases it is obvious from the code onc=
e
> you know (1), (2), and (3) anyway).

Addressing the slowness is a nice side effect. My main concern is to
collect all skip-worktree checks in a central place so that I can do
tree-like traversing.

>> --- a/cache.h
>> +++ b/cache.h
>> @@ -182,6 +182,7 @@ struct cache_entry {
>> =C2=A0#define CE_WT_REMOVE (0x400000) /* remove in work directory */
>>
>> =C2=A0#define CE_UNPACKED =C2=A0(0x1000000)
>> +#define CE_NEW_SKIP_WORKTREE (0x2000000)
>
> Semantics?

Yep, missed this in the commit message. While unpack_trees() is
running, this bit will be set in entries that are outside worktree
area, according to the (possibly updated) sparse-checkout file.
Compare this bit with CE_SKIP_WORKTREE, we would know this entry
should be removed/added due to sparse-checkout updates.

>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -258,7 +258,7 @@ static int apply_sparse_checkout(struct cache_en=
try *ce, struct unpack_trees_opt
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 int was_skip_worktree =3D ce_skip_worktree(ce);
>>
>> - =C2=A0 =C2=A0 if (!ce_stage(ce) && will_have_skip_worktree(ce, o))
>> + =C2=A0 =C2=A0 if (ce->ce_flags & CE_NEW_SKIP_WORKTREE)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ce->ce_flags |=3D C=
E_SKIP_WORKTREE;
>
> So CE_NEW_SKIP_WORKTREE roughly means "stage-0 entry outside the spar=
se checkout area"?

Yes. Conflicted entries must always stay in worktree regardless
sparse-checkout patterns.

>
>> =C2=A0 =C2=A0 =C2=A0 else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ce->ce_flags &=3D ~=
CE_SKIP_WORKTREE;
>
> In particular, I guess the NEW part refers to the sparse checkout
> area, not the entry, since existing index entries with SKIP_WORKTREE
> bits need to keep that bit.

The NEW part still refers to entry. It's basically
ce_flags[CE_SKIP_WORKTREE] =3D ce_flags[CE_NEW_SKIP_WORKTREE]. The
former bit is kept in file, the later is in memory only.

>> +
>> +static int verify_absent(struct cache_entry *, enum unpack_trees_er=
ror_types, struct unpack_trees_options *);
>> +static int set_new_skip_worktree_2(struct unpack_trees_options *o)
>> +{
>> + =C2=A0 =C2=A0 int i;
>> +
>> + =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0* CE_ADDED marks new index entries. These have=
 not been processed
>> + =C2=A0 =C2=A0 =C2=A0* by set_new_skip_worktree_1() so we do it her=
e.
>> + =C2=A0 =C2=A0 =C2=A0*/
>
> Probably this comment belongs at the call site instead, to avoid some
> chasing.

There is a comment in the callsite, though it does not directly say
"set_new_skip_worktree_2". Will fix.

>> + =C2=A0 =C2=A0 for (i =3D 0;i < o->result.cache_nr;i++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cache_entry *ce =3D=
 o->result.cache[i];
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(ce->ce_flags & CE_=
ADDED))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 continue;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ce->ce_flags &=3D ~CE_AD=
DED;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ce_stage(ce) && wil=
l_have_skip_worktree(ce, o))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ce->ce_flags |=3D CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ce->ce_flags &=3D ~(CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE);
>
> CE_ADDED is private to the add_file_to_index() code path shared
> between add and rerere builtins. =C2=A0rerere is libified and used e.=
g. by
> cherry-pick foo..bar. =C2=A0Can it get us in trouble or do we have cl=
ear
> the flags before using them here? =C2=A0I think it would be worth a n=
ote in
> api-in-core-index.txt to warn future refactorers.

If it's too much trouble, I can use a new bit. Though the number of
available bits is decreasing.

>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Left-over checks from=
 merged_entry when old =3D=3D NULL */
>
> Huh? =C2=A0(That is completely cryptic outside the context of the pat=
ch.)

Will elaborate.

>> @@ -862,6 +905,9 @@ int unpack_trees(unsigned len, struct tree_desc =
*t, struct unpack_trees_options
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 o->el =3D &el;
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> + =C2=A0 =C2=A0 if (!o->skip_sparse_checkout)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_new_skip_worktree_1(=
o);
>> +
>
> Why is this not folded into the above if ()?
>
> This populates the NEW_SKIP_WORKTREE (=3D future SKIP_WORKTREE?) bit
> in the index that represents the preimage for a reset or merge.
>
> Perhaps call it:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_new_skip_w=
orktree(o->src_index, 0);
>
> and mark that function __attribute__((always_inline)) if the
> optimizer doesn't want to cooperate?

It's setting future skip-worktree on existing entries index, contrast
with the _2() function, which is setting future skip-worktree on _new_
entries in the index. How do you name those functions? Wait..

>> =C2=A0 =C2=A0 =C2=A0 memset(&o->result, 0, sizeof(o->result));
>> =C2=A0 =C2=A0 =C2=A0 o->result.initialized =3D 1;
>> =C2=A0 =C2=A0 =C2=A0 o->result.timestamp.sec =3D o->src_index->times=
tamp.sec;
>> @@ -922,6 +968,10 @@ int unpack_trees(unsigned len, struct tree_desc=
 *t, struct unpack_trees_options
>>
>> =C2=A0 =C2=A0 =C2=A0 if (!o->skip_sparse_checkout) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int empty_worktree =
=3D 1;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (set_new_skip_worktre=
e_2(o))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 goto return_failed;
>> +
>
> Trivial part of the merge is over. =C2=A0So now we can check the new
> index entries against the sparse worktree patterns. =C2=A0They were a=
dded in
> that trivial part using add_entry() and will have the CE_ADDED flag.
>
> So this might be:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_new_skip_w=
orktree(&o->result, CE_ADDED);
>
> or
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_result_ski=
p_worktree(o);
>

OK I like the former over the latter.

> The CE_ADDED flag was set in merged_entry, called by the merge_fn_t
> implementations. =C2=A0If there were an api-traverse-trees.txt explai=
ning
> the API, it would be worth a note there; for now it should suffice
> to add a note to future merge_fn_t implementors in the commit
> message ("each unpack-trees merge function arranges for
> CE_SKIP_WORKTREE and CE_SKIP_NEW_WORKTREE to be propagated and for th=
e
> CE_ADDED flag to be set on entries of new paths").

OK

>> @@ -1017,7 +1067,7 @@ static int verify_uptodate_1(struct cache_entr=
y *ce,
>> =C2=A0static int verify_uptodate(struct cache_entry *ce,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0struct unpack_trees_options *o)
>> =C2=A0{
>> - =C2=A0 =C2=A0 if (!o->skip_sparse_checkout && will_have_skip_workt=
ree(ce, o))
>> + =C2=A0 =C2=A0 if (!o->skip_sparse_checkout && (ce->ce_flags & CE_N=
EW_SKIP_WORKTREE))
> [...]
>> @@ -1204,7 +1254,7 @@ static int verify_absent(struct cache_entry *c=
e,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0enum unpack_trees_error_types error_type,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0struct unpack_trees_options *o)
>> =C2=A0{
>> - =C2=A0 =C2=A0 if (!o->skip_sparse_checkout && will_have_skip_workt=
ree(ce, o))
>> + =C2=A0 =C2=A0 if (!o->skip_sparse_checkout && (ce->ce_flags & CE_N=
EW_SKIP_WORKTREE))
>
> The point, I hope. =C2=A0Currently we alternate between finding entri=
es to
> remove and deciding whether if lie in the worktree. =C2=A0After this =
patch,
> whether they lie in the worktree is precomputed.

Yep.

>> @@ -1226,10 +1276,15 @@ static int merged_entry(struct cache_entry *=
merge, struct cache_entry *old,
>> =C2=A0 =C2=A0 =C2=A0 int update =3D CE_UPDATE;
>>
>> =C2=A0 =C2=A0 =C2=A0 if (!old) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Set CE_NEW_SKIP_=
WORKTREE on "merge" to make
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* verify_absent() =
no-op. The true check will be done
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* later on in unpa=
ck_trees().
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 merge->ce_flags |=3D CE_=
NEW_SKIP_WORKTREE;
>
> Mm? =C2=A0Since verify_absent() is a no-op, why call it? =C2=A0This l=
ooks like a
> placeholder for code that calls verify_absent later, when we know if
> it lies in the worktree.

It is no-op only when sparse checkout is enabled. In such cases we
don't know (yet) whether we will add those files in worktree. In
normal cases, everything must be added in worktree, so verify_absent()
is real.

>> @@ -1245,8 +1300,8 @@ static int merged_entry(struct cache_entry *me=
rge, struct cache_entry *old,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (verify_uptodate(old, o))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (ce_skip_worktree(old))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 update |=3D CE_SKIP_WORKTREE;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* Migrate old bits over */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 update |=3D old->ce_flags & (CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTRE=
E);
>
> Thanks, this looks promising.

Thanks for looking at it. These stuff can be error-prone.
--=20
Duy
