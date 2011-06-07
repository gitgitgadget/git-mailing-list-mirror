From: Jeff King <peff@peff.net>
Subject: [PATCH 7/8] transport-helper: don't feed bogus refs to export push
Date: Tue, 7 Jun 2011 13:21:11 -0400
Message-ID: <20110607172111.GF22111@sigill.intra.peff.net>
References: <20110607171838.GA21685@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:21:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTzy2-0001HF-0x
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756236Ab1FGRVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 13:21:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50765
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753554Ab1FGRVU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 13:21:20 -0400
Received: (qmail 17183 invoked by uid 107); 7 Jun 2011 17:21:26 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jun 2011 13:21:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2011 13:21:11 -0400
Content-Disposition: inline
In-Reply-To: <20110607171838.GA21685@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175224>

When we want to push to a remote helper that has the
"export" capability, we collect all of the refs we want to
push and then feed them to fast-export.

However, the list of refs is actually a list of remote refs,
not local refs. The mapped local refs are included via the
peer_ref pointer. So when we add an argument to our
fast-export command line, we must be sure to use the local
peer_ref name (and if there is no local name, it is because
we are not actually sending that ref, or we may not even
have the ref at all).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5800-remote-helpers.sh |    2 +-
 transport-helper.c        |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index b28f2b3..a6cc43b 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -102,7 +102,7 @@ test_expect_success PYTHON_24 'fetch multiple branches' '
 	compare_refs server new localclone refs/remotes/origin/new
 '
 
-test_expect_failure PYTHON_24 'push when remote has extra refs' '
+test_expect_success PYTHON_24 'push when remote has extra refs' '
 	(cd clone &&
 	 echo content >>file &&
 	 git commit -a -m six &&
diff --git a/transport-helper.c b/transport-helper.c
index b560b64..34d18aa 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -730,7 +730,8 @@ static int push_refs_with_export(struct transport *transport,
 		}
 		free(private);
 
-		string_list_append(&revlist_args, ref->name);
+		if (ref->peer_ref)
+			string_list_append(&revlist_args, ref->peer_ref->name);
 
 	}
 
-- 
1.7.6.rc0.35.gc40cb
