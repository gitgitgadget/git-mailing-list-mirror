From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v3 6/8] Support remote helpers implementing smart
	transports
Date: Mon, 7 Dec 2009 10:11:48 -0800
Message-ID: <20091207181148.GG17173@spearce.org>
References: <1260116931-16549-1-git-send-email-ilari.liusvaara@elisanet.fi> <1260116931-16549-7-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Mon Dec 07 19:12:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHi3z-00054J-Dd
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 19:11:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbZLGSLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 13:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbZLGSLq
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 13:11:46 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:63039 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964908AbZLGSLp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 13:11:45 -0500
Received: by gxk26 with SMTP id 26so4344696gxk.1
        for <git@vger.kernel.org>; Mon, 07 Dec 2009 10:11:52 -0800 (PST)
Received: by 10.101.177.33 with SMTP id e33mr2585284anp.181.1260209511827;
        Mon, 07 Dec 2009 10:11:51 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 15sm2625013yxh.40.2009.12.07.10.11.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Dec 2009 10:11:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1260116931-16549-7-git-send-email-ilari.liusvaara@elisanet.fi>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134768>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
> diff --git a/transport-helper.c b/transport-helper.c
> index 3d99fe1..e0254bc 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
>  static int fetch(struct transport *transport,
>  		 int nr_heads, struct ref **to_fetch)
>  {
>  	struct helper_data *data = transport->data;
>  	int i, count;
>  
> +	if (process_connect(transport, 0)) {
> +		transport_take_over(transport);
> +		return transport->fetch(transport, nr_heads, to_fetch);
> +	}

We should already be connected because of the prior call into
get_refs_list().  If I read your code correctly we'd try to open
a new connection right here, which makes no sense.  But its also
possible for us to be in a different transport, so we do code with
the assumption that we didn't get invoked through get_refs_list()
first and therefore need to open the connection ourselves.

Also, given the above invocation pattern, I see no reason why you
need the disown virtual function on struct transport*.  Just pass
the #@!**! struct child* into transport_take_over() from the 3
call sites here and get rid of that unnecessary indirection.

-- 
Shawn.
