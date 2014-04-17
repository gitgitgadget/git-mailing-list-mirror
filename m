From: Johan Herland <johan@herland.net>
Subject: Re: [RFC] t7410: 210 tests for various 'git submodule update' scenarios
Date: Thu, 17 Apr 2014 13:42:42 +0200
Message-ID: <CALKQrgfF2Kkk4itvtm_yU9qm9GrJf-DWQQG8y+CAwisOUqY=eg@mail.gmail.com>
References: <1397609688-25634-1-git-send-email-johan@herland.net>
	<20140416172153.GW21805@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Apr 17 13:42:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WakiX-0006yy-DX
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 13:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082AbaDQLmw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Apr 2014 07:42:52 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:41641 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656AbaDQLmt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Apr 2014 07:42:49 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1WakiN-0006Tv-9S
	for git@vger.kernel.org; Thu, 17 Apr 2014 13:42:47 +0200
Received: from mail-pb0-f44.google.com ([209.85.160.44])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WakiM-000OdA-Ro
	for git@vger.kernel.org; Thu, 17 Apr 2014 13:42:47 +0200
Received: by mail-pb0-f44.google.com with SMTP id rp16so292889pbb.3
        for <git@vger.kernel.org>; Thu, 17 Apr 2014 04:42:42 -0700 (PDT)
X-Received: by 10.68.110.4 with SMTP id hw4mr14966692pbb.147.1397734962584;
 Thu, 17 Apr 2014 04:42:42 -0700 (PDT)
Received: by 10.70.48.232 with HTTP; Thu, 17 Apr 2014 04:42:42 -0700 (PDT)
In-Reply-To: <20140416172153.GW21805@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246415>

TL;DR: I believe the update-related submodule.<name>.* options
(.branch, .update, .url, and even the --remote option) are
slowly growing into a separate DSL for specfying how to update
submodules. This adds a confusing and opaque layer in front of
what is essentially git commands run by "git submodule update"
within the submodule. Instead of adding more submodule.<name>.*
options to handle even more use cases, we should scale back on
the config options, and allow the user to specify what should
happen on "git submodule update" in the existing language of
git commands.

On Wed, Apr 16, 2014 at 7:21 PM, W. Trevor King <wking@tremily.us> wrot=
e:
> On Wed, Apr 16, 2014 at 02:54:48AM +0200, Johan Herland wrote:
>> This is a work-in-progress to flesh out (and promote discussion abou=
t)
>> the expected behaviors for all possible scenarios in which
>> 'git submodule update' might be run.
>
> This is lovely :).

Thanks!

Having been active in git-submodule development a few years ago,
I thought I had a fairly firm grasp of most details regarding
submodules, but when I recently tried to explain to someone how
"git submodule update" was supposed to work, I quickly found that
I had forgotten a lot, and that git-submodule had also changed.
After (albeit casually) reading the docs, I still didn't feel much
wiser, and this humongous testcase is sort of my ultimate attempt
to regain some understanding.

So far, my impression is that there are too many details/variables
and too much state to be able to sanely comprehend what is the intended
behavior in all cases, much less document in a way that is approachable
to regular users...

>> +#  - current state of submodule:
>> +#     ?.?.?.1 - not yet cloned
>> +#     ?.?.?.2 - cloned, detached, HEAD =3D=3D gitlink
>> +#     ?.?.?.3 - cloned, detached, HEAD !=3D gitlink
>> +#     ?.?.?.4 - cloned, on branch foo (exists upstream), HEAD =3D=3D=
 gitlink
>> +#     ?.?.?.5 - cloned, on branch foo (exists upstream), HEAD !=3D =
gitlink
>> +#     ?.?.?.6 - cloned, on branch bar (MISSING upstream), HEAD =3D=3D=
 gitlink
>> +#     ?.?.?.7 - cloned, on branch bar (MISSING upstream), HEAD !=3D=
 gitlink
