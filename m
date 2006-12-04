X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael K. Edwards" <medwards.linux@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Mon, 4 Dec 2006 10:56:22 -0800
Message-ID: <f2b55d220612041056w68db5891t105054c0d35efe45@mail.gmail.com>
References: <20061130170625.GH18810@admingilde.org>
	 <200612012355.03493.Josef.Weidendorfer@gmx.de>
	 <Pine.LNX.4.64.0612011510290.3695@woody.osdl.org>
	 <200612020114.42858.Josef.Weidendorfer@gmx.de>
	 <Pine.LNX.4.64.0612011621380.3695@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 4 Dec 2006 18:56:32 +0000 (UTC)
Cc: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>, sf <sf@b-i-t.de>,
	git@vger.kernel.org, "Martin Waitz" <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jQq76JJuVg0EaoT8zKdBgbM1uGvoLNVkAeYSheJjpAs81yk2UC6nIgRrPYSRgUHPSDlr0JImKzW4O+DGwLH0c5JKCZESStRklb1Jtg5t4W5ALfhuWT0VyFBXgBFR3PmeZUla15dZaPUiRJvWHmjkxhGNWVqkvahQJspRSl8yEA4=
In-Reply-To: <Pine.LNX.4.64.0612011621380.3695@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33218>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrIzL-0000oa-Nn for gcvg-git@gmane.org; Mon, 04 Dec
 2006 19:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937264AbWLDS4Z (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 13:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937266AbWLDS4Z
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 13:56:25 -0500
Received: from wx-out-0506.google.com ([66.249.82.226]:2257 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S937264AbWLDS4Y (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec
 2006 13:56:24 -0500
Received: by wx-out-0506.google.com with SMTP id h27so3880216wxd for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 10:56:23 -0800 (PST)
Received: by 10.90.93.6 with SMTP id q6mr8443475agb.1165258582908; Mon, 04
 Dec 2006 10:56:22 -0800 (PST)
Received: by 10.90.94.7 with HTTP; Mon, 4 Dec 2006 10:56:22 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

(I wrote most of this a couple of days ago, so it's not at the tip of
the conversational tree, so to speak.  But it's effectively a response
to Linus's "what do you want to do with submodules" question, with
some thoughts on implementation.  Sorry it's so long; like Blaise
Pascal, "I would have written a shorter letter, but I did not have the
time.")

The supermodule concept, implemented right, could really improve
cooperation among embedded platform integrators, boutique distro
publishers, and other editorial contributors to sprawling metaprojects
who don't want to run kernel.org-scale mirrors.  To make this work,
you need sparse repositories (conserving resources when fetching, by
omitting the bulk of currently un-needed submodules that can reliably
be obtained later from elsewhere) and shallow cloning (conserving
resources when publishing, by referring cloners to a third-party
repository for universally available content).

For instance, it would be a wonderful thing if the pile-o-patches
nightmare that is PTXdist (and crosstool and buildtool and every other
approach I have seen for ongoing maintenance of embedded toolchains
and userlands) were obsoleted by a git supermodule.  Its submodules
would mostly track external projects, but would also logically contain
the fix-up patches worked out during platform integration, checked in
to branches anchored at each upstream release point.  The supermodule
would contain all of the build automation, log auditing, and remote
unit testing stuff, as well as the metadata for each submodule
involved in this platform build cycle.

At a content level, the sparsely populated / shallowly published
supermodule wouldn't be much different from today's PTXdist.  But the
pay-off comes when you merge forward to a new release of some base
component (compiler, library, etc.) and discover that some of your
fix-ups have been adopted or obsoleted upstream, and new fix-ups are
needed for components that depend on the updated bit, and the set of
configurables has changed (for which you need to compensate in the
meta-configurator).  Instead of piling up versioned patch directories,
you commit fix-ups to the sub-modules, which other integration
branches can ignore (if they aren't affected), merge, or cherry-pick.

As I understand it, in today's git, every content object is a patch to
the _data_ of one and only one git repository, containing the label of
the preceding _data_ state plus a diff of file contents and
attributes.  Assuming this model is retained, any clean state of a
"leaf" module (one with no submodules) can be reached by replaying a
series of patches, starting from the repository's root node (an empty
directory with the hopefully unique label generated by init-db).  The
label (SHA1) of the last patch is therefore a perfectly good label for
this _data_ state.

If all we were trying to do with supermodules was to capture and track
various states of the submodules' data, we could extend the format of
content objects to include "state X of submodule with init-db label
Y".  That would have the effect of capturing submodule states as
_data_ in non-"leaf" modules.  We would have to help cloners find a
place from which to pull these states, of course; and it's easy to get
sidetracked onto that part of the problem.  But that's not where the
bang for the buck is in supermodules.

The whole model of distributed supermodules, with references to
slightly diverging submodules whose content should mostly be fetched
from external sources, smells to me just like LVM.  The external
sources (like an LVM volume of which you have taken a "snapshot") make
up the bulk of the content pool.  They also give you a window into
developments on the submodule's own branches (like being able to peek
forward and merge changes from the original volume).  The supermodule
(the snapshot volume) provides most of the interesting refs (submodule
commits referenced by supermodule tags and branch heads), along with
enough "journaled" content to replay forward from some checkpoint
guaranteed to be available in each external source to any of these
refs.

The implication here is that submodule states are not just SHA1 labels
to be embedded within supermodule data diffs.  One ought to be able to
clone a supermodule without immediately cloning full copies of any of
its submodules.  This ought to populate the clone's content database
with all of the quanta of submodule content that aren't guaranteed to
be available from any not-too-stale submodule mirror.  When cloning,
you don't want to have to inspect every supermodule state for
submodule states that are outside the global subset.  So the
supermodule needs to maintain a set of supplemental refs from which
all referenced submodule states can be reached.  This allows you to
traverse the portion of the pool of submodule content that can't be
reached from true submodule branch heads.

On 12/1/06, Linus Torvalds <torvalds@osdl.org> wrote:
> Yes, you do need to have a list of submodules somewhere, and you'd need to
> maintain that separately. One of the results of having the submodules be
> independent from the supermodule is that it's not all "automatically
> integrated", and thus the supermodule does end up having to have things
> like that maintained separately.

This is not a defect; it's a virtue.  It's important for every commit
to the supermodule to contain the information of which submodule
branches you're currently on and how far along them you've crawled.
Any particular supermodule commit point is likely to reflect an
integration milestone visible only to the person working at the
supermodule level.  No content object should ever cross a submodule
boundary, because then you wouldn't be able to apply it to the
submodule in isolation (or in another supermodule state) or identify
it when it is applied upstream and propagates back to you in a pull.
 But the supermodule can also contain supplemental refs (heads and
tags) that don't exist in the submodule (and shouldn't necessarily be
pushed to it); the commits they refer to are localized to the
submodule but may not be reachable from any of the submodule's branch
heads.

> And yes, if you screw that up, you wouldn't be able to fetch submodules
> properly etc, even if you see the supermodule, and yes, this sounds more
> like the CVS "Entries" kind of file that is more "tacked on" than really
> deeply integrated. But I think the separation is _more_ than worth the
> fact that you can see things being separate.

There is an opportunity for useful deep integration here.  The same
algorithm that does reachability analysis for "git prune" can dig from
supermodule down to submodules, copying objects into the supermodule
database until it hits a commit that is advertised as "global" by the
submodule.  "git clone" of the supermodule can then pull the bulk of
the submodules (a superset of the "global" subset) from (a mirror of)
the canonical place for each, and use the supermodule object database
as an alternate source for commits that don't exist in the "canonical"
submodule.

> In fact, I'm very much arguing for keeping things as separate as possible,
> while just integrating to the smallest possible degree (just _barely_
> enough that you can do things like "git clone" and it will fetch multiple
> repositories and put them all in the right places, and "git diff" and
> friends will do reasonably sane things).
>
> Keep it simple, stupid.

As simple as possible; but no simpler.  The "alternates" / "git clone
--reference" model is already almost powerful enough for the
supermodule to contain a "journal" of submodule commits that haven't
yet been retired to the canonical subset (guaranteed present in each
mirror).  The only difference is that the supermodule should be
considered a "weak alternates" source.  Commit objects in the
supermodule's database should be visible to submodule-level operations
(so that commits which are accepted upstream get flowed in nicely
during "git pull").

But if a commit becomes reachable from a ref that is really in the
submodule (not just one of the supermodule's "supplemental refs",
which should _not_ be visible to submodule operations), then it should
be copied into the submodule's object database.  (The refs internal to
the submodule should retain their integrity even if the supermodule is
inaccessible.)  The existing "strong alternates" mechanism should be
reserved for repos which are at least as public and persistent as the
submodule, and supermodules don't qualify (e. g., Linus's transmeta
scenario).

