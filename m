From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff returns fatal error with core.safecrlf is set to true.
Date: Mon, 24 Jun 2013 14:48:45 -0700
Message-ID: <7vli5z6uyq.fsf@alter.siamese.dyndns.org>
References: <6a3d8a2b19a859d8c969ee434e1d6a89@meuh.org>
	<7vobazo4ds.fsf@alter.siamese.dyndns.org>
	<7vip17ktyz.fsf@alter.siamese.dyndns.org>
	<b8e932cba326588db09ebd0986913ac2@meuh.org>
	<7vbo6v9xrr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 23:48:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrEd3-0005ac-7s
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 23:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131Ab3FXVst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 17:48:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45845 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958Ab3FXVss (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 17:48:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABAC32B84B;
	Mon, 24 Jun 2013 21:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7Z/XF3/M/LvHyHR+t/6dXi8Rq2o=; b=QNLiR4
	jCEf7MuUfiuAdSewDARj7Mny4BB0TwY5yFkqNleY/LT5KsgyOyum8bloNbQEMEaa
	7DYRHRt+ktbzLP2bcGVIlcQ2Rj+VJnc0U8PC7js3rzKMZBVulLMGZ1BL4A7LRqbm
	KArkEeg3PyjEn3XT0jHg8unONNRIkkEGNghrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aM7oCr0R16StPb+YS7BJh04RNy3+gk9H
	ktRzAiHCI6ph0QL3r44TtJM/xX/VT+2DZ++1s0ZZqqgi5ngavPlIuxlTOywScS4y
	361V+qqQLBmeNKTGe9iYU48SFR7UfoIH940zyYlHYdYtITKGX+Y7SbWCHMUF+KWL
	j3S/Ti6uOag=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2D822B84A;
	Mon, 24 Jun 2013 21:48:47 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E9472B848;
	Mon, 24 Jun 2013 21:48:46 +0000 (UTC)
In-Reply-To: <7vbo6v9xrr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 24 Jun 2013 11:19:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D916ED80-DD17-11E2-93B9-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228910>

Junio C Hamano <gitster@pobox.com> writes:

> Care to turn it into an appliable patch with tests?

In the meantime, here is a quick-and-dirty one.  I am not proud of
it; it was just something to keep in 'pu' let it gets lost.

A better replacement is very much welcomed.

-- >8 --
Subject: [PATCH] diff: demote core.safecrlf=true to core.safecrlf=warn

Otherwise the user will not be able to start to guess where in the
contents in the working tree the offending unsafe CR lies.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c          | 6 +++++-
 t/t0020-crlf.sh | 8 ++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 32142db..155857c 100644
--- a/diff.c
+++ b/diff.c
@@ -2647,6 +2647,10 @@ static int diff_populate_gitlink(struct diff_filespec *s, int size_only)
 int diff_populate_filespec(struct diff_filespec *s, int size_only)
 {
 	int err = 0;
+	enum safe_crlf crlf_warn = (safe_crlf != SAFE_CRLF_FAIL
+				    ? safe_crlf
+				    : SAFE_CRLF_WARN);
+
 	if (!DIFF_FILE_VALID(s))
 		die("internal error: asking to populate invalid file.");
 	if (S_ISDIR(s->mode))
@@ -2702,7 +2706,7 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 		/*
 		 * Convert from working tree format to canonical git format
 		 */
-		if (convert_to_git(s->path, s->data, s->size, &buf, safe_crlf)) {
+		if (convert_to_git(s->path, s->data, s->size, &buf, crlf_warn)) {
 			size_t size = 0;
 			munmap(s->data, s->size);
 			s->should_munmap = 0;
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 1a8f44c..e526184 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -81,6 +81,14 @@ test_expect_success 'safecrlf: print warning only once' '
 	test $(git add doublewarn 2>&1 | grep "CRLF will be replaced by LF" | wc -l) = 1
 '
 
+
+test_expect_success 'safecrlf: git diff demotes safecrlf=true to warn' '
+	git config core.autocrlf input &&
+	git config core.safecrlf true &&
+	git diff HEAD
+'
+
+
 test_expect_success 'switch off autocrlf, safecrlf, reset HEAD' '
 	git config core.autocrlf false &&
 	git config core.safecrlf false &&
-- 
1.8.3.1-771-gb7c3f25