>
> The remote branches should only matter for the initial clone and
> --remote updates.  Also, only the configured submodule.<name>.branch
> (your first axis) should be checked; the locally checked-out submodul=
e
> branch shouldn't matter.

Yes, I realized that while working out the various cases, but it was
not at all obvious from the start, given that the config option is
called submodule.<name>.branch and not submodule.<name>.upstream or
similar (which might prevent a casual user from misinterpreting the
option as having something to do with the current local branch in the
submodule). See D6 for more discussion about the naming of .branch.

In general, I experimented with a few different ways of organizing the
axes to get a "flow" of testcases that more naturally "revealed" the
behavior of "git submodule update", but I haven't found a good
organization, yet. I suspect there is none...

>> +# T2: Test with submodule.<name>.url !=3D submodule's remote.origin=
=2Eurl. Does
>> +#     "submodule update --remote" sync with submodule.<name>.url, o=
r with the
>> +#     submodule's origin? (or with the submodule's current branch's=
 upstream)?
>
> All fetches should currently use the submodule's remote.origin.url.
> submodule.<name>.url is only used for the initial clone (*.*.*.1), an=
d
> never referenced again.  This would change using my tightly-bound
> submodule proposal [1], where a difference between
> submodule.<name>.url and the submodule's @{upstream} URL would be
> trigger a dirty-tree condition (for folks with tight-bind syncing
> enabled) from which you couldn't update before resolving the
> difference.

Ok. As stated above, I am worried about the amount of duplicated
state between the superproject's submodule config (which itself is
split between .gitmodules and .git/config) and the submodule's own
config. And from the above paragraph, I suspect two more dimensions
need to be added to the test matrix:

 - submodule's remote.origin.url =3D=3D/!=3D submodule.<name>.url

 - "tightly-bound submodule" is enabled/disabled

Even if we might successfully deal with the duplicate state (and the
exploding test matrix), it will certainly not be easy to
describe/document the intended behavior in a way that's simple to
grasp and straightforward to use.

We should instead seek ways to minimize the duplication of state.
If it is indeed the case that several submodule.<name>.* values in the
superproject are only consulted _once_ (when cloning the submodule),
we should make it obvious that they will not be used after the clone
is done. Similarly, we should make it obvious that the update-related
options only apply exactly when "git submodule update" is run.

What about something like this:

 - submodule.<name>.create: The command that will be used by
   "git submodule update" to initially populate the contents of
   the submodule. The command is run from within the submodule
   directory, and the following environment variables are available:

    - $SUPER_URL: The URL of the superproject's current upstream
      remote.

    - $SUPER_HEAD: The current value of the superproject's HEAD.
      Typically a refname, but may be commit id (if detached).

    - $GITLINK: The current value of the superproject's gitlink
      for this submodule.

   Example values for submodule.<name>.create:

    - 'git clone -n $SUPER_URL/../sub.git . && git reset --hard $GITLIN=
K'
      This clones from a relative submodule URL (by using $SUPER_URL),
      and then does a detached checkout of $GITLINK. This would be
      equivalent to the current "checkout-mode".

    - 'git clone -n git://url.to/sub.git . && git checkout dev-branch'
      This clones from an absolute submodule URL, and then (assuming
      "dev-branch" exists upstream, which triggers a checkout's DWIM
      behavior) creates a local "dev-branch" with origin/dev-branch
      as its upstream. This would be a suitable start point for
      developing on "dev-branch" in the submodule.

    - 'git clone -n -c branch.autosetuprebase=3Dremote git://url.to/sub=
