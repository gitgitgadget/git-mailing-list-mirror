From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v2] Revamp git-cherry(1)
Date: Fri, 22 Nov 2013 17:29:16 +0100
Message-ID: <dde93c10b7f6cb7b8cf94e9a0310c8e05aca2517.1385137650.git.tr@thomasrast.ch>
References: <xmqqli0h4kvj.fsf@gitster.dls.corp.google.com>
Cc: a.huemer@commend.com, "Michael S. Tsirkin" <mst@kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 22 17:29:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjtbu-0007g0-K5
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 17:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755936Ab3KVQ3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 11:29:34 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:49911 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755749Ab3KVQ3c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 11:29:32 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id E37F54D6580;
	Fri, 22 Nov 2013 17:29:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 4apg_sm1wue4; Fri, 22 Nov 2013 17:29:20 +0100 (CET)
Received: from linux-k42r.v.cablecom.net (unknown [213.55.184.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 5B1F14D6414;
	Fri, 22 Nov 2013 17:29:19 +0100 (CET)
X-Mailer: git-send-email 1.8.5.rc2.355.g6969a19
In-Reply-To: <xmqqli0h4kvj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238194>

git-cherry(1)'s "description" section has never really managed to
explain to me what the command does.  It contains too much explanation
of the algorithm instead of simply saying what goals it achieves, and
too much terminology that we otherwise do not use (fork-point instead
of merge-base).

Try a much more concise approach: state what it finds out, why this is
neat, and how the output is formatted, in a few short paragraphs.  In
return, provide much longer examples of how it fits into a
format-patch/am based workflow, and how it compares to reading the
same from git-log.

Also carefully avoid using "merge" in a context where it does not mean
something that comes from git-merge(1).  Instead, say "apply" in an
attempt to further link to patch workflow concepts.

While there, also omit the language about _which_ upstream branch we
treat as the default.  I literally just learned that we support having
several, so let's not confuse new users here, especially considering
that git-config(1) does _not_ document this.

Prompted-by: a.huemer@commend.com on #git
Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---

Junio C Hamano wrote:
> > +EXAMPLES
> > +--------
> > +
> > +git-cherry is frequently used in patch-based workflows (see
> > +linkgit:gitworkflows[7]) to determine if a series of patches has been
> > +applied by the upstream maintainer.  In such a workflow you might
> > +create and send a topic branch like this (fill in appropriate
> > +arguments for `...`):
> 
> I think the ASCII art commit graph that shows topology which we lost
> by this patch gave a more intiutive sense of what "a topic branch
> like this" looked like than an incomplete skeleton of a command
> sequence that would be understood by those who already know how to
> work with multiple branches.  Perhaps we want both?

Perhaps like this?  I tried to tie in directly with what a user might
see from git-log.

This does push the ascii art rather far down in the manpage, but even
with a puny laptop display and a large font size the new EXAMPLES is
well on the first page of the manpage.  So the hope is that a
still-confused user would at least see that there are examples.


 Documentation/git-cherry.txt | 136 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 103 insertions(+), 33 deletions(-)

diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index 2d0daae..6d14b3e 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -3,7 +3,7 @@ git-cherry(1)
 
 NAME
 ----
-git-cherry - Find commits not merged upstream
+git-cherry - Find commits not applied in upstream
 
 SYNOPSIS
 --------
@@ -12,46 +12,26 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-The changeset (or "diff") of each commit between the fork-point and <head>
-is compared against each commit between the fork-point and <upstream>.
-The diffs are compared after removing any whitespace and line numbers.
+Determine whether there are commits in `<head>..<upstream>` that are
+equivalent to those in the range `<limit>..<head>`.
 
-Every commit that doesn't exist in the <upstream> branch
-has its id (sha1) reported, prefixed by a symbol.  The ones that have
-equivalent change already
-in the <upstream> branch are prefixed with a minus (-) sign, and those
-that only exist in the <head> branch are prefixed with a plus (+) symbol:
-
-               __*__*__*__*__> <upstream>
-              /
-    fork-point
-              \__+__+__-__+__+__-__+__> <head>
-
-
-If a <limit> has been given then the commits along the <head> branch up
-to and including <limit> are not reported:
-
-               __*__*__*__*__> <upstream>
-              /
-    fork-point
-              \__*__*__<limit>__-__+__> <head>
-
-
-Because 'git cherry' compares the changeset rather than the commit id
-(sha1), you can use 'git cherry' to find out if a commit you made locally
-has been applied <upstream> under a different commit id.  For example,
-this will happen if you're feeding patches <upstream> via email rather
-than pushing or pulling commits directly.
+The equivalence test is based on the diff, after removing whitespace
+and line numbers.  git-cherry therefore detects when commits have been
+"copied" by means of linkgit:git-cherry-pick[1], linkgit:git-am[1] or
+linkgit:git-rebase[1].
 
+Outputs the SHA1 of every commit in `<limit>..<head>`, prefixed with
+`-` for commits that have an equivalent in <upstream>, and `+` for
+commits that do not.
 
 OPTIONS
 -------
 -v::
-	Verbose.
+	Show the commit subjects next to the SHA1s.
 
 <upstream>::
-	Upstream branch to compare against.
-	Defaults to the first tracked remote branch, if available.
+	Upstream branch to search for equivalent commits.
+	Defaults to the upstream branch of HEAD.
 
 <head>::
 	Working branch; defaults to HEAD.
@@ -59,6 +39,96 @@ OPTIONS
 <limit>::
 	Do not report commits up to (and including) limit.
 
+EXAMPLES
+--------
+
+Patch workflows
+~~~~~~~~~~~~~~~
+
+git-cherry is frequently used in patch-based workflows (see
+linkgit:gitworkflows[7]) to determine if a series of patches has been
+applied by the upstream maintainer.  In such a workflow you might
+create and send a topic branch like this:
+
+------------
+$ git checkout -b topic origin/master
+# work and create some commits
+$ git format-patch origin/master
+$ git send-email ... 00*
+------------
+Later, you can see whether your changes have been applied by saying
+(still on `topic`):
+
+------------
+$ git fetch  # update your notion of origin/master
+$ git cherry -v
+------------
+
+Concrete example
+~~~~~~~~~~~~~~~~
+
+In a situation where topic consisted of three commits, and the
+maintainer applied two of them, the situation might look like:
+
+------------
+$ git log --graph --oneline --decorate --boundary origin/master...topic
+* 7654321 (origin/master) upstream tip commit
+[... snip some other commits ...]
+* cccc111 cherry-pick of C
+* aaaa111 cherry-pick of A
+[... snip a lot more that has happened ...]
+| * cccc000 (topic) commit C
+| * bbbb000 commit B
+| * aaaa000 commit A
+|/
+o 1234567 branch point
+------------
+
+In such cases, git-cherry shows a concise summary of what has been
+applied:
+
+------------
+$ git cherry origin/master topic
+- cccc000... commit C
++ bbbb000... commit B
+- aaaa000... commit A
+------------
+
+Using a limit
+~~~~~~~~~~~~~
+
+The optional <limit> is useful in cases where your topic is based on
+other work that is not in upstream.  Expanding on the previous
+example, this might look like:
+
+------------
+$ git log --graph --oneline --decorate --boundary origin/master...topic
+* 7654321 (origin/master) upstream tip commit
+[... snip some other commits ...]
+* cccc111 cherry-pick of C
+* aaaa111 cherry-pick of A
+[... snip a lot more that has happened ...]
+| * cccc000 (topic) commit C
+| * bbbb000 commit B
+| * aaaa000 commit A
+| * 0000fff (base) unpublished stuff F
+[... snip ...]
+| * 0000aaa unpublished stuff A
+|/
+o 1234567 merge-base between upstream and topic
+------------
+
+By specifying `base` as the limit, you can avoid listing commits
+between `base` and `topic`:
+
+------------
+$ git cherry origin/master topic base
+- cccc000... commit C
++ bbbb000... commit B
+- aaaa000... commit A
+------------
+
+
 SEE ALSO
 --------
 linkgit:git-patch-id[1]
-- 
1.8.5.rc2.355.g6969a19
