From: Jeff King <peff@peff.net>
Subject: Re: git gc gives "error: Could not read..."
Date: Mon, 1 Jun 2015 04:52:26 -0400
Message-ID: <20150601085226.GA20537@peff.net>
References: <556C0BAD.80106@atlas-elektronik.com>
 <20150601081450.GA32634@peff.net>
 <556C1A95.9010704@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git list <git@vger.kernel.org>
To: Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 10:52:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzLST-00053v-UP
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 10:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbbFAIwa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jun 2015 04:52:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:38646 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751586AbbFAIw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 04:52:29 -0400
Received: (qmail 14926 invoked by uid 102); 1 Jun 2015 08:52:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 03:52:29 -0500
Received: (qmail 27376 invoked by uid 107); 1 Jun 2015 08:52:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 04:52:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Jun 2015 04:52:26 -0400
Content-Disposition: inline
In-Reply-To: <556C1A95.9010704@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270382>

On Mon, Jun 01, 2015 at 10:40:53AM +0200, Stefan N=C3=A4we wrote:

> Turns out to be a tree:
>=20
> tree 7713c3b1e9ea2dd9126244697389e4000bb39d85
> parent d7acfc22fbc0fba467d82f41c90aab7d61f8d751
> author Stefan Naewe <stefan.naewe@atlas-elektronik.com> 1429536806 +0=
200
> committer Stefan Naewe <stefan.naewe@atlas-elektronik.com> 1429536806=
 +0200

Yeah, I bungled the grep earlier. That message can come from a missing
tag, tree, or commit object. But I think the root cause is the same.

> Not exactly. My msysgit is merge-rebase'd (or rebase-merge'd...) onto=
 v2.2.0...
> I'll try older versions (pre v2.2.0) on linux.

OK, that makes more sense then.

> I also cloned from local filesystem (widnows drive) to a samba share.

And that, too.

I've managed to create a small test case that replicates the problem:

diff --git a/t/t6501-freshen-objects.sh b/t/t6501-freshen-objects.sh
index 157f3f9..015b0da 100755
--- a/t/t6501-freshen-objects.sh
+++ b/t/t6501-freshen-objects.sh
@@ -129,4 +129,19 @@ for repack in '' true; do
 	'
 done
=20
+test_expect_failure 'do not complain about existing broken links' '
+	cat >broken-commit <<-\EOF &&
+	tree 0000000000000000000000000000000000000001
+	parent 0000000000000000000000000000000000000002
+	author whatever <whatever@example.com> 1234 -0000
+	committer whatever <whatever@example.com> 1234 -0000
+
+	some message
+	EOF
+	commit=3D$(git hash-object -t commit -w broken-commit) &&
+	git gc 2>stderr &&
+	verbose git cat-file -e $commit &&
+	test_must_be_empty stderr
+'
+
 test_done

which produces:

  'stderr' is not empty, it contains:
  error: Could not read 0000000000000000000000000000000000000002
  error: Could not read 0000000000000000000000000000000000000001
  error: Could not read 0000000000000000000000000000000000000002
  error: Could not read 0000000000000000000000000000000000000001

Unfortunately the fix is a little bit invasive. I'll send something out
in a few minutes.

-Peff
