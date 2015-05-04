From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] write_sha1_file_prepare: fix buffer overrun with extra-long object type
Date: Mon, 04 May 2015 10:59:25 -0700
Message-ID: <xmqqzj5krzpe.fsf@gitster.dls.corp.google.com>
References: <1430724315-524-1-git-send-email-sunshine@sunshineco.com>
	<1430724315-524-4-git-send-email-sunshine@sunshineco.com>
	<xmqq4mnsteb8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 04 19:59:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpKeS-0007ML-Qs
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 19:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbbEDR73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 13:59:29 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63824 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750990AbbEDR71 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 13:59:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 531B74CFD1;
	Mon,  4 May 2015 13:59:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O5rj6lYG4HfJXcLwHZDQBJ8n7mM=; b=voI/lA
	likTfA4pBs6w4lZ2k6kTvntwgxOEyv26HR+crDZDwxVEYG0LmSq0nOBPjSrtY6Fh
	BLcvdk5LHLgSWGaD8qoFP9IWHed32c4YSCnt/b8yY6MrgtaZY1FZUgcqzOwzRnNE
	NRD2NNW41leay5jSIthwL/byJkFj/7LerNbeg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EVC+habT+Wtpf+Hz6HmHqL9cyVoJd/ea
	tvjasxLjvFHUSPVD+zj+aTqbaYbOpEFYhagQYfIIm3ASkD0Frqunn45JU7H33Q8M
	55d5YKqJzVvikMLkmlen5fqH/kxKsqBh9Q588dCFQyJSWOK/HBg7+tdtDu6jEfIS
	q0eL3ELkruY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 49DBE4CFCE;
	Mon,  4 May 2015 13:59:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B1FE34CFCD;
	Mon,  4 May 2015 13:59:26 -0400 (EDT)
In-Reply-To: <xmqq4mnsteb8.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 04 May 2015 10:58:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4DC7EF0E-F287-11E4-8471-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268338>

By the way, you would notice that "if we have returnsha1, then copy
that in" bit is not in the new literally codepath but still is in
write_sha1_file().

I do not think any caller passes a NULL as return_sha1 in today's
code, which made me curious.

It turns out to be a remnant of d6d3f9d0 (This implements the new
"recursive tree" write-tree., 2005-04-09); before that change,
write_sha1_file() did not have an ability to tell the caller what
object it wrote, and Linus made it optional for the callers when he
added the return_sha1[] out parameter, but all of its callers did
want the resulting object name.

So I think it is safe and sensible to do the following change
regardless of "hash-object --literally" fix.

 sha1_file.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index c8ab069..96e813f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3002,9 +3002,8 @@ static int freshen_packed_object(const unsigned char *sha1)
 	return find_pack_entry(sha1, &e) && freshen_file(e.p->pack_name);
 }
 
-int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
+int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1)
 {
-	unsigned char sha1[20];
 	char hdr[32];
 	int hdrlen;
 
@@ -3012,8 +3011,6 @@ int write_sha1_file(const void *buf, unsigned long len, const char *type, unsign
 	 * it out into .git/objects/??/?{38} file.
 	 */
 	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
-	if (returnsha1)
-		hashcpy(returnsha1, sha1);
 	if (freshen_loose_object(sha1) || freshen_packed_object(sha1))
 		return 0;
 	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
