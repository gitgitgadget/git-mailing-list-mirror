From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 03/20] pkt-line: add gentle version of packet_write
Date: Thu, 12 May 2016 14:14:26 -0700
Message-ID: <xmqqlh3fc72l.fsf@gitster.mtv.corp.google.com>
References: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
	<1463084415-19826-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu May 12 23:14:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0xwI-0007qB-GK
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 23:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbcELVOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 17:14:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65367 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751330AbcELVOa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 17:14:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B026F1B745;
	Thu, 12 May 2016 17:14:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gCWEGQ9p4ahJiJDfGMVVD5sb2q4=; b=CtRf0k
	cJ5NTCMkSY3RUYz1mRPgPkOawx9RCKVw0idbQCdHOLWdfF8JU2c0kNeX0Sax+0PG
	yYnMG4qkC5GxPwMxPwbrqnvzwOT0OZKBb7Vy3w8otWnCdvnkCWuzLhKxAVPcE54O
	LLfuEinv/IRjuTEX7GeUulaU0JnnZtPVhm1Lw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mWm2vxZHHIGSJQuvYzOTICn082O+2TyM
	8UL9BzqBgFqPc/UhEz4028QCcEkUTU5VsaCIjSBdLVvk/5craZJtEYG9Uhk35G/O
	5cWCu2CzpPNNnrLMQImiQFDbBIi3tcJpslQnPNI19JZAQtipKsTrDvMbd4m7sX5g
	Beg63MhT/iQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A727B1B744;
	Thu, 12 May 2016 17:14:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29A131B743;
	Thu, 12 May 2016 17:14:28 -0400 (EDT)
In-Reply-To: <1463084415-19826-4-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Thu, 12 May 2016 16:19:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 82E0D838-1886-11E6-8A96-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294479>

David Turner <dturner@twopensource.com> writes:

> packet_write calls write_or_die, which dies with a sigpipe even if
> calling code has explicitly blocked that signal.
>
> Add packet_write_gently and packet_flush_gently, which don't.  Soon,
> we will use this for communication with git index-helper, which, being
> merely an optimization, should be permitted to die without disrupting
> clients.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---

Looks quite sensible.  Thanks.

>  pkt-line.c | 18 ++++++++++++++++++
>  pkt-line.h |  2 ++
>  2 files changed, 20 insertions(+)
>
> diff --git a/pkt-line.c b/pkt-line.c
> index 62fdb37..f964446 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -91,6 +91,12 @@ void packet_flush(int fd)
>  	write_or_die(fd, "0000", 4);
>  }
>  
> +int packet_flush_gently(int fd)
> +{
> +	packet_trace("0000", 4, 1);
> +	return write_in_full(fd, "0000", 4) != 4;
> +}
> +
>  void packet_buf_flush(struct strbuf *buf)
>  {
>  	packet_trace("0000", 4, 1);
> @@ -130,6 +136,18 @@ void packet_write(int fd, const char *fmt, ...)
>  	write_or_die(fd, buf.buf, buf.len);
>  }
>  
> +int packet_write_gently(int fd, const char *fmt, ...)
> +{
> +	static struct strbuf buf = STRBUF_INIT;
> +	va_list args;
> +
> +	strbuf_reset(&buf);
> +	va_start(args, fmt);
> +	format_packet(&buf, fmt, args);
> +	va_end(args);
> +	return write_in_full(fd, buf.buf, buf.len) != buf.len;
> +}
> +
>  void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
>  {
>  	va_list args;
> diff --git a/pkt-line.h b/pkt-line.h
> index 3cb9d91..deffcb5 100644
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -20,7 +20,9 @@
>   * side can't, we stay with pure read/write interfaces.
>   */
>  void packet_flush(int fd);
> +int packet_flush_gently(int fd);
>  void packet_write(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
> +int packet_write_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
>  void packet_buf_flush(struct strbuf *buf);
>  void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
