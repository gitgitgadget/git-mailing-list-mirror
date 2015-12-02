From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: BuGit: File-less distributed issue tracking system with Git
Date: Wed, 02 Dec 2015 14:34:19 -0500
Message-ID: <jwva8psr6vr.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 20:34:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4DAp-00049O-3N
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 20:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbbLBTeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 14:34:37 -0500
Received: from plane.gmane.org ([80.91.229.3]:55676 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbbLBTef (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 14:34:35 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1a4DAe-0003r6-Bq
	for git@vger.kernel.org; Wed, 02 Dec 2015 20:34:32 +0100
Received: from 104-247-246-42.cpe.teksavvy.com ([104-247-246-42.cpe.teksavvy.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 20:34:32 +0100
Received: from monnier by 104-247-246-42.cpe.teksavvy.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 20:34:32 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 104-247-246-42.cpe.teksavvy.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.50 (gnu/linux)
Cancel-Lock: sha1:SkHFabsWr4PClm+VmHpBVTGvpVc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281912>

I've hacked on this for personal use, mostly, but I figured if there
could be interest in such a beast, this is probably one of the best
places to find it.

So, see attached BuGit, an issue tracking system which stores its
database in Git to try and get "distributed operation for free".

By pushing all the hard work to Git, BuGit is able to implement
a distributed bug tracking system in a simple shell script (less than
20KB so far).  It can of course do off-line operations, but it can also
share bugs between unrelated databases (e.g. if you forward a bug report
to someone else using this same system, you can keep the two bugs
sync'd, even if they may get different bug-numbers on each side).

Obviously, this is lacking in many respects.  You can get a barely
tolerable web-based UI (but only to browse bugs, not to manipulate them)
with any Git front-end, but if you really need a web-based UI it'll take
extra work.


        Stefan


#!/bin/sh

###  BuGit  ---  File-less distributed bug tracking system with Git

# The design is based on the idea of trying to represent the bug-database
# in such a way that Git's merge takes care of our own merge needs.  IOW
# Git's merge should only result in conflicts when there is a *real* conflict
# that can only be resolved by hand (e.g. two concurrent changes to the title
# of a bug).
#
# The general idea is as follows:
# - Keep messages in the metadata (more specifically the commit log), so
#   they can't generate conflicts, they're auto-merged, and the ordering
#   automatically preserved.
# - Most other data is kept in file *names* (i.e. the files themselves are
#   empty, to avoid merge conflicts).

# In BuGit, bugs can be identified in 3 ways:
# - ID: Bugs have a unique and immutable identification called "ID", usually
#   some kind of random hexadecimal number.  This is the only stable and
#   unambiguous identification.
# - NAME: Bugs have a "NAME", also known as their "title".  This is
#   a human-readable text which is expected to describe the bug concisely.
#   This property can change over time, and several bugs can have
#   the same NAME, tho this should be unusual.
# - NB: Bugs can have a number.  This is not a property of the bug, tho, in
#   the sense that the same bug can be known under different numbers in
#   different databases.  So a bug can have several different NBs, and
#   initially a bug has no NB at all (since allocation of a bug NB tends to
#   be a centralized operation).  But in a given database, a given bug
#   has at most one NB.
# If BuGit says it wants a "BUG", it means that you can give it any one of
# those kinds of identifiers.

# The database is layed out as follows:
# - Every bug lives in its own branch named "bugs/ID".
#   The branch's commit messages hold the bug's messages.
#   The branch's files are as follows:
#   - "name": simple file holding the current NAME of this bug.
#   - "attachments/<timestamp> - <name>" are attachments.
#   - "followers/<email>" are empty files whose name indicates that <email>
#     would like to receive updates on this bug.
#   - "assigned-to/<email>" are empty files whose name indicate that <email>
#     is reponsible for this bug.
#   - "tags/<tag>" are empty files indicating that <tag> is applied to the bug.
# Additionally to those bug branches, there is a "master" branch whose
# commit message are unimportant and whose files are:
# - "names/NAME/ID": empty file indicating that bug ID has name NAME.
#   This is a cache used to perform reverse lookups (from NAME to ID),
#   and it currently is not always kept up-to-date.  FIXME!
# - "numbers/NB": simple file holding the ID of bug number NB.
#
# By design, the only possible sources of conflicts when merging different
# databases are:
# - if different bugs have the same NB.
# - if a given bug ID has different names.
# - if a bug has two different attachments with the same name same timestamp
#   [ the timestamp should make this very unlikely, tho ].

## Helper functions ###########################################################

bugit_upcase () {
    echo "$@" | tr '[:lower:]' '[:upper:]'
}

bugit_make_optloop () {
    echo 'done=""'
    echo 'while [ $# -gt 0 ] && [ "" = "$done" ]; do'
    echo 'case $1 in'
    for arg in $(echo $1); do
        case $arg in
            *\=)
                argname=$(echo "$arg" | sed 's/=$//')
                echo "--${arg}*) ${argname}=\$(echo \$1 | sed 's/^[^=]*=//')"
                echo "shift ;;"
                echo "--${argname})"
                echo "[ \$# -gt 1 ] || invalid \"Missing arg for \$1 option\""
                echo "${argname}=\$2; shift 2 ;;" ;;
            *)
                echo "--${arg}) ${arg}=true; shift ;;" ;;
        esac
    done
    echo '--) done=--; shift ;;'
    echo '--*) invalid "Invalid option $1" ;;'
    echo '*) done=-- ;;'
    echo 'esac'
    echo 'done'
    shift
    while [ $# -gt 0 ]; do
        arg=$1
        case $arg in
            "...") [ $# = 1 ] || internal_error "... can only be last"
                   rest=ok ;;
            "["*"]") argname=$(echo "$arg" | sed 's/[][]//g')
                     echo "[ \$# = 0 ] || { $argname=\$1 ; shift; }" ;;
            *)
                echo "[ \$# -gt 0 ] ||"
                echo "invalid 'Missing argument $(bugit_upcase "$arg")'"
                echo "{ $arg=\$1 ; shift; }" ;;
        esac
        shift
    done
    [ "ok" = "$rest" ] ||
        echo "[ \$# = 0 ] || invalid 'Unexpected extra args:' \"\$@\""
}

invalid () {
    echo "$@"; echo
    source=$(which "$0")
    sed -ne 's|^bugit_cmd_\([^ ()]*\).*#|bugit \1|p' <"$source"
    exit 1
}

user_error () {
    echo "$@"
    exit 1
}

internal_error () { user_error "Internal error!" "$@"; }

bugit_get_id () {
    bug="$1"
    [ ! "" = "$bug" ] || user_error "Empty bug identifer!"
    if git show-ref "bugs/$bug" >/dev/null; then id="$bug"; else
        bugit_checkout_master
        if [ -f "numbers/$bug" ]; then id=$(cat "numbers/$bug"); else
            name=$(bugit_to_filename "$bug")
            ids=$(ls "names/$name" 2>/dev/null)
            case $ids in
                "") user_error "No bug by that name" ;;
                *" "*) user_error "Ambiguous name: $ids" ;;
                *) id="$ids" ;;
            esac
        fi
    fi
}

