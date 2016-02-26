From: Mathias Nyman <m.nyman@iki.fi>
Subject: Re: [PATCH] contrib/subtree: add repo url to commit messages
Date: Fri, 26 Feb 2016 10:28:28 +0200
Message-ID: <20160226082828.GA5960@iki.fi>
References: <20160223102559.GA18668@iki.fi>
 <CAPig+cSwQmbvZYbk3T-XYDfMYaMdJ=bFbDwEUtaR121pBrYJOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Nicola Paolucci <npaolucci@atlassian.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 09:28:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZDlQ-0002Iw-E4
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 09:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbcBZI2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 03:28:37 -0500
Received: from mail.kapsi.fi ([217.30.184.167]:39816 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750935AbcBZI2g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 03:28:36 -0500
Received: from lakka.kapsi.fi ([2001:1bc8:1004::1] ident=Debian-exim)
	by mail.kapsi.fi with esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <lem@kapsi.fi>)
	id 1aZDlE-0001VH-Ps; Fri, 26 Feb 2016 10:28:28 +0200
Received: from lem by lakka.kapsi.fi with local (Exim 4.80)
	(envelope-from <lem@lakka.kapsi.fi>)
	id 1aZDlE-0007qd-M0; Fri, 26 Feb 2016 10:28:28 +0200
Content-Disposition: inline
In-Reply-To: <CAPig+cSwQmbvZYbk3T-XYDfMYaMdJ=bFbDwEUtaR121pBrYJOQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:1bc8:1004::1
X-SA-Exim-Mail-From: lem@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287552>

On 2016-02-25 17:23-0500, Eric Sunshine wrote:
>On Tue, Feb 23, 2016 at 5:25 AM, Mathias Nyman <mathias.nyman@iki.fi> wrote:
>> For recalling where a subtree came from; git-subtree operations 'add'
>> and 'pull', when called with the <repository> parameter add this to the
>> commit message:
>>     git-subtree-repo: <repo_url>
>>
>> Other operations that don't have the <repository> information, like
>> 'merge' and 'add' without <repository>, are unchanged. Users with such a
>> workflow will continue to be on their own with the --message parameter,
>> if they'd like to record where the subtree came from.
>
>I'm not a subtree user, so review comments below are superficial...
>

Thank you for reviewing; will send PATCH v2 shortly.

>> Signed-off-by: Mathias Nyman <mathias.nyman@iki.fi>
>> Based-on-patch-by: Nicola Paolucci <npaolucci@atlassian.com>
>> ---
>> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
>> @@ -335,18 +335,21 @@ add_msg()
>>         dir="$1"
>>         latest_old="$2"
>>         latest_new="$3"
>> +       repo="$4" # optional
>>         if [ -n "$message" ]; then
>>                 commit_message="$message"
>>         else
>>                 commit_message="Add '$dir/' from commit '$latest_new'"
>>         fi
>> -       cat <<-EOF
>> -               $commit_message
>> -
>> -               git-subtree-dir: $dir
>> -               git-subtree-mainline: $latest_old
>> -               git-subtree-split: $latest_new
>> -       EOF
>> +       echo $commit_message
>> +       echo
>> +       echo git-subtree-dir: $dir
>> +       echo git-subtree-mainline: $latest_old
>> +       echo git-subtree-split: $latest_new
>
>It's not clear why this code was changed to use a series of echo's in
>place of the single cat. Although the net result is the same, this
>appears to be mere code churn. If your intention was to make it
>similar to how squash_msg() uses a series of echo's, then that might
>make sense, however, rejoin_msg() uses the same single 'cat' as
>add_msg(), so inconsistency remains. Thus, it's not clear what the
>intention is.
>

Using a mixutre of heredoc and echo felt messy. But I'll change it
back to heredoc here, and through out the commit aim for near-zero
refactoring.

>> +       if [ -n "$repo" ]; then
>> +               repo_url=$(get_repository_url "$repo")
>> +               echo "git-subtree-repo: $repo_url"
>> +       fi
>>  }
>>
>>  add_squashed_msg()
>> @@ -382,8 +385,9 @@ squash_msg()
>>         dir="$1"
>>         oldsub="$2"
>>         newsub="$3"
>> +       repo="$4" # optional
>>         newsub_short=$(git rev-parse --short "$newsub")
>> -
>> +
>
>Okay, this change is removing an unnecessary tab. Perhaps the commit
>message can say that the patch fixes a few whitespace inconsistencies
>while touching nearby code.
>
>More below...
>

