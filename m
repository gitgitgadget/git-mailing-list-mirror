Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4081F4F8
	for <e@80x24.org>; Mon, 26 Sep 2016 04:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751372AbcIZE3J (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 00:29:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56258 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750754AbcIZE3I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 00:29:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2276342DCB;
        Mon, 26 Sep 2016 00:29:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8SoMjn53UNkVtFikHn1V/LW6ves=; b=EBqWYY
        8H7j9PAfP1Q+RteQERebbNoTmSr3EubbX2b5F07OHF6DKdvPFlrHrJOKbFc6fER6
        2CDjk4g5az4xut0G4F/UISen5v/kHvdOexkqaV5oFaHRtmxeem7WjCIfT0yPIgn2
        J3Np/DeqekbOEMToUL0SPb3In1gIx/mYsTgho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gZ1p+iiaaH5Oq34EIyofKtyNH2bmKx+U
        SW/BQXm1bpudwUtdYYhtN+zA71RkZnsZQCVi4YhUWpGh0v72wd6pYPEq0hvjZCM/
        JAH763cBG+Q+UYqQt8D7y1vj08tSsI735I5LTkDOaPBXU3lA2PCOK3CiF8RONfhl
        D8yKLr2bw/k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1858D42DCA;
        Mon, 26 Sep 2016 00:29:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A68F42DC9;
        Mon, 26 Sep 2016 00:29:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     Gustavo Grieco <gustavo.grieco@imag.fr>
Subject: [PATCH] unpack_sha1_header(): detect malformed object header
References: <1825523389.8224664.1474812766424.JavaMail.zimbra@imag.fr>
        <xmqqbmzbwmfc.fsf@gitster.mtv.corp.google.com>
Date:   Sun, 25 Sep 2016 21:29:04 -0700
In-Reply-To: <xmqqbmzbwmfc.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sun, 25 Sep 2016 17:10:31 -0700")
Message-ID: <xmqqshsnuvvz.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2F51D5E-83A1-11E6-85AC-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When opening a loose object file, we often do this sequence:

 - prepare a short buffer for the object header (on stack)

 - call unpack_sha1_header() and have early part of the object data
   inflated, enough to fill the buffer

 - parse that data in the short buffer, assuming that the first part
   of the object is <type> SP <length> NUL

Nobody in this sequence however actually verifies that the loop that
tries to find SP that must come after the typename or NUL that must
come after the length exist in the inflated data.  Because the
parsing function parse_sha1_header_extended() is not even given the
number of bytes inflated into the header buffer, it can easily read
past it, looking for the SP byte that may not even exist.

A variant recently introduced to support "--allow-unknown-type"
option of "git cat-file -t" changes the second step to use
unpack_sha1_header_to_strbuf(), but the story is essentially the
same.  It did check to see if it saw enough to include NUL, but
nobody checked for SP before calling the parsing function.

To correct this, do these three things:

 - rename unpack_sha1_header() to unpack_sha1_short_header() and
   have unpack_sha1_header_to_strbuf() keep calling that as its
   helper function.  This will detect and report zlib errors, but is
   not aware of the format of a loose object (as before).

 - introduce unpack_sha1_header() that calls the same helper
   function, and when zlib reports it inflated OK into the buffer,
   check if the buffer has both SP and NUL in this order.  This
   would ensure that parsing function will terminate within the
   buffer that holds the inflated header.

 - update unpack_sha1_header_to_strbuf() to check if the resulting
   buffer has both SP and NUL in this order for the same effect.

Reported-by: Gustavo Grieco <gustavo.grieco@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Unlike the "something like this" version, this does the "we got
   some data, does it look like an object header, safely parseable
   by our parser?" check in the unpack code, without touching the
   parser, as I think that division of labor between the unpacker
   and the parser makes more sense.

   The strbuf codepath came in 46f03448 ("sha1_file: support reading
   from a loose object of unknown type", 2015-05-03) by Karthik,
   whose log says it was written by me, and helped by Peff, so I'm
   asking these two to lend their eyes.

 sha1_file.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index b9c1fa3..445e763 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1646,7 +1646,9 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 	return used;
 }
 
-int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz)
+static int unpack_sha1_short_header(git_zstream *stream,
+				    unsigned char *map, unsigned long mapsize,
+				    void *buffer, unsigned long bufsiz)
 {
 	/* Get the data stream */
 	memset(stream, 0, sizeof(*stream));
@@ -1659,13 +1661,37 @@ int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long ma
 	return git_inflate(stream, 0);
 }
 
+int unpack_sha1_header(git_zstream *stream,
+		       unsigned char *map, unsigned long mapsize,
+		       void *buffer, unsigned long bufsiz)
+{
+	const char *eoh;
+	int status = unpack_sha1_short_header(stream, map, mapsize,
+					      buffer, bufsiz);
+
+	if (status < Z_OK)
+		return status;
+
+	/* Make sure we have the terminating NUL */
+	eoh = memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer);
+	if (!eoh)
+		return -1;
+	/* Make sure we have ' ' at the end of type */
+	if (!memchr(buffer, ' ', eoh - (const char *)buffer))
+		return -1;
+	return 0;
+}
+
 static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
 					unsigned long mapsize, void *buffer,
 					unsigned long bufsiz, struct strbuf *header)
 {
+	const char *eoh;
 	int status;
 
-	status = unpack_sha1_header(stream, map, mapsize, buffer, bufsiz);
+	status = unpack_sha1_short_header(stream, map, mapsize, buffer, bufsiz);
+	if (status < Z_OK)
+		return -1;
 
 	/*
 	 * Check if entire header is unpacked in the first iteration.
@@ -1686,11 +1712,19 @@ static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
 		status = git_inflate(stream, 0);
 		strbuf_add(header, buffer, stream->next_out - (unsigned char *)buffer);
 		if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
-			return 0;
+			goto enough;
 		stream->next_out = buffer;
 		stream->avail_out = bufsiz;
 	} while (status != Z_STREAM_END);
 	return -1;
+
+enough:
+	eoh = memchr(header->buf, '\0', header->len);
+	if (!eoh)
+		die("BUG: the NUL we earlier saw is gone???");
+	if (!memchr(header->buf, ' ', eoh - header->buf))
+		return -1;
+	return 0;
 }
 
 static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long size, const unsigned char *sha1)
