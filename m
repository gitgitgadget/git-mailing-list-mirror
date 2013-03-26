From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] make sure a pattern without trailing slash matches a
 directory
Date: Tue, 26 Mar 2013 11:39:31 -0700
Message-ID: <1364323171-20299-5-git-send-email-gitster@pobox.com>
References: <20130323083927.GA25600@sigill.intra.peff.net>
 <1364323171-20299-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, pclouds@gmail.com, avila.jn@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 26 19:40:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKYn6-0002XY-VI
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 19:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760136Ab3CZSjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 14:39:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61020 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760132Ab3CZSjl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 14:39:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBA76A877;
	Tue, 26 Mar 2013 14:39:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=nM6B
	Ne9GLE+Ki488LLScTx2/lpw=; b=MiHON4s5WazqHOwVycv3kcF7mRc5mBCtMYyV
	13gl328Xsd+3KpdYYycSz7UawAQ7hcAk5u0Ye5NR0i+EV5sYFjAHMBMz/5sAD2vo
	LwFsWlN6g+0LLu5dHqon7RY/FcHe9zevW40HPRGe/tEla1RYwxtn28buMGPc9kMS
	Rke+yf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	cjw3C6d2PNPO7Ui+ZiphhLTA28KycSszScpV9coetUwal4+WLUZ/YwiyG+oo/CKH
	oZ5Fge0XK3tLfnq5u4FjtN7zO0IACL9+cVtN/LRLayXB9L+mCG0VfANv47zOw59Z
	sV8U43WHLdVDC6TCSuN4MXslprIhx3JXTL5o86chUKw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD2E6A876;
	Tue, 26 Mar 2013 14:39:40 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E58DA872; Tue, 26 Mar 2013
 14:39:40 -0400 (EDT)
X-Mailer: git-send-email 1.8.2-350-g3df87a1
In-Reply-To: <1364323171-20299-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 84BA63D0-9644-11E2-A1E0-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219181>

From: Jeff King <peff@peff.net>

Prior to v1.8.1.1, with:

  git init
  echo content >foo &&
  mkdir subdir &&
  echo content >subdir/bar &&
  echo "subdir export-ignore" >.gitattributes
  git add . &&
  git commit -m one &&
  git archive HEAD | tar tf -

the resulting archive would contain only "foo" and ".gitattributes",
not subdir.  This was broken with a recent change that intended to
allow "subdir/ export-ignore" to also exclude the directory, but
instead ended up _requiring_ the trailing slash by mistake.

A pattern "subdir" should match any path "subdir", whether it is a
directory or a non-diretory.  A pattern "subdir/" insists that a
path "subdir" must be a directory for it to match.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5002-archive-attr-pattern.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t5002-archive-attr-pattern.sh b/t/t5002-archive-attr-pattern.sh
index 0c847fb..3be809c 100755
--- a/t/t5002-archive-attr-pattern.sh
+++ b/t/t5002-archive-attr-pattern.sh
@@ -27,6 +27,10 @@ test_expect_success 'setup' '
 	echo ignored-only-if-dir/ export-ignore >>.git/info/attributes &&
 	git add ignored-only-if-dir &&
 
+	mkdir -p ignored-without-slash &&
+	echo ignored without slash >ignored-without-slash/foo &&
+	git add ignored-without-slash/foo &&
+	echo ignored-without-slash export-ignore >>.git/info/attributes &&
 
 	mkdir -p one-level-lower/two-levels-lower/ignored-only-if-dir &&
 	echo ignored by ignored dir >one-level-lower/two-levels-lower/ignored-only-if-dir/ignored-by-ignored-dir &&
@@ -49,6 +53,8 @@ test_expect_exists	archive/not-ignored-dir/ignored-only-if-dir
 test_expect_exists	archive/not-ignored-dir/
 test_expect_missing	archive/ignored-only-if-dir/
 test_expect_missing	archive/ignored-ony-if-dir/ignored-by-ignored-dir
+test_expect_missing     archive/ignored-without-slash/ &&
+test_expect_missing     archive/ignored-without-slash/foo &&
 test_expect_exists	archive/one-level-lower/
 test_expect_missing	archive/one-level-lower/two-levels-lower/ignored-only-if-dir/
 test_expect_missing	archive/one-level-lower/two-levels-lower/ignored-ony-if-dir/ignored-by-ignored-dir
-- 
1.8.2-350-g3df87a1