Will undo the whitespace fixing.

>>         if [ -n "$oldsub" ]; then
>>                 oldsub_short=$(git rev-parse --short "$oldsub")
>>                 echo "Squashed '$dir/' changes from $oldsub_short..$newsub_short"
>> @@ -397,6 +401,10 @@ squash_msg()
>>         echo
>>         echo "git-subtree-dir: $dir"
>>         echo "git-subtree-split: $newsub"
>> +       if [ -n "$repo" ]; then
>> +               repo_url=$(get_repository_url "$repo")
>> +               echo "git-subtree-repo: $repo_url"
>> +       fi
>>  }
>>
>>  toptree_for_commit()
>> @@ -440,12 +448,13 @@ new_squash_commit()
>>         old="$1"
>>         oldsub="$2"
>>         newsub="$3"
>> +       repo="$4" # optional
>>         tree=$(toptree_for_commit $newsub) || exit $?
>>         if [ -n "$old" ]; then
>> -               squash_msg "$dir" "$oldsub" "$newsub" |
>> +               squash_msg "$dir" "$oldsub" "$newsub" "$repo" |
>>                         git commit-tree "$tree" -p "$old" || exit $?
>>         else
>> -               squash_msg "$dir" "" "$newsub" |
>> +               squash_msg "$dir" "" "$newsub" "$repo" |
>>                         git commit-tree "$tree" || exit $?
>>         fi
>>  }
>> @@ -517,6 +526,16 @@ ensure_valid_ref_format()
>>             die "'$1' does not look like a ref"
>>  }
>>
>> +get_repository_url()
>> +{
>> +       repo=$1
>> +       repo_url=$(git config --get remote.$repo.url)
>> +       if [ -z "$repo_url" ]; then
>> +               repo_url=$repo
>> +       fi
>> +       echo $repo_url
>> +}
>> +
>>  cmd_add()
>>  {
>>         if [ -e "$dir" ]; then
>> @@ -548,19 +567,18 @@ cmd_add()
>>  cmd_add_repository()
>>  {
>>         echo "git fetch" "$@"
>> -       repository=$1
>> +       repo=$1
>
>Hmm, so 'repository' was present already but unused in this function,
>and now you're using it. I suppose you renamed it 'repo' for
>consistency with other 'repo' variable the patch introduces elsewhere.
>

Yes.

>>         refspec=$2
>>         git fetch "$@" || exit $?
>>         revs=FETCH_HEAD
>> -       set -- $revs
>> +       set -- $revs $repo
>>         cmd_add_commit "$@"
>
>The original code intentionally allowed passing a set of revs to
>cmd_add_commit(), however, you've repurposed it (below) so that it
>accepts one rev and an (optional) repo. Therefore, there doesn't seem
>to be much value anymore to using "set --" when you could just do:
>
>    cmd_add_commit $revs $repo
>
>Or am I missing something obvious?
>
>(Of course, the original code unconditionally used "set --" even while
>setting 'revs' to hardcoded FETCH_HEAD, so I suppose this isn't any
>worse, but still...)
>

Will leave this as is; your suggestion would mean refactoring the 'set
--' quirks, which I tried not to do.

>>  }
>>
>>  cmd_add_commit()
>>  {
>> -       revs=$(git rev-parse $default --revs-only "$@") || exit $?
>> -       set -- $revs
>> -       rev="$1"
>> +       rev=$(git rev-parse $default --revs-only "$1") || exit $?
>
>An audit of call callers of cmd_add_commit() shows that it was only
>ever invoked with a single rev, so this change to make it accept a
>single rev plus an optional repo seems safe. However, I wonder if it
>would make sense to keep the more flexible interface (in case future
>callers might need the functionality) by passing repo in as the first
>argument (using an empty string, for instance, for the optional bit)
>and then taking all subsequent arguments as revs, but perhaps that's
>overkill since it doesn't seem to care about revs other than the first
>one.
>

I think it makes sense to refactor the general 'set --' dance in
git-subtree.sh all together.

>cmd_merge() still goes through the "set --" dance which you've removed
>here, even though an audit of all its callers pass in only a single
>rev, so that seems inconsistent...
>

I'll readd this 'set --' dance here for consistency.

>> +       repo="$2" # optional
>>
>>         debug "Adding $dir as '$rev'..."
>>         git read-tree --prefix="$dir" $rev || exit $?
>> @@ -575,12 +593,12 @@ cmd_add_commit()
>>         fi
>>
>>         if [ -n "$squash" ]; then
>> -               rev=$(new_squash_commit "" "" "$rev") || exit $?
>> +               rev=$(new_squash_commit "" "" "$rev" "$repo") || exit $?
>>                 commit=$(add_squashed_msg "$rev" "$dir" |
>>                          git commit-tree $tree $headp -p "$rev") || exit $?
>>         else
>>                 revp=$(peel_committish "$rev") &&
>> -               commit=$(add_msg "$dir" "$headrev" "$rev" |
>> +               commit=$(add_msg "$dir" "$headrev" "$rev" "$repo" |
>>                          git commit-tree $tree $headp -p "$revp") || exit $?
>>         fi
>>         git reset "$commit" || exit $?
>> @@ -609,7 +627,8 @@ cmd_split()
>>         else
>>                 unrevs="$(find_existing_splits "$dir" "$revs")"
>>         fi
>> -
>> +e
>
>So, you're replacing a line containing a single tab with a line
>containing a single 'e'. Seems fishy.
>

Great typo find!

>> +       rev="$1"
>>         # We can't restrict rev-list to only $dir here, because some of our
>>         # parents have the $dir contents the root, and those won't match.
>>         # (and rev-list --follow doesn't seem to solve this)
>> @@ -683,15 +702,20 @@ cmd_split()
>>
>>  cmd_merge()
>>  {
>> -       revs=$(git rev-parse $default --revs-only "$@") || exit $?
>> +       revs=$(git rev-parse $default --revs-only "$1") || exit $?
>
>Why is this variable still named 'revs' (plural) since you're only
>passing in $1 now rather than $@?
>

Because technically the result can still be more then one rev I guess.
Consider 'git rev-parse HEAD~1..HEAD', which would return two hashes.

>>         ensure_clean
>> -
>>         set -- $revs
>
>Do you still need this "set --" or am I missing something?
>
>>         if [ $# -ne 1 ]; then
>>                 die "You must provide exactly one revision.  Got: '$revs'"
>>         fi
>
>Ditto with the conditional, considering that you only ever look at $1
>now rather than $@.
>

This will handle the case where 'git rev-parse' caught more than one
hash earlier.

>> +       do_merge "$@"
>> +}
>> +
>> +do_merge()
>> +{
>>         rev="$1"
>> -
>> +       repo="$2" # optional
>> +
>>         if [ -n "$squash" ]; then
>>                 first_split="$(find_latest_squash "$dir")"
>>                 if [ -z "$first_split" ]; then
>> @@ -704,7 +728,7 @@ cmd_merge()
>>                         say "Subtree is already at commit $rev."
>>                         exit 0
>>                 fi
>> -               new=$(new_squash_commit "$old" "$sub" "$rev") || exit $?
>> +               new=$(new_squash_commit "$old" "$sub" "$rev" "$repo") || exit $?
>>                 debug "New squash commit: $new"
>>                 rev="$new"
>>         fi
>> @@ -730,12 +754,13 @@ cmd_pull()
>>         if [ $# -ne 2 ]; then
>>             die "You must provide <repository> <ref>"
>>         fi
>> +       repo=$1
>>         ensure_clean
>>         ensure_valid_ref_format "$2"
>>         git fetch "$@" || exit $?
>>         revs=FETCH_HEAD
>> -       set -- $revs
>> -       cmd_merge "$@"
>> +       set -- $revs $repo
>> +       do_merge "$@"
>
>Same question as above. Is "set --" still buying you anything over just:
>
>    do_merge $revs $repo
>
>?
>

No. But I will not deviate from the function parameter passing method
('set --') used throughout git-subtree.sh in this commit. I do think
parameter passing in git-subtree.sh deserves a separate
no-functional-changes refactoring commit though.

>>  }
>>
>>  cmd_push()
>> --
>> 2.7.1
