From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] fetch-pack: fix object_id of exact sha1
Date: Mon, 29 Feb 2016 23:54:53 -0500
Message-ID: <20160301045453.GB19272@sigill.intra.peff.net>
References: <CABaesJK+zuuYAJ6YaEugLMFywMqE8V0W1=_4mJPGDAnfT9yXJg@mail.gmail.com>
 <1456798376-29904-1-git-send-email-gabrielfrancosouza@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 05:55:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aacKs-00046W-Ud
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 05:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbcCAEy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 23:54:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:52215 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750789AbcCAEy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 23:54:56 -0500
Received: (qmail 1371 invoked by uid 102); 1 Mar 2016 04:54:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 23:54:56 -0500
Received: (qmail 4454 invoked by uid 107); 1 Mar 2016 04:55:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 23:55:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Feb 2016 23:54:53 -0500
Content-Disposition: inline
In-Reply-To: <1456798376-29904-1-git-send-email-gabrielfrancosouza@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287997>

On Mon, Feb 29, 2016 at 11:12:56PM -0300, Gabriel Souza Franco wrote:

> Commit 58f2ed0 (remote-curl: pass ref SHA-1 to fetch-pack as well,
> 2013-12-05) added support for specifying a SHA-1 as well as a ref name.
> Add support for specifying just a SHA-1 and set the ref name to the same
> value in this case.
> 
> Signed-off-by: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
> ---
> 
> I did keep the oid variable because ref is uninitialized at that point,
> and this means having to copy either name or old_oid afterwards anyway.

Oh, right. That's why we had the variable in the first place (even in
the original, we could otherwise have gone without the extra variable).

>  builtin/fetch-pack.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

The code looks good to me. Do we need documentation or test updates?

Here's a test that can be squashed in. For documentation, it looks like
we don't cover the "<sha1> <ref>" form at all. That's maybe OK, as it's
mostly for internal use by remote-http (though fetch-pack _is_ plumbing,
so perhaps some other remote-* could make use of it). But perhaps we
should document that "<sha1>" should work.

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index e5f83bf..9b9bec4 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -531,6 +531,20 @@ test_expect_success 'shallow fetch with tags does not break the repository' '
 		git fsck
 	)
 '
+
+test_expect_success 'fetch-pack can fetch a raw sha1' '
+	git init hidden &&
+	(
+		cd hidden &&
+		test_commit 1 &&
+		test_commit 2 &&
+		git update-ref refs/hidden/one HEAD^ &&
+		git config transfer.hiderefs refs/hidden &&
+		git config uploadpack.allowtipsha1inwant true
+	) &&
+	git fetch-pack hidden $(git -C hidden rev-parse refs/hidden/one)
+'
+
 check_prot_path () {
 	cat >expected <<-EOF &&
 	Diag: url=$1
