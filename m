From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC PATCH] Make 'git request-pull' more strict about matching
 local/remote branches
Date: Wed, 22 Jan 2014 13:08:54 -0800 (PST)
Message-ID: <alpine.LFD.2.11.1401221243090.18459@i7.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tejun Heo <tj@kernel.org>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 22 22:09:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6531-0000xb-0Z
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 22:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348AbaAVVJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 16:09:13 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:63912 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720AbaAVVJL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 16:09:11 -0500
Received: by mail-pa0-f52.google.com with SMTP id bj1so930224pad.11
        for <git@vger.kernel.org>; Wed, 22 Jan 2014 13:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:user-agent:mime-version
         :content-type;
        bh=Q5DiFPY1ff6D9qAHx402+1DX6svIeEAKUA6NC88sdpU=;
        b=GPqFfUAr/E+JwBi2eTpT/U0FOEnfs3yQhhWfTOhaeovZOIJiA0MFwZZh9EblPw5Aiv
         d0S0Q7t+y3eg2igFvtrAAnrivbAWNfZsNCqDme0eTw/hOduEcwyXTMUaocDbk/oqMjXV
         xMLlGEkn2AFZTP38raiYgRL+V4Mm2hjdRYv93b03GqWplchW/h0shTZEmcMj7QL8NH83
         tm1VmIKyEEam0zQdWae4ZJrK1i17YV2pRbtaShpx71QhIYrWhqP+oo78+sKiJhg4I03b
         Ezvw9L+kB6EuZeeURqcMBeZAkF9Sa40e3zA9adBnT4NBO8Vq1aeCce4crA8WN32eqzLE
         z9gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=sender:date:from:to:cc:subject:message-id:user-agent:mime-version
         :content-type;
        bh=Q5DiFPY1ff6D9qAHx402+1DX6svIeEAKUA6NC88sdpU=;
        b=V1azpkla4X0E3y2CDjSUFYFb1CsIu81qPPjaSZ8SMh6yKosiAPmIJTfgnEeoMtuuRz
         6+89yrhhkvJ0hRvXmnVmG2LXP0cvT5Dy2uJwlNfPzL9UVXSHbgfgx73OqpqxNJbKScf7
         IYA7GeBn/wBO9sZkdqYTlfWcHfOpMlFniJ+X4=
X-Received: by 10.66.159.132 with SMTP id xc4mr3967885pab.27.1390424950749;
        Wed, 22 Jan 2014 13:09:10 -0800 (PST)
Received: from [192.168.0.44] (c-24-22-13-12.hsd1.or.comcast.net. [24.22.13.12])
        by mx.google.com with ESMTPSA id de3sm27227117pbb.33.2014.01.22.13.09.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 22 Jan 2014 13:09:10 -0800 (PST)
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240860>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Jan 2014 12:32:30 -0800
Subject: [PATCH] Make 'git request-pull' more strict about matching
 local/remote branches

The current 'request-pull' will try to find matching commit on the given 
remote, and rewrite the "please pull" line to match that remote ref.

That may be very helpful if your local tree doesn't match the layout of 
the remote branches, but for the common case it's been a recurring 
disaster, when "request-pull" is done against a delayed remote update, and 
it rewrites the target branch randomly to some other branch name that 
happens to have the same expected SHA1 (or more commonly, leaves it 
blank).

To avoid that recurring problem, this changes "git request-pull" so that 
it matches the ref name to be pulled against the *local* repository, and 
then warns if the remote repository does not have that exact same branch 
or tag name and content.

This means that git request-pull will never rewrite the ref-name you gave 
it.  If the local branch name is "xyzzy", that is the only branch name 
that request-pull will ask the other side to fetch.

If the remote has that branch under a different name, that's your problem 
and git request-pull will not try to fix it up (but git request-pull will 
warn about the fact that no exact matching branch is found, and you can 
edit the end result to then have the remote name you want if it doesn't 
match your local one).

