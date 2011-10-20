From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [IGNORETHIS/PATCH] Choosing the sha1 prefix of your commits
Date: Thu, 20 Oct 2011 11:36:48 -0700
Message-ID: <7vehy7a4sf.fsf_-_@alter.siamese.dyndns.org>
References: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
 <20111019190114.GA4670@sigill.intra.peff.net>
 <20111019193834.GA14168@sigill.intra.peff.net>
 <7vvcrk9td7.fsf@alter.siamese.dyndns.org>
 <20111020043448.GA7628@sigill.intra.peff.net>
 <7vr5289mlu.fsf@alter.siamese.dyndns.org>
 <20111020071356.GA14945@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 20 20:36:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGxU8-0004JX-G8
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 20:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354Ab1JTSgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 14:36:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36781 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042Ab1JTSgv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 14:36:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 979DB4DAD;
	Thu, 20 Oct 2011 14:36:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HvPgPPqhqREx0bwJMP2Orre6n7g=; b=fzw48G
	Rp1wUZ4LsmWF7scltjcbDy4XLeSoeOe593cIKcXxgyslrX3q+jYtM8ph26UZteon
	xeSjMvYxT8kh1+zNyUXgSIHPgRgoqD9+RbwzZ0EW7B25yMQrHed4UZaWawpvlwm1
	t8PTTkZlGGF1SIyipiwcSUH192LjWtmXRbsI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bcK32CmYhpo8AkI3fr4pNGwDhF2O/4U1
	cCfVlGTuR3YQL4BgTaUGP+NSED4OM6RPeI/uEcPJvAYwBphlqLAnsd867Eto6D6r
	uZf4pThaJEWc2e+P/nIQpb38e63pO1eS3REBOh5BJMbej7IL/P6Nhr57jM9vyHak
	onZXh6dDriI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EA2D4DAB;
	Thu, 20 Oct 2011 14:36:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7A354DAA; Thu, 20 Oct 2011
 14:36:49 -0400 (EDT)
In-Reply-To: <20111020071356.GA14945@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 20 Oct 2011 03:13:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 790EDCDC-FB4A-11E0-B879-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184033>

Jeff King <peff@peff.net> writes:

> It's not that the commit is bad or the source of problems. My point is
> that the assumption that commit messages are NUL-terminated has been
> there for a really long time, so there are lots of spots in the code
> that sloppily run string functions on them. Every one of those needs to
> be found and fixed (e.g., I remember seeing this in
> for-each-ref.c:find_subpos recently).
>
> It's not impossible, of course, or even really that hard. It's just a
> giant pain, and I wonder if the effort is worth it.

True.

It probably is not worth it for most applications, but this fix-up to a
fairly recent one is worth doing, I would suspect.

-- >8 --
Subject: parse_signed_commit: really use the entire commit log message

... even beyond the first NUL in the buffer, when checking the commit
against the detached signature in the header.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c                 |   11 +++++------
 t/t7510-signed-commit.sh |   21 ++++++++++++++++-----
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/commit.c b/commit.c
index 93045a2..6ec49fa 100644
--- a/commit.c
+++ b/commit.c
@@ -854,28 +854,27 @@ int parse_signed_commit(const unsigned char *sha1,
 	unsigned long size;
 	enum object_type type;
 	char *buffer = read_sha1_file(sha1, &type, &size);
-	int in_header, saw_signature = -1;
+	int saw_signature = -1;
 	char *line;
 
 	if (!buffer || type != OBJ_COMMIT)
 		goto cleanup;
 
 	line = buffer;
-	in_header = 1;
 	saw_signature = 0;
-	while (*line) {
+	while (line < buffer + size) {
 		char *next = strchrnul(line, '\n');
 		if (*next)
 			next++;
-		if (in_header && !prefixcmp(line, gpg_sig_header)) {
+		if (!prefixcmp(line, gpg_sig_header)) {
 			const char *sig = line + gpg_sig_header_len;
 			strbuf_add(signature, sig, next - sig);
 			saw_signature = 1;
 		} else {
+			if (*line == '\n')
+				next = buffer + size; /* dump the whole remainder */
 			strbuf_add(payload, line, next - line);
 		}
-		if (*line == '\n')
-			in_header = 0;
 		line = next;
 	}
  cleanup:
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 5c7475d..30401ce 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -50,11 +50,22 @@ test_expect_success GPG 'show signatures' '
 
 test_expect_success GPG 'detect fudged signature' '
 	git cat-file commit master >raw &&
-	sed -e "s/fourth signed/4th forged/" raw >forged &&
-	git hash-object -w -t commit forged >forged.commit &&
-	git show --pretty=short --show-signature $(cat forged.commit) >actual &&
-	grep "BAD signature from" actual &&
-	! grep "Good signature from" actual
+
+	sed -e "s/fourth signed/4th forged/" raw >forged1 &&
+	git hash-object -w -t commit forged1 >forged1.commit &&
+	git show --pretty=short --show-signature $(cat forged1.commit) >actual1 &&
+	grep "BAD signature from" actual1 &&
+	! grep "Good signature from" actual1
+'
+
+test_expect_success GPG 'detect fudged signature with NUL' '
+	git cat-file commit master >raw &&
+	cat raw >forged2 &&
+	echo Qwik | tr "Q" "\000" >>forged2 &&
+	git hash-object -w -t commit forged2 >forged2.commit &&
+	git show --pretty=short --show-signature $(cat forged2.commit) >actual2 &&
+	grep "BAD signature from" actual2 &&
+	! grep "Good signature from" actual2
 '
 
 test_done
