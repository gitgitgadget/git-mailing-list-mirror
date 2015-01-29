From: Jeff King <peff@peff.net>
Subject: Re: All gnupg tests broken on el4 [Re: [ANNOUNCE] Git v2.3.0-rc2]
Date: Thu, 29 Jan 2015 10:43:20 -0500
Message-ID: <20150129154319.GA742@peff.net>
References: <xmqqpp9ziyqh.fsf@gitster.dls.corp.google.com>
 <54CA3169.4020701@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
X-From: git-owner@vger.kernel.org Thu Jan 29 16:43:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGrFf-0008Ji-RO
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 16:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177AbbA2PnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2015 10:43:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:43011 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751815AbbA2PnW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2015 10:43:22 -0500
Received: (qmail 26456 invoked by uid 102); 29 Jan 2015 15:43:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Jan 2015 09:43:22 -0600
Received: (qmail 18574 invoked by uid 107); 29 Jan 2015 15:43:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Jan 2015 10:43:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jan 2015 10:43:20 -0500
Content-Disposition: inline
In-Reply-To: <54CA3169.4020701@statsbiblioteket.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263149>

On Thu, Jan 29, 2015 at 02:11:05PM +0100, Tom G. Christensen wrote:

> All signed commit tests fail on RHEL4 which is a regression from 2.2.2.
> 
> From t4202.42:
> 
> ++ git tag -s -m signed_tag_msg signed_tag
> gpg: key CDDE430D: secret key without public key - skipped
> gpg: skipped `C O Mitter <committer@example.com>': secret key not available
> gpg: signing failed: secret key not available
> error: gpg failed to sign the data
> error: unable to sign the tag
> error: last command exited with $?=128
> 
> There are indeed no public keys available after commit 1e3eef which seems to
> be contrary to the commit log:
> ----
>    Instead import public and secret keys for one key pair from a text
>    file that holds ASCII-armored export of them.
> ----
> 
> I extracted the pubkeys as ascii armored text from the old binary keyrings
> and added them to the new keyring.gpg and then the tests pass.
> 
> This is apparently only a problem for older gnupg versions (RHEL4 has gnupg
> 1.2.6) since it did not fail on RHEL5 (gnupg 1.4.5).

Weird. The pubkeys are there in keyring.gpg; I wonder why the older
version of gpg has trouble extracting them (and how one was _supposed_
to export secret keys at that time).

So if I understand you correctly, the tests should pass with the patch
below?

It feels a bit hacky, and I wish I knew more about why the current file
doesn't work (i.e., if we did "gpg --export-secret-keys" with v1.2.6,
would it produce different output that can be read by both versions?).
Another option is to just declare that version old and broken, and skip
the tests (either by checking its version, or just checking after we
import the keys that we can actually _use_ them).

-- >8 --
Subject: [PATCH] t/lib-gpg: include separate public keys in keyring.gpg

Since 1e3eefb (tests: replace binary GPG keyrings with
ASCII-armored keys, 2014-12-12), we import our test GPG keys
from a single file. Each keypair in the import stream
contains both the secret and public keys. However, older
versions of gpg reportedly fail to import the public half of
the key. We can solve this by including duplicates of the
public keys separately. The duplicates are ignored by modern
gpg, and this makes older versions work.

Reported by Tom G. Christensen <tgc@statsbiblioteket.dk> on
gpg 1.2.6 (from RHEL4).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-gpg.sh          |  2 ++
 t/lib-gpg/keyring.gpg | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index d88da29..16e0d3f 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -23,6 +23,8 @@ else
 		# To write armored exported key to keyring:
 		#	gpg --homedir /tmp/gpghome --export-secret-keys \
 		#		--armor 0xDEADBEEF >> lib-gpg/keyring.gpg
+		#	gpg --homedir /tmp/gpghome --export \
+		#		--armor 0xDEADBEEF >> lib-gpg/keyring.gpg
 		# To export ownertrust:
 		#	gpg --homedir /tmp/gpghome --export-ownertrust \
 		#		> lib-gpg/ownertrust
diff --git a/t/lib-gpg/keyring.gpg b/t/lib-gpg/keyring.gpg
index fb1f048..d4754a1 100644
--- a/t/lib-gpg/keyring.gpg
+++ b/t/lib-gpg/keyring.gpg
@@ -86,3 +86,57 @@ Z9Ei+zj6JD5Pcdi3BJhQo9WOLOVEJ0NHmewTYqk9QVXH/0v1Hdl4LMJtgcbdbDWk
 BOW78WUxzhu0YJTLKy+iKCjg5HS5dx6OC+e4aEEgfhNPCMkbvDsJjtQ=
 =hieJ
 -----END PGP PRIVATE KEY BLOCK-----
+-----BEGIN PGP PUBLIC KEY BLOCK-----
+Version: GnuPG v1
+
+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
+=iYv/
+-----END PGP PUBLIC KEY BLOCK-----
-- 
2.3.0.rc1.287.g761fd19
