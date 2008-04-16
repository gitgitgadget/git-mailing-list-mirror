From: Jeff King <peff@peff.net>
Subject: Re: Friendly refspecs
Date: Wed, 16 Apr 2008 00:25:14 -0400
Message-ID: <20080416042514.GA22179@sigill.intra.peff.net>
References: <20080409101428.GA2637@elte.hu> <20080409145758.GB20874@sigill.intra.peff.net> <20080409200836.GA19248@mithlond> <20080409203453.GA10370@sigill.intra.peff.net> <20080409222500.GB19248@mithlond> <20080409225112.GB12103@sigill.intra.peff.net> <20080413093102.GC12107@mithlond.arda.local> <20080416034823.GA11727@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Apr 16 07:53:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlzDe-0005i5-TZ
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 06:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbYDPEZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 00:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbYDPEZR
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 00:25:17 -0400
Received: from [208.65.91.99] ([208.65.91.99]:3419 "EHLO peff.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbYDPEZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 00:25:16 -0400
Received: (qmail 10990 invoked by uid 111); 16 Apr 2008 04:25:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 16 Apr 2008 00:25:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Apr 2008 00:25:14 -0400
Content-Disposition: inline
In-Reply-To: <20080416034823.GA11727@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79672>

On Tue, Apr 15, 2008 at 11:48:23PM -0400, Jeff King wrote:

> ISTR some discussion in the past few months about using the type of
> <branch1> to guess the type of <branch2>, but it seems not to have gone
> anywhere.
> 
> Daniel, were you working on this?

Hmm. Here is a quick patch I worked up, but it causes t5516:14 (push
with ambiguity) to fail. However, I'm not sure the test is right: it
looks like it's trying to find ambiguity between remotes/origin/master
and remotes/frotz/master, but in fact matches _neither_ of them. So it
was failing before as we expected, but for the wrong reason.

---
 remote.c              |   23 +++++++++++++++++++----
 t/t5516-fetch-push.sh |    8 ++++++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/remote.c b/remote.c
index 08af7f9..2f5d062 100644
--- a/remote.c
+++ b/remote.c
@@ -851,10 +851,25 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	case 0:
 		if (!memcmp(dst_value, "refs/", 5))
 			matched_dst = make_linked_ref(dst_value, dst_tail);
-		else
-			error("dst refspec %s does not match any "
-			      "existing ref on the remote and does "
-			      "not start with refs/.", dst_value);
+		else {
+			/*
+			 * We don't have a full ref name for the dst and
+			 * it doesn't exist, so let's assume it's the same
+			 * type as our src.
+			 */
+			struct strbuf tmp = STRBUF_INIT;
+			const char *c;
+			int slashes;
+			for (c = matched_src->name, slashes = 0;
+					*c && slashes < 2; c++) {
+				strbuf_addch(&tmp, *c);
+				if (*c == '/')
+					slashes++;
+			}
+			strbuf_addstr(&tmp, dst_value);
+			dst_value = strbuf_detach(&tmp, NULL);
+			matched_dst = make_linked_ref(dst_value, dst_tail);
+		}
 		break;
 	default:
 		matched_dst = NULL;
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 793ffc6..370f79a 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -285,6 +285,14 @@ test_expect_success 'push with colon-less refspec (4)' '
 
 '
 
+test_expect_success 'push with non-existant, incomplete dest' '
+
+	mk_test &&
+	git push testrepo master:brandnewbranch &&
+	check_push_result $the_commit heads/brandnewbranch
+
+'
+
 test_expect_success 'push with HEAD' '
 
 	mk_test heads/master &&
-- 
1.5.5.64.geecd2.dirty
