From: Jeff King <peff@peff.net>
Subject: Re: All gnupg tests broken on el4 [Re: [ANNOUNCE] Git v2.3.0-rc2]
Date: Thu, 29 Jan 2015 10:51:11 -0500
Message-ID: <20150129155111.GB742@peff.net>
References: <xmqqpp9ziyqh.fsf@gitster.dls.corp.google.com>
 <54CA3169.4020701@statsbiblioteket.dk>
 <20150129154319.GA742@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
X-From: git-owner@vger.kernel.org Thu Jan 29 16:51:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGrNG-0008K8-LH
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 16:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbbA2PvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2015 10:51:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:43016 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751759AbbA2PvN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2015 10:51:13 -0500
Received: (qmail 26794 invoked by uid 102); 29 Jan 2015 15:51:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Jan 2015 09:51:13 -0600
Received: (qmail 18605 invoked by uid 107); 29 Jan 2015 15:51:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Jan 2015 10:51:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jan 2015 10:51:11 -0500
Content-Disposition: inline
In-Reply-To: <20150129154319.GA742@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263150>

On Thu, Jan 29, 2015 at 10:43:20AM -0500, Jeff King wrote:

> It feels a bit hacky, and I wish I knew more about why the current file
> doesn't work (i.e., if we did "gpg --export-secret-keys" with v1.2.6,
> would it produce different output that can be read by both versions?).
> Another option is to just declare that version old and broken, and skip
> the tests (either by checking its version, or just checking after we
> import the keys that we can actually _use_ them).

That would look like this:

-- >8 --
Subject: [PATCH] t/lib-gpg: sanity-check that we can actually sign

Some older versions of gpg (reportedly v1.2.6 from RHEL4)
cannot import the keyrings found in our test suite, and thus
cannot even make a signature. We can detect this case by
doing a test-sign before declaring the GPG prerequisite
fulfilled.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-gpg.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index d88da29..a87747a 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -34,6 +34,8 @@ else
 			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
 		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import-ownertrust \
 			"$TEST_DIRECTORY"/lib-gpg/ownertrust &&
+		gpg --homedir "${GNUPGHOME}" </dev/null >/dev/null 2>&1 \
+			--sign -u committer@example.com &&
 		test_set_prereq GPG
 		;;
 	esac
-- 
2.3.0.rc1.287.g761fd19
