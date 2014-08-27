From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] teach fast-export an --anonymize option
Date: Wed, 27 Aug 2014 12:58:54 -0400
Message-ID: <20140827165854.GC1432@peff.net>
References: <20140821070130.GA15930@peff.net>
 <xmqqiollqzel.fsf@gitster.dls.corp.google.com>
 <20140821224910.GB21105@peff.net>
 <20140821232100.GA27849@peff.net>
 <xmqq8um9gbwh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 18:59:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMgYn-0005XV-IY
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 18:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933744AbaH0Q65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 12:58:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:60172 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751200AbaH0Q64 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 12:58:56 -0400
Received: (qmail 10632 invoked by uid 102); 27 Aug 2014 16:58:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Aug 2014 11:58:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2014 12:58:54 -0400
Content-Disposition: inline
In-Reply-To: <xmqq8um9gbwh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256011>

On Wed, Aug 27, 2014 at 09:01:02AM -0700, Junio C Hamano wrote:

> > +# this also covers commit messages
> > +test_expect_success 'stream omits path names' '
> > +	! fgrep base stream &&
> > +	! fgrep foo stream &&
> > +	! fgrep subdir stream &&
> > +	! fgrep bar stream &&
> > +	! fgrep xyzzy stream
> > +'
> 
> I know there are a few isolated places that already use "fgrep", but
> let's not spread the disease. Neither "fgrep" nor "egrep" appears in
> POSIX and they can easily be spelled more portably as "grep -F" and
> "grep -E", respectively.s

I actually specifically used "fgrep" rather than "grep -F" because some
platforms have the former but not the latter. It has been a while since
commit 8753941, but I think Solaris was such a platform (and maybe AIX,
too, based on [1]).

[1] http://article.gmane.org/gmane.comp.version-control.git/97076

They could actually just be "grep" in this case, since we know the
patterns do not have any metacharacters. I was thinking that our
$GIT_COMMITTER_NAME (grepped below) did, but it is "C O Mitter", not "C.
O. Mitter".

I'll switch that in the re-roll.

> > +test_expect_success 'stream allows master as refname' '
> > +	fgrep master stream
> > +'
> > +
> > +test_expect_success 'stream omits other refnames' '
> > +	! fgrep other stream
> > +'
> 
> What should happen to mytag?

I added the tag test at the very end, and you can see that it did not
get as much attention. :) We should check "! grep mytag stream" here.
Will be in the re-roll.

> > +test_expect_success 'repo has original shape' '
> > +	cat >expect <<-\EOF &&
> > +	> subject 3
> > +	> subject 2
> > +	< subject 1
> > +	- subject 0
> > +	EOF
> > +	git log --format="%m %s" --left-right --boundary \
> > +		master...$other_branch >actual &&
> > +	test_cmp expect actual
> > +'
> 
> Yuck and Hmph.  Doing a shape-preserving conversion is very
> important, but I wonder if we can we verify without having to cast a
> particular rewrite rule in stone.  We know we want to preserve
> relative order of committer timestamps (to reproduce bugs that
> depend on the traversal order), and it may be OK to reuse the
> exactly the same committer timestamps from the original, in which
> case we can make sure that we create the original history with
> appropriate "test_tick"s (I think test_commit does that for us) and
> use "%ct" instead of "%s" here, perhaps?  That way we can later
> change the rewrite rules of commit object payload without having to
> adjust this test.

Yeah, everything is lost except the shape and committer timestamps. So
our choices are basically "%m" or "%m %ct". I think the latter is
probably the least bad choice. Will switch.

There's a potential problem with picking the same branches in the same
order. We can cheat a little here, though, because "master" retains its
same name. Since there's only one other branch, it's always the other
one we want.

The trees are not necessarily so lucky. We check that the root tree ends
up with a blob and a tree. But the anonymization does not necessarily
have to preserve their order (and it probably wouldn't under many
schemes). I think we can get away with just sorting the type list.

> > +test_expect_success 'tag points to branch tip' '
> > +	git rev-parse $other_branch >expect &&
> > +	git for-each-ref --format="%(*objectname)" | grep . >actual &&
> > +	test_cmp expect actual
> > +'
> 
> I notice you haven't checked how many tags you have in the
> repository, unlike the number of branches which you counted
> earlier.

Yes, because test_commit makes a bunch of extraneous tags, which I
thought made the test a little brittle.

