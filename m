From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] write_sha1_file(): do not use a separate sha1[] array
Date: Mon,  4 May 2015 14:37:31 -0700
Message-ID: <1430775451-31130-5-git-send-email-gitster@pobox.com>
References: <1430724315-524-1-git-send-email-sunshine@sunshineco.com>
 <1430775451-31130-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 23:37:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpO3o-0001N2-33
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 23:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbbEDVhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 17:37:51 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64286 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752331AbbEDVhj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 17:37:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EBD774FA24;
	Mon,  4 May 2015 17:37:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=QLpu
	YjUdYh2GFD6e67dyBNxr+7Q=; b=kRbAuyFxAeLh+cSmvo/SAjEbeBoWTkkLOZBx
	Ded5gkDLD1jCi1Adra190Cecdlv4WPe/cujbEvIDjQDQwQgYbwRJIPdF6SwjY4e+
	OFboH1xYNUb4+dCwD4sViwyaPnGWcSHaK111uXe7DBxrG/wVmgv8alnvq4uU4PDl
	H3dK9mc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=WGIWGo
	hXCVmAhy4x8sKZRgvdrwB7N2cl+Vl39IOof41tr5ZnKkBK1A4Q651ciEQKx+/+qJ
	XKscpUQ6T+oE+2e3u6yNTq2BYA3togavVA4fS0OllA7m5zm+4s7/W1GENtRQ/blM
	A9wtdJeuBcFPWiBmsAQo3qSNOTZGLZHsCF7Ko=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E5DB94FA23;
	Mon,  4 May 2015 17:37:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6EE414FA22;
	Mon,  4 May 2015 17:37:38 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-307-g8f38e3e
In-Reply-To: <1430775451-31130-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C90E9320-F2A5-11E4-9D0D-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268361>

In the beginning, write_sha1_file() did not have a way to tell the
caller the name of the object it wrote to the caller.  This was
changed in d6d3f9d0 (This implements the new "recursive tree"
write-tree., 2005-04-09) by adding the "returnsha1" parameter to the
function so that the callers who are interested in the value can
optionally pass a pointer to receive it.

It turns out that all callers do want to know the name of the object
it just has written.  Nobody passes a NULL to this parameter, hence
it is not necessary to use a separate sha1[] array to receive the
result from  write_sha1_file_prepare(), and copy the result to the
returnsha1 supplied by the caller.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is something I noticed while in the vicinity.

 sha1_file.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 0fe3f29..cec0ef2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2945,9 +2945,8 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	return move_temp_to_file(tmp_file, filename);
 }
 
-int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
+int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1)
 {
-	unsigned char sha1[20];
 	char hdr[32];
 	int hdrlen;
 
@@ -2955,8 +2954,6 @@ int write_sha1_file(const void *buf, unsigned long len, const char *type, unsign
 	 * it out into .git/objects/??/?{38} file.
 	 */
 	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
-	if (returnsha1)
-		hashcpy(returnsha1, sha1);
 	if (has_sha1_file(sha1))
 		return 0;
 	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
-- 
2.4.0-302-g6743426
