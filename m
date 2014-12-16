From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/6] receive-pack.c: add protocol support to negotiate atomic-push
Date: Tue, 16 Dec 2014 11:05:28 -0800
Message-ID: <xmqqbnn3bekn.fsf@gitster.dls.corp.google.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
	<1418755747-22506-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, jrnieder@gmail.com,
	ronniesahlberg@gmail.com, Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 20:05:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0xRA-0007Dp-VE
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 20:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbaLPTFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 14:05:33 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750862AbaLPTFc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 14:05:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C4A52844E;
	Tue, 16 Dec 2014 14:05:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wHrll54t64EVY+wts/dPrulaZuc=; b=EXx1xi
	hurnzo8oeG3C2RuZOesNKnUWsQzh0yPTGjL2MAbs2B7mgLn2FVZ7wz/MBr4Z9Zya
	oN8GZG27FCwojv0RNyj4GIA3vOxeR5Jgy+xjzvIkeTJ+NbndhWO/QGFC1ZPakASw
	RdjTpKBV7LpUcNZXt2dCQSPn8GDqUEKOQV1C8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h8153BvzWp35OnmOTkFOi3V7558Ew2eq
	hlyCzrEYZK8IHECNBkFZtTtUYspaPDslkZww99ifOb4/OldFWrQVEPDdMUX9hmLG
	CvcSHkH2Nlc2BtYeYv/ckMZ4ngmKAz+8x4beywZHZ3oMRbdSm2gLOFvOshe7w7TW
	CnfuDxQwUM4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 521F92844D;
	Tue, 16 Dec 2014 14:05:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B9B912844C;
	Tue, 16 Dec 2014 14:05:31 -0500 (EST)
In-Reply-To: <1418755747-22506-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 16 Dec 2014 10:49:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 81BEDD3E-8556-11E4-8A0F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261451>

Stefan Beller <sbeller@google.com> writes:

> diff --git a/send-pack.c b/send-pack.c
> index 949cb61..2a513f4 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -294,6 +294,8 @@ int send_pack(struct send_pack_args *args,
>  	int use_sideband = 0;
>  	int quiet_supported = 0;
>  	int agent_supported = 0;
> +	int use_atomic;
> +	int atomic_supported = 0;
>  	unsigned cmds_sent = 0;
>  	int ret;
>  	struct async demux;
> @@ -314,6 +316,8 @@ int send_pack(struct send_pack_args *args,
>  		agent_supported = 1;
>  	if (server_supports("no-thin"))
>  		args->use_thin_pack = 0;
> +	if (server_supports("atomic"))
> +		atomic_supported = 1;
>  	if (args->push_cert) {
>  		int len;
>  
> @@ -328,6 +332,11 @@ int send_pack(struct send_pack_args *args,
>  			"Perhaps you should specify a branch such as 'master'.\n");
>  		return 0;
>  	}
> +	if (args->atomic && !atomic_supported) {
> +		fprintf(stderr, "Server does not support atomic push.");
> +		return -1;

I'd tweak this to

	return error("server does not support atomic push.");

to (0) shorten, (1) make sure the message is terminated with LF,
and (2) match the other error messages in the program.

Other than that looks good.

Thanks.

> +	}
> +	use_atomic = atomic_supported && args->atomic;
>  
>  	if (status_report)
>  		strbuf_addstr(&cap_buf, " report-status");
> @@ -335,6 +344,8 @@ int send_pack(struct send_pack_args *args,
>  		strbuf_addstr(&cap_buf, " side-band-64k");
>  	if (quiet_supported && (args->quiet || !args->progress))
>  		strbuf_addstr(&cap_buf, " quiet");
> +	if (use_atomic)
> +		strbuf_addstr(&cap_buf, " atomic");
>  	if (agent_supported)
>  		strbuf_addf(&cap_buf, " agent=%s", git_user_agent_sanitized());
>  
> diff --git a/send-pack.h b/send-pack.h
> index 5635457..b664648 100644
> --- a/send-pack.h
> +++ b/send-pack.h
> @@ -13,7 +13,8 @@ struct send_pack_args {
>  		use_ofs_delta:1,
>  		dry_run:1,
>  		push_cert:1,
> -		stateless_rpc:1;
> +		stateless_rpc:1,
> +		atomic:1;
>  };
>  
>  int send_pack(struct send_pack_args *args,