> > +test_expect_success 'idents are shared' '
> > +	git log --all --format="%an <%ae>" >authors &&
> > +	sort -u authors >unique &&
> > +	test_line_count = 1 unique &&
> > +	git log --all --format="%cn <%ce>" >committers &&
> > +	sort -u committers >unique &&
> > +	test_line_count = 1 unique &&
> > +	! test_cmp authors committers
> > +'
> 
> Two commits by the same author must convert to two commits by the
> same anonymized author, but that is not tested here; the history
> made in 'setup a simple repo' step is a bit too simple to do that
> anyway, though ;-).

I think we do check that. The commits are all by the same author, so the
fact that "sort -u authors" has one line means that they all got
anonymized to the same author. What we don't check is that two
_different_ authors get different idents. I check that the two idents
get different values (authors != committers), but it is not clear from a
blackbox test that it is because the anonymization is working (it might
be because authors and committers come from a different pool of strings,
though I know having written the code that that is not the case).

I also do not test that the same ident as an author and as a committer
ends up the same. Honestly, I didn't really feel that it was worth much
bother. The shape of history and the tree is the most interesting thing
here, and the primary thing about idents is that we wipe them.

Maybe it was just me being lazy, though.

> > +test_expect_success 'commit timestamps are retained' '
> > +	git log --all --format="%ct" >timestamps &&
> > +	sort -u timestamps >unique &&
> > +	test_line_count = 4 unique
> > +'

I think we can drop this one if we check %ct in the graph-shape test
above. It's redundant.

I'll send v3 in a minute. Here's the interdiff.

diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
index f76ffe4..897dc50 100755
--- a/t/t9351-fast-export-anonymize.sh
+++ b/t/t9351-fast-export-anonymize.sh
@@ -19,30 +19,31 @@ test_expect_success 'export anonymized stream' '
 
 # this also covers commit messages
 test_expect_success 'stream omits path names' '
-	! fgrep base stream &&
-	! fgrep foo stream &&
-	! fgrep subdir stream &&
-	! fgrep bar stream &&
-	! fgrep xyzzy stream
+	! grep base stream &&
+	! grep foo stream &&
+	! grep subdir stream &&
+	! grep bar stream &&
+	! grep xyzzy stream
 '
 
 test_expect_success 'stream allows master as refname' '
-	fgrep master stream
+	grep master stream
 '
 
 test_expect_success 'stream omits other refnames' '
-	! fgrep other stream
+	! grep other stream &&
+	! grep mytag stream
 '
 
 test_expect_success 'stream omits identities' '
-	! fgrep "$GIT_COMMITTER_NAME" stream &&
-	! fgrep "$GIT_COMMITTER_EMAIL" stream &&
-	! fgrep "$GIT_AUTHOR_NAME" stream &&
-	! fgrep "$GIT_AUTHOR_EMAIL" stream
+	! grep "$GIT_COMMITTER_NAME" stream &&
+	! grep "$GIT_COMMITTER_EMAIL" stream &&
+	! grep "$GIT_AUTHOR_NAME" stream &&
+	! grep "$GIT_AUTHOR_EMAIL" stream
 '
 
 test_expect_success 'stream omits tag message' '
-	! fgrep "annotated tag" stream
+	! grep "annotated tag" stream
 '
 
 # NOTE: we chdir to the new, anonymized repository
@@ -59,25 +60,25 @@ test_expect_success 'result has two branches' '
 	other_branch=$(grep -v refs/heads/master branches)
 '
 
-test_expect_success 'repo has original shape' '
-	cat >expect <<-\EOF &&
-	> subject 3
-	> subject 2
-	< subject 1
-	- subject 0
-	EOF
-	git log --format="%m %s" --left-right --boundary \
-		master...$other_branch >actual &&
+test_expect_success 'repo has original shape and timestamps' '
+	shape () {
+		git log --format="%m %ct" --left-right --boundary "$@"
+	} &&
+	(cd .. && shape master...other) >expect &&
+	shape master...$other_branch >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'root tree has original shape' '
+	# the output entries are not necessarily in the same
+	# order, but we know at least that we will have one tree
+	# and one blob, so just check the sorted order
 	cat >expect <<-\EOF &&
 	blob
 	tree
 	EOF
 	git ls-tree $other_branch >root &&
-	cut -d" " -f2 <root >actual &&
+	cut -d" " -f2 <root | sort >actual &&
 	test_cmp expect actual
 '
 
@@ -108,10 +109,4 @@ test_expect_success 'idents are shared' '
 	! test_cmp authors committers
 '
 
-test_expect_success 'commit timestamps are retained' '
-	git log --all --format="%ct" >timestamps &&
-	sort -u timestamps >unique &&
-	test_line_count = 4 unique
-'
-
 test_done
