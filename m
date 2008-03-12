From: Jeff King <peff@peff.net>
Subject: Re: Solaris test failure for git-1.5.4.4 -- t0021-conversion.sh
Date: Wed, 12 Mar 2008 08:43:36 -0400
Message-ID: <20080312124336.GA7873@coredump.intra.peff.net>
References: <8ec76080803110533m14041aebhc779d117a5bb6112@mail.gmail.com> <alpine.DEB.1.00.0803110954360.4428@alchemy.localdomain> <8ec76080803111014w209e1ceep9baf6d5c8c7f6a20@mail.gmail.com> <20080311173536.GA14687@sigill.intra.peff.net> <20080311174045.GB14687@sigill.intra.peff.net> <7vhcfc8tu7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Whit Armstrong <armstrong.whit@gmail.com>,
	Asheesh Laroia <asheesh@asheesh.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 13:44:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZQJg-0003Gs-8V
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 13:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbYCLMnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 08:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbYCLMnl
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 08:43:41 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4698 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbYCLMnk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 08:43:40 -0400
Received: (qmail 30989 invoked by uid 111); 12 Mar 2008 12:43:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Mar 2008 08:43:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2008 08:43:36 -0400
Content-Disposition: inline
In-Reply-To: <7vhcfc8tu7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76947>

On Tue, Mar 11, 2008 at 09:11:28PM -0700, Junio C Hamano wrote:

> Besides tests, I think we have invocations of "tr" that Solaris people
> might want to audit in the real scripts.  POSIX does not require [] around
> the strings, but when from-string and to-string are of the same length,
> having [] around them would not hurt (they transliterate to themselves)
> and that is the only reason why we tend to use [] form to help potential
> porters to ancient System V systems ;-)

I'm not sure that it is always OK to just put in extra brackets, at
least in the case of multiple ranges. Consider the patch I just posted:

$ uname -a
SunOS tokyo 5.8 Generic_117350-47 sun4u sparc SUNW,Ultra-4

# what we have now, ok with bsd
$ echo foo | /usr/ucb/tr '[A-Za-z]' '[N-ZA-Mn-za-m]'
sbb

# what we have now, broken with SysV because of multiple ranges
echo foo | /usr/bin/tr '[A-Za-z]' '[N-ZA-Mn-za-m]'
Bad string

# potential fix, break multiple ranges. works with SysV
echo foo | /usr/bin/tr '[A-Z][a-z]' '[N-Z][A-M][n-z][a-m]'
sbb

# but here it breaks bsd
echo foo | /usr/ucb/tr '[A-Z][a-z]' '[N-Z][A-M][n-z][a-m]'
qzz


which makes no sense to me at all. If it were ignoring the duplicated
'[' on input, then I could understand a shift of one character. But
there is a shift of two characters.

> bisect has "tr '[\012]' ' '" which I think we can get rid of by rewriting
> the users of the resulting string.

This one is just being overzealous with the brackets. There is no need
for them unless there is a character sequence. This works correctly as

   tr '\012' ' '

at least using the Solaris SysV tr.

Below is a patch that fixes all of the problematic sites I found. Each
fix type was hand-tested with the Solaris SysV and UCB versions of tr,
and the tests ran successfully on Linux. On Solaris, I tried the tests
using /usr/bin/tr. However, I ran into problems with t1300, which tries:

  tr '\000' 'Q'

It seems that /usr/bin/tr silently removes NULs from the input stream:

  $ printf 'foo\000bar' | xxd
  0000000: 666f 6f00 6261 72                        foo.bar
  $ printf 'foo\000bar' | /usr/bin/tr '\000' 'Q' | xxd
  0000000: 666f 6f62 6172                           foobar

I don't think there is an easy way around this; we might have to switch
to using perl.

-- >8 --
tr portability fixes

Specifying character ranges in tr differs between System V
and POSIX. In System V, brackets are required (e.g.,
'[A-Z]'), whereas in POSIX they are not.

We can mostly get around this by just using the bracket form
for both sets, as in:

  tr '[A-Z] '[a-z]'

in which case POSIX interpets this as "'[' becomes '['",
which is OK.

However, this doesn't work with multiple sequences, like:

  # rot13
  tr '[A-Z][a-z]' '[N-Z][A-M][n-z][a-m]'

where the POSIX version does not behave the same as the
System V version. In this case, we must simply enumerate the
sequence.

This patch fixes problematic uses of tr in git scripts and
test scripts in one of three ways:

  - if a single sequence, make sure it uses brackets
  - if multiple sequences, enumerate
  - if extra brackets (e.g., tr '[A]' 'a'), eliminate
    brackets
---
 git-bisect.sh            |    4 ++--
 git-filter-branch.sh     |    4 ++--
 t/t4022-diff-rewrite.sh  |    5 ++++-
 t/t7003-filter-branch.sh |    2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 2c32d0b..48fb92d 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -293,14 +293,14 @@ bisect_next() {
 	bisect_next_check good
 
 	skip=$(git for-each-ref --format='%(objectname)' \
-		"refs/bisect/skip-*" | tr '[\012]' ' ') || exit
+		"refs/bisect/skip-*" | tr '\012' ' ') || exit
 
 	BISECT_OPT=''
 	test -n "$skip" && BISECT_OPT='--bisect-all'
 
 	bad=$(git rev-parse --verify refs/bisect/bad) &&
 	good=$(git for-each-ref --format='^%(objectname)' \
-		"refs/bisect/good-*" | tr '[\012]' ' ') &&
+		"refs/bisect/good-*" | tr '\012' ' ') &&
 	eval="git rev-list --bisect-vars $BISECT_OPT $good $bad --" &&
 	eval="$eval $(cat "$GIT_DIR/BISECT_NAMES")" &&
 	eval=$(filter_skipped "$eval" "$skip") &&
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 010353a..59cf023 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -58,8 +58,8 @@ eval "$functions"
 # "author" or "committer
 
 set_ident () {
-	lid="$(echo "$1" | tr "A-Z" "a-z")"
-	uid="$(echo "$1" | tr "a-z" "A-Z")"
+	lid="$(echo "$1" | tr "[A-Z]" "[a-z]")"
+	uid="$(echo "$1" | tr "[a-z]" "[A-Z]")"
 	pick_id_script='
 		/^'$lid' /{
 			s/'\''/'\''\\'\'\''/g
diff --git a/t/t4022-diff-rewrite.sh b/t/t4022-diff-rewrite.sh
index 6de4acb..bf996fc 100755
--- a/t/t4022-diff-rewrite.sh
+++ b/t/t4022-diff-rewrite.sh
@@ -8,7 +8,10 @@ test_expect_success setup '
 
 	cat ../../COPYING >test &&
 	git add test &&
-	tr 'a-zA-Z' 'n-za-mN-ZA-M' <../../COPYING >test
+	tr \
+	  "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" \
+	  "nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM" \
+	  <../../COPYING >test
 
 '
 
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 6e14bf1..553131f 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -4,7 +4,7 @@ test_description='git-filter-branch'
 . ./test-lib.sh
 
 make_commit () {
-	lower=$(echo $1 | tr A-Z a-z)
+	lower=$(echo $1 | tr '[A-Z]' '[a-z]')
 	echo $lower > $lower
 	git add $lower
 	test_tick
-- 
1.5.4.3.613.gdd757
