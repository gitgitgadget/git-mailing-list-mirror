From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v6 1/3] Add bidirectional_transfer_loop()
Date: Mon, 11 Oct 2010 20:57:13 -0700
Message-ID: <7v1v7woyg6.fsf@alter.siamese.dyndns.org>
References: <1286571713-7755-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1286571713-7755-2-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Oct 12 05:57:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5VzX-00036T-TK
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 05:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756538Ab0JLD5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 23:57:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33666 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756290Ab0JLD5U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 23:57:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 81B4CDDEBB;
	Mon, 11 Oct 2010 23:57:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=dqRAfJrhWxvnJKSWUKxK6BLODZ4=; b=WUzCWKQxBUpvf57bej1Etkm
	o2o1Rwk5wtc7kamU857mmX1Z4Z6QLF+sNlmadX2WkZhFqTle+yQw29ni8uXhoTYG
	O9jpXmW1PTYd9X5IbrrsdoPlSPIVFG1gDtJ9MwPo5NRzt9NKB2X8fb7DKQgihvQC
	hH7bE1y0GEml4DlEqO7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=NxlWdq35JoKyJSvtz5PkXo4Stt9iZ7LXQz/0FTT8+DOVcaA9c
	RWXHu/LW/42/Zh72boB2Mt39Vb6iTIjfk7abY7dR5m6fXoRKYatFmXE8dxk64nF5
	Bv5/haYe8LYtaeCwjDHba6q6uSxXgRnaVNmsov36UEpc2jMv/AKoBeU7oY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E741DDEB9;
	Mon, 11 Oct 2010 23:57:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 70C24DDEB8; Mon, 11 Oct
 2010 23:57:15 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CEBAD44A-D5B4-11DF-9F9F-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158821>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> This helper function copies bidirectional stream of data between
> stdin/stdout and specified file descriptors.
>
> Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
> ---
> diff --git a/transport-helper.c b/transport-helper.c
> index acfc88e..acbae47 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -862,3 +862,264 @@ int transport_helper_init(struct transport *transport, const char *name)
> + ...
> +static int udt_do_read(struct unidirectional_transfer *t)
> +{
> +	int r;
> +	transfer_debug("%s is readable", t->src_name);
> +	r = read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
> +	if (r < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
> +		errno != EINTR) {
> +		error("read(%s) failed: %s", t->src_name, strerror(errno));
> +		return -1;
> +	} else if (r == 0) {
> +		transfer_debug("%s EOF (with %i bytes in buffer)",
> +			t->src_name, t->bufuse);
> +		t->state = SSTATE_FLUSHING;
> +	} else if (r > 0) {
> +		t->bufuse += r;
> +		transfer_debug("Read %i bytes from %s (buffer now at %i)",
> +			r, t->src_name, (int)t->bufuse);
> +	}
> +	return 0;
> +}

This is probably a stupid question, but can t->bufuse be equal to BUFFERSIZE
when this function is entered?  What happens in such a case?

You would want to rename the counter "count" or "bytes" or somesuch if you
want to copy & paste it to udt_do_write() side, as "int r" that holds the
number of bytes _written_ feels somewhat odd ;-).

> +static int udt_do_write(struct unidirectional_transfer *t)
> +{
> +	int r;
> +	transfer_debug("%s is writable", t->dest_name);
> +	r = write(t->dest, t->buf, t->bufuse);
> +	if (r < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
> ...

> +#ifndef NO_PTHREADS
> +static int transloop_with_threads(struct bidirectional_transfer_state *s)
> +{
> +	pthread_t gtp_thread;
> +	pthread_t ptg_thread;
> +	int err;
> +	int ret = 0;
> +	void *dummy;
> +	err = pthread_create(&gtp_thread, NULL, udt_copy_thread_routine,
> +		&s->gtp);
> +	if (err)
> +		die("Can't start thread for copying data: %s", strerror(err));
> +	err = pthread_create(&ptg_thread, NULL, udt_copy_thread_routine,
> +		&s->ptg);
> +	if (err)
> +		die("Can't start thread for copying data: %s", strerror(err));
> +	err = pthread_join(gtp_thread, &dummy);
> +	if (!dummy) {

I suspect that originally you did not use "dummy" for anything, but if you
use the value to decide what to do, it now probably is something more than
a dummy, no?

Just out of curiosity, does the order of creation and joining of these
threads make a difference?

> +		error("Git to program copy thread failed");
> +		ret = 1;
> +	}
> ...
> +#else
> +
> +static void udt_kill_transfer(struct unidirectional_transfer *t)
> +{
> +	t->state = SSTATE_FINISHED;
> +	close(t->src);
> +	if (t->dest_is_sock)
> +		shutdown(t->dest, SHUT_WR);
> +	else
> +		close(t->dest);
> +}
> +
> +static int transloop_with_threads(struct bidirectional_transfer_state *s)
> +{

It feels funny to see in NO_PTHREADS codepath a something_with_threads
function that uses fork().  Perhaps bidirectional_transfer_loop() can call
a function with a more generic name, e.g. transloop(), that is implemented
in terms of either threads or processes depending on the platform
capability?