> On Sat, 2 Dec 2006, Josef Weidendorfer wrote:
> > The thing I wanted to discuss is whether such names would need to be globally
> > unique in the project containing submodles, or not.
>
> My preference would be for it to be "local", just because (as I
> mentioned), with mirroring etc, it might well be that you want to fetch
> things from the _closest_ repository. That's really not a global decision,
> it's a local one.

I think "global resource, local provider" is the way to go, with each
provider advertising what checkpoints of what resources it can supply.
 When I clone or pull, I should be able to consult a local mapping of
submodule URIs to "mirrors" (which may well be local repositories
containing content and branches that aren't in the "official"
upstream).  The only thing that may need "global" agreement is the
boundaries of the "global" subset for each submodule, i. e., the set
of commit objects that can reliably be obtained from any mirror of the
"official" upstream repository.  That doesn't need to be terribly
clever; "at least three days old on a globally published branch" would
probably be a perfectly good heuristic.

> > If yes, it IMHO makes a lot of sense to introduce "submodule objects" which contain
> > these submodule names, and which are used as pointers to submodule commits in
> > supermodule trees.
>
> You could do it that way, and then it would be global. It would work, and
> in many ways it would probably be "simpler" on a supermodule level.

I think the implication of "submodule objects" is that supermodule
diffs would say "roll submodule X from commit-id A to commit-id B".  I
don't think that would work very well for pulls/merges in the sparsely
populated scenario, because you want to be able to pull the
non-canonical subset of the individual diffs between states A and B
into the supermodule's object pool.  When you decide later to flesh
out submodule X, you should only have to clone some canonical mirror
and then fast-forward to state B using objects you already have in the
supermodule pool.