The new "find local ref" code will also complain loudly if you give an
ambiguous refname (eg you have both a tag and a branch with that same
name, and you don't specify "heads/name" or "tags/name").

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This should fix the problem we've had multiple times with kernel 
maintainers, where "git request-pull" ends up leaving the target branch 
name blank, because people either forgot to push it, or (more commonly) 
people pushed it just before doing the pull request, and it hadn't 
actually had time to mirror out to the public site.

Now, git request-pull will *warn* about the fact that the matching ref 
isn't found on the remote (and the new matching code is stricter at that), 
but it will never try to re-write the branch name that it asks the other 
end to pull.

So if the remote branch doesn't exist, you'll get a warning, but the pull 
request will still have the branch you specified.

The whole checking thing is both simplified (removing more lines than it 
adds) and made more strict.

Comments? It passes the tests I put it through locally, but I did *not* 
make it pass the test-suite, since it very much does change the rules. 
Some of the test suite code literally tests for the old completely broken 
case (at least t5150, subtests 4 and 5).

Thus the RFC part. Because the currect git request-pull behavior has been 
horrible.

 git-request-pull.sh | 110 ++++++++++++++++++++--------------------------------
 1 file changed, 43 insertions(+), 67 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index fe21d5db631c..659a412155d8 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -35,20 +35,7 @@ do
 	shift
 done
 
-base=$1 url=$2 head=${3-HEAD} status=0 branch_name=
-
-headref=$(git symbolic-ref -q "$head")
-if git show-ref -q --verify "$headref"
-then
-	branch_name=${headref#refs/heads/}
-	if test "z$branch_name" = "z$headref" ||
-		! git config "branch.$branch_name.description" >/dev/null
-	then
-		branch_name=
-	fi
-fi
-
-tag_name=$(git describe --exact "$head^0" 2>/dev/null)
+base=$1 url=$2 status=0
 
 test -n "$base" && test -n "$url" || usage
 
@@ -58,55 +45,68 @@ then
     die "fatal: Not a valid revision: $base"
 fi
 
+#
+# $3 must be a symbolic ref, a unique ref, or
+# a SHA object expression
+#
+head=$(git symbolic-ref -q "${3-HEAD}")
+head=${head:-$(git show-ref "${3-HEAD}" | cut -d' ' -f2)}
+head=${head:-$(git rev-parse --quiet --verify "$3")}
+
+# None of the above? Bad.
+test -z "$head" && die "fatal: Not a valid revision: $3"
+
+# This also verifies that the resulting head is unique:
+# "git show-ref" could have shown multiple matching refs..
 headrev=$(git rev-parse --verify --quiet "$head"^0)
-if test -z "$headrev"
+test -z "$headrev" && die "fatal: Ambiguous revision: $3"
+
+# Was it a branch with a description?
+branch_name=${head#refs/heads/}
+if test "z$branch_name" = "z$headref" ||
+	! git config "branch.$branch_name.description" >/dev/null
 then
-    die "fatal: Not a valid revision: $head"
+	branch_name=
 fi
 
+prettyhead=${head#refs/}
+prettyhead=${prettyhead#heads/}
+
 merge_base=$(git merge-base $baserev $headrev) ||
 die "fatal: No commits in common between $base and $head"
 
-# $head is the token given from the command line, and $tag_name, if
-# exists, is the tag we are going to show the commit information for.
-# If that tag exists at the remote and it points at the commit, use it.
-# Otherwise, if a branch with the same name as $head exists at the remote
-# and their values match, use that instead.
+# $head is the refname from the command line.
+# If a ref with the same name as $head exists at the remote
+# and their values match, use that.
 #
 # Otherwise find a random ref that matches $headrev.
 find_matching_ref='
-	sub abbr {
-		my $ref = shift;
-		if ($ref =~ s|^refs/heads/|| || $ref =~ s|^refs/tags/|tags/|) {
-			return $ref;
-		} else {
-			return $ref;
-		}
-	}
-
-	my ($tagged, $branch, $found);
+	my ($exact,$found);
 	while (<STDIN>) {
-		my ($sha1, $ref, $deref) = /^(\S+)\s+(\S+?)(\^\{\})?$/;
+		my ($sha1, $ref, $deref) = /^(\S+)\s+([^^]+)(\S*)$/;
 		next unless ($sha1 eq $ARGV[1]);
-		$found = abbr($ref);
-		if ($deref && $ref eq "tags/$ARGV[2]") {
-			$tagged = $found;
-			last;
+		if ($ref eq $ARGV[0]) {
+			$exact = $ref;
 		}
-		if ($ref =~ m|/\Q$ARGV[0]\E$|) {
-			$exact = $found;
+		if ($sha1 eq $ARGV[0]) {
+			$found = $sha1;
 		}
 	}
-	if ($tagged) {
-		print "$tagged\n";
-	} elsif ($exact) {
+	if ($exact) {
 		print "$exact\n";
 	} elsif ($found) {
 		print "$found\n";
 	}
 '
 
-ref=$(git ls-remote "$url" | @@PERL@@ -e "$find_matching_ref" "$head" "$headrev" "$tag_name")
+ref=$(git ls-remote "$url" | @@PERL@@ -e "$find_matching_ref" "$head" "$headrev")
+
+if test -z "$ref"
+then
+	echo "warn: No match for $prettyhead found at $url" >&2
+	echo "warn: Are you sure you pushed '$prettyhead' there?" >&2
+	status=1
+fi
 
 url=$(git ls-remote --get-url "$url")
 
@@ -116,7 +116,7 @@ git show -s --format='The following changes since commit %H:
 
 are available in the git repository at:
 ' $merge_base &&
-echo "  $url${ref+ $ref}" &&
+echo "  $url $prettyhead" &&
 git show -s --format='
 for you to fetch changes up to %H:
 
@@ -129,34 +129,10 @@ then
 	echo "(from the branch description for $branch_name local branch)"
 	echo
 	git config "branch.$branch_name.description"
-fi &&
-
-if test -n "$tag_name"
-then
-	if test -z "$ref" || test "$ref" != "tags/$tag_name"
-	then
-		echo >&2 "warn: You locally have $tag_name but it does not (yet)"
-		echo >&2 "warn: appear to be at $url"
-		echo >&2 "warn: Do you want to push it there, perhaps?"
-	fi
-	git cat-file tag "$tag_name" |
-	sed -n -e '1,/^$/d' -e '/^-----BEGIN PGP /q' -e p
-	echo
-fi &&
-
-if test -n "$branch_name" || test -n "$tag_name"
-then
 	echo "----------------------------------------------------------------"
 fi &&
 
 git shortlog ^$baserev $headrev &&
 git diff -M --stat --summary $patch $merge_base..$headrev || status=1
 
-if test -z "$ref"
-then
-	echo "warn: No branch of $url is at:" >&2
-	git show -s --format='warn:   %h: %s' $headrev >&2
-	echo "warn: Are you sure you pushed '$head' there?" >&2
-	status=1
-fi
 exit $status
-- 
1.9.rc0.7.gd9bb4be.dirty
