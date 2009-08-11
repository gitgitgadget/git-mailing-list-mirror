From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH 3/6] Move setup of curl remote helper from transport.c
 to transport-helper.c
Date: Tue, 11 Aug 2009 14:23:32 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908111421290.4638@intel-tinevez-2-302>
References: <alpine.LNX.2.00.0908101205120.27553@iabervon.org> <1249985426-13726-4-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, barkalow@iabervon.org, gitster@pobox.com,
	benji@silverinsanity.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Aug 11 14:24:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaqP7-00043V-Tf
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbZHKMXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 08:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbZHKMXe
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 08:23:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:37457 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751105AbZHKMXd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 08:23:33 -0400
Received: (qmail invoked by alias); 11 Aug 2009 12:23:33 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp041) with SMTP; 11 Aug 2009 14:23:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX184C9xoKKk4E+QdsAHltFFgqKnVh0OgosmwbiagtT
	SO76w98Q7DqpMl
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1249985426-13726-4-git-send-email-johan@herland.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125534>

Hi,

On Tue, 11 Aug 2009, Johan Herland wrote:

> diff --git a/transport-helper.c b/transport-helper.c
> index a901630..d3ce984 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -249,6 +249,34 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
>  	return ret;
>  }
>  
> +#ifndef NO_CURL
> +static int curl_transport_push(struct transport *transport, int refspec_nr, const char **refspec, int flags)
> +{
> +	const char **argv;
> +	int argc;
> +
> +	if (flags & TRANSPORT_PUSH_MIRROR)
> +		return error("http transport does not support mirror mode");
> +
> +	argv = xmalloc((refspec_nr + 12) * sizeof(char *));
> +	argv[0] = "http-push";
> +	argc = 1;
> +	if (flags & TRANSPORT_PUSH_ALL)
> +		argv[argc++] = "--all";
> +	if (flags & TRANSPORT_PUSH_FORCE)
> +		argv[argc++] = "--force";
> +	if (flags & TRANSPORT_PUSH_DRY_RUN)
> +		argv[argc++] = "--dry-run";
> +	if (flags & TRANSPORT_PUSH_VERBOSE)
> +		argv[argc++] = "--verbose";
> +	argv[argc++] = transport->url;
> +	while (refspec_nr--)
> +		argv[argc++] = *refspec++;
> +	argv[argc] = NULL;
> +	return !!run_command_v_opt(argv, RUN_GIT_CMD);
> +}
> +#endif
> +
>  int transport_helper_init(struct transport *transport)
>  {
>  	struct helper_data *data = xcalloc(sizeof(*data), 1);
> @@ -269,5 +297,16 @@ int transport_helper_init(struct transport *transport)
>  	transport->get_refs_list = get_refs_list;
>  	transport->fetch = fetch;
>  	transport->disconnect = disconnect_helper;
> +
> +	if (!strcmp(data->name, "http")
> +	 || !strcmp(data->name, "https")
> +	 || !strcmp(data->name, "ftp")) {
> +#ifdef NO_CURL
> +		error("git was compiled without libcurl support.");
> +#else
> +		transport->push = curl_transport_push;
> +#endif
> +	}
> +
>  	return 0;
>  }

I still find it rather, uhm, confusing that copying git-http-push and/or 
git-remote-http into place will still give you the error message "Git was 
compiled without libcurl support".

It's just as well that I do not need to maintain RPMs or DEBs.

Ciao,
Dscho