The merge case is even clearer.  Suppose I pull updates from two
remote branches of the supermodule onto my master branch.  Each remote
branch has added the same submodule, cloned from third-party
repositories whose clone history goes back to the same origin.  (The
example I have in mind is when some project switches to git from some
other SCM, and the maintainers of the remote branches port their
integration patches over from their git-svn tracker submodule to a
clone of upstream's new git repo.)  I should be able to postpone the
merge effort, come back later and clone the upstream repo, then merge
the non-canonical commits that were pulled earlier.

I might want to decide at supermodule pull time to postpone pulling
the bodies of the submodule commits; but I want the full sequence of
submodule commit IDs in the supermodule commit object.  So it's not so
much the supermodule _state_ that has a hierarchical structure; it's
the supermodule _diffs_ and _object_pool_ that become hierarchical.

> The advantage of a global namespace is that you can much more easily
> update it - "git fetch" will just fetch the new file(s) that describe the
> subprojects very naturally if they are all global. Putting them in a local
> .git/config file has it's advantages (see above), but it also makes it
> very hard to version them, and to update the list - it would have to
> become manual.

I think the only global-to-local-namespace mapping applies to the
different labels for the "empty repository" state generated at init-db
time.  Given the init-db SHA1 of the linux kernel repository, I should
be able to choose any mirror or clone of that repository as a source
for objects in its "global set".  I expect this provider not to
scribble on globally published branches, but that isn't even all that
critical; anything outside the canonical set is kept in the
supermodule's object pool, so I can always blow the submodule away and
regenerate it from a different mirror.

> There are possibly combinations of the two approaches: have a "global
> namespace" that describes the canonical place to get the subprojects, but
> have some way to add local "translation" of the canonical names into
> locally preferred versions (eg you could just have a way to say "this is
> the local mirror for that global canonical place")
>
> Maybe that would work?

Sure.  But all you really need from the canonical place is its init-db
SHA1 (permanent) and its list of globally published branches
(monotonically expanding).  A URL for it is a convenient shorthand but
doesn't have to be persistent.

Cheers,
