From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/3] send-pack: avoid deadlock on git:// push with failed
 pack-objects
Date: Mon, 16 May 2011 22:02:16 +0200
Message-ID: <4DD182C8.50308@kdbg.org>
References: <20110516063944.GB25731@sigill.intra.peff.net> <20110516065257.GC19078@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 16 22:02:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM3zl-0000pB-Db
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 22:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755151Ab1EPUCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 16:02:18 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:27026 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754904Ab1EPUCR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 16:02:17 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 615B8130047;
	Mon, 16 May 2011 22:02:16 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 3229A19F380;
	Mon, 16 May 2011 22:02:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.17) Gecko/20110414 SUSE/3.1.10 Thunderbird/3.1.10
In-Reply-To: <20110516065257.GC19078@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173752>

Am 16.05.2011 08:52, schrieb Jeff King:
> And if you wanted to drop the first two patches, this probably works OK
> without the conditional, as the shutdown is just a no-op on a pipe
> descriptor then.
> 
>  builtin-send-pack.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/builtin-send-pack.c b/builtin-send-pack.c
> index 3e70795..682a3f9 100644
> --- a/builtin-send-pack.c
> +++ b/builtin-send-pack.c
> @@ -520,6 +520,8 @@ int send_pack(struct send_pack_args *args,
>  				ref->status = REF_STATUS_NONE;
>  			if (args->stateless_rpc)
>  				close(out);
> +			if (git_connection_is_socket(conn))
> +				shutdown(fd[0], SHUT_WR);
>  			if (use_sideband)
>  				finish_async(&demux);
>  			return -1;

We probably need a wrapper for shutdown() on Windows. I'll look into
this tomorrow.

-- Hannes