bugit_in_master_p () {
    [ "ref: refs/heads/master" = "$(cat .git/HEAD)" ]
}

bugit_get_number () {
    bugit_in_master_p || internal_error "bugit_get_number while not in master!"
    set -- $(cd numbers 2>/dev/null && grep -l "$1" * 2>/dev/null)
    if [ "$#" = 0 ]; then return 1; else number=$1; fi
}

bugit_get_name () {
    id=$1
    bugit_get_branch "$id" nomerge
    name=$(git cat-file blob "$branch:name")
    if bugit_in_master_p; then
        # Let's just double check that the "names" subdir is up-to-date
        filename=$(bugit_to_filename "$name")
        [ -f "names/$filename/$id" ] || {
            touch "names/$filename/$id"
            git add "names/$filename/$id"
            # FIXME: If bugit_get_name is called several times (as is the
            # case for "bugit list"), we'd want to combine all these commits
            # into a single one.
            git commit -m "Update name of $id"
        }
    fi
}

bugit_assert_clean_p () {
    [ "" = "$(git status --porcelain)" ] || user_error "Uncommitted changes!"
}

bugit_checkout_master () {
    bugit_in_master_p || {
        bugit_assert_clean_p
        git checkout master
    }
}

bugit_get_branch () {           # Find the branch of a given bug-id
    id=$1
    nomerge=$2
    if git show-ref -q --verify "refs/heads/bugs/$id"; then
        branch="refs/heads/bugs/$id"
    else
        branches=$(git for-each-ref --format "%(refname)" \
                       "refs/remotes/*/bugs/$id")
        set -- $branches
        case $# in
            0) user_error "No bug with id '$id'" ;;
            1) branch=$1 ;;
            *) if [ "nomerge" = "$nomerge" ]; then
                   branch=$1
               else
                   bugit_checkout_id "$id"
                   branch="refs/heads/bugs/$id"
               fi ;;
        esac
    fi
}

