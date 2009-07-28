From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3 v2] Use an external program to implement fetching
 with curl
Date: Tue, 28 Jul 2009 15:19:22 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907281505290.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0907280207350.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jul 28 15:19:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVmaV-0006kH-Lj
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 15:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939AbZG1NTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 09:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbZG1NTU
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 09:19:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:39918 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751873AbZG1NTT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 09:19:19 -0400
Received: (qmail invoked by alias); 28 Jul 2009 13:19:18 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp033) with SMTP; 28 Jul 2009 15:19:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18uxiYTLakuQnNPjN8C8g4Hv8PWJYNkxjj5Gwidba
	94r42uYkwp4DOU
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.2.00.0907280207350.2147@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124247>

Hi,

On Tue, 28 Jul 2009, Daniel Barkalow wrote:

> diff --git a/Makefile b/Makefile
> index 01efc73..d3dd2ed 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -980,6 +980,7 @@ else
>  		CURL_LIBCURL = -lcurl
>  	endif
>  	BUILTIN_OBJS += builtin-http-fetch.o
> +	PROGRAMS += git-shim-curl$X

So now you not only use that disgustingly meaningless name "shim", but 
also abolish the notion that the helper is called by its protocol name?

> diff --git a/shim-curl.c b/shim-curl.c
> new file mode 100644
> index 0000000..bde041b
> --- /dev/null
> +++ b/shim-curl.c
> @@ -0,0 +1,132 @@
> +#include "cache.h"
> +#include "remote.h"
> +#include "strbuf.h"
> +#include "walker.h"
> +#include "http.h"
> +
> +static struct ref *get_refs(struct walker *walker, const char *url)
> +{
> +	int http_ret;
> +	char *refs_url;
> +	struct strbuf buffer = STRBUF_INIT;
> +	char *data, *start, *mid;
> +	int i = 0;
> +	char *ref_name;
> +	struct ref *refs = NULL;
> +	struct ref *ref = NULL;
> +	struct ref *last_ref = NULL;
> +
> +	refs_url = xmalloc(strlen(url) + 11);
> +	sprintf(refs_url, "%s/info/refs", url);

And I thought we had strbufs...

> +
> +	http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
> +	switch (http_ret) {
> +	case HTTP_OK:
> +		break;
> +	case HTTP_MISSING_TARGET:
> +		die("%s not found: did you run git update-server-info on the"
> +		    " server?", refs_url);
> +	default:
> +		http_error(refs_url, http_ret);
> +		die("HTTP request failed");
> +	}
> +	free(refs_url);
> +
> +	data = buffer.buf;
> +	start = NULL;
> +	mid = data;

What does "mid" stand for?

> +	while (i < buffer.len) {
> +		if (!start) {
> +			start = &data[i];
> +		}

Why curly brackets around this one, but not this:

> +		if (data[i] == '\t')
> +			mid = &data[i];

> +		if (data[i] == '\n') {
> +			data[i] = 0;
> +			ref_name = mid + 1;
> +			ref = xmalloc(sizeof(struct ref) +
> +				      strlen(ref_name) + 1);

What is alloc_ref() for?

> +			memset(ref, 0, sizeof(struct ref));
> +			strcpy(ref->name, ref_name);
> +			get_sha1_hex(start, ref->old_sha1);
> +			if (!refs)
> +				refs = ref;
> +			if (last_ref)
> +				last_ref->next = ref;
> +			last_ref = ref;

Is this another "tail"?

> +			start = NULL;
> +		}
> +		i++;

Oh, so it _is_ a for() loop.

> +	}
> +	strbuf_release(&buffer);
> +
> +	ref = alloc_ref("HEAD");
> +	if (!walker->fetch_ref(walker, ref) &&
> +	    !resolve_remote_symref(ref, refs)) {
> +		ref->next = refs;
> +		refs = ref;
> +	} else {
> +		free(ref);
> +	}
> +
> +	return refs;
> +}
> +
> +int main(int argc, const char **argv)
> +{
> +	struct remote *remote;
> +	struct strbuf buf = STRBUF_INIT;
> +	const char *url;
> +	struct walker *walker = NULL;
> +
> +	setup_git_directory();
> +	if (argc < 2) {
> +		fprintf(stderr, "Remote needed\n");
> +		return 1;
> +	}
> +
> +	remote = remote_get(argv[1]);
> +
> +	if (argc > 2) {
> +		url = argv[2];
> +	} else {
> +		url = remote->url[0];
> +	}
> +
> +	do {
> +		if (strbuf_getline(&buf, stdin, '\n') == EOF)
> +			break;
> +		if (!prefixcmp(buf.buf, "fetch ")) {
> +			char *obj = buf.buf + strlen("fetch ");
> +			if (!walker)
> +				walker = get_http_walker(url, remote);
> +			walker->get_all = 1;
> +			walker->get_tree = 1;
> +			walker->get_history = 1;
> +			walker->get_verbosely = 0;
> +			walker->get_recover = 0;
> +			if (walker_fetch(walker, 1, &obj, NULL, NULL))
> +				die("Fetch failed.");
> +			printf("\n");
> +			fflush(stdout);
> +		} else if (!strcmp(buf.buf, "list")) {
> +			struct ref *refs;
> +			struct ref *posn;
> +			if (!walker)
> +				walker = get_http_walker(url, remote);
> +			refs = get_refs(walker, url);
> +			for (posn = refs; posn; posn = posn->next) {
> +				if (posn->symref)
> +					printf("@%s %s\n", posn->symref, posn->name);
> +				else
> +					printf("%s %s\n", sha1_to_hex(posn->old_sha1), posn->name);
> +			}
> +			printf("\n");
> +			fflush(stdout);
> +		} else {
> +			return 1;
> +		}
> +		strbuf_reset(&buf);
> +	} while (1);
> +	return 0;
> +}

If you already start some infrastructure like this, you should go the 
whole nine yards and make helper functions in remote.c or transport.c that 
help implementing "git-remote-<protocol>" helpers.

> diff --git a/transport.c b/transport.c
> index de0d587..6d13b0e 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -950,14 +818,12 @@ struct transport *transport_get(struct remote *remote, const char *url)
>  	} else if (!prefixcmp(url, "http://")
>  	        || !prefixcmp(url, "https://")
>  	        || !prefixcmp(url, "ftp://")) {
> +		transport_shim_init(ret, "curl");

Like I said, identifying the remote helper by anything else than the 
protocol is a design catastrophe.

>  #ifdef NO_CURL
>  		error("git was compiled without libcurl support.");

Why the heck does this have to be guarded by an #ifdef NO_CURL?  It is the 
helper's task to say, not transport.c's.

>  #else
> -		ret->get_refs_list = get_refs_via_curl;
> -		ret->fetch = fetch_objs_via_curl;
>  		ret->push = curl_transport_push;
>  #endif
> -		ret->disconnect = disconnect_walker;
>  
>  	} else if (is_local(url) && is_file(url)) {
>  		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));

I think the basic idea of yours is sound, but all I see is some incomplete 
separation between builtin git-fetch/-push and the helper.  As it stands, 
git-fetch/-push have to be compiled with the exact knowledge what helper 
is there, git-fetch/-push are _still_ aware if Git was compiled with http 
support (so that it is not possible to just install the helper 
afterwards), and the infrastructure forbids any extension of capabilities 
in the future.

I think these issues are serious enough to merit a rework.

Thanks,
Dscho
