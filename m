From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: [PATCH/RFC] Introduce git submodule add|update --attach
Date: Thu, 2 Jan 2014 19:48:30 +0100
Message-ID: <CALas-igDaweib14zaLJk3m1zmBWk=14oA7h_e7G82vpxmBjiOg@mail.gmail.com>
References: <1388368184-18418-1-git-send-email-ceztko@gmail.com> <CABURp0pQHw7qvG_tq8oK=6DBOUoYy=Rb5othV+zBpNonuv=PLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 02 19:49:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VynKC-0002Jp-Pu
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 19:48:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbaABSsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 13:48:53 -0500
Received: from mail-oa0-f47.google.com ([209.85.219.47]:43487 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755AbaABSsv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 13:48:51 -0500
Received: by mail-oa0-f47.google.com with SMTP id k1so15175127oag.34
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 10:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hM83D/iy1NPE2vW9dcxytHwU2Ndr2/BGsaZfnCf+FkE=;
        b=T/zHe4+8VVsr/a41w8G5XRHZ2sQIAsR1JCKElEA61Js3alWeJYbfNuJDOqgp5+T0Rn
         oY1qh0H3bFbePpkSQxgG087n/cay3jxpKM1CUBnU0IKkNr4WOPq7znWaFfKErLHzSuud
         NSOWwggGBm5pxgdFt/l3loxxmr3MfHElmEFqzu9vsZsRqVO6t7P3WyadCGur2HMj7TjF
         ZRYY5owyXy8f4cZTREoQyFPYDHcLJk68WCQZsN66P3stbL72XcXxviy0NhOi67hE91i0
         UPmwoc8NSDPUiQp88mPAiNE/XWbmTLl3uuj2YH7gxvxxzasALrh1NWowpVOCCUl/DaNC
         ku/w==
X-Received: by 10.60.80.137 with SMTP id r9mr23449880oex.30.1388688531114;
 Thu, 02 Jan 2014 10:48:51 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Thu, 2 Jan 2014 10:48:30 -0800 (PST)
In-Reply-To: <CABURp0pQHw7qvG_tq8oK=6DBOUoYy=Rb5othV+zBpNonuv=PLw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239865>

Thanks for the comments, my replies below. Before, a couple of general
questions:
- I'm also writing some tests, should I commit them together with the
feature patch?
- to determine the attached/detached state I did this:

head_detached=
if test "$(rev-parse --abbrev-ref HEAD)" = "HEAD"
then
    head_detached="true"
fi

Is this correct?

2013/12/31 Phil Hord <phil.hord@gmail.com>
>
> On Sun, Dec 29, 2013 at 8:49 PM, Francesco Pretto <ceztko@gmail.com> wrote:
>  [...]
> >
> > When updating, using the '--attach' switch or operating in a repository with
> > 'submodule.<name>.attach' set to 'true' will:
> > - checkout a branch with an attached HEAD if the repository was just cloned;
> > - perform a fast-forward only merge of changes if it's a 'checkout' update,
> > keeping the HEAD attached;
> > - reattach the HEAD prior performing a 'merge', 'rebase' or '!command' update
> > operation if the HEAD was found detached.
>
> I need to understand this "reattach the HEAD" case better. Can you
> give some examples of the expected behavior when merge, rebase or
> !command is encountered?
>

Thanks for pointing this out, actually my patch was a bit lacking at
this. Reattaching the HEAD prior to merge, rebase or "!command" would
have caused just a *silent* "git checkout "<branch>", possibly leaving
orphaned commits forgotten.

My plans for the patch are now to implement this safer and, IMO,
intuitive behavior: let set say we have a submodule "mod" with the
HEAD detached at orphaned commit <orphaned-sha1>. Let say
"origin/<branch>" is at commit <origin-sha1>. Let say I set
"submodule.mod.attach" to "true" or I run "git submodule update" with
the "--attach" switch. The expected behavior for submodule "mod" would
be (pseudocode):

git checkout <branch>
if "merge" and "head_detached" then
    git merge <orphaned-sha1>
case:
    "merge":
        git merge <origin-sha1>
    "rebase":
        git rebase <origin-sha1>
    "!<command>":
        <command> <origin-sha1>
if "rebase" and "head_detached" then
   git merge <orphaned-sha1>

So, in both "merge|rebase" cases we merge back orphaned commits with a
"git merge", but the effect will be a merge or a rebase depending of
the ordering of the main "update" operation. We can't assume a merge
or rebase operation in the case of !command so we let the
responsibility of merging back orphaned commits to the user.

Sounds good?

>
> > +
> > +--attach::
> > +       This option is only valid for the add and update commands. Cause the
>
> Grammar: 'Causes the result'
>

Ok.

>
> > +       result of an add or update operation to be an attached HEAD. In the
> > +       update command , if `submodule.<name>.branch` is not set, it will
>
> typo: space before comma.
>

Ok.

>
> Also, the pronoun "it" here is unclear to me.  Does this convey the
> correct meaning?
>
>    In the update operation, the branch named by 'submodule.<name>.branch' is
>    checked out as the new HEAD of the submodule repository. If
>    'submodule.<name>.branch' is not set, the 'master' branch is
> checked out as the
>    new HEAD of the submodule.
>

Sounds good to me.

>
> > +       default to `master`. Note: for the update command `--attach` also
> > +       implies `--remote`.
> > +
> > +--detach::
> > +       This option is only valid for the update command. Cause the result
>
>  Grammar: 'Causes the result'
>

Ok.

>
> > +       of the update operation to be forcedly a detached HEAD.
>
> "Forcedly" is a bit strong, maybe, slightly misplaced, and not a word,
> besides.   How's this, instead:
>
>    Forces the result of the update operation to be a detached HEAD in
> the submodule.


Sounds good to me.

>
> >  submodule.<name>.update::
> >         Defines what to do when the submodule is updated by the superproject.
> > -       If 'checkout' (the default), the new commit specified in the
> > -       superproject will be checked out in the submodule on a detached HEAD.
> > +       If 'checkout' (the default), the new commit (or the branch, when using
> > +       the '--attach' switch or the 'submodule.<name>.attach' property is set
> > +       to 'true' during an update operation) specified in the superproject will
> > +       be checked out in the submodule.
>
> IMHO, this wording is overcomplicated by this change.  How about:
>
>        If 'checkout' (the default), the new commit specified in the superproject
>        (or branch, with '--attach') will be checked out in the submodule.
>

Sounds good to me.

>
> >         If 'rebase', the current branch of the submodule will be rebased onto
> >         the commit specified in the superproject. If 'merge', the commit
> >         specified in the superproject will be merged into the current branch
>
> Does the 'merge', 'rebase' and '!command' description need to be
> updated, too?  Here and above it seems to still suggest the old
> behavior is kept when --attach is used.
>

You are right, I'll improve those. Also I think the documentation was
a bit innacurate because, with the current git features state, it's
possible merge changes keeping the HEAD detached, and that's what
happen.


>
> > @@ -54,6 +56,11 @@ submodule.<name>.branch::
> >         If the option is not specified, it defaults to 'master'.  See the
> >         `--remote` documentation in linkgit:git-submodule[1] for details.
> >
> > +submodule.<name>.attach::
> > +       Determine if the update operation will produce a detached HEAD or not.
> > +       Valid values are `true` or `false`. If the property is set to `true`
> > +       and `submodule.<name>.branch`, it will default to `master`
>
> I think you mean "...and 'submodule.<name>.branch' is not set, it
> will...", right?


Correct. I'll fix it.

>
> Some explanation of what happens when it _is_ set would be useful
> here, too, I think.  But maybe I do not understand the nuances yet.
>

I think you're right. I'll improve it.

>
> > @@ -475,8 +479,17 @@ Use -f if you really want to add it." >&2
> >                         cd "$sm_path" &&
> >                         # ash fails to wordsplit ${branch:+-b "$branch"...}
> >                         case "$branch" in
> > -                       '') git checkout -f -q ;;
> > -                       ?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
> > +                       '')
> > +                               git checkout -f -q
> > +                               ;;
>
> Is this whitespace change intentional and necessary?
>

