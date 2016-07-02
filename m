Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA1801F744
	for <e@80x24.org>; Sat,  2 Jul 2016 09:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbcGBJpJ (ORCPT <rfc822;e@80x24.org>);
	Sat, 2 Jul 2016 05:45:09 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48610 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031AbcGBJpI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2016 05:45:08 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BA501F744;
	Sat,  2 Jul 2016 09:45:04 +0000 (UTC)
Date:	Sat, 2 Jul 2016 09:45:04 +0000
From:	Eric Wong <e@80x24.org>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, peff@peff.net, dwwang@google.com,
	gitster@pobox.com, dennis@kaarsemaker.net
Subject: Re: [PATCHv2 3/4] push: accept push options
Message-ID: <20160702094504.GA7476@dcvr.yhbt.net>
References: <20160702002014.29497-1-sbeller@google.com>
 <20160702002014.29497-4-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160702002014.29497-4-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> wrote:
> @@ -513,6 +531,17 @@ int send_pack(struct send_pack_args *args,
>  	strbuf_release(&req_buf);
>  	strbuf_release(&cap_buf);
>  
> +	if (use_push_options) {
> +		struct string_list_item *item;
> +		struct strbuf sb = STRBUF_INIT;
> +
> +		for_each_string_list_item(item, args->push_options)
> +			packet_buf_write(&sb, "%s", item->string);
> +			write_or_die(out, sb.buf, sb.len);

write_or_die looks mis-indented.

> +		packet_flush(out);
> +		strbuf_release(&sb);
> +	}
> +
>  	if (use_sideband && cmds_sent) {
>  		memset(&demux, 0, sizeof(demux));
>  		demux.proc = sideband_demux;

> @@ -640,6 +641,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
>  	struct transport *ret = xcalloc(1, sizeof(*ret));
>  
>  	ret->progress = isatty(2);
> +	ret->push_options = NULL;

Seems unnecessary to set NULL, here, xcalloc is right above.

>  	if (!remote)
>  		die("No remote provided to transport_get()");
