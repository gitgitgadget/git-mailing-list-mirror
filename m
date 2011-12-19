From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote-curl: don't pass back fake refs
Date: Mon, 19 Dec 2011 12:10:55 -0500
Message-ID: <20111219171055.GA21227@sigill.intra.peff.net>
References: <20111217104539.GA23844@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 18:11:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rcgk1-0007yZ-Cl
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 18:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318Ab1LSRK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 12:10:59 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45905
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752182Ab1LSRK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 12:10:57 -0500
Received: (qmail 367 invoked by uid 107); 19 Dec 2011 17:17:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Dec 2011 12:17:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Dec 2011 12:10:55 -0500
Content-Disposition: inline
In-Reply-To: <20111217104539.GA23844@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187459>

On Sat, Dec 17, 2011 at 05:45:39AM -0500, Jeff King wrote:

> Most of the time this bug goes unnoticed, as the fake ref
> won't match our refspecs. However, if "--mirror" is used,
> then we see it as remote cruft to be pruned, and try to pass
> along a deletion refspec for it. Of course this refspec has
> bogus syntax (because of the ^{}), and the helper complains,
> aborting the push.
> 
> Let's have remote-curl mirror what the builtin
> get_refs_via_connect does (at least for the case of using
> git protocol; we can leave the dumb info/refs reader as it
> is).

I did some experimenting, and this also fixes another bug: pushing with
--mirror to a smart-http remote that uses alternates.

The fake ".have" refs that the server produces are similarly bogus and
should not be passed back from remote-curl to the parent git process.
Currently they are, so you get:

  remote part of refspec is not a valid name in :.have

in the --mirror case.

I had thought this patch wouldn't make a difference there, since
get_remote_heads handles ".have" specifically before the check_refname
call. But it only does so if you pass in a non-NULL extra_have_objects
pointer. We do for regular git (since we care about the .haves for
efficiency, obviously).

But for smart-http, we actually end up parsing the refs twice: once to
get the list of refs to hand back to the parent git process, and then
again later in a send-pack subprocess that actually does care about the
.haves. In the first one, we just pass NULL for extra_have, and
get_remote_heads happily adds the bogus ones to the list.

For the same reason that this patch squelches the bogus "capability^{}",
it also squelches the bogus ".have" refs (but of course they are still
in our buffer to be handed to send-pack, so there is no loss of
efficiency).

Perhaps we should squash in the test below, which demonstrates the
breakage. I also wonder if this is maint-worthy.

-Peff

---
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 89232b2..9b85d42 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -168,5 +168,23 @@ test_expect_success 'push --mirror can push to empty repo' '
 	git push --mirror "$HTTPD_URL"/smart/empty-mirror.git
 '
 
+test_expect_success 'push --all to repo with alternates' '
+	s=$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git &&
+	d=$HTTPD_DOCUMENT_ROOT_PATH/alternates-all.git &&
+	git clone --bare --shared "$s" "$d" &&
+	git --git-dir="$d" config http.receivepack true &&
+	git --git-dir="$d" repack -adl &&
+	git push --all "$HTTPD_URL"/smart/alternates-all.git
+'
+
+test_expect_success 'push --mirror to repo with alternates' '
+	s=$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git &&
+	d=$HTTPD_DOCUMENT_ROOT_PATH/alternates-mirror.git &&
+	git clone --bare --shared "$s" "$d" &&
+	git --git-dir="$d" config http.receivepack true &&
+	git --git-dir="$d" repack -adl &&
+	git push --mirror "$HTTPD_URL"/smart/alternates-mirror.git
+'
+
 stop_httpd
 test_done
