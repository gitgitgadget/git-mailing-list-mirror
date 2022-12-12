Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD28FC00145
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 14:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiLLOzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 09:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiLLOzj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 09:55:39 -0500
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD65D337
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 06:55:36 -0800 (PST)
Date:   Mon, 12 Dec 2022 14:55:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1670856933; x=1671116133;
        bh=1F6Cv5/GdkZinffEFKnIThijJWAPrfqaxuw9hGaleyc=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=u9kHWUWWYTRnAUrZ3lSPIuwXhKhMAvgGEa9Hid8jc9ApNwu405/2CdIgTQwdntqgo
         zp8I9Mh51dbnSY2Et4gFaVTUfvJnonUYO39+ZXZUyoaixGh5LpKXi9p1lFEsF/a+Zs
         9vD+f/w3pEg64ElE9uEVHvX2RQR5rV2F5G95gcpMKbXxc0ovOODtHqvYLV0yAVlmiO
         ECHI2b1+B8TdWsgW7jt9amqRLRYg8JuGeo1PjEx/qkO02MDXSmXoTI8wYH0j5b017r
         FUQtEzX+3kzr9Bow0XJQYeqLubZJvmlsBVdLdILLSIgUI1+1gGkLNiLNLvlUApEmUc
         bVJ3162hLvohQ==
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v4 2/3] worktree add: add --orphan flag
Message-ID: <20221212145515.pohzoyllo3bgz7eb@phi>
In-Reply-To: <221212.86tu2158bz.gmgdl@evledraar.gmail.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221212014003.20290-3-jacobabel@nullpo.dev> <221212.86tu2158bz.gmgdl@evledraar.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/12/12 09:11AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> > +static int make_worktree_orphan(const char * ref, const struct add_opt=
s *opts,
> > +=09=09=09=09struct strvec *child_env)
> > +{
> > +=09int ret;
>
> You can avoid this variable entirely....
>
> > +
> > +=09validate_new_branchname(ref, &symref, 0);
> > +=09strvec_pushl(&cp.args, "symbolic-ref", "HEAD", symref.buf, NULL);
>
> ...by just calling strbuf_release(&symref); right after this line, we'll
> never need it again, and the strvec will have its own copy.
>
> > +=09if (opts->quiet)
> > +=09=09strvec_push(&cp.args, "--quiet");
> > +=09strvec_pushv(&cp.env, child_env->v);
>
> So:
>
> > +=09ret =3D run_command(&cp);
> > +=09strbuf_release(&symref);
> > +=09return ret;
>
> We don't have to carry the "ret" here, and can just do:
>
> =09return run_command(&cp);
>

Done.

>
> > +=09struct strbuf symref =3D STRBUF_INIT;
> > +=09struct child_process cp =3D CHILD_PROCESS_INIT;
> > +=09cp.git_cmd =3D 1;
>
> (aside: We usually split up variables & decls, I think this is better
> right before the run_command() line).

Sorry, I'm not quite clear what you mean.

> > +}
> > +
> >  static int add_worktree(const char *path, const char *refname,
> >  =09=09=09const struct add_opts *opts)
> >  {
> > @@ -393,8 +415,9 @@ static int add_worktree(const char *path, const cha=
r *refname,
> >  =09=09=09die_if_checked_out(symref.buf, 0);
> >  =09}
> >  =09commit =3D lookup_commit_reference_by_name(refname);
> > -=09if (!commit)
> > +=09if (!commit && !opts->orphan) {
> >  =09=09die(_("invalid reference: %s"), refname);
> > +=09}
>
> We don't add {}'s for one-statement if's like this, see
> CodingGuidelines. So skip the {}'s.
>

Ah. I think that slipped in when I temporarily added in logging for debug
purposes. Removed.

> >
> >  =09name =3D worktree_basename(path, &len);
> >  =09strbuf_add(&sb, name, path + len - name);
> > @@ -482,10 +505,10 @@ static int add_worktree(const char *path, const c=
har *refname,
> >  =09strvec_pushf(&child_env, "%s=3D%s", GIT_WORK_TREE_ENVIRONMENT, path=
);
> >  =09cp.git_cmd =3D 1;
> >
> > -=09if (!is_branch)
> > +=09if (!is_branch && commit) {
> >  =09=09strvec_pushl(&cp.args, "update-ref", "HEAD",
> >  =09=09=09     oid_to_hex(&commit->object.oid), NULL);
> > -=09else {
> > +=09} else {
>
> Here that style change is good, even if it inflates the diff size a
> litte bit with the while-at-it fixu-up.
>
> > +=09/*
> > +=09 * When creating a new branch, new_branch now contains the branch t=
o
> > +=09 * create.
> > +=09 *
> > +=09 * Past this point, new_branch_force can be treated solely as a
> > +=09 * boolean flag to indicate whether `-B` was selected.
> > +=09 */
> >  =09if (new_branch_force) {
> >  =09=09struct strbuf symref =3D STRBUF_INIT;
> >
>
> I think I commented on this commentary in an earlier round. IMO it could
> just be omitted, as the code is rather self-explanatory.
>
> To the extent that it isn't this commentary just makes things more
> confusing, at least to my reading. It's not explaining what the code is
> doing now, because the very next line after this context (omitted here) i=
s:
>
> =09new_branch =3D new_branch_force
>
> So we're saying it "can be treated solely as a boolean flag", but it
> isn't being treated as such by the code now.
>
> And the "new_branch now contains the branch to create" is also
> inaccurate, we're about to make it true with that assignment, but (and
> again, I don't think a comment is needed at all) *if* we think that's
> worth commenting on then surely the first paragraph of the comment
> should be split off, and come just before that assignment.

Ah yep. In a previous round I removed the other comment but forgot this one=
.
Removed.

>
> > -=09if (new_branch) {
> > +=09if (opts.orphan) {
> > +=09=09branch =3D new_branch;
> > +=09} else if (!lookup_commit_reference_by_name(branch)) {
> > +=09=09/*
> > +=09=09 * If `branch` does not reference a valid commit, a new
> > +=09=09 * worktree (and/or branch) cannot be created based off of it.
> > +=09=09 */
>
> I think with the advice added in 3/3 this comment can also just be
> omitted here, as the end result is that the comment will be
> re-explaining something which should be obvious from the inline advice
> string (and if it isn't, that inline string needs improving).

Done.

>
> > -test_expect_success '"add" -b/-B mutually exclusive' '
> > -=09test_must_fail git worktree add -b poodle -B poodle bamboo main
> > -'
> > -
> > -test_expect_success '"add" -b/--detach mutually exclusive' '
> > -=09test_must_fail git worktree add -b poodle --detach bamboo main
> > -'
> > +# Helper function to test mutually exclusive options.
> > +test_wt_add_excl() {
> > +=09local opts=3D"$@" &&
> > +=09test_expect_success "'worktree add' with '$opts' has mutually exclu=
sive options" '
> > +=09=09test_must_fail git worktree add $opts
> > +=09'
> > +}
> >
> > -test_expect_success '"add" -B/--detach mutually exclusive' '
> > -=09test_must_fail git worktree add -B poodle --detach bamboo main
> > -'
> > +test_wt_add_excl -b poodle -B poodle bamboo main
> > +test_wt_add_excl -b poodle --orphan poodle bamboo
> > +test_wt_add_excl -b poodle --detach bamboo main
> > +test_wt_add_excl -B poodle --detach bamboo main
> > +test_wt_add_excl -B poodle --detach bamboo main
> > +test_wt_add_excl -B poodle --orphan poodle bamboo
> > +test_wt_add_excl --orphan poodle --detach bamboo
> > +test_wt_add_excl --orphan poodle --no-checkout bamboo
> > +test_wt_add_excl --orphan poodle bamboo main
>
> It's good to see this as a helper function, but I think it would be nice
> to have this split up into its own pre-refactoring commit.
>
> As here we're changing some existing tests that are per-se unrelated,
> just so that they can use this new helper.
>
> This commit could then add tests that use the helper, and which are new
> for --orphan.

Done. Also at some point I think I accidentally rolled back the change I ma=
de to
remove the duplicate `test_wt_add_excl -B poodle --detach bamboo main` so I=
've
made sure to remove that this time.


