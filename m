Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 492BB1F4F8
	for <e@80x24.org>; Mon, 26 Sep 2016 00:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941167AbcIZAKg (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 20:10:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54776 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S941073AbcIZAKf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 20:10:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1487F40F5C;
        Sun, 25 Sep 2016 20:10:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xgIExUVQYC9zfRYpDvc6eEvjSA8=; b=nV2dsu
        sZmtqh+lLdWQRAJqptqjIGzUOn+YJBgfLrDbvc3z2R0mRKmA29m8QWqOTrwu56Zl
        IL0zzbwpnyG+xW/jZQCyV06cQI6FBAPlccqepxwC779ZDNC0ountc+c2BnKxua1U
        DDLFdwd6leoV4zAMjGUkKTVd8pdS4cc1tJ450=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wF/ERpLCCS87bzGC3l3NLfn3MHoT8LP7
        V5U2Zux6tKewKS1QJsjlvt8mQjg8FJWRRo+U1mYQZECjZvtKESFrgNRUAFtWjLsv
        FToS3uHyu0QQE/iKIkiVmfkTs1yCyoeq9fuHNOfSF/b866hxyYaBmDynm9LT5YB4
        Ft/4tdZKXO8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0CB2540F5B;
        Sun, 25 Sep 2016 20:10:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 874B840F5A;
        Sun, 25 Sep 2016 20:10:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Gustavo Grieco <gustavo.grieco@imag.fr>
Cc:     git@vger.kernel.org
Subject: Re: Stack read out-of-bounds in parse_sha1_header_extended using git 2.10.0
References: <1825523389.8224664.1474812766424.JavaMail.zimbra@imag.fr>
Date:   Sun, 25 Sep 2016 17:10:31 -0700
In-Reply-To: <1825523389.8224664.1474812766424.JavaMail.zimbra@imag.fr>
        (Gustavo Grieco's message of "Sun, 25 Sep 2016 16:12:46 +0200 (CEST)")
Message-ID: <xmqqbmzbwmfc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4846EFC-837D-11E6-9485-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gustavo Grieco <gustavo.grieco@imag.fr> writes:

> We found a stack read out-of-bounds parsing object files using git 2.10.0. It was tested on ArchLinux x86_64. To reproduce, first recompile git with ASAN support and then execute:
>
> $ git init ; mkdir -p .git/objects/b2 ; printf 'x' > .git/objects/b2/93584ddd61af21260be75ee9f73e9d53f08cd0

Interesting.  If you prepare such a broken loose object file in your
local repository, I would expect that either unpack_sha1_header() or
unpack_sha1_header_to_strbuf() that sha1_loose_object_info() calls
would detect and barf by noticing that an error came from libz while
it attempts to inflate and would not even call parse_sha1_header.

But it is nevertheless bad to assume that whatever happens to
inflate without an error must be formatted correctly to allow
parsing (i.e. has ' ' and then NUL termination within the first 32
bytes after inflation), which is exactly what the hdr[32] is saying.

Perhaps we need something like the following to tighten the
codepath.

Note that this is totally unteseted and not thought through; I
briefly thought about what unpack_sha1_header_to_strbuf() does with
this change (it first lets unpack_sha1_header() to attempt with a
small buffer but it seems to discard the error code from it before
seeing if the returned buffer has NUL in it); there may be bad
interactions with it.


 sha1_file.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 60ff21f..dfcbd76 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1648,6 +1648,8 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 
 int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz)
 {
+	int status;
+
 	/* Get the data stream */
 	memset(stream, 0, sizeof(*stream));
 	stream->next_in = map;
@@ -1656,7 +1658,15 @@ int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long ma
 	stream->avail_out = bufsiz;
 
 	git_inflate_init(stream);
-	return git_inflate(stream, 0);
+	status = git_inflate(stream, 0);
+	if (status)
+		return status;
+
+	/* Make sure we got the terminating NUL for the object header */
+	if (!memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
+		return -1;
+
+	return 0;
 }
 
 static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
@@ -1758,6 +1768,8 @@ static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
 		char c = *hdr++;
 		if (c == ' ')
 			break;
+		if (!c)
+			die("invalid object header");
 		type_len++;
 	}
 

