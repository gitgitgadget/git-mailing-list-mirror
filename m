From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] mailinfo.c: Allow convert_to_utf8() to specify both
 src/dst charset and do conversion alone
Date: Mon, 18 Apr 2011 12:36:22 -0700
Message-ID: <7vd3kj8i89.fsf@alter.siamese.dyndns.org>
References: <1302986971-28080-1-git-send-email-r0bertz@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org
To: "ZHANG\, Le" <r0bertz@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 21:36:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBuFR-00014H-EN
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 21:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991Ab1DRTgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 15:36:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42889 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472Ab1DRTgb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 15:36:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 56FBD5B43;
	Mon, 18 Apr 2011 15:38:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Gk7g5SNTTRb+PRLjFtL7kpQ+Hjc=; b=Qv0eEXnE9b0QeoiWwxIz
	CPqFUa5QfqsS5xbZvCHC9v0JSExIZtfBkTlqkWYQRTiIjeetEY0JlHB9MCLZUS7y
	+kdkNPObgAQx0W5QojqYIeSnEsSsEh7PzH+MJ2OqnNg+vhakC0xnSB6UNO4K27RV
	Ru4x0himd+AedfK9FvuBGOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=o35wiKt2S7TcKyGomUYlLD+hh1rAPuZYVzydXMq4xbRXoY
	1/GDp5vrBWBvPZJOqQy/zEtslYdHUDon1Lsjl29NfnktAI40VZOtbHniThRvvsy4
	4rjn3uDtxNAh8nLUkQCsOL4fY+eLFAFd6BDe2Iybqix5JkLSC3yTZzl2s9av4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 353865B42;
	Mon, 18 Apr 2011 15:38:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 184915B41; Mon, 18 Apr 2011
 15:38:22 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6DCF6F5A-69F3-11E0-BBC4-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171754>

--=-=-=

"ZHANG, Le" <r0bertz@gentoo.org> writes:

> And the guess_charset() function does not do exactly what
> its name says.

Really?  See below.

