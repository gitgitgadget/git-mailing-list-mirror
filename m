From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] strbuf: add strbuf_percentquote_buf
Date: Tue, 12 Jan 2010 22:55:45 -0800
Message-ID: <7viqb6trwu.fsf@alter.siamese.dyndns.org>
References: <20100112153656.GA24840@coredump.intra.peff.net>
 <20100112154153.GB24957@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 13 07:55:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUx94-0000oO-7L
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 07:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754927Ab0AMGzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 01:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754925Ab0AMGzz
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 01:55:55 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37825 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923Ab0AMGzy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 01:55:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CDA9A90010;
	Wed, 13 Jan 2010 01:55:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=nEelaBCKdIIl7RSgJJdEtMd+1zU=; b=k5XN7Ceqx2yoTN+kFPUR9dw
	jW1By3e/NpbG8ia3YTB2fIlSh0VJ5+EUDAePi34cEejD05xU+OtoMvSnf2XuJRHU
	s/OKhUXe8FJPx3jqXwaPgUdYfEK0limmF74m/FJ+5BVkUfIlW786AXlJRYhLH3Zz
	+ZEsY0MTnOiqMyiHWuas=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=BNWUa9uPryjjzN39kzDOCSGwgGbLSKw+IgcufTOj0yeQyNaiM
	pbThqOc3FYBWXMiZs9nsyTps8ouQRitD4Wza7dZKGehlFZfMjS66nApg45uEx72n
	PgPa9YDMKpVwa9vrPDVyyUg1fNc8ApKFmn+XP4Usr/lYzirHlRaeqxmLDc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9987D9000E;
	Wed, 13 Jan 2010 01:55:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B67959000A; Wed, 13 Jan
 2010 01:55:46 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AF5CA382-0010-11DF-B6C0-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136774>

Jeff King <peff@peff.net> writes:

> +`strbuf_percentquote_buf`::
> +
> +	Append the contents of one strbuf to another, quoting any
> +	percent signs ("%") into double-percents ("%%") in the
> +	destination. This is useful for literal data to be fed to either
> +	strbuf_expand or to the *printf family of functions.
> +
>  `strbuf_addf`::
>  
>  	Add a formatted string to the buffer.
> diff --git a/strbuf.c b/strbuf.c
> index 6cbc1fc..b5183c6 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -257,6 +257,16 @@ size_t strbuf_expand_dict_cb(struct strbuf *sb, const char *placeholder,
>  	return 0;
>  }
>  
> +void strbuf_percentquote_buf(struct strbuf *dest, struct strbuf *src)
> +{

Just a style thing, but please call that "dst" to be consistent.  You are
already dropping vowels from the other side to spell it "src".

I wondered if the function should be just 1-arg that always quotes
in-place instead, but your [PATCH 3/3] wants to have an appending
semantics from this function, so changing it to be a 1-arg "in-place
quoter" will force the caller to run strbuf_addbuf() on the result, which
is not nice.

Since tucking a p-quoted version of the same string to its original
doesn't make sense at all, perhaps this should:

 (0) be renamed to have "append" somewhere in its name;

 (1) mark the src side as const; and

 (2) perhaps have assert(dst != src).  The loop won't terminate when
     called with src == dst, I think.

There seems to be only one other strbuf function that takes two strbufs in
the suite (strbuf_addbuf), and I think it is unsafe in a different way,
which is trivial to fix.

-- >8 --

Subject: [PATCH] strbuf_addbuf(): allow passing the same buf to dst and src

If sb and sb2 are the same (i.e. doubling the string), the underlying
strbuf_add() will make sb2->buf invalid by calling strbuf_grow(sb) at
the beginning and will read from the freed buffer.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 strbuf.h |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index fa07ecf..e272359 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -105,7 +105,13 @@ static inline void strbuf_addstr(struct strbuf *sb, const char *s) {
 	strbuf_add(sb, s, strlen(s));
 }
 static inline void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2) {
-	strbuf_add(sb, sb2->buf, sb2->len);
+	char *buf = sb2->buf;
+	int len = sb2->len;
+	if (sb->buf == sb2->buf) {
+		strbuf_grow(sb, len);
+		buf = sb->buf;
+	}
+	strbuf_add(sb, buf, len);
 }
 extern void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len);
 
-- 
1.6.6.280.ge295b7.dirty