It's unnecessary but it was intentional. In the file there are mixed
indentation styles for cases but when there are multiple statements
clauses the more frequent style is to span single statement clauses to
multi-line too. I touched the clause below to become muti-statenent so
here we are. Please tell me if it's more correct to not touch that
line.


>
> >  }
> > @@ -622,7 +641,7 @@ cmd_init()
> >                    test -z "$(git config submodule."$name".update)"
> >                 then
> >                         case "$upd" in
> > -                       rebase | merge | none)
> > +                       checkout | rebase | merge | none)
>
> This belongs in a commit of its own.
>

Agreed. I'll do it.

>
> >                                 ;; # known modes of updating
> >                         *)
> >                                 echo >&2 "warning: unknown update mode '$upd' suggested for submodule '$name'"
> > @@ -632,6 +651,23 @@ cmd_init()
> >                         git config submodule."$name".update "$upd" ||
> >                         die "$(eval_gettext "Failed to register update mode for submodule path '\$displaypath'")"
> >                 fi
> > +
> > +               # Copy "attach" setting when it is not set yet
> > +               if attached="$(git config -f .gitmodules submodule."$name".attach)" &&
> > +                  test -n "$attached" &&
> > +                  test -z "$(git config submodule."$name".attach)"
> > +               then
> > +                       case "$attached" in
> > +                       true | false)
> > +                               ;; # Valid attach flag values
> > +                       *)
> > +                               echo >&2 "warning: invalid attach flag value for submodule '$name'"
> > +                               upd=none
> > +                               ;;
> > +                       esac
> > +                       git config submodule."$name".attach "$attached" ||
> > +                       die "$(eval_gettext "Failed to register attached option for submodule path '\$displaypath'")"
> > +               fi
> >         done
> >  }
> >
> > @@ -750,6 +786,14 @@ cmd_update()
> >                 --reference=*)
> >                         reference="$1"
> >                         ;;
> > +               --attach)
> > +                       if test "$attach" = "false" ; then usage ; fi
> > +                       attach="true"
> > +                       ;;
> > +               --detach)
> > +                       if test "$attach" = "true" ; then usage ; fi
> > +                       attach="false"
> > +                       ;;
> >                 -m|--merge)
> >                         update="merge"
> >                         ;;
> > @@ -800,11 +844,44 @@ cmd_update()
> >                 name=$(module_name "$sm_path") || exit
> >                 url=$(git config submodule."$name".url)
> >                 branch=$(get_submodule_config "$name" branch master)
> > +               if test -n "$attach"
> > +               then
> > +                       attach_module=$attach
> > +               else
> > +                       attach_module=$(git config submodule."$name".attach)
> > +                       case "$attach_module" in
> > +                       '')
> > +                               ;; # Unset attach flag
> > +                       true|false)
> > +                               ;; # Valid attach flag values
> > +                       *)
> > +                               echo >&2 "warning: invalid attach flag value for submodule '$name'"
> > +                               attach_module=
> > +                               ;;
> > +                       esac
> > +               fi
> > +               if test "$attach_module" = "false"
> > +               then
> > +                       # Normalize attach 'false' flag value
> > +                       attach_module=
> > +               fi
> >                 if ! test -z "$update"
> >                 then
> >                         update_module=$update
> >                 else
> >                         update_module=$(git config submodule."$name".update)
> > +                       case "$update_module" in
> > +                       '')
> > +                               ;; # Unset update mode
> > +                       checkout | rebase | merge | none)
> > +                               ;; # Known update modes
> > +                       !*)
> > +                               ;; # Custom update command
> > +                       *)
> > +                               update_module=
> > +                               echo >&2 "warning: invalid update mode for submodule '$name'"
> > +                               ;;
> > +                       esac
>
> Probably belongs to the same "other" commit mentioned before.
>

Agreed. Please confirm that you meant only the
submodule."$module".update part here as you quoted also a lof of code
that does belongs to the main "--attach" functionality.

>
> I didn't have time to parse out all these conditional completion
> commands in this review, but the feature seems sane to me, as I
> understand it.
>

Good. After a response I should be able to produce an improved patch.

Thanks,
Francesco
