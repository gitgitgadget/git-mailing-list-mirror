From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 2/4] apply: do not read from the filesystem under --index
Date: Tue, 10 Feb 2015 14:36:09 -0800
Message-ID: <1423607771-27157-3-git-send-email-gitster@pobox.com>
References: <1423010662-26497-1-git-send-email-gitster@pobox.com>
 <1423607771-27157-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 23:36:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLJPu-000540-Fu
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 23:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066AbbBJWgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 17:36:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752916AbbBJWgS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 17:36:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 584C73749E;
	Tue, 10 Feb 2015 17:36:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=vt29
	B2X6DP/hjkmY+s1KvM+p9ho=; b=IVIN02SbGiVy+mh4JD5JX1l1jIj+9kY7iZ/E
	HvaObrR7sfHGdaU0BOLeMNzbp8AqaRU+TcQ0363zDiVWkZrpXabgUM0yPZX0y2xN
	/mOdBnleZwhBiuqaHUHx/DCQ/KsWmOIiaAl+Sgdv79Vml8wBBGP/I97QovuqOYpG
	whRGQ8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=A1LKwc
	pLGAywCMnlGSXyhj96l0crbcRFhWf5UlWA2INDbvjmMTLnTJ0OfUuScZfwPqlmdo
	aROGHMUCtSmaEznjQxuBgJdOy+6f+QKP2XABc5fYj78WNBNTvzQ1FXYKAFznWTR1
	EaObnX7zvOtEtsNg6ifOY9u2dUCTe4WpnwkJc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 346963749D;
	Tue, 10 Feb 2015 17:36:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A8EE13749C;
	Tue, 10 Feb 2015 17:36:16 -0500 (EST)
X-Mailer: git-send-email 2.3.0-185-g073f588
In-Reply-To: <1423607771-27157-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 39CD8D68-B175-11E4-8978-38A39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263654>

We currently read the preimage to apply a patch from the index only
when the --cached option is given.  Do so also when the command is
running under the --index option.  With --index, the index entry and
the working tree file for a path that is involved in a patch must be
identical, so this should not affect the result, but by reading from
the index, we will get the protection to avoid reading an unintended
path beyond a symbolic link automatically.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 8561236..21e45a0 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3136,7 +3136,7 @@ static int load_patch_target(struct strbuf *buf,
 			     const char *name,
 			     unsigned expected_mode)
 {
-	if (cached) {
+	if (cached || check_index) {
 		if (read_file_or_gitlink(ce, buf))
 			return error(_("read of %s failed"), name);
 	} else if (name) {
-- 
2.3.0-185-g073f588
