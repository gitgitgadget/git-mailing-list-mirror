From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rework strbuf API and semantics.
Date: Thu, 06 Sep 2007 03:03:57 -0700
Message-ID: <7vtzq89kky.fsf@gitster.siamese.dyndns.org>
References: <20070905085720.GD31750@artemis.corp>
	<11890199232110-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 12:04:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITEDc-0004kw-6s
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 12:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755508AbXIFKEH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 06:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755073AbXIFKEG
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 06:04:06 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbXIFKEE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 06:04:04 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 230B512F510;
	Thu,  6 Sep 2007 06:04:22 -0400 (EDT)
In-Reply-To: <11890199232110-git-send-email-madcoder@debian.org> (Pierre
	Habouzit's message of "Wed, 5 Sep 2007 21:18:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57855>

Pierre Habouzit <madcoder@debian.org> writes:

> diff --git a/strbuf.c b/strbuf.c
> ...
> +void strbuf_addvf(struct strbuf *sb, const char *fmt, va_list ap)
> +{
> +	size_t len;
> +	va_list ap2;
> +
> +	va_copy(ap2, ap);
> +
> +	len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
> +	if (len < 0) {
> +		len = 0;
> +	}
> +	if (len >= sb->alloc - sb->len) {
> +		strbuf_grow(sb, len);
> +		len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap2);
> +		if (len >= sb->alloc - sb->len) {
> +			len = sb->alloc - sb->len - 1;
> +		}
> +	}
> +	sb->len = sb->len + len;
> +	sb->buf[sb->len] = '\0';
>  }

Hmmmmm...  Didn't we recently had a patch that used va_copy()
which was not available somewhere and was shot down?

Instead of that nice inline strbuf_addf(), you may have to do
something like:

	strbuf_addf(..., fmt, ...) {
                va_list ap;

                va_start(ap, fmt);
                len = vsnprintf(...);
                va_end(ap);
                if (len >= sb_avail(sb)) {
                        strbuf_grow(sb, len);
                        va_start(ap, fmt);
                        len = vsnprintf(...);
                        va_end(ap);
                        if (len >= sb_avail(sb))
                                gaah();
                }
		sb->len += len;
                sb->buf[sb->len] = '\0';
	}


> +ssize_t strbuf_read(struct strbuf *sb, int fd)
> +{
> +	size_t oldlen = sb->len;
> +
> +	for (;;) {
> +		ssize_t cnt;
> +
> +		strbuf_grow(sb, 8192);
> +		cnt = xread(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
> +		if (cnt < 0) {
> +			sb->buf[sb->len = oldlen] = '\0';

Assignment inside array subscript is very hard to read.
Besides, what's the error semantics?  On error, this behaves as
if no bytes are read (i.e. partial read results in the initial
round is lost forever)?
