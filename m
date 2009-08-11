From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH 5/6] Let transport_helper_init() decide if a remote
 helper program can be used
Date: Tue, 11 Aug 2009 14:21:02 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908111403500.4638@intel-tinevez-2-302>
References: <alpine.LNX.2.00.0908101205120.27553@iabervon.org> <1249985426-13726-6-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, barkalow@iabervon.org, gitster@pobox.com,
	benji@silverinsanity.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Aug 11 14:21:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaqMM-0002qk-UI
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbZHKMVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 08:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752412AbZHKMVF
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 08:21:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:52942 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752079AbZHKMVE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 08:21:04 -0400
Received: (qmail invoked by alias); 11 Aug 2009 12:21:04 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp027) with SMTP; 11 Aug 2009 14:21:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Jehliz9MJSgWbs1BWznppyF/x7l99Bd5KZnk3a3
	rTmIs9copq8tIN
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1249985426-13726-6-git-send-email-johan@herland.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125533>

Hi,

On Tue, 11 Aug 2009, Johan Herland wrote:

> diff --git a/transport-helper.c b/transport-helper.c
> index d3ce984..de30727 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -5,6 +5,7 @@
>  #include "commit.h"
>  #include "diff.h"
>  #include "revision.h"
> +#include "help.h"
>  
>  struct helper_data
>  {
> @@ -279,11 +280,18 @@ static int curl_transport_push(struct transport *transport, int refspec_nr, cons
>  
>  int transport_helper_init(struct transport *transport)
>  {
> -	struct helper_data *data = xcalloc(sizeof(*data), 1);
> +	struct helper_data *data;
> +	struct strbuf buf = STRBUF_INIT;
> +	char *cmd;
> +
> +	if (!transport->remote)
> +		return -1;
>  
> +	data = xcalloc(sizeof(*data), 1);
>  	if (transport->remote->foreign_vcs) {
>  		data->name = xstrdup(transport->remote->foreign_vcs);
> -		transport->url = transport->remote->foreign_vcs;
> +		if (!transport->url)
> +			transport->url = transport->remote->foreign_vcs;
>  	} else {
>  		char *eom = strchr(transport->url, ':');
>  		if (!eom) {

IMHO it would be better to decide early if there is no vcs helper, rather 
than doing all kinds of set up, only to free() the data we worked so hard 
in setting up later.  Something like

	if (!transport->remote->foreign_vcs) {
		const char *colon = transport->url ?
			strchr(transport->url, ':') : NULL;

		if (!colon)
			return -1;

		transport->remote->foreign_vcs =
			xstrndup(transport->url, colon - transport->url);
	}

	strbuf_addf(&buf, "remote-%s", transport->remote->foreign_vcs);
	if (!is_git_command_or_alias(buf.buf)) {
		error("Could not find remote helper '%s'", buf.buf);
		strbuf_release(&buf);
		return -1;
	}

> diff --git a/transport.c b/transport.c
> index 81a28bc..b7033eb 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -794,11 +794,12 @@ struct transport *transport_get(struct remote *remote, const char *url)
>  		ret->fetch = fetch_objs_via_rsync;
>  		ret->push = rsync_transport_push;
>  
> -	} else if (!url
> -	        || !prefixcmp(url, "http://")
> -	        || !prefixcmp(url, "https://")
> -	        || !prefixcmp(url, "ftp://")) {
> -		transport_helper_init(ret);
> +	} else if ((!url
> +	         || (prefixcmp(url, "git:")
> +	          && prefixcmp(url, "ssh:")
> +	          && prefixcmp(url, "file:")))
> +	        && !transport_helper_init(ret)) {
> +		/* no-op, ret is initialized by transport_helper_init() */
>  
>  	} else if (url && is_local(url) && is_file(url)) {

Confusing...

When is transport_helper_init(ret) called now?  What is done in the code 
block?  Ah, nothing is done, but we usually write that this way:

		; /* do nothing */

And a comment would have been in order to say that we fall back to native 
Git transport, which will probably silently fail when there is no URL (I 
_know_ that allowing two different ways to specify the same thing are not 
only inconsistent and confusing, they lead to errors -- if not here then 
somewhere else).

Also, you missed two cases mentioned in connect.c: "git+ssh" and 
"ssh+git".  Which brings me to another thing: I'd rather handle the known 
protocols and fall back to a remote helper.  The other way round seems 
pretty backwards.

Sidenote: I have to admit that I find it distracting that "ret" is passed 
to transport_helper_init(), either, it's probably not an "int" but an 
instance of struct transport.)

Ciao,
Dscho