bugit_merge () {
    bug=$1
    branch=$2
    git merge -m Merge "$branch" ||
        user_error "Merge conflict in bug '$bug'"
}

bugit_checkout_id () {          # Checkout the branch for bug ID.
    id=$1
    bugit_assert_clean_p
    if git show-ref -q --verify "refs/heads/bugs/$id"; then
        git checkout "bugs/$id"
    else
        branches=$(git for-each-ref --format "%(refname)" \
                       "refs/remotes/*/bugs/$id")
        [ ! "" = "$branches" ] || user_error "No bug with id '$id'"
        set -- $branches
        first="$1"; shift
        git checkout -b "bugs/$id" "$first"
        for branch; do
            bugit_merge "$id" "$branch"
        done
    fi
}

bugit_author () {
    echo "$(git config --get user.name) <$(git config --get user.email)>"
}

bugit_to_branchname () {
    echo "$@" | tr ' ' '_'
}

bugit_to_filename () {
    echo "$@" | tr '/' '_'
}

bugit_to_bugname () {
    tr '_' '/'
}

bugit_generate_id () {
    uuidgen 2>/dev/null ||
        dd bs=1 count=16 </dev/urandom 2>/dev/null |
            md5sum |
            sed 's/ .*//'
}

bugit_add_attachments () {
    if [ $# -gt 0 ]; then
        # Add a timestamp to reduce the risk of conflict.
        date=$(date "+%Y-%m-%d %H:%M")
        mkdir -p attachments
        for f; do
            filename="$(date "+%Y-%m-%d %H:%M") - $(basename "$f")"
            cp "$f" "attachments/$filename"
        done
        git add attachments/
    fi
}

## Commands ###################################################################

bugit_cmd_init () {             # : Initialize a new bug database
    eval "$(bugit_make_optloop '')"
    git init "$@"
    git commit --allow-empty -m 'Initial commit'
}

bugit_cmd_new () {              # [--author AUTHOR] NAME [ATTACHMENTS...]
    eval "$(bugit_make_optloop 'author=' name ...)"
    [ ! "" = "$author" ] || author=$(bugit_author)
    id=$(bugit_generate_id)
    
    bugit_assert_clean_p
    git checkout --orphan bugs/"$id" ||
        user_error "Can't create branch 'bugs/$id'"
    git rm -rf .
    mkdir -p followers
    bugit_add_attachments "$@"
    touch followers/"$author"
    echo "$name" >name
    git add .
    git commit

    # Now record the name->id mapping in the master branch.
    git checkout master
    filename=$(bugit_to_filename "$name")
    mkdir -p names/"$filename"
    touch names/"$filename"/"$id"
    git add names/"$filename"/"$id"
    git commit -m "Add name->id mapping for $name"
}

bugit_cmd_reply () {            # [--author AUTHOR] BUG [ATTACHMENTS...]
    eval "$(bugit_make_optloop 'author=' bug ...)"
    [ ! "" = "$author" ] || author=$(bugit_author)
    bugit_get_id "$bug";
    bugit_checkout_id "$id"
    bugit_add_attachments "$@"
    git commit --allow-empty
}

bugit_cmd_show () {             # BUG : Display the bug's content
    eval "$(bugit_make_optloop '' bug)"
    bugit_get_id "$bug"
    git log --no-merges --reverse bugs/"$id"
}

bugit_cmd_list () {             # : List all bugs in the database
    eval "$(bugit_make_optloop '')"
    bugit_checkout_master
    for id in $(git branch -a --list 'bugs/*' '*/bugs/*' |
                       sed 's|^..\(.*/\)\?bugs/||' | sort -u); do
        bugit_get_name "$id" || name=""
        if bugit_get_number "$id"; then
            echo "bug#$number: $name"
        else
            echo "$id: $name"
        fi
    done
}

bugit_cmd_number () {           # BUG... : Assign numbers to bugs
    eval "$(bugit_make_optloop '' ...)"
    # TODO: Allow several BUGs at a time, or 
    [ $# -gt 0 ] ||
        # FIXME: when no BUG is specified, we should do it for all
        # un-numbered bugs.
        user_error "Have to identify bugs explicitly"
    bugit_checkout_master
    for bug; do
        bugit_get_id "$bug"
        nb=$(cd numbers 2>/dev/null && grep -l "$id" * 2>/dev/null)
        [ "" = "$nb" ] || {
            echo "Already assigned number $nb to bug '$bug'"
            continue
        }
        mkdir -p numbers
        # FIXME: Randomize this number somewhat, so that bug-numbering
        # can be done offline as well!
        last=$( (echo 0; ls numbers) | sort -n | tail -n 1)
        nb=$(($last + 1))
        echo "$id" >"numbers/$nb"
        git add "numbers/$nb"
    done
    git commit -m "Assign some bug numbers"
}

bugit_cmd_push () {             # [--subset] REMOTE [BUG]
    eval "$(bugit_make_optloop 'subset' [remote] [bug])"
    [ ! "" = "$remote" ] || remote=origin
    # FIXME: If we don't push "master", the remote "master" will have
    # an incomplete "names" subdir!  Maybe we could fix it lazily (by improving
    # the "names" cache so we can detect its staleness) or with a push-hook.
    if [ "true" = "$subset" ]; then
        [ "" = "$bug" ] || invalid "Option --subset is redundant with $bug"
        git push "$remote" 'bugs/*:bugs/*'
    elif [ "" = "$bug" ]; then
        # FIXME: We can't "--prune" here since the remote may have some new
        # branches.  That basically means there's no way to remove bugs/ID
        # since the next "bugit push" will bring it right back!
        git push --all "$remote"
    else
        bugit_get_id "$bug"
        git push "$remote" "bugs/$id:bugs/$id"
    fi
}

bugit_cmd_pull () {
    eval "$(bugit_make_optloop 'bugsonly' [remote] [bug])"
    # TODO: Same as push, with single bug, and matching bugs-only.
    [ ! "" = "$remote" ] || remote=origin

    if [ "true" = "$subset" ]; then
        [ "" = "$bug" ] || invalid "Option --subset is redundant with $bug"
        pattern="bugs/"
    elif [ "" = "$bug" ]; then
        pattern=""
    else
        bugit_get_id "$bug"
        pattern="bugs/$id"
    fi
    
    git fetch "$remote"

    for branch in $(git for-each-ref --format "%(refname)" \
                        "refs/remotes/$remote/$pattern"); do
        local=$(echo "$branch" | sed 's|refs/remotes/[^/]*/||')
        if [ "HEAD" = "$local" ]; then echo "Skipping HEAD"
        elif ! git show-ref -q --verify "refs/heads/$local"; then
            echo "branch $branch has no local equivalent"
        elif [ "" = "$(git rev-list "$local..$branch")" ]; then
            echo "branch $branch has nothing new"
        else
            bugit_assert_clean_p
            git checkout "$local"
            bugit_merge "$local" "$branch"
        fi
    done
}

bugit_cmd_id () {               # BUG : Return the id of BUG
    eval "$(bugit_make_optloop '' bug)"
    bugit_get_id "$bug"
    echo "$id"
}

bugit_cmd_name () {             # BUG : Return the name of BUG
    eval "$(bugit_make_optloop '' bug)"
    bugit_get_id "$bug"
    bugit_get_name "$id"
    echo "$name"
}

bugit_cmd_rename () {           # BUG NEWNAME
    eval "$(bugit_make_optloop '' bug newname ...)"
    bugit_get_id "$bug"
    bugit_get_name "$id"
    bugit_checkout_id "$id"
    echo "$newname" "$@" >name
    git add name
    git commit -m "Rename"
    bugit_checkout_master
    [ "" = "$name" ] ||
        rm -f "names/$(bugit_to_filename "$name")/$id"
    mkdir -p "names/$(bugit_to_filename "$newname")"
    touch "names/$(bugit_to_filename "$newname")/$id"
    git add names
    git commit -m "Rename $bug"
}

bugit_cmd_tag () {              # BUG TAG
    eval "$(bugit_make_optloop '' bug tag)"
    set -- $tag
    [ $# = 1 ] || user_error "Invalid tag name '$tag'"
    bugit_get_id "$bug"
    bugit_checkout_id "$id"
    mkdir -p tags
    touch "tags/$tag" || user_error "Invalid tag name '$tag'"
    git add "tags/$tag"
    git commit -m 'Add tag'
}

bugit_cmd_untag () {              # BUG TAG
    eval "$(bugit_make_optloop '' bug tag)"
    set -- $tag
    [ $# = 1 ] || user_error "Invalid tag name '$tag'"
    bugit_get_id "$bug"
    bugit_checkout_id "$id"
    rm -f "tags/$tag"
    git add "tags/$tag"
    git commit -m 'Remove tag'
}

bugit_cmd_taglist () {          # BUG
    eval "$(bugit_make_optloop '' bug)"
    bugit_get_id "$bug"
    bugit_get_branch "$id"
    tags=""
    echo $(git cat-file -p "$branch:tags" | while read mode type hash name; do
                  echo $name
              done)
}

bugit_cmd_assign () {           # [--only] BUG EMAIL
    eval "$(bugit_make_optloop 'only' bug email)"
    bugit_get_id "$bug"
    bugit_checkout_id "$id"
    mkdir -p assigned-to
    if [ "true" = "only" ]; then rm -f assigned-to/*; fi
    touch "assigned-to/$email" || user_error "Invalid email name '$email'"
    git add "assigned-to/"
    git commit -m 'Assign'
}

bugit_cmd_unassign () {         # BUG EMAIL
    eval "$(bugit_make_optloop '' bug email)"
    bugit_get_id "$bug"
    bugit_checkout_id "$id"
    rm -rf "assigned-to/$email"
    git add "assigned-to/"
    git commit -m 'Unassign'
}

bugit_cmd_assigned () {         # BUG
    eval "$(bugit_make_optloop '' bug)"
    bugit_get_id "$bug"
    bugit_get_branch "$id"
    git cat-file -p "$branch:assigned-to" | while read mode type hash name; do
        echo "$name"
    done
}

bugit_cmd_follow () {           # BUG EMAIL
    eval "$(bugit_make_optloop '' bug email)"
    bugit_get_id "$bug"
    bugit_checkout_id "$id"
    mkdir -p followers
    touch "followers/$email" || user_error "Invalid email name '$email'"
    git add "followers/"
    git commit -m 'Add follower'
}

# TODO: Severity
# 

[ "$#" -gt 0 ] || invalid "BuGit usage:"
cmd=$1; shift

type "bugit_cmd_$cmd" >/dev/null ||
    invalid "Unknown BuGit command '$cmd'"

"bugit_cmd_$cmd" "$@"
