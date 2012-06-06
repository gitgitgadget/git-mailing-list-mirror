From: Jeff King <peff@peff.net>
Subject: [PATCH] t1304: improve setfacl prerequisite setup
Date: Wed, 6 Jun 2012 09:28:24 -0400
Message-ID: <20120606132824.GA2597@sigill.intra.peff.net>
References: <vpq4nqqj8ss.fsf@bauges.imag.fr>
 <CALbm-EbGoaxkvBXphAPF8rRkS=VFeeFHXQSFdWVrZUJJ8DYovw@mail.gmail.com>
 <vpqk3zlhorc.fsf@bauges.imag.fr>
 <20120605140449.GA15640@sigill.intra.peff.net>
 <20120605141039.GB15640@sigill.intra.peff.net>
 <20120605142813.GA17238@sigill.intra.peff.net>
 <20120605150550.GA19843@sigill.intra.peff.net>
 <7vpq9dpvnp.fsf@alter.siamese.dyndns.org>
 <20120605164439.GA2694@sigill.intra.peff.net>
 <7v62b5pt2s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <stefanbeller@googlemail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 15:36:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScGOv-0006op-Gu
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 15:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652Ab2FFNft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 09:35:49 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:44967
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753452Ab2FFNfs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 09:35:48 -0400
Received: (qmail 1918 invoked by uid 107); 6 Jun 2012 13:28:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Jun 2012 09:28:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jun 2012 09:28:24 -0400
Content-Disposition: inline
In-Reply-To: <7v62b5pt2s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199329>

t1304 first runs setfacl as an experiment to see whether the
filesystem supports ACLs, and skips the remaining tests if
it does not. However, our setfacl run did not exercise the
ACLs very well, and some filesystems may support our initial
setfacl, but not the rest of the test.

In particular, some versions of ecryptfs will erroneously
apply the umask on top of an inherited directory ACL,
causing our tests to fail. Let's be more careful and make
sure both that we can read back the user ACL we set, and
that the inherited ACL is propagated correctly. The latter
catches the ecryptfs bug, but may also catch other bugs
(e.g., an implementation which does not handle inherited
ACLs at all).

Since we're making the setup more complex, let's move it
into its own test. This will hide the output for us unless
the user wants to run "-v" to see it (and we don't need to
bother printing anything about setfacl failing; the
remaining tests will properly print "skip" due to the
missing prerequisite).

Signed-off-by: Jeff King <peff@peff.net>
---
The ecryptfs response was that it is probably a bug, so I think we
should go with this (especially because it is general enough to
potentially catch other weird errors).

 t/t1304-default-acl.sh | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
index 2b962cf..79045ab 100755
--- a/t/t1304-default-acl.sh
+++ b/t/t1304-default-acl.sh
@@ -14,16 +14,15 @@ umask 077
 # We need an arbitrary other user give permission to using ACLs. root
 # is a good candidate: exists on all unices, and it has permission
 # anyway, so we don't create a security hole running the testsuite.
-
-setfacl_out="$(setfacl -m u:root:rwx . 2>&1)"
-setfacl_ret=$?
-
-if test $setfacl_ret != 0
-then
-	say "Unable to use setfacl (output: '$setfacl_out'; return code: '$setfacl_ret')"
-else
-	test_set_prereq SETFACL
-fi
+test_expect_success 'checking for a working acl setup' '
+	if setfacl -m d:m:rwx -m u:root:rwx . &&
+	   getfacl . | grep user:root:rwx &&
+	   touch should-have-readable-acl &&
+	   getfacl should-have-readable-acl | egrep "mask::?rw-"
+	then
+		test_set_prereq SETFACL
+	fi
+'
 
 if test -z "$LOGNAME"
 then
-- 
1.7.11.rc1.4.g0d3b9b3
