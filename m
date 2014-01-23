From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC PATCH 2/1] Make request-pull able to take a refspec of form
 local:remote
Date: Wed, 22 Jan 2014 16:06:32 -0800 (PST)
Message-ID: <alpine.LFD.2.11.1401221535140.18207@i7.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tejun Heo <tj@kernel.org>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 01:06:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W67on-0001GL-FL
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 01:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290AbaAWAGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 19:06:44 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:62354 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127AbaAWAGo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 19:06:44 -0500
Received: by mail-pb0-f45.google.com with SMTP id un15so1089043pbc.4
        for <git@vger.kernel.org>; Wed, 22 Jan 2014 16:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:user-agent:mime-version
         :content-type;
        bh=dRy3wY36vPsbjq1FWYl3B/T4GGwmuS25vQ2XE8tmOuQ=;
        b=uIa8kBp5JwrdUUh9Y51h3iauh07l42oANzBa+4OCBz6v+obXAhb9clwP+FSd7uORR2
         /ZE7lbfq8NTjGqdaUKypbC871KC9sl8Rn7HGZofi8Nf7fPWBYx4IP+OEtC3ANDdKHMRI
         jp3FyrY0kycLaDNfng9UO2JzKSStyn2vUhX2+HjTsw4wVck/QwTr/TBuFrVEQBJE9Qf5
         r2cmaWpSW2yxb48e8XAre+dIejy/EndPCu6dWDKrMjcfuOqTP8ojD4IEW0zHj8iNAZ4z
         6y2Clzga/qnNczYBSrWMrJ7Tkq5kcY24s8fLmgo4X6qkreCGKY9ZennHsMfLsSA06VHV
         jhAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=sender:date:from:to:cc:subject:message-id:user-agent:mime-version
         :content-type;
        bh=dRy3wY36vPsbjq1FWYl3B/T4GGwmuS25vQ2XE8tmOuQ=;
        b=NMre9pFl2UGhTqH3MXokOqRw5uMnN8gqp2i98kfucBMMdus6J/9+qLjOwPYwOzpdhc
         9FaoeECCNaaY62pF6sDIp6FRL/pos5xffvWPj1GlT8eQY/Y8jUru/0Msn6AWcMjeBnyj
         PvIPjRFOVOKHDJfTGw5W5oW/COOg3hnvvSNT4=
X-Received: by 10.68.108.130 with SMTP id hk2mr4806976pbb.16.1390435603595;
        Wed, 22 Jan 2014 16:06:43 -0800 (PST)
Received: from [192.168.0.44] (c-24-22-13-12.hsd1.or.comcast.net. [24.22.13.12])
        by mx.google.com with ESMTPSA id xv2sm28537540pbb.39.2014.01.22.16.06.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 22 Jan 2014 16:06:42 -0800 (PST)
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240886>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Jan 2014 15:23:48 -0800
Subject: [PATCH] Make request-pull able to take a refspec of form local:remote

This allows a user to say that a local branch has a different name on
the remote server, using the same syntax that "git push" uses to create
that situation.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

So this relaxes the remote matching, and allows using the "local:remote" 
syntax to say that the local branch is differently named from the remote 
one.

It is probably worth folding it into the previous patch if you think this 
whole approach is workable.

 git-request-pull.sh | 50 +++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 659a412155d8..c8ab0e912011 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -47,19 +47,23 @@ fi
 
 #
 # $3 must be a symbolic ref, a unique ref, or
-# a SHA object expression
+# a SHA object expression. It can also be of
+# the format 'local-name:remote-name'.
 #
-head=$(git symbolic-ref -q "${3-HEAD}")
-head=${head:-$(git show-ref "${3-HEAD}" | cut -d' ' -f2)}
-head=${head:-$(git rev-parse --quiet --verify "$3")}
+local=${3%:*}
+local=${local:-HEAD}
+remote=${3#*:}
+head=$(git symbolic-ref -q "$local")
+head=${head:-$(git show-ref --heads --tags "$local" | cut -d' ' -f2)}
+head=${head:-$(git rev-parse --quiet --verify "$local")}
 
 # None of the above? Bad.
-test -z "$head" && die "fatal: Not a valid revision: $3"
+test -z "$head" && die "fatal: Not a valid revision: $local"
 
 # This also verifies that the resulting head is unique:
 # "git show-ref" could have shown multiple matching refs..
 headrev=$(git rev-parse --verify --quiet "$head"^0)
-test -z "$headrev" && die "fatal: Ambiguous revision: $3"
+test -z "$headrev" && die "fatal: Ambiguous revision: $local"
 
 # Was it a branch with a description?
 branch_name=${head#refs/heads/}
@@ -69,9 +73,6 @@ then
 	branch_name=
 fi
 
-prettyhead=${head#refs/}
-prettyhead=${prettyhead#heads/}
-
 merge_base=$(git merge-base $baserev $headrev) ||
 die "fatal: No commits in common between $base and $head"
 
@@ -81,30 +82,37 @@ die "fatal: No commits in common between $base and $head"
 #
 # Otherwise find a random ref that matches $headrev.
 find_matching_ref='
-	my ($exact,$found);
+	my ($head,$headrev) = (@ARGV);
+	my ($found);
+
 	while (<STDIN>) {
+		chomp;
 		my ($sha1, $ref, $deref) = /^(\S+)\s+([^^]+)(\S*)$/;
-		next unless ($sha1 eq $ARGV[1]);
-		if ($ref eq $ARGV[0]) {
-			$exact = $ref;
+		my ($pattern);
+		next unless ($sha1 eq $headrev);
+
+		$pattern="/$head\$";
+		if ($ref eq $head) {
+			$found = $ref;
+		}
+		if ($ref =~ /$pattern/) {
+			$found = $ref;
 		}
-		if ($sha1 eq $ARGV[0]) {
+		if ($sha1 eq $head) {
 			$found = $sha1;
 		}
 	}
-	if ($exact) {
-		print "$exact\n";
-	} elsif ($found) {
+	if ($found) {
 		print "$found\n";
 	}
 '
 
-ref=$(git ls-remote "$url" | @@PERL@@ -e "$find_matching_ref" "$head" "$headrev")
+ref=$(git ls-remote "$url" | @@PERL@@ -e "$find_matching_ref" "${remote:-HEAD}" "$headrev")
 
 if test -z "$ref"
 then
-	echo "warn: No match for $prettyhead found at $url" >&2
-	echo "warn: Are you sure you pushed '$prettyhead' there?" >&2
+	echo "warn: No match for commit $headrev found at $url" >&2
+	echo "warn: Are you sure you pushed '${remote:-HEAD}' there?" >&2
 	status=1
 fi
 
@@ -116,7 +124,7 @@ git show -s --format='The following changes since commit %H:
 
 are available in the git repository at:
 ' $merge_base &&
-echo "  $url $prettyhead" &&
+echo "  $url $remote" &&
 git show -s --format='
 for you to fetch changes up to %H:
 
-- 
1.9.rc0.10.gf0799f9.dirty
