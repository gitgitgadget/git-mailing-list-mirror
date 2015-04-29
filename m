From: Jeff King <peff@peff.net>
Subject: Re: Bug report : bad filter-branch (OSX only)
Date: Wed, 29 Apr 2015 11:48:58 -0400
Message-ID: <20150429154857.GA13518@peff.net>
References: <CAM=W1NkZr6o-DCxXskeWC8xjRMiT2P9qXeeUe91qLBqOxzqNtg@mail.gmail.com>
 <20150428055506.GJ24580@peff.net>
 <CAM=W1NnR2-T7vpMSM-3-VypnR-T235tMudyjJowtj5utNmoKNQ@mail.gmail.com>
 <20150429043947.GA10702@peff.net>
 <20150429045600.GA10781@peff.net>
 <xmqqy4lbtrvj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Olivier ROLAND <cyrus-dev@edla.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 17:49:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnUEZ-00011d-EP
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 17:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031767AbbD2PtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 11:49:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:51649 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030254AbbD2PtB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 11:49:01 -0400
Received: (qmail 6407 invoked by uid 102); 29 Apr 2015 15:49:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 10:49:01 -0500
Received: (qmail 27332 invoked by uid 107); 29 Apr 2015 15:49:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 11:49:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Apr 2015 11:48:58 -0400
Content-Disposition: inline
In-Reply-To: <xmqqy4lbtrvj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267977>

On Tue, Apr 28, 2015 at 10:39:44PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm not sure of a solution short of replacing the use of sed here with
> > something else. perl would be a simple choice, but filter-branch does
> > not otherwise depend on it. We could use a shell "read" loop, but those
> > are quite slow (and filter-branch is slow enough as it is!).
> 
> You need to only skip the header part, right?
> I would imagine that
> 
> (
> 	while read x && test -n "$x"
>         do
>         	:;
> 	done
> 	cat
> ) <../commit | eval "$filter_msg"
> 
> would not spin too much in shell loop, perhaps?

Yeah, that is not too bad. Probably we want "read -r", just in case of
weirdness in the header lines (and that's in POSIX, and we use it
in other scripts, so it should be portable enough). And we can save a
subshell if we don't mind the potential variable-name conflict.

Here's what I came up with.

-- >8 --
Subject: filter-branch: avoid passing commit message through sed

On some systems (like OS X), if sed encounters input without
a trailing newline, it will silently add it. As a result,
"git filter-branch" on such systems may silently rewrite
commit messages that omit a trailing newline. Even though
this is not something we generate ourselves with "git
commit", it's better for filter-branch to preserve the
original data as closely as possible.

We're using sed here only to strip the header fields from
the commit object. We can accomplish the same thing with a
shell loop. Since shell "read" calls are slow (usually one
syscall per byte), we use "cat" once we've skipped past the
header. Depending on the size of your commit messages, this
is probably faster (you pay the cost to fork, but then read
the data in saner-sized chunks). This idea is shamelessly
stolen from Junio.

Signed-off-by: Jeff King <peff@peff.net>
---
I confirmed the test fixes things on the OS X box I have access to.

The "probably faster" above is of course hand-waving. On my system
starting "cat" takes only about 40 syscalls, so that would naively imply
it's a win in for all but the shortest messages. But of course "fork()"
is a much more expensive syscall than "read()".

 git-filter-branch.sh     | 10 +++++++++-
 t/t7003-filter-branch.sh | 10 ++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index e6e99f5..5b3f63d 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -346,7 +346,15 @@ while read commit parents; do
 				die "parent filter failed: $filter_parent"
 	fi
 
-	sed -e '1,/^$/d' <../commit | \
+	{
+		while read -r header_line && test -n "$header_line"
+		do
+			# skip header lines...
+			:;
+		done
+		# and output the actual commit message
+		cat
+	} <../commit |
 		eval "$filter_msg" > ../message ||
 			die "msg filter failed: $filter_msg"
 	workdir=$workdir @SHELL_PATH@ -c "$filter_commit" "git commit-tree" \
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 66643e4..855afda 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -394,4 +394,14 @@ test_expect_success 'replace submodule revision' '
 	test $orig_head != `git show-ref --hash --head HEAD`
 '
 
+test_expect_success 'filter commit message without trailing newline' '
+	git reset --hard original &&
+	commit=$(printf "no newline" | git commit-tree HEAD^{tree}) &&
+	git update-ref refs/heads/no-newline $commit &&
+	git filter-branch -f refs/heads/no-newline &&
+	echo $commit >expect &&
+	git rev-parse refs/heads/no-newline >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.4.0.rc3.477.gc25258d
