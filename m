Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 458C4208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 16:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbdHRQcb (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 12:32:31 -0400
Received: from smtprelay09.ispgateway.de ([134.119.228.113]:52726 "EHLO
        smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbdHRQca (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 12:32:30 -0400
X-Greylist: delayed 1582 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Aug 2017 12:32:29 EDT
Received: from [89.15.237.222] (helo=book.hvoigt.net)
        by smtprelay09.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1dijmy-00018K-RY; Fri, 18 Aug 2017 18:06:25 +0200
Date:   Fri, 18 Aug 2017 18:06:23 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [RFC PATCH 1/2] implement fetching of moved submodules
Message-ID: <20170818160623.GB69414@book.hvoigt.net>
References: <20170817105349.GC52233@book.hvoigt.net>
 <CAGZ79kY41A--4j6bkeKE=vOVVLXDcFc6BhBgz0G-4jQ2bVjyBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kY41A--4j6bkeKE=vOVVLXDcFc6BhBgz0G-4jQ2bVjyBw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2017 at 10:20:13AM -0700, Stefan Beller wrote:
> On Thu, Aug 17, 2017 at 3:53 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > We store the changed submodules paths to calculate which submodule needs
> > fetching. This does not work for moved submodules since their paths do
> > not stay the same in case of a moved submodules. In case of new
> > submodules we do not have a path in the current checkout, since they
> > just appeared in this fetch.
> >
> > It is more general to collect the submodule names for changes instead of
> > their paths to include the above cases.
> >
> > With the change described above we implement 'on-demand' fetching of
> > changes in moved submodules.
> 
> This sounds as if this would also enable fetching new submodules
> eventually?

Yes that was the goal when starting with these changes back then. But it
took more time than I had back then. So instead of letting these changes
sit bitrot again lets see if we can get them integrated.

For new submodules we need to change the iteration somehow. Currently we
are iterating through the index. But new submodules obviously do not
have an index entry (otherwise they would not be new). So instead of the
index we will need to create another list that contains "all"
submodules. Maybe something like: all submodules from the index plus all
submodules that changed / are new? We could also go further and inspect
all submodules from all ref tips to handle submodules on other branches
configured to 'yes'. But I think we should leave that for later if need
arises.

Some merge of index and additional submodules is needed, because for
--recurse-submodules=yes or submodule.<name>.fetchRecurseSubmodules=yes
we always need to run fetch inside the submodule. That would break if we
only looked at submodules that are collected as changed.

> > Note: This does only work when repositories have a .gitmodules file. In
> > other words: It breaks if we do not get a name for a repository.
> > IIRC, consensus was that this is a requirement to get nice submodule
> > handling these days?
> 
> I think that should have been the consensus since ~1.7.8 (since the
> submodules git dir can live inside the superprojects
> <gitdir>/module/<name>).

I agree but since we started without it, we kind of have a mixed state.

> A gitlink entry without corresponding .gitmodules entry is just a gitlink.
> If we happen to have a repository at that path of the gitlink, we can
> be nice and pretend like it is a functional submodule, but it really is
> not. It's just another repo inside the superproject that happen to live
> at the path of a gitlink.

Yeah but at the moment we are handling 'on-demand' fetches and stuff for
such just gitlink submodules. If we were firm on that requirement we
would just skip those but that is not the case with the current
implementation.

> > Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> > ---
> >
> > I updated the leftover code from my series implementing recursive fetch
> > for moved submodules[1] to the current master.
> >
> > This breaks t5531 and t5545 because they do not use a .gitmodules file.
> >
> > I also have some code leftover that does fallback on paths in case no
> > submodule names can be found. But I do not really like it. The question
> > here is how far do we support not using .gitmodules. Is it e.g.
> > reasonable to say: "For --recurse-submodules=on-demand you need a
> > .gitmodules file?"
> 
> I would not intentionally break users here, but any new functionality can
> safely assume (a) we have a proper .gitmodules entry or (b) it is not a
> submodule, so do nothing/be extra careful.
> 
> For example in recursive diff sort of makes sense to also handle
> non-submodule gitlinks, but fetch is harder to tell.

Well we have a few different cases for gitlinks without .gitmodule
entry:

 1. New gitlink: We can not handle since we do not know where to clone
                 from.

 2. Removed gitlink: No need to do anything in fetch

 3. Changed (but same name) gitlink: We can / and currently do run fetch
                                     in it

 4. Renamed: We currently skip those. We could probably do something to
             track the rename and run fetch in case of gitlink changes.
             In my current approach only the ones with a name are
             handled.

So I guess I will add a fallback to paths for 3. so we do not
unnecessarily break users using the current implementation.

> (just last night I was rereading
> https://public-inbox.org/git/CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com/
> which I think is a super cute application of gitlinks. If you happen
> to checkout such
> a tree, you don't want to fetch all of the fake submodules)
> 
> >
> > [1] https://public-inbox.org/git/f5baa2acc09531a16f4f693eebbe60706bb8ed1e.1361751905.git.hvoigt@hvoigt.net/
> 
> Oha, that is from way back in the time. :)

Yeah this code did go through some proper bitrotting :)

> >  submodule.c                 | 92 +++++++++++++++++++++++++--------------------
> >  t/t5526-fetch-submodules.sh | 35 +++++++++++++++++
> >  2 files changed, 86 insertions(+), 41 deletions(-)
> >
> > diff --git a/submodule.c b/submodule.c
> > index 27de65a..3ed78ac 100644
> > --- a/submodule.c
> > +++ b/submodule.c
> > @@ -23,7 +23,7 @@
> >  static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
> >  static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
> >  static int parallel_jobs = 1;
> > -static struct string_list changed_submodule_paths = STRING_LIST_INIT_DUP;
> > +static struct string_list changed_submodule_names = STRING_LIST_INIT_DUP;
> >  static int initialized_fetch_ref_tips;
> >  static struct oid_array ref_tips_before_fetch;
> >  static struct oid_array ref_tips_after_fetch;
> > @@ -742,11 +742,11 @@ const struct submodule *submodule_from_ce(const struct cache_entry *ce)
> >  }
> >
> >  static struct oid_array *submodule_commits(struct string_list *submodules,
> > -                                          const char *path)
> > +                                          const char *name)
> >  {
> >         struct string_list_item *item;
> >
> > -       item = string_list_insert(submodules, path);
> > +       item = string_list_insert(submodules, name);
> >         if (item->util)
> >                 return (struct oid_array *) item->util;
> >
> > @@ -755,39 +755,34 @@ static struct oid_array *submodule_commits(struct string_list *submodules,
> >         return (struct oid_array *) item->util;
> >  }
> >
> > +struct collect_changed_submodules_cb_data {
> > +       struct string_list *changed;
> 
> Here a comment would be helpful or a more concise variable name.
> (What is changed?)

I'll change that to 'changed_submodules' the caller who is passing this
in called this changed. It is the list of changed submodules to be
filled.

> 
> > +       const struct object_id *commit_oid;

What about this name? It is the commit_oid in the superproject of the
current revision under investigation. IMO is easy to get confused what
commits are referenced superproject or submodule. Maybe
'super_commit_oid' would be more clear?

> > +};
> > +
> >  static void collect_changed_submodules_cb(struct diff_queue_struct *q,
> >                                           struct diff_options *options,
> >                                           void *data)
> >  {
> > +       struct collect_changed_submodules_cb_data *me = data;
> > +       struct string_list *changed = me->changed;
> > +       const struct object_id *commit_oid = me->commit_oid;
> >         int i;
> > -       struct string_list *changed = data;
> >
> >         for (i = 0; i < q->nr; i++) {
> >                 struct diff_filepair *p = q->queue[i];
> >                 struct oid_array *commits;
> > +               const struct submodule *submodule;
> 
> (optional style nit, personal opinion, feel free to ignore)
> I personally prefer to not name variables exactly as their type.
> Also most (all) of the struct submodule uses used 'sub' as
> the variable name, maybe keep it consistent?

Well I understand that and its similar for me but I personally I do not
like abbreviations for variable names since I like to be able to read
code natually. So that took precendence over naming submodule
differently than its type here :) Counting submodule vs. sub in
submodule.c I see 4 vs. 5 occurrences...  I'll think about it.

> > +
> >                 if (!S_ISGITLINK(p->two->mode))
> >                         continue;
> >
> > -               if (S_ISGITLINK(p->one->mode)) {
> > -                       /*
> > -                        * NEEDSWORK: We should honor the name configured in
> > -                        * the .gitmodules file of the commit we are examining
> > -                        * here to be able to correctly follow submodules
> > -                        * being moved around.
> > -                        */
> > -                       commits = submodule_commits(changed, p->two->path);
> > -                       oid_array_append(commits, &p->two->oid);
> > -               } else {
> > -                       /* Submodule is new or was moved here */
> > -                       /*
> > -                        * NEEDSWORK: When the .git directories of submodules
> > -                        * live inside the superprojects .git directory some
> > -                        * day we should fetch new submodules directly into
> > -                        * that location too when config or options request
> > -                        * that so they can be checked out from there.
> > -                        */
> > +               submodule = submodule_from_path(commit_oid, p->two->path);
> > +               if (!submodule)
> >                         continue;
> > -               }
> > +
> > +               commits = submodule_commits(changed, submodule->name);
> > +               oid_array_append(commits, &p->two->oid);
> >         }
> >  }
> >
> > @@ -810,11 +805,14 @@ static void collect_changed_submodules(struct string_list *changed,
> >
> >         while ((commit = get_revision(&rev))) {
> >                 struct rev_info diff_rev;
> > +               struct collect_changed_submodules_cb_data data;
> > +               data.changed = changed;
> > +               data.commit_oid = &commit->object.oid;
> >
> >                 init_revisions(&diff_rev, NULL);
> >                 diff_rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
> >                 diff_rev.diffopt.format_callback = collect_changed_submodules_cb;
> > -               diff_rev.diffopt.format_callback_data = changed;
> > +               diff_rev.diffopt.format_callback_data = &data;
> >                 diff_tree_combined_merge(commit, 1, &diff_rev);
> >         }
> >
> > @@ -871,6 +869,7 @@ static int submodule_has_commits(const char *path, struct oid_array *commits)
> >         oid_array_for_each_unique(commits, check_has_commit, &has_commit);
> >
> >         if (has_commit) {
> > +
> 
> stray new line

Yeah saw that too late. Will fix.

> >                 /*
> >                  * Even if the submodule is checked out and the commit is
> >                  * present, make sure it exists in the submodule's object store
> > @@ -945,7 +944,7 @@ int find_unpushed_submodules(struct oid_array *commits,
> >                 const char *remotes_name, struct string_list *needs_pushing)
> >  {
> >         struct string_list submodules = STRING_LIST_INIT_DUP;
> > -       struct string_list_item *submodule;
> > +       struct string_list_item *name;
> >         struct argv_array argv = ARGV_ARRAY_INIT;
> >
> >         /* argv.argv[0] will be ignored by setup_revisions */
> > @@ -956,12 +955,16 @@ int find_unpushed_submodules(struct oid_array *commits,
> >
> >         collect_changed_submodules(&submodules, &argv);
> >
> > -       for_each_string_list_item(submodule, &submodules) {
> > -               struct oid_array *commits = submodule->util;
> > -               const char *path = submodule->string;
> > +       for_each_string_list_item(name, &submodules) {
> > +               struct oid_array *commits = name->util;
> > +               const struct submodule *submodule;
> > +
> > +               submodule = submodule_from_name(&null_oid, name->string);
> > +               if (!submodule)
> > +                       continue;
> >
> > -               if (submodule_needs_pushing(path, commits))
> > -                       string_list_insert(needs_pushing, path);
> > +               if (submodule_needs_pushing(submodule->path, commits))
> > +                       string_list_insert(needs_pushing, submodule->path);
> 
> eventually we can also migrate to name here as well.
> In a later patch.

Yeah, then it would be possible to also push submodules without a
populated worktree.

There was this other thread about the is-populated-check in
push_submodules() where it was consensus that it does not make much
sense but for a maintainer integrating others work it might be useful to
not always have all submodules populated.

Cheers Heiko
