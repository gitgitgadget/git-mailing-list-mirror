From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] .clang-format: introduce the use of clang-format
Date: Wed, 21 Jan 2015 17:09:03 -0500
Message-ID: <20150121220903.GA10267@peff.net>
References: <1421530221-39306-1-git-send-email-artagnon@gmail.com>
 <1421859687-27216-1-git-send-email-artagnon@gmail.com>
 <20150121204502.GA3287@peff.net>
 <CALkWK0knxJ5VTJoKhR_t4GS7pfg6PPYox9Srf3bvaX=m+sjqVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 23:09:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE3Sg-0004La-0b
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 23:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbbAUWJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 17:09:07 -0500
Received: from cloud.peff.net ([50.56.180.127]:37019 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751400AbbAUWJG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 17:09:06 -0500
Received: (qmail 31022 invoked by uid 102); 21 Jan 2015 22:09:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jan 2015 16:09:04 -0600
Received: (qmail 855 invoked by uid 107); 21 Jan 2015 22:09:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jan 2015 17:09:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jan 2015 17:09:03 -0500
Content-Disposition: inline
In-Reply-To: <CALkWK0knxJ5VTJoKhR_t4GS7pfg6PPYox9Srf3bvaX=m+sjqVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262773>

On Wed, Jan 21, 2015 at 04:28:00PM -0500, Ramkumar Ramachandra wrote:

> > So overall I think it has some promise, but I do not think it is quite
> > flexible enough yet for us to use day-to-day.
> 
> The big negative is that it will probably never be. I'll try to look
> at the larger issues later this week, if you can compromise on the
> fine details that are probably too hard to fix.

The key to me is that we do not have necessarily take every suggestion
the tool makes. So it does not have to be perfect, just "pretty good".

But...I think it is not quite so simple. The clang-format-diff script
(and git-clang-format) _do_ seem to operate on more than just the lines
I've changed. I'm not clear on whether they're examining the whole file
(just with the patches applied), or there's something in between
happening.

So rejecting the tool's suggestion one day may mean it suggests the same
change to you any other time you touch nearby parts of the file, which
could be annoying.

> >   2. It can operate on patches (and generates patches for you to apply!
> >      You could add a git-add--interactive mode to selectively take its
> >      suggestions).
> 
> There's a git-clang-format in the $CLANG_ROOT/tools/clang-format/. I do:
> 
>    $ g cf @~
> 
> ... with the appropriate aliases.

Neat. Debian's package does not ship with that. I hacked-in very
rudimentary interactive-add support for clang-format-diff (below) before
getting your response. It would be better built around "git-clang-format
--diff" (though that script would need to be taught to do the right
thing with the --color argument).

However, because of the "suggest the same change" thing I mentioned
above, I am not sure whether interactively selecting is a good idea or
not.  You might end up having to say "no" to the same suggestions a lot.

Anyway, here it is, for reference. You can use it like:

  git add--interactive --patch=format --

and you could probably even stick an "exec" line into an interactive
rebase to go through and fixup individual patches in a whole series.

---
diff --git a/.gitignore b/.gitignore
index a052419..6f5b815 100644
--- a/.gitignore
+++ b/.gitignore
@@ -30,6 +30,7 @@
 /git-checkout-index
 /git-cherry
 /git-cherry-pick
+/git-clang-format-diff
 /git-clean
 /git-clone
 /git-column
diff --git a/Makefile b/Makefile
index c44eb3a..113534e 100644
--- a/Makefile
+++ b/Makefile
@@ -455,6 +455,7 @@ unexport CDPATH
 
 SCRIPT_SH += git-am.sh
 SCRIPT_SH += git-bisect.sh
+SCRIPT_SH += git-clang-format-diff.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-merge-octopus.sh
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index c725674..fd83adf 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -167,6 +167,16 @@ my %patch_modes = (
 		FILTER => undef,
 		IS_REVERSE => 0,
 	},
+	'format' => {
+		DIFF => 'clang-format-diff',
+		APPLY => sub { apply_patch_for_checkout_commit '', @_ },
+		APPLY_CHECK => 'apply',
+		VERB => 'Apply',
+		TARGET => 'to index and worktree',
+		PARTICIPLE => 'applying',
+		FILTER => undef,
+		IS_REVERSE => 0
+	},
 );
 
 my %patch_mode_flavour = %{$patch_modes{stage}};
@@ -1591,6 +1601,15 @@ sub process_args {
 						       'checkout_head' : 'checkout_nothead');
 					$arg = shift @ARGV or die "missing --";
 				}
+			} elsif ($1 eq 'format') {
+				$patch_mode = $1;
+				$arg = shift @ARGV or die "missing --";
+				if ($arg eq '--') {
+					$patch_mode_revision = 'HEAD^';
+				} else {
+					$patch_mode_revision = $arg;
+					$arg = shift @ARGV or die "missing --";
+				}
 			} elsif ($1 eq 'stage' or $1 eq 'stash') {
 				$patch_mode = $1;
 				$arg = shift @ARGV or die "missing --";
diff --git a/git-clang-format-diff.sh b/git-clang-format-diff.sh
new file mode 100755
index 0000000..9351883
--- /dev/null
+++ b/git-clang-format-diff.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+
+# This is what it's called in the Debian package, but it seems
+# like there ought to be a symlink without the version...
+CFD=clang-format-diff-3.6
+
+# Strip out --color, as clang's patch reader cannot handle it.
+# Robustly handling arrays in bourne shell is insane.
+eval "set -- $(
+	for i in "$@"; do
+		test "--color" = "$i" && continue
+		printf " '"
+		printf '%s' "$i" | sed "s/'/'\\\\''/g"
+		printf "'"
+	done
+)"
+
+git diff-index -p "$@" |
+$CFD -p1 |
+sed -e 's,^--- ,&a/,' -e 's,^+++ ,&b/,'
