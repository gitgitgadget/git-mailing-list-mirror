Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AC68211B4
	for <e@80x24.org>; Thu,  6 Dec 2018 06:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbeLFGfT (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 01:35:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61878 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbeLFGfT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 01:35:19 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C25B512326F;
        Thu,  6 Dec 2018 01:35:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6qk4WPWg0/2OgUvsC15V1FI0h64=; b=Dyasg1
        Mf7pnezuv51BdaaTYS6miN0bFiy6Rhtz0DNaAR9mQyKjLy3znPDX4UVzvvp9a4JK
        m0MQJpMySE5/d7ag9/cZ+IHAtahi/ZSADjrXQPddntPyUUTSgojtdKY4R48/o/Vo
        uIXQVH4Lz0gCWfDLmzyuAWiMyS8UmBy9iRtZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PpKioRmEp9vsX31lOt7PwjPmhJO9GMEK
        6r8iRRfRAVsQaUl0aYBK/LuzrFXonGtE+MVScxC3ByTGQ3UypBm9EpAQpXiZ1Gtk
        90XRk31uVN6n1ce0Pz77Z8cT0a0QJNW2qA5ihQE3EKVy898AnXHNduuNuG7csFgP
        vnhLF34C5Xs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BAB9C12326E;
        Thu,  6 Dec 2018 01:35:16 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 22F1E12326D;
        Thu,  6 Dec 2018 01:35:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [WIP RFC 4/5] upload-pack: refactor writing of "packfile" line
References: <cover.1543879256.git.jonathantanmy@google.com>
        <1d678a78a63b7e58988b52c8c0efab38c34a6848.1543879256.git.jonathantanmy@google.com>
Date:   Thu, 06 Dec 2018 15:35:15 +0900
In-Reply-To: <1d678a78a63b7e58988b52c8c0efab38c34a6848.1543879256.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 3 Dec 2018 15:37:37 -0800")
Message-ID: <xmqqzhtj88nw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17B1ADB6-F921-11E8-942D-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> @@ -126,6 +129,12 @@ static int read_pack_objects_stdout(int outfd, struct output_state *os)
>  	}
>  	os->used += readsz;
>  
> +	if (!os->packfile_started) {
> +		os->packfile_started = 1;
> +		if (use_protocol_v2)
> +			packet_write_fmt(1, "packfile\n");

If we fix this function so that the only byte in the buffer is held
back without emitted when os->used == 1 as I alluded to, this may
have to be done a bit later, as with such a change, it is no longer
guaranteed that send_client_data() will be called after this point.

> +	}
> +
>  	if (os->used > 1) {
>  		send_client_data(1, os->buffer, os->used - 1);
>  		os->buffer[0] = os->buffer[os->used - 1];

> +static void flush_progress_buf(struct strbuf *progress_buf)
> +{
> +	if (!progress_buf->len)
> +		return;
> +	send_client_data(2, progress_buf->buf, progress_buf->len);
> +	strbuf_reset(progress_buf);
> +}

Interesting.

>  static void create_pack_file(const struct object_array *have_obj,
> -			     const struct object_array *want_obj)
> +			     const struct object_array *want_obj,
> +			     int use_protocol_v2)
>  {
>  	struct child_process pack_objects = CHILD_PROCESS_INIT;
>  	struct output_state output_state = {0};
> @@ -260,9 +278,13 @@ static void create_pack_file(const struct object_array *have_obj,
>  			 */
>  			sz = xread(pack_objects.err, progress,
>  				  sizeof(progress));
> -			if (0 < sz)
> -				send_client_data(2, progress, sz);
> -			else if (sz == 0) {
> +			if (0 < sz) {
> +				if (output_state.packfile_started)
> +					send_client_data(2, progress, sz);
> +				else
> +					strbuf_add(&output_state.progress_buf,
> +						   progress, sz);

Isn't progress output that goes to the channel #2 pretty much
independent from the payload stream that carries the pkt-line 
command like "packfile" plus the raw pack stream?  It somehow
feels like an oxymoron to _buffer_ progress indicator, as it
defeats the whole point of progress report to buffer it.
