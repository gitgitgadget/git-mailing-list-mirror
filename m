From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 13/14] t4135-*.sh: Skip the "backslash" tests on cygwin
Date: Tue, 21 Dec 2010 19:31:47 +0000
Message-ID: <4D1100A3.2010309@ramsay1.demon.co.uk>
References: <4D07B977.9010502@ramsay1.demon.co.uk> <201012142149.33725.j6t@kdbg.org> <4D0A94D8.6090206@ramsay1.demon.co.uk> <201012172254.31242.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, jrnieder@gmail.com,
	pclouds@gmail.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Dec 21 20:56:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV8JV-0006MJ-Sg
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 20:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017Ab0LUTz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 14:55:56 -0500
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:45007 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752479Ab0LUTz4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Dec 2010 14:55:56 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1PV8JO-0000y7-kO; Tue, 21 Dec 2010 19:55:55 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <201012172254.31242.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164050>

Johannes Sixt wrote:
> Yes, that's clear, and this is the reason that we must skip this test on 
> MinGW.
> 
> But you said that when the single quotes are removed, the test passes (and you 
> are right). Then git-add sees this pathspec/pattern:
> 
>     fo[ou]bar
> 
> and it matches 'foobar' when it interprets that as a pattern, but 'fo[ou]bar' 
> when it interprets that as straight file name. Even on Linux, the latter 
> happens, and *that* is suspicious. What am I missing?

Ah, sorry, I mis-understood your point. :(

So, I decided to have a quick look and ... yeah, something is not quite right!

Hmm, I *think* I have a fix, see patch attached below. This patch provoked a
failure of the unicode tests in t0050-filesystem.sh for me on Linux. However,
these tests are borked when run by the dash shell, but work fine when run by
bash. (see separate e-mail) So, all (non svn) tests pass for me when I run
the tests thus:

    $ SHELL_PATH=/bin/bash make NO_SVN_TESTS=1 test

Of course, this is no guarantee that I haven't messed up all git commands that
use match_one() to process pathspecs, but is at least promising.

The problem boils down to the call to strncmp_icase() suppressing the call to
fnmatch() when the pattern contains glob chars, but the (remaining) string is
equal to the name; thus returning an exact match (MATCHED_EXACTLY) rather than
calling fnmatch (and returning either no-match or MATCHED_FNMATCH).

Note that the test itself is not correct; the argument to git-ls-files should
be quoted the same as the git-add before it ... (well you could pass
fo\\[ou\\]bar instead!).

[BTW, I started looking at the history of this function and I think this
problem has been there for a long time!]

Hmm, I think this is all being rewritten, at the moment (in branch
nd/struct-pathspec) isn't it?

Anyway, let me know what you think...

ATB,
Ramsay Jones

--- 8< ---
From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Date: Sun, 19 Dec 2010 19:47:39 +0000
Subject: [PATCH] dir.c: Fix handling of filespecs containing glob-ing chars


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 dir.c          |    2 +-
 t/t3700-add.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 852e60f..4e8c7bf 100644
--- a/dir.c
+++ b/dir.c
@@ -139,7 +139,7 @@ static int match_one(const char *match, const char *name, int namelen)
 	 * we need to match by fnmatch
 	 */
 	matchlen = strlen(match);
-	if (strncmp_icase(match, name, matchlen))
+	if (is_glob_special(*match) || strncmp_icase(match, name, matchlen))
 		return !fnmatch_icase(match, name, 0) ? MATCHED_FNMATCH : 0;
 
 	if (namelen == matchlen)
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index ec71083..9140164 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -239,7 +239,7 @@ test_expect_success BSLASHPSPEC "git add 'fo\\[ou\\]bar' ignores foobar" '
 	git reset --hard &&
 	touch fo\[ou\]bar foobar &&
 	git add '\''fo\[ou\]bar'\'' &&
-	git ls-files fo\[ou\]bar | fgrep fo\[ou\]bar &&
+	git ls-files '\''fo\[ou\]bar'\'' | fgrep fo\[ou\]bar &&
 	! ( git ls-files foobar | grep foobar )
 '
 
-- 
1.7.3