=2Egit . \
       && git checkout dev-branch'
      Same as above, but prepares for a rebase-style workflow instead.

 - submodule.<name>.update: The command that will be run within the
   already-existing submodule by "git submodule update". The same
   enviroment variables as above are available. Example values for
   submodule.<name>.update:

    - 'git reset --hard $GITLINK'
      Equivalent to checkout-mode (without --remote).

    - 'git fetch && git reset --hard origin/HEAD'
      Equivalent to checkout-mode with --remote.

    - 'git merge $GITLINK'
      Equivalent to merge-mode (without --remote).

    - 'git pull origin next'
      Equivalent to merge-mode with --remote and .branch =3D=3D next.

    - 'git rebase $GITLINK'
      Equivalent to rebase-mode (without --remote)

    - 'git pull --rebase origin pu'
      Equivalent to rebase-mode with --remote and .branch =3D=3D pu.

    - 'git pull'
      Defer completely to the submodule's own config.

Pros/Cons:

 Pro: It is obvious to everybody exactly what will happen when
      "git submodule update" is run.

 Pro: We no longer duplicate state with the submodule's config.
      Instead, it is obvious when and how these options modify
      the submodule, and whether or not they operate independently
      of the submodule's own config.

 Pro: We reuse the current "language" (of git commands and
      command-line options) for describing how to perform updates,
      instead of having to invent a duplicate (but terser) language
      in the form of submodule.<name>.* options.

 Pro: With just a couple of options, we can obsolete most of the
      existing submodule.<name>.* options:

       - .branch =3D=3D $foo is replaced by "git pull origin $foo" in
         the new .update command.

       - .update =3D=3D none/checkout/merge/rebase is replaced by an
         appropriate git command in the new .update command.

       - .url becomes a 'clone' argument in the .create command.

       - The --remote option is replaced by updating against remote
         .branch instead of $GITLINK

 Pro: Allows for ultimate flexibility in handling submodule updates
      without increasing the pressure to keep adding
      submodule.<name>.* options.

 Con: Wildly backwards-incompatible with existing submodule.* configs.

 Con: Probably missing proper error handling and/or other handling of
      corner cases in the above example commands.

 Con: A user who has copied/modified these options into his
      superproject's .git/config will manually have to reconcile that
      with any future updates to .gitmodules.

 Con: Too much information in each config option? Maybe consider using
      hooks instead of config options?

>> +# D1: When submodule is already at right commit, checkout-mode curr=
ently does
>> +#     nothing. Should it instead detach, even when no update is nee=
ded?
>> +#     Affects: 1.2.1.4, 1.2.1.6, 2.2.1.4, 2.2.1.6, 3.2.1.4, 3.2.1.6
>
> =E2=80=9CCheckout updates always leave a detached HEAD=E2=80=9D seems=
 easier to
> explain, so I'm leaning that way.

Yes, although I suspect different people using different workflows will
have different (but valid) opinions on how this should be handled.
Which is why I'm approaching the conclusion outlined in the TL;DR; i.e.
that adding more submodule.<name>.* options (which often interacts
with other options in complex ways) is probably NOT the way to go.

Instead, we should recognize that people may want to have their
submodules updated in so many different ways, that trying to encode it
in a collection of submodule.<name>.* options is pointless. We can then
provide something more flexible that reuses existing syntax, like the
"free-form" options suggested above, or maybe a "submodule-update" hook
that allows even more customization.

Obviously, we should still have good defaults to deal with the most
common cases, but the current set of options is growing too large to be
understandable by most users.

>> +# D2: Should all/some of 1.3.*/1.4.* abort/error because we don't k=
now what to
>> +#     merge/rebase with (because .branch is unset)? Or is the curre=
nt default
>> +#     to origin/HEAD OK?
>> +#     Affects: 1.3.*, 1.4.*
>
> Maybe you mean 1.3.*, 1.4.*, and 1.5.* (merge, rebase, and !command)?
> In all of these cases, we're integrating the current HEAD with the
> gitlinked (*.*.1.*) or remote-tracking branch (*.*.2.*).  Since
> submodule.<name>.branch defaults to master (and may be changed to HEA=
D
> after a long transition period? [2,3]), I don't think we should
> abort/error in those cases.

Yes, it seems we're settling on origin/HEAD as an acceptable default.

