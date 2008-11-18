From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/9] update-index: add --checkout/--no-checkout to
	update CE_NO_CHECKOUT bit
Date: Tue, 18 Nov 2008 06:33:16 -0500
Message-ID: <20081118113316.GA18610@segfault.peff.net>
References: <1222833849-22129-1-git-send-email-pclouds@gmail.com> <1222833849-22129-2-git-send-email-pclouds@gmail.com> <1222833849-22129-3-git-send-email-pclouds@gmail.com> <1222833849-22129-4-git-send-email-pclouds@gmail.com> <1222833849-22129-5-git-send-email-pclouds@gmail.com> <1222833849-22129-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 12:34:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2Oqp-0000KC-SH
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 12:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbYKRLdU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Nov 2008 06:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbYKRLdU
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 06:33:20 -0500
Received: from peff.net ([208.65.91.99]:2982 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751715AbYKRLdT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 06:33:19 -0500
Received: (qmail 18622 invoked by uid 1000); 18 Nov 2008 11:33:17 -0000
Content-Disposition: inline
In-Reply-To: <1222833849-22129-6-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101270>

On Wed, Oct 01, 2008 at 11:04:05AM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> +test_expect_success 'setup' '
> +	mkdir sub &&
> +	touch 1 2 sub/1 sub/2 &&
> +	git add 1 2 sub/1 sub/2

Mind-boggling, but this manages to break on Solaris. Fix is
below.

-- >8 --
t2104: touch portability fix

Some versions of touch support the syntax:

  touch [MMDDhhmm[yy]] file...

which makes the first argument an optional time
specification. They can get confused by

  touch 1 2 foo bar

as they assume that '1' is a bogus time specification. This
is broken, for example, with /bin/touch on Solaris 8.

To fix it, we'll just reverse the order of arguments so that
an unambiguous argument is in the slot for the optional time
specification.

Signed-off-by: Jeff King <peff@peff.net>
---
Note that this has implications for 'touch "$FOO" "$BAR"'
used in scripts if FOO might be entirely numeric. However, a
quick grep shows we usually touch one file at a time.

 t/t2104-update-index-no-checkout.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t2104-update-index-no-checkout.sh b/t/t2104-update-index=
-no-checkout.sh
index be9f913..37a6861 100755
--- a/t/t2104-update-index-no-checkout.sh
+++ b/t/t2104-update-index-no-checkout.sh
@@ -9,7 +9,7 @@ test_description=3D'git update-index no-checkout bits (=
a.k.a sparse checkout)'
=20
 test_expect_success 'setup' '
 	mkdir sub &&
-	touch 1 2 sub/1 sub/2 &&
+	touch sub/1 sub/2 1 2 &&
 	git add 1 2 sub/1 sub/2
 '
=20
--=20
1.6.0.4.984.gbd0b7
