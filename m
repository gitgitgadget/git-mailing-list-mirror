From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] A loose object is not corrupt if it cannot be read due
 to EMFILE
Date: Thu, 28 Oct 2010 13:53:30 -0700
Message-ID: <1288299210-27092-2-git-send-email-gitster@pobox.com>
References: <1288299210-27092-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 28 22:53:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBZTo-0007fH-1C
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 22:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759833Ab0J1Uxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 16:53:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47744 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757856Ab0J1Uxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 16:53:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BC3121EF8
	for <git@vger.kernel.org>; Thu, 28 Oct 2010 16:53:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=SxMa
	8Zg9V07KFh5e+CZw+1DHIRo=; b=OmIOlfkAkxlQ86sURCpxMeGs4jFHBGHEuhtp
	C+n8MAeuzmKLE/p7NbVxkJm5TpBtfKFChmN/fTqS9g8sZUjolV17WSP++wHUKX+F
	LtjUPbGRXBDsiSQQaQ093beSnrqXvdP0IdDJzNjHou/Fc5aY8Ld62DKBjYTL4uP4
	V6weWuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=FkxJTe
	MnJBOWy4ySwtBV/RbflmudXunxinKS5Z7yoEBawzlfI5kS8ZFypGJx9CfEM51zp/
	BF/JXKBkkJ/Os8oIvMB1Av7jlwn7s9KoBp3lqbOBAGSIHeTYA/8azFSrJgkjEXEH
	VHmV2Ch5BZHB4qVhoIPhnlgK2VrVY8UgMXiDU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B845F1EF7
	for <git@vger.kernel.org>; Thu, 28 Oct 2010 16:53:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29A3C1EF6 for
 <git@vger.kernel.org>; Thu, 28 Oct 2010 16:53:33 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.2.191.g2d0e57
In-Reply-To: <1288299210-27092-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6E1614D2-E2D5-11DF-80BF-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160224>

"git fsck" bails out with a claim that a loose object that cannot be
read but exists on the filesystem to be corrupt, which is wrong when
read_object() failed due to e.g. EMFILE.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 5ed5497..f709ed6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2090,16 +2090,21 @@ void *read_sha1_file_repl(const unsigned char *sha1,
 			  const unsigned char **replacement)
 {
 	const unsigned char *repl = lookup_replace_object(sha1);
-	void *data = read_object(repl, type, size);
+	void *data;
 	char *path;
 	const struct packed_git *p;
 
+	errno = 0;
+	data = read_object(repl, type, size);
 	if (data) {
 		if (replacement)
 			*replacement = repl;
 		return data;
 	}
 
+	if (errno != ENOENT)
+		die_errno("failed to read object %s", sha1_to_hex(sha1));
+
 	/* die if we replaced an object with one that does not exist */
 	if (repl != sha1)
 		die("replacement %s not found for %s",
-- 
1.7.3.2.191.g2d0e57
