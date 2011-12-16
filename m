From: Junio C Hamano <gitster@pobox.com>
Subject: Re* How to generate pull-request with info of signed tag
Date: Fri, 16 Dec 2011 08:56:14 -0800
Message-ID: <7vbor8jw0h.fsf@alter.siamese.dyndns.org>
References: <874nx1korf.fsf@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 17:56:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbb55-0003GD-0W
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 17:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759892Ab1LPQ4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 11:56:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46286 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189Ab1LPQ4S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 11:56:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23DEB738D;
	Fri, 16 Dec 2011 11:56:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YGU7A3ggv5Y51qfONKiex+Nnhy0=; b=Q1tE6Z
	P/DQWAbiYh21+tnhI5Nj0kc0f4sZ827ZORLoTX6sD5SHsbXx6o4QVrV0cU61otuS
	Uy2AWSGbm4TvcM/rbjOZLFEs31NsxyUOnVcfuUT4ZAWjljVxHXc6KB6DFuhiReso
	KpmVpUCTr953PdFBBytXuW+gd97o9RBGEUyHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CSglw6V//Xelt3viSNkukyYpiBE8Oqnb
	qn561pdSdpEdFEBH7DRk7iVL0v4XcLnYn8PizA+jW2xytmol7YvMfmR51R1A/QWd
	ajZymQ+XSFvgPH7zzV6g4KHlI/Nx395P+GKycSXqxZ7bqnAvQjxv09F/nN4mCwZ7
	X9LPLKsPULY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AF30738C;
	Fri, 16 Dec 2011 11:56:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6DC6A738B; Fri, 16 Dec 2011
 11:56:16 -0500 (EST)
In-Reply-To: <874nx1korf.fsf@linux.vnet.ibm.com> (Aneesh Kumar K. V.'s
 message of "Fri, 16 Dec 2011 12:05:16 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DE6FBC34-2806-11E1-B946-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187286>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> I am using git from master branch and wanted to try the signed pull
> request. I have pushed the signed tag to repo.or.cz, but not sure how to
> generate pull request with signed tag information?

The correct script should grok the following command line:

 $ git request-pull v1.7.7.4 git://git.kernel.org/pub/scm/git/git.git v1.7.7.5

and include

    are available in the git repository at

      git://git.kernel.org/.../git.git tag v1.7.7.5

    for you to fetch changes up to 66c1...

but we didn't loosen the code that inspects the publishing repository to
allow asking for a tag that points at an older part of the history to be
pulled.

Here is an update.
-- >8 --
Subject: request-pull: update the "pull" command generation logic

The old code that insisted on asking for the tip of a branch to be pulled
were not updated when we started allowing for a tag to be pulled. When a
tag points at an older part of the history and there is no branch that
points at the tagged commit, the script failed to say which ref is to be
pulled.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-request-pull.sh |   46 +++++++++++++++++++++++++++++++++++++---------
 1 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index c6a5b7a..7b5c777 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -57,12 +57,40 @@ headrev=$(git rev-parse --verify "$head"^0) || exit
 merge_base=$(git merge-base $baserev $headrev) ||
 die "fatal: No commits in common between $base and $head"
 
-find_matching_branch="/^$headrev	"'refs\/heads\//{
-	s/^.*	refs\/heads\///
-	p
-	q
-}'
-branch=$(git ls-remote "$url" | sed -n -e "$find_matching_branch")
+# $head is the token given from the command line. If a ref with that
+# name exists at the remote and their values match, we should use it.
+# Otherwise find a ref that matches $headrev.
+find_matching_ref='
+	sub abbr {
+		my $ref = shift;
+		if ($ref =~ s|refs/heads/||) {
+			return $ref;
+		} elsif ($ref =~ s|refs/tags/||) {
+			return "tag $ref";
+		} else {
+			return $ref;
+		}
+	}
+
+	my ($exact, $found);
+	while (<STDIN>) {
+		my ($sha1, $ref, $deref) = /^(\S+)\s+(\S+?)(\^\{\})?$/;
+		next unless ($sha1 eq $ARGV[1]);
+		$found = abbr($ref);
+		if ($ref =~ m|/\Q$ARGV[0]\E$|) {
+			$exact = $found;
+			last;
+		}
+	}
+	if ($exact) {
+		print "$exact\n";
+	} elsif ($found) {
+		print "$found\n";
+	}
+'
+
+ref=$(git ls-remote "$url" | perl -e "$find_matching_ref" "$head" "$headrev")
+
 url=$(git ls-remote --get-url "$url")
 
 git show -s --format='The following changes since commit %H:
@@ -71,7 +99,7 @@ git show -s --format='The following changes since commit %H:
 
 are available in the git repository at:
 ' $baserev &&
-echo "  $url${branch+ $branch}" &&
+echo "  $url${ref+ $ref}" &&
 git show -s --format='
 for you to fetch changes up to %H:
 
@@ -81,7 +109,7 @@ for you to fetch changes up to %H:
 
 if test -n "$branch_name"
 then
-	echo "(from the branch description for $branch local branch)"
+	echo "(from the branch description for $branch_name local branch)"
 	echo
 	git config "branch.$branch_name.description"
 fi &&
@@ -101,7 +129,7 @@ fi &&
 git shortlog ^$baserev $headrev &&
 git diff -M --stat --summary $patch $merge_base..$headrev || status=1
 
-if test -z "$branch"
+if test -z "$ref"
 then
 	echo "warn: No branch of $url is at:" >&2
 	git show -s --format='warn:   %h: %s' $headrev >&2
