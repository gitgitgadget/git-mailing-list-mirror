From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 7/7] Factor ref updating out of fetch_with_import
Date: Thu, 29 Oct 2009 07:22:32 -0700
Message-ID: <20091029142232.GS10505@spearce.org>
References: <1256798426-21816-1-git-send-email-srabbelier@gmail.com> <1256798426-21816-8-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 15:22:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Vtf-0007PK-5B
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 15:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813AbZJ2OW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 10:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753786AbZJ2OW2
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 10:22:28 -0400
Received: from george.spearce.org ([209.20.77.23]:35034 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661AbZJ2OW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 10:22:27 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4D97F381D3; Thu, 29 Oct 2009 14:22:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1256798426-21816-8-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131592>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Also allow the new update_refs to actually update the refs set, this
> way the remote helper can set the value of previously unknown refs.
...
> diff --git a/builtin-clone.c b/builtin-clone.c
> index f281756..768668d 100644
> --- a/builtin-clone.c
> +++ b/builtin-clone.c
> @@ -512,6 +512,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		if (refs) {
>  			struct ref *ref_cpy = copy_ref_list(refs);
>  			transport_fetch_refs(transport, ref_cpy);
> +			if (transport->update_refs)
> +			{
> +				ref_cpy = copy_ref_list(refs);
> +				transport->update_refs(transport, ref_cpy);

Please define a transport_update_refs wrapper function to implement
this method invocation on the transport instance.  Callers should
not be reaching into the struct transport directly.

> diff --git a/builtin-fetch.c b/builtin-fetch.c
> index 63a4ff0..3aaac47 100644
> --- a/builtin-fetch.c
> +++ b/builtin-fetch.c
> @@ -479,7 +479,11 @@ static int fetch_refs(struct transport *transport, struct ref *ref_map)
>  {
>  	int ret = quickfetch(ref_map);
>  	if (ret)
> +	{
>  		ret = transport_fetch_refs(transport, ref_map);
> +		if (transport->update_refs)
> +			transport->update_refs(transport, ref_map);

I certainly have to wonder... if this is done in both fetch and
clone, why isn't it just part of fetch_refs?

> diff --git a/transport-helper.c b/transport-helper.c
> index a361366..9a98fae 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -264,5 +271,6 @@ int transport_helper_init(struct transport *transport, const char *name)
>  	transport->get_refs_list = get_refs_list;
>  	transport->fetch = fetch;
>  	transport->disconnect = release_helper;
> +	transport->update_refs = update_refs;

Please set this before the disconnect method (move it up one line).

-- 
Shawn.