>> +# D3: When submodule is already at right commit, merge/rebase-mode =
currently
>> +#     does nothing. Should it do something else (e.g. not leave sub=
module
>> +#     detached, or checked out on the "wrong" branch (i.e. !=3D .br=
anch))?
>> +#     (This discussion point is related to D1, D5 and D6)
>
> =E2=80=9CNon-checkout updates always leave you on a branch=E2=80=9D s=
eems easier to
> explain, but I think we'd want to distinguish between the local branc=
h
> and the remote submodule.<name>.branch [1].  Lacking that distinction=
,
> I'd prefer to leave the checked-out branch unchanged.

Yes, although again I feel that we are making policy decision based on
what we _believe_ would be ok in our use cases. Adding a .local-branch
config option to specify what happens to the local branch would maybe
fix things for other use cases, but it would also compound the overall
complexity of "submodule update". See above arguments for replacing
config options with explicit git commands, to make "submodule update"
more transparent.

>> +# D4: When 'submodule update' performs a clone to populate a submod=
ule, it
>> +#     currently also creates a default branch (named after origin/H=
EAD) in
>> +#     that submodule, EVEN WHEN THAT BRANCH WILL NEVER BE USED (e.g=
=2E because
>> +#     we're in checkout-mode and submodule will always be detached)=
=2E Is this
>> +#     good, or should the clone performed by 'submodule update' ski=
p the
>> +#     automatic local branch creation?
>> +#     Affects: 1.2.*.1, 1.3.*.1, 1.4.*.1, 1.5.*.1,
>> +#              2.2.*.1, 2.3.*.1, 2.4.*.1, 2.5.*.1,
>> +#              3.2.1.1, 3.3.1.1, 3.4.1.1, 3.5.1.1
>
> =E2=80=9CCheckout updates always leave a detached HEAD=E2=80=9D seems=
 easier to
> explain, so I'm leaning that way.

This is not about detached HEAD. This is about the "extra" local branch
automatically created by "git clone". This branch is unused and
unnecessary in checkout-mode, and only coincidentally useful in other
modes (when .branch =3D=3D origin/HEAD).