> @@ -483,32 +497,14 @@ static struct strbuf *decode_b_segment(const struct strbuf *b_seg)
>   * Otherwise, we default to assuming it is Latin1 for historical
>   * reasons.
>   */
> -static const char *guess_charset(const struct strbuf *line, const char *target_charset)
> +static void guess_and_convert_to(struct strbuf *line, const char *to_charset)
>  {
> +	if (is_encoding_utf8(to_charset)) {
>  		if (is_utf8(line->buf))
>  			return;
>  	}
>  
> +    convert_to(line, to_charset, "ISO8859-1");

Broken indent.

I have to wonder if this helper should be inlined into its single caller,
i.e.

  	if (metainfo_charset) {
		if (is_encoding_utf8(metainfo_charset) && is_utf8(it->buf))
			; /* nothing to be done */
		else
			convert_to(it, metainfo_charset, "ISO8859-1");
	}

The decode_header() codepath is the only place that we have to handle a
possible binary guck without an explicit "this piece of text is in that
encoding" available in the message, and we guess by "if the data looks
like utf-8, we treat it as such, otherwise we assume it is 8859-1 which
was historically popular".  All the other codepaths we should know what
encoding the incoming data is in.

Having said all that, I do not think your patch is correct.

 - Does the code with your patch work correctly when the incoming data is
   pre-MIME and does not specify charset, in which case charset.buf may be
   an empty string?

 - When the incoming data does not say in what encoding it is in, our
   intended behaviour is to inspect each line, and if it looks like utf-8
   then assume it is in utf-8, otherwise assume it is in 8859-1.  And then
   we convert it to whatever encoding the repository wants, often utf-8
   (coming from metainfo_charset, suitable for recording commit log
   messages).

   We might want to change this heuristic in the future, but I do not see
   a need for doing so right now (Cf. b59d398: Do a better job at guessing
   unknown character sets, 2007-07-17).

   I do think the guess_and_convert_to() does not implement that intended
   logic correctly.  When we are _not_ encoding to UTF-8, we do not even
   bother to inspect the data to guess if it is UTF-8.  Shouldn't it be
   more like (modulo "NULL implies utf-8"):

	if (is_utf8(it->buf))
        	from_charset = "utf-8";
	else
        	from_charset = "ISO8859-1";
	if (is_encoding_utf8(metainfo_charset) && !strcmp(from_charset, "utf-8"))
        	; /* nothing to do */
	else if (strcasecmp(to_charset, from_charset))
		convert_to(it, metainfo_charset, from_charset);

 - I don't think the commit message part is handled correctly anymore with
   your patch. When you want UTF-8 commit log message (metainfo_charset is
   set to utf-8), and when the incoming data does not have its charset
   specified, we should be doing the same "guess line-by-line" conversion.
   You seem to have lost that with this patch, which would be a grave
   regression.

Please apply the attached patch that adds a test at the end of t5100 and
make sure the test passes to prevent that regression from happening.

Thanks.


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=1
Content-Transfer-Encoding: base64
Content-Description: addition to t5100

RnJvbSBmNmFkZmRiOTczNzg1N2QxMWRmMzM1YTgyMjEzMDZhMzRhZWM1OWI2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBwb2JveC5jb20+CkRh
dGU6IE1vbiwgMTggQXByIDIwMTEgMTI6MjI6NTMgLTA3MDAKU3ViamVjdDogW1BBVENIXSB0NTEw
MDogbWFrZSBzdXJlIGxpbmUtYnktbGluZSBndWVzcyBvZiBjaGFyc2V0IHdvcmtzCgpTaWduZWQt
b2ZmLWJ5OiBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBwb2JveC5jb20+Ci0tLQogdC90NTEwMC1t
YWlsaW5mby5zaCAgICB8ICAgMjIgKysrKysrKysrKysrKysrKysrKysrKwogdC90NTEwMC8uZ2l0
YXR0cmlidXRlcyB8ICAgIDEgKwogdC90NTEwMC9zYW1wbGUuODg1OSAgICB8ICAgIDkgKysrKysr
KysrCiAzIGZpbGVzIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCiBj
cmVhdGUgbW9kZSAxMDA2NDQgdC90NTEwMC9zYW1wbGUuODg1OQoKZGlmZiAtLWdpdCBhL3QvdDUx
MDAtbWFpbGluZm8uc2ggYi90L3Q1MTAwLW1haWxpbmZvLnNoCmluZGV4IGViYzM2YzEuLjRhYWJi
MzAgMTAwNzU1Ci0tLSBhL3QvdDUxMDAtbWFpbGluZm8uc2gKKysrIGIvdC90NTEwMC1tYWlsaW5m
by5zaApAQCAtODksNCArODksMjYgQEAgdGVzdF9leHBlY3Rfc3VjY2VzcyAnbWFpbGluZm8gb24g
ZnJvbSBoZWFkZXIgd2l0aG91dCBuYW1lIHdvcmtzJyAnCiAKICcKIAordGVzdF9leHBlY3Rfc3Vj
Y2VzcyAnbWFpbGluZm8gZmFsbGJhY2sgdG8gbGluZS1ieS1saW5lIGd1ZXNzJyAnCisJY2F0ID5p
bmZvLmV4cGVjdCA8PC1FT0YgJiYKKwlBdXRob3I6IMOBdSBUaG9yCisJRW1haWw6IGF1dGhvckBl
eGFtcGxlLnh6CisJU3ViamVjdDogU2FtcGxlIFPDvGJqZWN0CisJRGF0ZTogTW9uLCAxOCBBcHIg
MjAxMSAxMjowMDowMCAtMDcwMAorCisJRU9GCisJY2F0ID5tc2cuZXhwZWN0IDw8LUVPRiAmJgor
CcOBIHNhbXBsZSBtZXNzYWdlLgorCisJRU9GCisJY2F0ID5wYXRjaC5leHBlY3QgPDwtRU9GICYm
CisJLS0tCisJQW5kIGFuIGVtcHR5IHBhdGNoLgorCUVPRgorCWdpdCBtYWlsaW5mbyBtc2cgcGF0
Y2ggPCIkVEVTVF9ESVJFQ1RPUlkiL3Q1MTAwL3NhbXBsZS44ODU5ID5pbmZvICYmCisJdGVzdF9j
bXAgaW5mby5leHBlY3QgaW5mbyAmJgorCXRlc3RfY21wIG1zZy5leHBlY3QgbXNnICYmCisJdGVz
dF9jbXAgcGF0Y2guZXhwZWN0IHBhdGNoCisnCisKIHRlc3RfZG9uZQpkaWZmIC0tZ2l0IGEvdC90
NTEwMC8uZ2l0YXR0cmlidXRlcyBiL3QvdDUxMDAvLmdpdGF0dHJpYnV0ZXMKaW5kZXggYzkzZjUx
NC4uOGE2YTI4NCAxMDA2NDQKLS0tIGEvdC90NTEwMC8uZ2l0YXR0cmlidXRlcworKysgYi90L3Q1
MTAwLy5naXRhdHRyaWJ1dGVzCkBAIC0yLDMgKzIsNCBAQCBtc2cqCWVuY29kaW5nPVVURi04CiBp
bmZvKgllbmNvZGluZz1VVEYtOAogcmZjMjA0Ny1pbmZvLSoJZW5jb2Rpbmc9VVRGLTgKIHNhbXBs
ZS5tYm94CWVuY29kaW5nPVVURi04CitzYW1wbGUuODg1OQllbmNvZGluZz1JU084ODU5LTEKZGlm
ZiAtLWdpdCBhL3QvdDUxMDAvc2FtcGxlLjg4NTkgYi90L3Q1MTAwL3NhbXBsZS44ODU5Cm5ldyBm
aWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLmY5N2Q1OWYKLS0tIC9kZXYvbnVsbAorKysg
Yi90L3Q1MTAwL3NhbXBsZS44ODU5CkBAIC0wLDAgKzEsOSBAQAorRnJvbSBub2JvZHkgTW9uIFNl
cCAxNyAwMDowMDowMCAyMDAxCitGcm9tOiDBdSBUaG9yIDxhdXRob3JAZXhhbXBsZS54ej4KK1N1
YmplY3Q6IFNhbXBsZSBT/GJqZWN0CitEYXRlOiBNb24sIDE4IEFwciAyMDExIDEyOjAwOjAwIC0w
NzAwCisKK8Egc2FtcGxlIG1lc3NhZ2UuCisKKy0tLQorQW5kIGFuIGVtcHR5IHBhdGNoLgotLSAK
MS43LjUucmMyLjQuZzRkOGIzCgo=
--=-=-=--
