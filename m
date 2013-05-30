From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 1/3] read-cache: plug a few leaks
Date: Thu, 30 May 2013 17:13:18 +0200
Message-ID: <51A76C8E.1080009@lsrfire.ath.cx>
References: <1369920861-30030-1-git-send-email-felipe.contreras@gmail.com> <1369920861-30030-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 17:13:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui4Xg-0006hU-Ln
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 17:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933477Ab3E3PNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 11:13:25 -0400
Received: from india601.server4you.de ([85.25.151.105]:57668 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933340Ab3E3PNY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 11:13:24 -0400
Received: from [192.168.2.105] (p579BEB6E.dip0.t-ipconnect.de [87.155.235.110])
	by india601.server4you.de (Postfix) with ESMTPSA id 0D43B1FF;
	Thu, 30 May 2013 17:13:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <1369920861-30030-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226009>

Am 30.05.2013 15:34, schrieb Felipe Contreras:
> We don't free 'istate->cache' properly.
> 
> Apparently 'initialized' doesn't really mean initialized, but loaded, or
> rather 'not-empty', and the cache can be used even if it's not
> 'initialized', so we can't rely on this variable to keep track of the
> 'istate->cache'.
> 
> So assume it always has data, and free it before overwriting it.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>   read-cache.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/read-cache.c b/read-cache.c
> index 04ed561..e5dc96f 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1449,6 +1449,7 @@ int read_index_from(struct index_state *istate, const char *path)
>   	istate->version = ntohl(hdr->hdr_version);
>   	istate->cache_nr = ntohl(hdr->hdr_entries);
>   	istate->cache_alloc = alloc_nr(istate->cache_nr);
> +	free(istate->cache);

With that change, callers of read_index_from need to set ->cache to
NULL for uninitialized (on-stack) index_state variables.  They only had
to set ->initialized to 0 before in that situation.  It this chunk safe
for all existing callers?  Shouldn't the same free in discard_index
(added below) be enough?

>   	istate->cache = xcalloc(istate->cache_alloc, sizeof(struct cache_entry *));
>   	istate->initialized = 1;
>   
> @@ -1510,6 +1511,9 @@ int discard_index(struct index_state *istate)
>   
>   	for (i = 0; i < istate->cache_nr; i++)
>   		free(istate->cache[i]);
> +	free(istate->cache);
> +	istate->cache = NULL;
> +	istate->cache_alloc = 0;
>   	resolve_undo_clear_index(istate);
>   	istate->cache_nr = 0;
>   	istate->cache_changed = 0;

I was preparing a similar change, looks good.  There is a comment at
the end of discard_index() that becomes wrong due to that patch,
though -- better remove it as well.  It was already outdated as it
mentioned active_cache, while the function can be used with any
index_state.

diff --git a/read-cache.c b/read-cache.c
index e5dc96f..0f868af 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1522,8 +1522,6 @@ int discard_index(struct index_state *istate)
 	free_name_hash(istate);
 	cache_tree_free(&(istate->cache_tree));
 	istate->initialized = 0;
-
-	/* no need to throw away allocated active_cache */
 	return 0;
 }
 
