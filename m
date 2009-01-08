From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG PATCH RFC] mailinfo: correctly handle multiline 'Subject:'
 header
Date: Thu, 08 Jan 2009 00:35:52 -0800
Message-ID: <7vy6xm42l3.fsf@gitster.siamese.dyndns.org>
References: <1230316721-14339-1-git-send-email-kirr@mns.spb.ru>
 <20090107224342.GB4946@roro3> <7vy6xm5i6h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Thu Jan 08 09:37:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKqOJ-00040l-PG
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 09:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbZAHIgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 03:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbZAHIgA
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 03:36:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41283 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbZAHIf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 03:35:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 89DAA1C0FC;
	Thu,  8 Jan 2009 03:35:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 04E0D1C0FD; Thu, 
 8 Jan 2009 03:35:53 -0500 (EST)
In-Reply-To: <7vy6xm5i6h.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 08 Jan 2009 00:13:42 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5EF1CF5A-DD5F-11DD-BA6F-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104899>

Junio C Hamano <gitster@pobox.com> writes:

> Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:
> ...
>> http://marc.info/?l=git&m=123031899307286&w=2
>
> I have not had chance to look at your patch at marc yet, but from the look
> of your problem description, I presume you could trigger this with any
> utf-8 b-encoded loooooong subject line?

Ok, I took a look at it after downloading from the marc archive.

> diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
> index e890f7a..d138bc3 100644
> --- a/builtin-mailinfo.c
> +++ b/builtin-mailinfo.c
> @@ -436,6 +436,14 @@ static struct strbuf *decode_b_segment(const struct strbuf *b_seg)
>  			 * for now we just trust the data.
>  			 */
>  			c = 0;
> +
> +			/* XXX: the following is needed not to output NUL in
> +			 * the resulting string
> +			 *
> +			 * This seems to be ok, but I'm not 100% sure -- that's
> +			 * why this is an RFC.
> +			 */
> +			continue;
>  		}
>  		else
>  			continue; /* garbage */

B encoding (RFC 2045) encodes an octet stream into a sequence of groups of
4 letters from 64-char alphabet, each of which encodes 6-bit, plus zero or
more padding char '=' to make the result multiple of 4.

 * If the length of the payload is a multiple of 3 octets, there is no
   special handling.  Padding char '=' is not produced;

 * If it is a multiple of 3 octets plus one, the remaining one octet is
   encoded with two letters, and two more padding char '=' is added;

 * If it is a multiple of 3 octets plus two, the remaining two octets are
   encoded with three letters, and one padding char '=' is added.

Hence, a "correct" implementation should decode the input as if '=' were
the same as 'A' (which encodes 6 bits of 0) til the end, making sure that
the padding char '=' appears only at the end of the input, that no char
outside the Base64 encoding alphabet appears in the input, and that the
length of the entire encoded string is multiple of 4.  Finally it would
discard either one or two octets (depending on the number of padding chars
it saw) from the end of the output.

Our decode_b_segment() however emits each octet as it completes, without
waiting for the 24-bit group that contains it to complete.  When decoding
a correctly encoded input, by the time we see a padding '=', all the real
payload octets are complete and we would not have any real information
still kept in the variable "acc" (accumulator), so ignoring '=' (you do
not even need to assign c = 0) like your patch did would work just fine.
An alternative would be to count the number of padding at the end and drop
the NULs from the output as necessary after the loop but that does not add
any value to the current code.

Ideally we should validate the encoded string a bit more carefully (see
the "correct" implementation about), and warn if a malformed input is
found (but probably not reject outright).  But as a low-impact fix for the
maintenance branches, I think your fix is very good.

	Side note: I suspect that the existing code was Ok before strbuf
	conversion as we assumed NUL terminated output buffer.

> @@ -513,7 +521,15 @@ static int decode_header_bq(struct strbuf *it)
>  		strbuf_reset(&piecebuf);
>  		rfc2047 = 1;
>  
> -		if (in != ep) {
> +		/* XXX: the follwoing is needed not to output '\n' on every
> +		 * multi-line segment in Subject.
> +		 *
> +		 * I suspect this is not 100% correct, but I'm not a MIME guy
> +		 * -- that's why this is an RFC.
> +		 */
> +
> +		/* if in does not end with '=?=', we emit it as is */
> +		if (in <= (ep-2) && !(ep[-1]=='\n' && ep[-2]=='=')) {
>  			strbuf_add(&outbuf, in, ep - in);
>  			in = ep;
> 
>  		}

I am not a MIME guy either (and mailinfo has a big comment that says we do
not really do MIME --- we just pretend to do), but let me give it a try.

RFC2046 specifies that an encoded-word ("=?charset?encoding?...?=") may
not be more than 75 characters long, and multiple encoded-words, separated
by CRLF SPACE can be used to encode more text if needed.

It further specifies that an encoded-word can appear next to ordinary text
or another encoded-word but it must be separated by linear white space,
and says that such linear white space is to be ignored when displaying.

Which means that we should be eating the CRLF SPACE we see if we have seen
an encoded-word immediately before and we are about to process another
encoded-word.

Based on the above discussion, here is what I came up with.  It passes
your test, but I ran out of energy to try breaking it seriously in any
other way than just running the existing test suite.  

We might want to steal some test cases from the "8. Examples" section of
RFC2047 and add them to t5100.

Thanks.

 builtin-mailinfo.c |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)

diff --git c/builtin-mailinfo.c w/builtin-mailinfo.c
index e890f7a..fcb32c9 100644
--- c/builtin-mailinfo.c
+++ w/builtin-mailinfo.c
@@ -430,13 +430,6 @@ static struct strbuf *decode_b_segment(const struct strbuf *b_seg)
 			c -= 'a' - 26;
 		else if ('0' <= c && c <= '9')
 			c -= '0' - 52;
-		else if (c == '=') {
-			/* padding is almost like (c == 0), except we do
-			 * not output NUL resulting only from it;
-			 * for now we just trust the data.
-			 */
-			c = 0;
-		}
 		else
 			continue; /* garbage */
 		switch (pos++) {
@@ -514,7 +507,25 @@ static int decode_header_bq(struct strbuf *it)
 		rfc2047 = 1;
 
 		if (in != ep) {
-			strbuf_add(&outbuf, in, ep - in);
+			/*
+			 * We are about to process an encoded-word
+			 * that begins at ep, but there is something
+			 * before the encoded word.
+			 */
+			char *scan;
+			for (scan = in; scan < ep; scan++)
+				if (!isspace(*scan))
+					break;
+
+			if (scan != ep || in == it->buf) {
+				/*
+				 * We should not lose that "something",
+				 * unless we have just processed an
+				 * encoded-word, and there is only LWS
+				 * before the one we are about to process.
+				 */
+				strbuf_add(&outbuf, in, ep - in);
+			}
 			in = ep;
 		}
 		/* E.g.
