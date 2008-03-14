From: Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH] Add MIME information to outgoing email
Date: Fri, 14 Mar 2008 17:27:07 -0400
Message-ID: <20080314212707.GA1027@coredump.intra.peff.net>
References: <1205426419-4594-1-git-send-email-sam@rfc1149.net> <20080313170016.GA3439@sigill.intra.peff.net> <7v4pb9qnuu.fsf@gitster.siamese.dyndns.org> <7vbq5hoy48.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Samuel Tardieu <sam@rfc1149.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 22:28:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaHRP-0000EN-7i
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 22:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693AbYCNV1M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Mar 2008 17:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754799AbYCNV1L
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 17:27:11 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3590 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754998AbYCNV1K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Mar 2008 17:27:10 -0400
Received: (qmail 32059 invoked by uid 111); 14 Mar 2008 21:27:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 14 Mar 2008 17:27:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Mar 2008 17:27:07 -0400
Content-Disposition: inline
In-Reply-To: <7vbq5hoy48.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77285>

On Fri, Mar 14, 2008 at 01:21:27PM -0700, Junio C Hamano wrote:

> I think the real culprit was the way the "after_subject" was added to=
 the
> callchain (it had loaded semantics -- "here is what we want to say af=
ter
> emitting Subject: line" and "have we done any MIME yet?"), not the po=
or
> guy who did format.headers.
>=20
> In any case, this patch would hopefully separate the two.  The old
> "plain_non_ascii" parameter is now need_8bit_ct_header and now can ha=
ve
> one of three values:

I was just about to submit a patch splitting after_subject into
"mime_headers" and "extra_headers".

I noticed another bug while doing mine: we are sometimes not strict
_enough_ in squelching headers. A patch made with "-s --attach" when th=
e
signoff has non-ascii characters would end up with duplicated MIME
headers. Your patch handles this fine.

I think your approach is a little nicer. Here is the test case I wrote
for my patch. It covers the original problem and the one I mentioned
above; both fail with current master but pass with your patch.

---
diff --git a/t/t4021-format-patch-signer-mime.sh b/t/t4021-format-patch=
-signer-mime.sh
index 67a70fa..9bc47a5 100755
--- a/t/t4021-format-patch-signer-mime.sh
+++ b/t/t4021-format-patch-signer-mime.sh
@@ -38,5 +38,13 @@ test_expect_success 'format with non ASCII signer na=
me' '
=20
 '
=20
+test_expect_success 'attach and signoff do not duplicate mime headers'=
 '
+
+	GIT_COMMITTER_NAME=3D"=1B$B$O$^$N=1B(B =1B$B$U$K$*$&=1B(B" \
+	git format-patch -s --stdout -1 --attach >output &&
+	test `grep -ci ^MIME-Version: output` =3D 1
+
+'
+
 test_done
=20
diff --git a/t/t4028-format-patch-mime-headers.sh b/t/t4028-format-patc=
h-mime-headers.sh
new file mode 100755
index 0000000..204ba67
--- /dev/null
+++ b/t/t4028-format-patch-mime-headers.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description=3D'format-patch mime headers and extra headers do not=
 conflict'
+. ./test-lib.sh
+
+test_expect_success 'create commit with utf-8 body' '
+	echo content >file &&
+	git add file &&
+	git commit -m one &&
+	echo more >>file &&
+	git commit -a -m "two
+
+	utf-8 body: =C3=B1"
+'
+
+test_expect_success 'patch has mime headers' '
+	rm -f 0001-two.patch &&
+	git format-patch HEAD^ &&
+	grep -i "content-type: text/plain; charset=3Dutf-8" 0001-two.patch
+'
+
+test_expect_success 'patch has mime and extra headers' '
+	rm -f 0001-two.patch &&
+	git config format.headers "x-foo: bar" &&
+	git format-patch HEAD^ &&
+	grep -i "x-foo: bar" 0001-two.patch &&
+	grep -i "content-type: text/plain; charset=3Dutf-8" 0001-two.patch
+'
+
+test_done