However, this is probably a git-clone problem, and not a git-submodule
problem: I am surprised that "git clone --no-checkout" produces the
same local branch (without checking it out). I would instead have
expected the clone to only have the refs/remote/origin/* refs (and
HEAD pointing to an unborn branch - like "git init" does).

>> +# D5: When in merge/rebase-mode, and 'submodule update' actually en=
ds up doing
>> +#     a merge/rebase, that will happen on the current branch (or de=
tached HEAD)
>> +#     and NOT on the configured (or default) .branch. Is this OK? S=
hould we
>> +#     abort (or at least warn) instead? (In general, .branch seems =
only to
>> +#     affect the submodule's HEAD when the submodule is first clone=
d.)
>> +#     (This discussion point is related to D3 and D6)
>> +#     Affects: 1.3.1.3, 1.3.1.5, 1.3.1.7, 1.3.2.>=3D2,
>> +#              1.4.1.3, 1.4.1.5, 1.4.1.7, 1.4.2.>=3D2,
>> +#              2.3.1.3, 2.3.1.5, 2.3.1.7, 2.3.2.2, 2.3.2.4, 2.3.2.6=
,
>> +#              2.4.1.3, 2.4.1.5, 2.4.1.7, 2.4.2.2, 2.4.2.4, 2.4.2.6
>> +#              3.3.1.3, 3.3.1.5, 3.3.1.7
>> +#              3.4.1.3, 3.4.1.5, 3.4.1.7
>
> With the --remote option that added submodule.<name>.branch (which
> eventually landed with v8 of that series [4]), I initially imagined i=
t
> as the name of the local branch [5], but transitioned to imagining it
> as the name of the remote-tracking branch in v5 of that series [6].
> There were no major logical changes between v5 and v8.  With the v8
> version that landed in Git v1.8.2, submodule.<name>.branch was clearl=
y
> the name of the remote-tracking branch, and we gave no way to
> separately configure the local branch.

=46irst of all, shame on me for not following the discussion at the tim=
e.
I still think that when the meaning changed from local to remote-
tracking branch, the actual option name should have changed as well.
Documenting that it specifies a remote branch is good, but not as good
as choosing a better name for it in the first place.

> Recently, we decided that local branches might be important after all
> [7], which lead to the partially landed v5 of my local-branch-creatio=
n
> series [8], now partially reverted with d851ffb (Revert "submodule:
> explicit local branch creation in module_clone", 2014-04-02).  Like v=
4
> of that series [9], I considered the landed-and-now-reverted v5 to be
> a stop-gap until we got better local-branch handling.
>
> Anyhow, that's why submodule.<name>.branch is only important when we
> interact with the remote repository (during clones and --remote
> updates).  We've never landed a patch that explicitly addresses what
> the local branch should be.

Thanks for the recap. I now realize that my above arguments against
increased complexity in submodule.<name>.* options arrive way too
late, and is probably more like trolling than like constructive input.
I am sorry for having been absent during most of this discussion.
Still, I'm afraid that the current set of options are so complex that
they will only ever be fully understood by the very small set of people
involved with their development.

>> +# D6: The meaning of submodule.<name>.branch is initially confusing=
, as it does
>> +#     not really concern the submodule's local branch (except as a =
naming hint
>> +#     when the submodule is first cloned). Instead, submodule.<name=
>.branch is
>> +#     really about which branch in the _upstream_ submodule
>
> Which is how gitmodules(5) explains it:
>
>   submodule.<name>.branch
>     A remote branch name for tracking updates=E2=80=A6

Good, but I fear gitmodules(5) is too hidden for the regular user.
It'd be better to mention this in git-submodule(1), as I expect
gitmodules(5) is largely read by .gitmodules _authors_, and not
regular users. Obviously, the real fix would be a better name...

>> +#     submodule.<name>.url, or by the submodule's remote.origin.url=
?)
>> +#     want to integrate with.
>
> The submodule's remote.origin.url for everything except the initial
> clone (*.*.*.1).  See my response to T2.

As mentioned above, submodule.<name>.url is then an unnecessary state
duplication. We should make it more obvious that it is only ever used
on the initial clone (see my above argument for moving .url into an
explicit git-clone command)

>> =E2=80=A6                               This is probably the more us=
eful setting, and it
>> +#     becomes obviously correct after (re-)reading gitmodules(5) an=
d
>> +#     git-config(1). However, from just reading the "update" sectio=
n in
>> +#     git-submodule(1) (or not even that), things are not so clear-=
cut. Would
>> +#     submodule.<name>.upstream (or .remote-branch, or similar) be =
a better
>> +#     name for this?
>
> Are the docs from 23d25e4 (submodule: explicit local branch creation
> in module_clone, 2014-01-26; now reverted with d851ffb, Revert
> "submodule: explicit local branch creation in module_clone",
> 2014-04-02) clearer?  Maybe we can salvage some of those docs even
> though we've reverted the actual code changes?

As I said above, better docs is good, but no replacement for a better
named option.

>> +# D7: What to do when .branch refers to a branch that is missing fr=
om upstream?
>> +#     Currently, when trying to clone, the clone fails (which cause=
s 'git
>> +#     submodule update --remote' to fail), but leaves the submodule=
 in an
>> +#     uninitialized state (there is a .git, but the work tree is mi=
ssing).
>> +#     This is probably not the behavior we want...
>> +#     Affects: pre, 3.2.2.1, 3.3.2.1, 3.4.2.1, 3.5.2.1
>
> I think we should remove the submodule's .git file after the failed c=
lone.

Agreed, but does that extend to the superproject's .git/modules/<name> =
too?


Again, sorry for the length and lateness of this discussion. I still
hope it may be of some use, though.

=2E..Johan

--
Johan Herland, <johan@herland.net>
www.herland.net
