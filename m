From: Jeff King <peff@peff.net>
Subject: Re: [Bug] for-each-ref: %(object) and %(type) unimplemented
Date: Thu, 26 Jun 2008 04:08:41 -0400
Message-ID: <20080626080841.GA27935@sigill.intra.peff.net>
References: <48625DAD.5040404@gmail.com> <20080625160814.GA3321@sigill.intra.peff.net> <20080625161433.GA6612@sigill.intra.peff.net> <20080626053551.GA20767@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lea Wiemann <lewiemann@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 10:09:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBmY4-0004bt-5U
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 10:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287AbYFZIIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 04:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752575AbYFZIIq
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 04:08:46 -0400
Received: from peff.net ([208.65.91.99]:4680 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751847AbYFZIIn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 04:08:43 -0400
Received: (qmail 24901 invoked by uid 111); 26 Jun 2008 08:08:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 26 Jun 2008 04:08:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jun 2008 04:08:41 -0400
Content-Disposition: inline
In-Reply-To: <20080626053551.GA20767@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86410>

On Thu, Jun 26, 2008 at 01:35:51AM -0400, Jeff King wrote:

> > Hmm. Actually, there is a test in t6300 that runs with each atom name.
> > Unfortunately, it doesn't bother actually checking the output for
> > sanity, so the fact that these atoms returned the empty string was
> > missed.
> 
> And here is a two patch series cleaning up the test script and fixing
> the bug.

Hmm, looks like I just missed you applying the original fix to maint.
Ignore 2/2, then, as you already have it. I think it is still worth
doing the test script cleanup, though. Here it is, rebased on the
current master (the only difference is we don't have to mark the
breakage as expect_failure).

-- >8 --
improve for-each-ref test script

Previously, we did a sanity check by doing for-each-ref
using each possible format atom. However, we never checked
the actual output produced by that atom, which recently let
an obvious bug go undetected for some time.

While we're at it, also clean up a few '!' into
test_must_fail.
---
 t/t6300-for-each-ref.sh |   87 +++++++++++++++++++++++++++++++++++++---------
 1 files changed, 70 insertions(+), 17 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 91ea85d..a3c8941 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -26,25 +26,78 @@ test_expect_success 'Create sample commit with known timestamp' '
 	git tag -a -m "Tagging at $datestamp" testtag
 '
 
-test_expect_success 'Check atom names are valid' '
-	bad=
-	for token in \
-		refname objecttype objectsize objectname tree parent \
-		numparent object type author authorname authoremail \
-		authordate committer committername committeremail \
-		committerdate tag tagger taggername taggeremail \
-		taggerdate creator creatordate subject body contents
-	do
-		git for-each-ref --format="$token=%($token)" refs/heads || {
-			bad=$token
-			break
-		}
-	done
-	test -z "$bad"
+test_atom() {
+	case "$1" in
+		head) ref=refs/heads/master ;;
+		 tag) ref=refs/tags/testtag ;;
+	esac
+	printf '%s\n' "$3" >expected
+	test_expect_${4:-success} "basic atom: $1 $2" "
+		git for-each-ref --format='%($2)' $ref >actual &&
+		test_cmp expected actual
+	"
+}
+
+test_atom head refname refs/heads/master
+test_atom head objecttype commit
+test_atom head objectsize 171
+test_atom head objectname 67a36f10722846e891fbada1ba48ed035de75581
+test_atom head tree 0e51c00fcb93dffc755546f27593d511e1bdb46f
+test_atom head parent ''
+test_atom head numparent 0
+test_atom head object ''
+test_atom head type ''
+test_atom head author 'A U Thor <author@example.com> 1151939924 +0200'
+test_atom head authorname 'A U Thor'
+test_atom head authoremail '<author@example.com>'
+test_atom head authordate 'Mon Jul 3 17:18:44 2006 +0200'
+test_atom head committer 'C O Mitter <committer@example.com> 1151939923 +0200'
+test_atom head committername 'C O Mitter'
+test_atom head committeremail '<committer@example.com>'
+test_atom head committerdate 'Mon Jul 3 17:18:43 2006 +0200'
+test_atom head tag ''
+test_atom head tagger ''
+test_atom head taggername ''
+test_atom head taggeremail ''
+test_atom head taggerdate ''
+test_atom head creator 'C O Mitter <committer@example.com> 1151939923 +0200'
+test_atom head creatordate 'Mon Jul 3 17:18:43 2006 +0200'
+test_atom head subject 'Initial'
+test_atom head body ''
+test_atom head contents 'Initial
+'
+
+test_atom tag refname refs/tags/testtag
+test_atom tag objecttype tag
+test_atom tag objectsize 154
+test_atom tag objectname 98b46b1d36e5b07909de1b3886224e3e81e87322
+test_atom tag tree ''
+test_atom tag parent ''
+test_atom tag numparent ''
+test_atom tag object '67a36f10722846e891fbada1ba48ed035de75581'
+test_atom tag type 'commit'
+test_atom tag author ''
+test_atom tag authorname ''
+test_atom tag authoremail ''
+test_atom tag authordate ''
+test_atom tag committer ''
+test_atom tag committername ''
+test_atom tag committeremail ''
+test_atom tag committerdate ''
+test_atom tag tag 'testtag'
+test_atom tag tagger 'C O Mitter <committer@example.com> 1151939925 +0200'
+test_atom tag taggername 'C O Mitter'
+test_atom tag taggeremail '<committer@example.com>'
+test_atom tag taggerdate 'Mon Jul 3 17:18:45 2006 +0200'
+test_atom tag creator 'C O Mitter <committer@example.com> 1151939925 +0200'
+test_atom tag creatordate 'Mon Jul 3 17:18:45 2006 +0200'
+test_atom tag subject 'Tagging at 1151939927'
+test_atom tag body ''
+test_atom tag contents 'Tagging at 1151939927
 '
 
 test_expect_success 'Check invalid atoms names are errors' '
-	! git-for-each-ref --format="%(INVALID)" refs/heads
+	test_must_fail git-for-each-ref --format="%(INVALID)" refs/heads
 '
 
 test_expect_success 'Check format specifiers are ignored in naming date atoms' '
@@ -64,7 +117,7 @@ test_expect_success 'Check valid format specifiers for date fields' '
 '
 
 test_expect_success 'Check invalid format specifiers are errors' '
-	! git-for-each-ref --format="%(authordate:INVALID)" refs/heads
+	test_must_fail git-for-each-ref --format="%(authordate:INVALID)" refs/heads
 '
 
 cat >expected <<\EOF
-- 
1.5.6.129.g8dea5.dirty
