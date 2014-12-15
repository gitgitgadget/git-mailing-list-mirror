From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] receive-pack.c: add protocol support to negotiate atomic-push
Date: Mon, 15 Dec 2014 12:53:12 -0800
Message-ID: <xmqqy4q8d493.fsf@gitster.dls.corp.google.com>
References: <1418673368-20785-1-git-send-email-sbeller@google.com>
	<1418673368-20785-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, jrnieder@gmail.com,
	ronniesahlberg@gmail.com, Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 21:53:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0ce1-0003Vn-Rp
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 21:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbaLOUxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 15:53:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53511 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750722AbaLOUxY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 15:53:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AEF5C27D8E;
	Mon, 15 Dec 2014 15:53:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sOugQRKiR1Rog9XdrCicpxHa9Rw=; b=pxg+iI
	66JjVv+xTS9cdGVzK3tQkU6UFeGYec0jzBP5BeMlag8jnzo8wSKjpwzTA/tB1594
	aG6f9CLDEI9S287cAv/kWCV4sUe/GpxJ7hN/JFjfZU7iXThRctL314ck6IyLcAYC
	S3akz8gWCHR/bB9fTDTenIsCVINWHUzlfDkd0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hTrlDZyqwB49X790ZQuVk7EGediNO2OC
	30LMRdWqfbaTqGwNXG0vjepknlJz28zNhyrTxcLo3mw0lwLfNVgxD2baZbGGGK/M
	/exU5o+O0ljxDj4SCs+gqvbT6WBWO+Pcv+R+snebZXr9wRUEgSRhRrQc6JbH1VS9
	QfrD9pf6PeA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A588027D8C;
	Mon, 15 Dec 2014 15:53:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2BC1A27D8A;
	Mon, 15 Dec 2014 15:53:14 -0500 (EST)
In-Reply-To: <1418673368-20785-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 15 Dec 2014 11:56:04 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 633BB91E-849C-11E4-A6A1-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261422>

Stefan Beller <sbeller@google.com> writes:

> From: Ronnie Sahlberg <sahlberg@google.com>
>
> This adds support to the protocol between send-pack and receive-pack to
> * allow receive-pack to inform the client that it has atomic push capability
> * allow send-pack to request atomic push back.
>
> There is currently no setting in send-pack to actually request that atomic
> pushes are to be used yet. This only adds protocol capability not ability
> for the user to activate it.

Hmph, am I reading the patch to send-pack.c correctly?

It detects if the other side supports the capability and leaves it
in atomic_push_supported variable for later use, and also requests
the feature to be activated when atomic_push is set, but I see no
logic to link these two together, e.g. error out when atomic_push
is true and atomic_push_supported is false (or turn it off with a
warning, or whatever).

> diff --git a/send-pack.c b/send-pack.c
> index 949cb61..1ccc84c 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -294,6 +294,8 @@ int send_pack(struct send_pack_args *args,
>  	int use_sideband = 0;
>  	int quiet_supported = 0;
>  	int agent_supported = 0;
> +	int atomic_push_supported = 0;
> +	int atomic_push = 0;
>  	unsigned cmds_sent = 0;
>  	int ret;
>  	struct async demux;
> @@ -314,6 +316,8 @@ int send_pack(struct send_pack_args *args,
>  		agent_supported = 1;
>  	if (server_supports("no-thin"))
>  		args->use_thin_pack = 0;
> +	if (server_supports("atomic-push"))
> +		atomic_push_supported = 1;
>  	if (args->push_cert) {
>  		int len;
>  
> @@ -335,6 +339,8 @@ int send_pack(struct send_pack_args *args,
>  		strbuf_addstr(&cap_buf, " side-band-64k");
>  	if (quiet_supported && (args->quiet || !args->progress))
>  		strbuf_addstr(&cap_buf, " quiet");
> +	if (atomic_push)
> +		strbuf_addstr(&cap_buf, " atomic-push");
>  	if (agent_supported)
>  		strbuf_addf(&cap_buf, " agent=%s", git_user_agent_sanitized());
