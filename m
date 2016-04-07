From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] builtin/am: read mailinfo from file
Date: Thu, 07 Apr 2016 10:08:37 -0700
Message-ID: <xmqqinzt1h4a.fsf@gitster.mtv.corp.google.com>
References: <1460042563-32741-1-git-send-email-mst@redhat.com>
	<1460042563-32741-4-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 19:08:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoDQD-0008W1-NB
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 19:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556AbcDGRIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 13:08:41 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62637 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751440AbcDGRIk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 13:08:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6DFB0525D0;
	Thu,  7 Apr 2016 13:08:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oNojk1yPq8nej2AD8RNRaH/fEMU=; b=a1hgOV
	gjE/2QWdLKaSQg//7ut72WaAZ7hdFfoBwVRRfFIP9eHZ1BIB098396Qw6oB/D8NA
	xSaW3zt6P3tp4xjZlEDPoChNs79Vo9ga7tT7qgAZHk6vmPzgiYy2IMkdJrzowr/E
	EQTWLMgcxOp0SpweqUwMk5FxtJKG0+VHy+q7k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QFRdkuHMEFZozDKImwD+tGiFvxcIDaXP
	XZLwkM7khblI+pj8sZEUTFHKXYpDSKXlB0d42y46vghachZIpyb9VUhsrcZ7AGGQ
	f+jZ/xeLAF83pG9e6ARCyVy5U+TEptazWXlYnw5n/Vyp5SGRc4fqQztf/iLteqc+
	geVebd/4NPE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 64CF6525CF;
	Thu,  7 Apr 2016 13:08:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D32C9525CE;
	Thu,  7 Apr 2016 13:08:38 -0400 (EDT)
In-Reply-To: <1460042563-32741-4-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Thu, 7 Apr 2016 18:23:13 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5F262E70-FCE3-11E5-BC78-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290928>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Slightly slower, but will allow easy additional processing on it.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

I haven't read 4/4 yet, but can guess from what this patch does that
the next step would let others futz with the contents of the message
that is on disk (i.e. what mailinfo() wrote out, which is identical
to what we have in mi.log_message at this point of the codeflow)
before you do the new strbuf_read_file().

It probably is better to do this as part of 4/4; it is easier to
understand why this is a good and necessary thing to do.  An obvious
improvement is to omit this extra "read back from the filesystem"
when we won't be making any interpret-trailer calls (i.e. no -t
option from the command line), but if we stop at this step 3/4, then
we'd end up wasting cycles without having any benefit.

>  builtin/am.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index d003939..4180b04 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1246,6 +1246,7 @@ static int parse_mail(struct am_state *state, const char *mail)
>  	FILE *fp;
>  	struct strbuf sb = STRBUF_INIT;
>  	struct strbuf msg = STRBUF_INIT;
> +	struct strbuf log_msg = STRBUF_INIT;
>  	struct strbuf author_name = STRBUF_INIT;
>  	struct strbuf author_date = STRBUF_INIT;
>  	struct strbuf author_email = STRBUF_INIT;
> @@ -1330,7 +1331,12 @@ static int parse_mail(struct am_state *state, const char *mail)
>  	}
>  
>  	strbuf_addstr(&msg, "\n\n");
> -	strbuf_addbuf(&msg, &mi.log_message);
> +
> +	if (strbuf_read_file(&log_msg,  am_path(state, "msg"), 0) < 0) {
> +		die_errno(_("could not read '%s'"), am_path(state, "msg"));
> +	}

I do not think these {} serve any purpose; drop them?

> +
> +	strbuf_addbuf(&msg, &log_msg);
>  	strbuf_stripspace(&msg, 0);
>  
>  	if (state->signoff)
> @@ -1349,6 +1355,7 @@ static int parse_mail(struct am_state *state, const char *mail)
>  	state->msg = strbuf_detach(&msg, &state->msg_len);
>  
>  finish:
> +	strbuf_release(&log_msg);
>  	strbuf_release(&msg);
>  	strbuf_release(&author_date);
>  	strbuf_release(&author_email);
