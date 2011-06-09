From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] unpack_compressed_entry(): zlib can only process 4GB at a
 time
Date: Thu, 09 Jun 2011 13:12:33 -0700
Message-ID: <7vvcwewyq6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 22:12:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUlau-0002aR-7G
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 22:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755302Ab1FIUMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 16:12:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40026 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755289Ab1FIUMi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 16:12:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A28045491;
	Thu,  9 Jun 2011 16:14:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=L
	ruPz4xYSNGKWya4VCUFxEPhTM4=; b=jaDhCvJH5+HvnIPVEc2peN79UJjFYDQa+
	DBHWMtJ60P6JR7vf5ZC/4VCZkH6qYhAr6R4ytbMvJy+jOEPbqF0akVJ+LHadhX5D
	KR4O7PDE31/VsTAT8u973lSybzNiQPbjrl+UqdnabnHg6uR2K3qujPEQRFdm15pb
	K6g6DpwhLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=rN7
	klTRCUYfZ7RXy09qWaMKKCzPaGIINTB8S+wIB0VKpYj5GrsVWsJ5aiuAxPmYxuSJ
	fCXe1MKjSXzuh0Z9/3L3Ikx1GN4XTIuA9TEaViy4wZooiY67iLRrDczeED4ZILmL
	4qKh2j781CNP/r+BnuIsxbk8bDMdSTMVXDleOUbM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 90DFA5490;
	Thu,  9 Jun 2011 16:14:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CE58D548F; Thu,  9 Jun 2011
 16:14:44 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1EE36436-92D5-11E0-B5C4-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175572>

The same theme as "unpack-objects" patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 921a216..12a166f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1643,19 +1643,24 @@ static void *unpack_compressed_entry(struct packed_git *p,
 	int st;
 	z_stream stream;
 	unsigned char *buffer, *in;
+	unsigned long bytes_to_inflate;
 
 	buffer = xmallocz(size);
 	memset(&stream, 0, sizeof(stream));
 	stream.next_out = buffer;
-	stream.avail_out = size + 1;
+	bytes_to_inflate = size + 1;
+	stream.avail_out = zlib_buf_cap(bytes_to_inflate);
 
 	git_inflate_init(&stream);
 	do {
+		unsigned char *out0 = stream.next_out;
 		in = use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
 		st = git_inflate(&stream, Z_FINISH);
-		if (!stream.avail_out)
+		bytes_to_inflate -= stream.next_out - out0;
+		if (!bytes_to_inflate)
 			break; /* the payload is larger than it should be */
+		stream.avail_out = zlib_buf_cap(bytes_to_inflate);
 		curpos += stream.next_in - in;
 	} while (st == Z_OK || st == Z_BUF_ERROR);
 	git_inflate_end(&stream);
-- 
1.7.6.rc1.118.ge175b4a
