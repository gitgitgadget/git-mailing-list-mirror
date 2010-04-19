From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] patch-id: Add support for mbox format
Date: Mon, 19 Apr 2010 14:48:33 -0700
Message-ID: <7vy6gjp0zy.fsf@alter.siamese.dyndns.org>
References: <7vfx2ubxz1.fsf@alter.siamese.dyndns.org>
 <1271666774-11619-1-git-send-email-bonzini@gnu.org>
 <1271666774-11619-2-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Apr 19 23:48:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3ypk-0004dl-Pk
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 23:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658Ab0DSVsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 17:48:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32963 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178Ab0DSVsm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 17:48:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EF81ACA9E;
	Mon, 19 Apr 2010 17:48:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=bYGr1WD3DgNxsU+YshClz00M+KE=; b=xhIJn7+ovs3JMAYgqiaPW1A
	qzBfkWhkKeSlFUjR3GF59UZpEadeZahzy8ZNGxUXeZi9H987KKpKRRVngr/R0w1Y
	zxLpM0US92XtxdcuIJx5eQNF+ij/HHT2uhNOVghZopXKY9LyH0dCue4/JU4mbVCp
	DjanuVf3iORLEOXWc1CY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=NdeCdW0FLfIFYK2ojUKCCHhFsMNDxRAOEorjy0tmcvTqFYq2z
	NUKeEYUADfyCrQEYIOAMscJCDByrWezwXoZxAgWDAq+FIK3e/29wTbABSWD7W4pF
	tBJJJffUPtUETF9CYIYIkGUM2Wr1ACA+tpwOnCUIwmA7euWFsW45+9y2AI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E0074ACA9C;
	Mon, 19 Apr 2010 17:48:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12A90ACA97; Mon, 19 Apr
 2010 17:48:34 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4F9CBA3E-4BFD-11DF-9740-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145332>

Paolo Bonzini <bonzini@gnu.org> writes:

> This patch adds hunk parsing logic to git patch-id in order to detect an
> out of place "-" line and split the patch when it comes.  In addition,
> commit ids in the "From " lines are considered and printed in the output.

I don't know how this patch will affect the difficulty of enhancing it to
handle MIME attachments later, but let's say we won't worry about it for
now, because we do not even know if we want to do so at this moment.

I fixed up some style issues locally before applying, but please be
careful next time.

 - One SP after a keyword used in syntactic constructs (e.g. "if (cond)",
   not "while(cond)"); your patches were fine wrt this;

 - No SP after a function (e.g. "memcpy(args...)", not "memcpy (args...)").

Also please be careful when calling get_sha1_hex(); an unsuccessful call
to this function is allowed to clobber the buffer.  In addition to the
style fixes, I squashed something like this (not exactly this).

Thanks.

 builtin/patch-id.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 40af5c7..4785411 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -61,7 +61,8 @@ int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx)
 {
 	static char line[1000];
 	int patchlen = 0;
-	int before = -1, after = -1;
+	int before = -1, after = -1, found_next = 0;
+
 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		char *p = line;
 		int len;
@@ -73,8 +74,10 @@ int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx)
 		else if (!memcmp(line, "From ", 5))
 			p += 5;
 
-		if (!get_sha1_hex(p, next_sha1))
+		if (!get_sha1_hex(p, next_sha1)) {
+			found_next = 1;
 			break;
+		}
 
 		/* Ignore commit comments */
 		if (!patchlen && memcmp(line, "diff ", 5))
@@ -117,6 +120,8 @@ int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx)
 		patchlen += len;
 		git_SHA1_Update(ctx, line, len);
 	}
+	if (!found_next)
+		hashclr(next_sha1);
 	return patchlen;
 }
 
@@ -128,8 +133,8 @@ static void generate_id_list(void)
 	int patchlen;
 
 	git_SHA1_Init(&ctx);
+	hashclr(sha1);
 	while (!feof(stdin)) {
-		memset(n, 0, 20);
 		patchlen = get_one_patchid(n, &ctx);
 		flush_current_id(patchlen, sha1, &ctx);
 		hashcpy(sha1, n);
