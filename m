Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FF1B207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 17:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161552AbcIZReh (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 13:34:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55335 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1030261AbcIZReg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 13:34:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F16340FC7;
        Mon, 26 Sep 2016 13:34:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7Fg40BryyGHqF/ot4YUkDdn9FWA=; b=ncIA4v
        YDvxaI/QjHSvX/kgoaV1IWPhUaqUnmXVAnyjLQrtyonhEZ2MmDE/aMmT1AguRowg
        NuLbzZjfIcFprm/eCXasVOHyfdmzCAoPgc1VqnubXhiaVmQZOeo13PutmIs5kqSA
        S0HGDq2eTDRrfBDNoNzkOKd8bMiyzTxRsICOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HyM/GlOmzdrakvJQOZA9UwcwxDFDTIbK
        /1DLJNH4y15VM6d635u/kYJwSFkpf0RuO+sWrI2q/9ho35NFGQIW/M/Owub+B5Gm
        XtyoVIRpqJ1CqkCMqNDl5T+YcbnHA8651oMdptkyz1Gw0z7IOrk3gv8+xGDC/S3k
        kc4YskgaJ/k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2674D40FC6;
        Mon, 26 Sep 2016 13:34:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C77E40FC4;
        Mon, 26 Sep 2016 13:34:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
        Gustavo Grieco <gustavo.grieco@imag.fr>
Subject: Re: [PATCH] unpack_sha1_header(): detect malformed object header
References: <1825523389.8224664.1474812766424.JavaMail.zimbra@imag.fr>
        <xmqqbmzbwmfc.fsf@gitster.mtv.corp.google.com>
        <xmqqshsnuvvz.fsf_-_@gitster.mtv.corp.google.com>
        <20160926140309.l2h4b65gpqyutepn@sigill.intra.peff.net>
        <xmqqfuomvdqe.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 26 Sep 2016 10:34:32 -0700
In-Reply-To: <xmqqfuomvdqe.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 26 Sep 2016 09:15:53 -0700")
Message-ID: <xmqqoa3atviv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D83A7B8-840F-11E6-BAB4-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

And the second one, that no longer checks SP in unpacker, looks like
this.

-- >8 --
Subject: [PATCH] unpack_sha1_header(): detect malformed object header

When opening a loose object file, we often do this sequence:

 - prepare a short buffer for the object header (on stack)

 - call unpack_sha1_header() and have early part of the object data
   inflated, enough to fill the buffer

 - parse that data in the short buffer, assuming that the first part
   of the object is <typename> SP <length> NUL

Because the parsing function parse_sha1_header_extended() is not
given the number of bytes inflated into the header buffer, it you
craft a file whose early part inflates a garbage sequence without SP
or NUL, and replace a loose object with it, it will end up reading
past the end of the inflated data.

To correct this, do the following four things:

 - rename unpack_sha1_header() to unpack_sha1_short_header() and
   have unpack_sha1_header_to_strbuf() keep calling that as its
   helper function.  This will detect and report zlib errors, but is
   not aware of the format of a loose object (as before).

 - introduce unpack_sha1_header() that calls the same helper
   function, and when zlib reports it inflated OK into the buffer,
   check if the inflated data has NUL.  This would ensure that
   parsing function will terminate within the buffer that holds the
   inflated header.

 - update unpack_sha1_header_to_strbuf() to check if the resulting
   buffer has NUL for the same effect.

 - update parse_sha1_header_extended() to make sure that its loop to
   find the SP that terminates the <typename> stops at NUL.

Essentially, this makes unpack_*() functions that are asked to
unpack a loose object header to be a bit more strict and detect an
input that cannot possibly be a valid object header, even before the
parsing function kicks in.

Reported-by: Gustavo Grieco <gustavo.grieco@imag.fr>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 17262e1..f7054d3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1566,7 +1566,9 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 	return used;
 }
 
-int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz)
+static int unpack_sha1_short_header(git_zstream *stream,
+				    unsigned char *map, unsigned long mapsize,
+				    void *buffer, unsigned long bufsiz)
 {
 	/* Get the data stream */
 	memset(stream, 0, sizeof(*stream));
@@ -1579,13 +1581,31 @@ int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long ma
 	return git_inflate(stream, 0);
 }
 
+int unpack_sha1_header(git_zstream *stream,
+		       unsigned char *map, unsigned long mapsize,
+		       void *buffer, unsigned long bufsiz)
+{
+	int status = unpack_sha1_short_header(stream, map, mapsize,
+					      buffer, bufsiz);
+
+	if (status < Z_OK)
+		return status;
+
+	/* Make sure we have the terminating NUL */
+	if (!memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
+		return -1;
+	return 0;
+}
+
 static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
 					unsigned long mapsize, void *buffer,
 					unsigned long bufsiz, struct strbuf *header)
 {
 	int status;
 
-	status = unpack_sha1_header(stream, map, mapsize, buffer, bufsiz);
+	status = unpack_sha1_short_header(stream, map, mapsize, buffer, bufsiz);
+	if (status < Z_OK)
+		return -1;
 
 	/*
 	 * Check if entire header is unpacked in the first iteration.
@@ -1676,6 +1696,8 @@ static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
 	 */
 	for (;;) {
 		char c = *hdr++;
+		if (!c)
+			return -1;
 		if (c == ' ')
 			break;
 		type_len++;
-- 
2.10.0-533-ga18d90d

