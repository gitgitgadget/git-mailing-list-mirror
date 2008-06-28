From: Jeff King <peff@peff.net>
Subject: Re: An alternate model for preparing partial commits
Date: Sat, 28 Jun 2008 01:03:17 -0400
Message-ID: <20080628050317.GE9451@sigill.intra.peff.net>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com> <alpine.DEB.1.00.0806271408290.9925@racer> <7vprq2rbfz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robert Anderson <rwa000@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 07:04:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCSbh-0007d9-Bo
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 07:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbYF1FDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 01:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbYF1FDU
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 01:03:20 -0400
Received: from peff.net ([208.65.91.99]:4649 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751420AbYF1FDT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 01:03:19 -0400
Received: (qmail 8680 invoked by uid 111); 28 Jun 2008 05:03:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 28 Jun 2008 01:03:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Jun 2008 01:03:17 -0400
Content-Disposition: inline
In-Reply-To: <7vprq2rbfz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86705>

On Fri, Jun 27, 2008 at 11:15:44AM -0700, Junio C Hamano wrote:

> I've always said that I am not in favor of any form of partial commits,
> exactly for the reason Robert states, namely that you are not committing
> what you had in your work tree as a whole.  I said so back when the only
> form of partial commits were "git commit [-o] this-file".  I said it again
> even when I introduced "add -i", that the interface goes backwards and
> does not fix the issues associated with partial commits.

I do partial commits all the time. I used to use the "go back and clean
up and test each" method. But now with stash, I use the workflow
mentioned elsewhere in the thread:

  1. hack hack hack
  2. add -i; commit -m tmp
  3. stash
  4. reset HEAD^

which is really kind of awkward, since I didn't want to make that commit
in the first place.

I think of it as three ordered buckets: index, working tree, and stash.
You can move changes from any bucket to an adjacent bucket, but you can
only test what's in the working tree.

So we have too many changes in the working tree. Right now we can put
some of them in the index bucket. But that doesn't help with testing.
So what I do now is move good changes to the index bucket (and then
commit -- more on that in a second), and then everything else to the
stash bucket, and then reset the commit.

The extra commit / reset is annoying. We could do better than that
with the proposed "stash --keep-index". Then I just have to move my good
changes into the index and say "ok, now stash everything else."

But that still involves two bucket moves. I think what would be much
more natural is to simply say "I don't want these changes right now;
move them into the stash bucket." And Dscho mentioned "git stash -i",
which does that (and theoretically, it could even be based on the "git
add -i" code).

What you propose below accomplishes the same thing, but seems mentally
reversed to me (and involves two bucket moves):

> One thing I think would make sense is to stash away _everything_ at this
> point.  That would take you to the state before you started working.  Then
> if we can selectively _unstash_ the parts that should logically be
> committed first to bring them to your work tree, then you can inspect that
> change against HEAD, test it, and when you are happy with it, you would
> make your first commit in the final sequence.

Here we say "OK, I don't want any of these changes; stash them" and then
selectively bring them back. And maybe that _is_ what you want
sometimes, or maybe how certain people think. But personally, given two
sets of changes, what makes sense to me is to directly say "these are
the changes I _don't_ want". And at any point after ditching some
changes, you can re-run your tests.

So I fundamentally think that all of these contortions are because
moving things to the stash bucket is not as featureful as moving them to
the index bucket. And there's no reason for it, since we can use the
_same_ tools to do both.

Here's a somewhat hackish implementation of "git stash -i" that just relies
on "add -i":

---
diff --git a/git-stash.sh b/git-stash.sh
index 4938ade..6685004 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -67,7 +67,7 @@ create_stash () {
 		GIT_INDEX_FILE="$TMP-index" &&
 		export GIT_INDEX_FILE &&
 		git read-tree -m $i_tree &&
-		git add -u &&
+		git add $ADD_OPTIONS </dev/tty >/dev/tty 2>&1 &&
 		git write-tree &&
 		rm -f "$TMP-index"
 	) ) ||
@@ -218,6 +218,11 @@ drop_stash () {
 	git rev-parse --verify "$ref_stash@{0}" > /dev/null 2>&1 || clear_stash
 }
 
+ADD_OPTIONS="-u"
+case "$1" in
+	-i|-p) ADD_OPTIONS=$1; shift
+esac
+
 # Main command set
 case "$1" in
 list)
@@ -235,7 +240,7 @@ show)
 	;;
 save)
 	shift
-	save_stash "$*" && git-reset --hard
+	save_stash "$*" && show_stash -p -R | git apply
 	;;
 apply)
 	shift
@@ -269,7 +274,7 @@ pop)
 	then
 		save_stash &&
 		echo '(To restore them type "git stash apply")' &&
-		git-reset --hard
+		show_stash -p -R | git apply
 	else
 		usage
 	fi
