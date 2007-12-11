From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7004: test that "git-tag -u" implies "-s"
Date: Mon, 10 Dec 2007 20:38:31 -0800
Message-ID: <7v63z5j16g.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.9999.0712101950110.28293@woody.linux-foundation.org>
	<20071211042436.GA23805@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Carlos Rica <jasampler@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 11 05:39:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1wtj-0004rW-Ie
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 05:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbXLKEiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 23:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbXLKEiu
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 23:38:50 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47819 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbXLKEit (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 23:38:49 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 063863A09;
	Mon, 10 Dec 2007 23:38:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 04D553A08;
	Mon, 10 Dec 2007 23:38:34 -0500 (EST)
In-Reply-To: <20071211042436.GA23805@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 10 Dec 2007 23:24:36 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67786>

Jeff King <peff@peff.net> writes:

> Looks good to me, and here's a test. It was trivial to whip up, since I
> wrote a test for almost the identical bug a few days ago (that one was
> "-s implies -a").

Looks good to me.  We should verify both common forms of key-id and also
check a negative case.  This squashes a few of mine on top of yours.

---

 t/t7004-tag.sh |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index c7130c4..a502286 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -640,6 +640,32 @@ test_expect_success 'creating a signed tag with -m message should succeed' '
 	git diff expect actual
 '
 
+get_tag_header implied-sign $commit commit $time >expect
+echo 'Another signed tag' >>expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success '-u implies signed tag' '
+	git-tag -u CDDE430D -m "Another signed tag" implied-sign &&
+	get_tag_msg implied-sign >actual &&
+	git diff expect actual
+'
+
+get_tag_header u-signed-tag $commit commit $time >expect
+echo 'Another message' >>expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success 'sign with a given key id' '
+
+	git tag -u committer@example.com -m "Another message" u-signed-tag &&
+	get_tag_msg u-signed-tag >actual &&
+	git diff expect actual
+
+'
+
+test_expect_success 'sign with an unknown id' '
+
+	! git tag -u author@example.com -m "Another message" o-signed-tag
+
+'
+
 cat >sigmsgfile <<EOF
 Another signed tag
 message in a file.
