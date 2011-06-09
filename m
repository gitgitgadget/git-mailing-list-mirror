From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] unpack-objects: zlib can only process 4GB at a time
Date: Thu, 09 Jun 2011 13:11:58 -0700
Message-ID: <7vzklqwyr5.fsf@alter.siamese.dyndns.org>
References: <7v1uz42liw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 22:12:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUlaM-0002E2-DB
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 22:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755054Ab1FIUMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 16:12:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39390 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574Ab1FIUME (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 16:12:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 350925486;
	Thu,  9 Jun 2011 16:14:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DP4qcGG58OeX/95/eD0zAFsI1yc=; b=qpONae
	OdKBlKU+cT3ShZcugo4CL2DqtciV/ROnGGgEg0NzDJx1dSnjkFO+ktxoU64b/oms
	DvNdfIjCwIt57GAzjMdDNL4Hrp0aFNkT27BlrIMfyjOynKVf2OCH2y5nJtTAPJZg
	0X9v24noLHq0yWm/biCBRKQqMj1AsSQN7X5xA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jIsD2qexGsA2L5VqoMkuvsJ/Cva2dqGg
	pCX/zX2FKxOi9Y1TGAtXkcTR0QAIFUeDOHymzxMD9YZJmiGaQLhKofNQCEL5K5YX
	q3EArcYI39s5/LwcDQLqeiy+ut1kOMWR+tkZe4OBg+gahbFWJ1dBSE1/mmhCr5no
	YfWPntcrisY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F6C75485;
	Thu,  9 Jun 2011 16:14:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2BBC15484; Thu,  9 Jun 2011
 16:14:09 -0400 (EDT)
In-Reply-To: <7v1uz42liw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 08 Jun 2011 12:03:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A4DD7CC-92D5-11E0-8145-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175571>

This codepath tried to tell zlib that we have allocated a large enough
output buffer and expected a single call to inflate() to succeed, but
zlib cannot expand into a buffer that is larger than 4GB at a time.

Ideally we should be transferring a better cue between send-pack and
receive-pack (or fetch-pack and upload-pack) to tell that we would be
better off not to explode into individual loose objects, but that is not
an excuse to leave our use of zlib broken and fail to unpack large objects
in a pack even on a beefy machine with enough memory.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/unpack-objects.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index f63973c..b208d6e 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -92,18 +92,22 @@ static void *get_data(unsigned long size)
 {
 	z_stream stream;
 	void *buf = xmalloc(size);
+	unsigned long bytes_to_inflate;
 
 	memset(&stream, 0, sizeof(stream));
 
 	stream.next_out = buf;
-	stream.avail_out = size;
+	bytes_to_inflate = size;
+	stream.avail_out = zlib_buf_cap(bytes_to_inflate);
 	stream.next_in = fill(1);
 	stream.avail_in = len;
 	git_inflate_init(&stream);
 
 	for (;;) {
+		unsigned char *out0 = stream.next_out;
 		int ret = git_inflate(&stream, 0);
 		use(len - stream.avail_in);
+		bytes_to_inflate -= (stream.next_out - out0);
 		if (stream.total_out == size && ret == Z_STREAM_END)
 			break;
 		if (ret != Z_OK) {
@@ -117,6 +121,7 @@ static void *get_data(unsigned long size)
 		}
 		stream.next_in = fill(1);
 		stream.avail_in = len;
+		stream.avail_out = zlib_buf_cap(bytes_to_inflate);
 	}
 	git_inflate_end(&stream);
 	return buf;
-- 
1.7.6.rc1.118.ge175b4a
