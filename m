From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] clone: treat "checking connectivity" like other progress
Date: Wed, 18 Sep 2013 16:06:50 -0400
Message-ID: <20130918200650.GB731@sigill.intra.peff.net>
References: <20130918200152.GA17074@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 18 22:07:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMO1g-0007p6-If
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 22:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639Ab3IRUG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 16:06:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:56961 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686Ab3IRUG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 16:06:59 -0400
Received: (qmail 25401 invoked by uid 102); 18 Sep 2013 20:06:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Sep 2013 15:06:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Sep 2013 16:06:50 -0400
Content-Disposition: inline
In-Reply-To: <20130918200152.GA17074@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234991>

When stderr does not point to a tty, we typically suppress
"we are now in this phase" progress reporting (e.g., we ask
the server not to send us "counting objects" and the like).

The new "checking connectivity" message is in the same vein,
and should be suppressed. Since clone relies on the
transport code to make the decision, we can simply sneak a
peek at the "progress" field of the transport struct. That
properly takes into account both the verbosity and progress
options we were given, as well as the result of isatty().

Note that we do not set up that progress flag for a local
clone, as we do not fetch using the transport at all. That's
acceptable here, though, because we also do not perform a
connectivity check in that case.

Signed-off-by: Jeff King <peff@peff.net>
---
Though the last paragraph explains why this is OK, it feels a bit
fragile. I wonder if we should hoist the call to transport_set_verbosity
outside the "!is_local" conditional. I do not think it would hurt
anything.

 builtin/clone.c          | 4 ++--
 t/t5702-clone-options.sh | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 8723a3a..7c62298 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -550,12 +550,12 @@ static void update_remote_refs(const struct ref *refs,
 	const struct ref *rm = mapped_refs;
 
 	if (check_connectivity) {
-		if (0 <= option_verbosity)
+		if (transport->progress)
 			fprintf(stderr, _("Checking connectivity... "));
 		if (check_everything_connected_with_transport(iterate_ref_map,
 							      0, &rm, transport))
 			die(_("remote did not send all necessary objects"));
-		if (0 <= option_verbosity)
+		if (transport->progress)
 			fprintf(stderr, _("done\n"));
 	}
 
diff --git a/t/t5702-clone-options.sh b/t/t5702-clone-options.sh
index d3dbdfe..9e24ec8 100755
--- a/t/t5702-clone-options.sh
+++ b/t/t5702-clone-options.sh
@@ -22,7 +22,8 @@ test_expect_success 'redirected clone does not show progress' '
 test_expect_success 'redirected clone does not show progress' '
 
 	git clone "file://$(pwd)/parent" clone-redirected >out 2>err &&
-	! grep % err
+	! grep % err &&
+	test_i18ngrep ! "Checking connectivity" err
 
 '
 
-- 
1.8.4.rc4.16.g228394f
