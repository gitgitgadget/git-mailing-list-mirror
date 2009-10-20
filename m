From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git hang with corrupted .pack
Date: Tue, 20 Oct 2009 12:33:45 -0700
Message-ID: <7vpr8hn9ly.fsf@alter.siamese.dyndns.org>
References: <20091014042249.GA5250@hexapodia.org>
 <20091014142351.GI9261@spearce.org> <7viqeaovmp.fsf@alter.siamese.dyndns.org>
 <7vzl7mng35.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Isaacson <adi@hexapodia.org>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Oct 20 21:34:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0KT8-00028K-Ag
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 21:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbZJTTd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 15:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbZJTTd4
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 15:33:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36740 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbZJTTdz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 15:33:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8151C607E5;
	Tue, 20 Oct 2009 15:33:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w5s8+jtiLbij4yrxwvhZETecJ7g=; b=we6oF3
	2SS/aXLwfjgeWVasA0BgiFM4ixFYKJlT5aUPsulSCK78GTBH4B+PwE2lRHCQJtmt
	cxbIpz4Vuze0lpsbN1B+9ubT1Up26AeC9ScPfapHYJWj3QUsSzf6DgNfvmGtHBqH
	LZz+a9Tde75QGNURb0SOuoVFE1WnE+02ieDfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rsW7qm0PNz0Mb0dCXzxbG3IcO9+6wLS3
	g+xTQcnDKzBBMx7HiUSI5Vnz8gpML1x83tauEShjIHIIvC7tp5b2igNCag8kpIhe
	7cD4QC3ePAXO8W3m/4x6uFFrGWYyWkOjvFQOrhLmFLph1IDG/mHGzXpZzbRO0z+j
	W78tkZ+qlpw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CF82607DF;
	Tue, 20 Oct 2009 15:33:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E643607DE; Tue, 20 Oct
 2009 15:33:46 -0400 (EDT)
In-Reply-To: <7vzl7mng35.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 20 Oct 2009 10\:13\:50 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8001F1EE-BDAF-11DE-A69B-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130830>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> We now abort the loop if inflate() returns Z_BUF_ERROR without
>>> consuming the entire input buffer it was given, or has filled
>>> the entire output buffer but has not yet returned Z_STREAM_END.
>>> Either state is a clear indicator that this loop is not working
>>> as expected, and should not continue.
>>
>> When the inflated contents is of size 0, avail_out would be 0 and avail_in
>> would still have something because the input stream needs to have the end
>> of stream marker that is more than zero byte long.
>
> After thinking about this a bit more, I am reasonably sure that this is
> it.  The contents does not have to be a 0-length string, but you would hit
> this if the pure-data portion of the deflated stream aligns at the end of
> your (un)pack window and it happens to require another use_pack() to move
> the window to read the end-of-stream signal.  In that situation, the
> output buffer has already been filled, but you haven't read the input
> stream fully.  Would't the new check incorrectly trigger in such a case?
>
>>>  		st = git_inflate(&stream, Z_FINISH);
>>> +		if (st == Z_BUF_ERROR && (stream.avail_in || !stream.avail_out))
>>> +			break;
>
> We won't see this on 64-bit platforms because we use larger (un)pack
> window and the condition is much less likely to be met.

Perhaps it would be as simple as this?

We deliberately give one byte more than what we expect to see and error
out when we do get that extra byte filled.

 sha1_file.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 4cc8939..8c9f392 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1344,7 +1344,7 @@ unsigned long get_size_from_delta(struct packed_git *p,
 			          off_t curpos)
 {
 	const unsigned char *data;
-	unsigned char delta_head[20], *in;
+	unsigned char delta_head[21], *in;
 	z_stream stream;
 	int st;
 
@@ -1357,13 +1357,14 @@ unsigned long get_size_from_delta(struct packed_git *p,
 		in = use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
 		st = git_inflate(&stream, Z_FINISH);
-		if (st == Z_BUF_ERROR && (stream.avail_in || !stream.avail_out))
-			break;
+		if (!stream.avail_out)
+			break; /* the payload is larger than it should be! */
 		curpos += stream.next_in - in;
 	} while ((st == Z_OK || st == Z_BUF_ERROR) &&
-		 stream.total_out < sizeof(delta_head));
+		 stream.total_out < (sizeof(delta_head) - 1));
 	git_inflate_end(&stream);
-	if ((st != Z_STREAM_END) && stream.total_out != sizeof(delta_head)) {
+	if ((st != Z_STREAM_END) &&
+	    stream.total_out != sizeof(delta_head) - 1) {
 		error("delta data unpack-initial failed");
 		return 0;
 	}
@@ -1589,15 +1590,15 @@ static void *unpack_compressed_entry(struct packed_git *p,
 	buffer[size] = 0;
 	memset(&stream, 0, sizeof(stream));
 	stream.next_out = buffer;
-	stream.avail_out = size;
+	stream.avail_out = size + 1;
 
 	git_inflate_init(&stream);
 	do {
 		in = use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
 		st = git_inflate(&stream, Z_FINISH);
-		if (st == Z_BUF_ERROR && (stream.avail_in || !stream.avail_out))
-			break;
+		if (!stream.avail_out)
+			break; /* the payload is larger than it should be! */
 		curpos += stream.next_in - in;
 	} while (st == Z_OK || st == Z_BUF_ERROR);
 	git_inflate_end(&stream);
