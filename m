From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/3 v2] Use an external program to implement fetching
 with curl
Date: Tue, 28 Jul 2009 13:59:44 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0907281339260.2147@iabervon.org>
References: <alpine.LNX.2.00.0907280207350.2147@iabervon.org> <alpine.DEB.1.00.0907281505290.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 28 20:00:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVqy0-00084N-HU
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 20:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196AbZG1R7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 13:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755194AbZG1R7v
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 13:59:51 -0400
Received: from iabervon.org ([66.92.72.58]:45545 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755038AbZG1R7u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 13:59:50 -0400
Received: (qmail 3560 invoked by uid 1000); 28 Jul 2009 17:59:44 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Jul 2009 17:59:44 -0000
In-Reply-To: <alpine.DEB.1.00.0907281505290.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124265>



On Tue, 28 Jul 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 28 Jul 2009, Daniel Barkalow wrote:
> 
> > diff --git a/Makefile b/Makefile
> > index 01efc73..d3dd2ed 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -980,6 +980,7 @@ else
> >  		CURL_LIBCURL = -lcurl
> >  	endif
> >  	BUILTIN_OBJS += builtin-http-fetch.o
> > +	PROGRAMS += git-shim-curl$X
> 
> So now you not only use that disgustingly meaningless name "shim", but 
> also abolish the notion that the helper is called by its protocol name?
> 
> > diff --git a/shim-curl.c b/shim-curl.c
> > new file mode 100644
> > index 0000000..bde041b
> > --- /dev/null
> > +++ b/shim-curl.c
> > @@ -0,0 +1,132 @@
> > +#include "cache.h"
> > +#include "remote.h"
> > +#include "strbuf.h"
> > +#include "walker.h"
> > +#include "http.h"
> > +
> > +static struct ref *get_refs(struct walker *walker, const char *url)
> > +{
> > +	int http_ret;
> > +	char *refs_url;
> > +	struct strbuf buffer = STRBUF_INIT;
> > +	char *data, *start, *mid;
> > +	int i = 0;
> > +	char *ref_name;
> > +	struct ref *refs = NULL;
> > +	struct ref *ref = NULL;
> > +	struct ref *last_ref = NULL;
> > +
> > +	refs_url = xmalloc(strlen(url) + 11);
> > +	sprintf(refs_url, "%s/info/refs", url);
> 
> And I thought we had strbufs...

This whole chunk of code is a direct move from transport.c, which is 
unfortunately not obvious in the way we represent diffs. I'd prefer to 
keep the code the same across the move so that we'd be able to track it if 
"git blame" got especially smart.

> > +
> > +	http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
> > +	switch (http_ret) {
> > +	case HTTP_OK:
> > +		break;
> > +	case HTTP_MISSING_TARGET:
> > +		die("%s not found: did you run git update-server-info on the"
> > +		    " server?", refs_url);
> > +	default:
> > +		http_error(refs_url, http_ret);
> > +		die("HTTP request failed");
> > +	}
> > +	free(refs_url);
> > +
> > +	data = buffer.buf;
> > +	start = NULL;
> > +	mid = data;
> 
> What does "mid" stand for?
> 
> > +	while (i < buffer.len) {
> > +		if (!start) {
> > +			start = &data[i];
> > +		}
> 
> Why curly brackets around this one, but not this:
> 
> > +		if (data[i] == '\t')
> > +			mid = &data[i];
> 
> > +		if (data[i] == '\n') {
> > +			data[i] = 0;
> > +			ref_name = mid + 1;
> > +			ref = xmalloc(sizeof(struct ref) +
> > +				      strlen(ref_name) + 1);
> 
> What is alloc_ref() for?
> 
> > +			memset(ref, 0, sizeof(struct ref));
> > +			strcpy(ref->name, ref_name);
> > +			get_sha1_hex(start, ref->old_sha1);
> > +			if (!refs)
> > +				refs = ref;
> > +			if (last_ref)
> > +				last_ref->next = ref;
> > +			last_ref = ref;
> 
> Is this another "tail"?
> 
> > +			start = NULL;
> > +		}
> > +		i++;
> 
> Oh, so it _is_ a for() loop.
> 
> > +	}
> > +	strbuf_release(&buffer);
> > +
> > +	ref = alloc_ref("HEAD");
> > +	if (!walker->fetch_ref(walker, ref) &&
> > +	    !resolve_remote_symref(ref, refs)) {
> > +		ref->next = refs;
> > +		refs = ref;
> > +	} else {
> > +		free(ref);
> > +	}
> > +
> > +	return refs;
> > +}
> > +
> > +int main(int argc, const char **argv)
> > +{
> > +	struct remote *remote;
> > +	struct strbuf buf = STRBUF_INIT;
> > +	const char *url;
> > +	struct walker *walker = NULL;
> > +
> > +	setup_git_directory();
> > +	if (argc < 2) {
> > +		fprintf(stderr, "Remote needed\n");
> > +		return 1;
> > +	}
> > +
> > +	remote = remote_get(argv[1]);
> > +
> > +	if (argc > 2) {
> > +		url = argv[2];
> > +	} else {
> > +		url = remote->url[0];
> > +	}
> > +
> > +	do {
> > +		if (strbuf_getline(&buf, stdin, '\n') == EOF)
> > +			break;
> > +		if (!prefixcmp(buf.buf, "fetch ")) {
> > +			char *obj = buf.buf + strlen("fetch ");
> > +			if (!walker)
> > +				walker = get_http_walker(url, remote);
> > +			walker->get_all = 1;
> > +			walker->get_tree = 1;
> > +			walker->get_history = 1;
> > +			walker->get_verbosely = 0;
> > +			walker->get_recover = 0;
> > +			if (walker_fetch(walker, 1, &obj, NULL, NULL))
> > +				die("Fetch failed.");
> > +			printf("\n");
> > +			fflush(stdout);
> > +		} else if (!strcmp(buf.buf, "list")) {
> > +			struct ref *refs;
> > +			struct ref *posn;
> > +			if (!walker)
> > +				walker = get_http_walker(url, remote);
> > +			refs = get_refs(walker, url);
> > +			for (posn = refs; posn; posn = posn->next) {
> > +				if (posn->symref)
> > +					printf("@%s %s\n", posn->symref, posn->name);
> > +				else
> > +					printf("%s %s\n", sha1_to_hex(posn->old_sha1), posn->name);
> > +			}
> > +			printf("\n");
> > +			fflush(stdout);
> > +		} else {
> > +			return 1;
> > +		}
> > +		strbuf_reset(&buf);
> > +	} while (1);
> > +	return 0;
> > +}
> 
> If you already start some infrastructure like this, you should go the 
> whole nine yards and make helper functions in remote.c or transport.c that 
> help implementing "git-remote-<protocol>" helpers.

I thought of that, but I couldn't think of any helper functions that 
wouldn't be harder to use than to not use. In any case, they should be in 
a separate file, since they'd only be used by a set of separate programs.

> > diff --git a/transport.c b/transport.c
> > index de0d587..6d13b0e 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -950,14 +818,12 @@ struct transport *transport_get(struct remote *remote, const char *url)
> >  	} else if (!prefixcmp(url, "http://")
> >  	        || !prefixcmp(url, "https://")
> >  	        || !prefixcmp(url, "ftp://")) {
> > +		transport_shim_init(ret, "curl");
> 
> Like I said, identifying the remote helper by anything else than the 
> protocol is a design catastrophe.

But this helper supports all of the protocols supported by curl, and may 
eventually not be the only available helper that supports some of these 
protocols. I think it's better to represent this fact by having 
transport.c explicitly know when to use this helper, rather than linking 
the same executable to git-remote-https, git-remote-http, git-remote-ftp, 
etc.

> >  #ifdef NO_CURL
> >  		error("git was compiled without libcurl support.");
> 
> Why the heck does this have to be guarded by an #ifdef NO_CURL?  It is the 
> helper's task to say, not transport.c's.

What helper? There is no helper at all if NO_CURL, and:

  git: 'remote-curl' is not a git-command. See 'git --help'.

is not a user-friendly message. For now, I'm keeping the existing 
behavior.

> >  #else
> > -		ret->get_refs_list = get_refs_via_curl;
> > -		ret->fetch = fetch_objs_via_curl;
> >  		ret->push = curl_transport_push;
> >  #endif
> > -		ret->disconnect = disconnect_walker;
> >  
> >  	} else if (is_local(url) && is_file(url)) {
> >  		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
> 
> I think the basic idea of yours is sound, but all I see is some incomplete 
> separation between builtin git-fetch/-push and the helper.  As it stands, 
> git-fetch/-push have to be compiled with the exact knowledge what helper 
> is there, git-fetch/-push are _still_ aware if Git was compiled with http 
> support (so that it is not possible to just install the helper 
> afterwards), and the infrastructure forbids any extension of capabilities 
> in the future.

In the long run, I want to have two methods for running an external 
helper: one where the installation in some way knows when to run the 
helper (either by having code in place or by having helpers with 
particular names or something), and one where the user specifies something 
explicit. That is, git shouldn't know that a remote with no url but some 
"codeline" settings that start with "//" is p4, and the user shouldn't 
have to know that git repositories whose urls start with http:// are done 
with an external helper, so no one mechanism is sufficient.

It would be nice if git supported querying its environment to see whether 
a command is available and printing a message suitted to why it was 
looking for it, but that's a separate topic.

	-Daniel
*This .sig left intentionally blank*
