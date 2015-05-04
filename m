From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 0/4] cat-file: add support for "-allow-unknown-type"
Date: Mon, 04 May 2015 13:57:51 -0700
Message-ID: <xmqqioc8rrg0.fsf@gitster.dls.corp.google.com>
References: <55463094.9040204@gmail.com>
	<xmqqzj5ltd6c.fsf@gitster.dls.corp.google.com>
	<xmqqvbg9td0x.fsf@gitster.dls.corp.google.com>
	<55477478.9010406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 04 22:59:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpNS5-0002Ky-UN
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 22:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbbEDU6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 16:58:53 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53834 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752860AbbEDU5z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 16:57:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D6974E8C9;
	Mon,  4 May 2015 16:57:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D2Dsdxvjsgf9t8/StUwISp1TN6E=; b=ID4Nip
	/H8xaF+LXX2pgMnxxthXpTumsv78ilvPhZYiHCkFHHdRtDii8ez0Rd514ScPo/R9
	QuD8CgWEdJLfdtoKwlU9Rsa3PwHikilvs75Da9pIePhequ8kMh8yB9KKPM49DSoy
	Eu2LikL+pkYMeyNFPDcXy4sb43mjXL1OI2DBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JSiAI1JP1yMuCTRKGO1zxrUWNd/SqEFS
	uZk3aFJoMSfzcO4EVllEfWSkU+FqxTBuUwHAdkTOQt0Gtz9taVGQsoOf6ofTbqQu
	Pkm+GAKPKhwNdHZAPw03bNPecOl3GF6eDez5l0V/e/qJ12asfsIGlBQeWIuMIolX
	acjAxGWVAcg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 751A64E8C8;
	Mon,  4 May 2015 16:57:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D4D434E8C7;
	Mon,  4 May 2015 16:57:53 -0400 (EDT)
In-Reply-To: <55477478.9010406@gmail.com> (karthik nayak's message of "Mon, 04
	May 2015 19:00:32 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3BBCB678-F2A0-11E4-A215-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268352>

karthik nayak <karthik.188@gmail.com> writes:

>> @@ -1579,7 +1578,6 @@ static int unpack_sha1_heade
>>   	if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
>>   		return 0;
>>
>> -	strbuf_add(header, buffer, stream->next_out - (unsigned char *)buffer);
> Ok this works, weird, I test before sending patches, anyways getting
> to the point of discussion, shouldn't we have add the buf, since we
> did inflate once, before doing inflate again?

+static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
+					unsigned long mapsize, void *buffer,
+					unsigned long bufsiz, struct strbuf *header)
+{
+	unsigned char *cp;
+	int status;
+
+	status = unpack_sha1_header(stream, map, mapsize, buffer, bufsiz);

Here, buffer..stream->next_out contains the inflated result

+	/*
+	 * Check if entire header is unpacked in the first iteration.
+	 */
+	if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
+		return 0;
+
+	strbuf_add(header, buffer, stream->next_out - (unsigned char *)buffer);

... and that is copied to header.buf ...

+	do {
+		status = git_inflate(stream, 0);

... and then we inflate further into where?

It inflates to stream->next_out and then advances the pointer

+		strbuf_add(header, buffer, stream->next_out - (unsigned char *)buffer);

... and then the same buffer..stream->next_out (whose early part
already holds the result from the initial inflation) is appended
to header.

+		if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
+			return 0;
+		stream->next_out = buffer;
+		stream->avail_out = bufsiz;

I think my squash is wrong.  The initial inflate must have filled
buffer[0..bufsiz] without any NULs, leaving stream->next_out at the
end of the buffer, and subsequent git_inflate() it will clobber
beyond the tail of the buffer.

It should have been more like this, I think.

diff --git a/sha1_file.c b/sha1_file.c
index f65bf90..37e6f2c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1568,7 +1568,6 @@ static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
 					unsigned long mapsize, void *buffer,
 					unsigned long bufsiz, struct strbuf *header)
 {
-	unsigned char *cp;
 	int status;
 
 	status = unpack_sha1_header(stream, map, mapsize, buffer, bufsiz);
@@ -1579,7 +1578,15 @@ static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
 	if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
 		return 0;
 
+	/*
+	 * buffer[0..bufsiz] was not large enough.  Copy the partial
+	 * result out to header, and then append the result of further
+	 * reading the stream.
+	 */
 	strbuf_add(header, buffer, stream->next_out - (unsigned char *)buffer);
+	stream->next_out = buffer;
+	stream->avail_out = bufsiz;
+
 	do {
 		status = git_inflate(stream, 0);
 		strbuf_add(header, buffer, stream->next_out - (unsigned char *)buffer);
