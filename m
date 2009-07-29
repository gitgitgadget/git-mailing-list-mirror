From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3 v2] Use an external program to implement fetching
 with curl
Date: Thu, 30 Jul 2009 00:16:44 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907300002450.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0907280207350.2147@iabervon.org> <alpine.DEB.1.00.0907281505290.8306@pacific.mpi-cbg.de> <alpine.LNX.2.00.0907281339260.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Jul 30 00:16:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWHRz-0000PG-Qt
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 00:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513AbZG2WQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 18:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753063AbZG2WQe
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 18:16:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:51374 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752555AbZG2WQd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 18:16:33 -0400
Received: (qmail invoked by alias); 29 Jul 2009 22:16:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp062) with SMTP; 30 Jul 2009 00:16:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+KJllSHyeK3gB3wcpyJkDHLrVh9EgzPgRPUjgaGb
	OQj4WXkuf+BWLP
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.2.00.0907281339260.2147@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124397>

Hi,

On Tue, 28 Jul 2009, Daniel Barkalow wrote:

> On Tue, 28 Jul 2009, Johannes Schindelin wrote:
> 
> > On Tue, 28 Jul 2009, Daniel Barkalow wrote:
> > 
> > > diff --git a/shim-curl.c b/shim-curl.c
> > > new file mode 100644
> > > index 0000000..bde041b
> > > --- /dev/null
> > > +++ b/shim-curl.c
> > > @@ -0,0 +1,132 @@
> > > +#include "cache.h"
> > > +#include "remote.h"
> > > +#include "strbuf.h"
> > > +#include "walker.h"
> > > +#include "http.h"
> > > +
> > > +static struct ref *get_refs(struct walker *walker, const char *url)
> > > +{
> > > +	int http_ret;
> > > +	char *refs_url;
> > > +	struct strbuf buffer = STRBUF_INIT;
> > > +	char *data, *start, *mid;
> > > +	int i = 0;
> > > +	char *ref_name;
> > > +	struct ref *refs = NULL;
> > > +	struct ref *ref = NULL;
> > > +	struct ref *last_ref = NULL;
> > > +
> > > +	refs_url = xmalloc(strlen(url) + 11);
> > > +	sprintf(refs_url, "%s/info/refs", url);
> > 
> > And I thought we had strbufs...
> 
> This whole chunk of code is a direct move from transport.c, which is 
> unfortunately not obvious in the way we represent diffs. I'd prefer to 
> keep the code the same across the move so that we'd be able to track it 
> if "git blame" got especially smart.

... and make review of the current patch -- which is possible right now, 
without the need of a super clever git blame -- hard?  Do you really think 
this is a wise decision?

> > > [a couple of unaddressed comments]
> > >
> > > +int main(int argc, const char **argv)
> > > +{
> > > +	struct remote *remote;
> > > +	struct strbuf buf = STRBUF_INIT;
> > > +	const char *url;
> > > +	struct walker *walker = NULL;
> > > +
> > > +	setup_git_directory();
> > > +	if (argc < 2) {
> > > +		fprintf(stderr, "Remote needed\n");
> > > +		return 1;
> > > +	}
> > > +
> > > +	remote = remote_get(argv[1]);
> > > +
> > > +	if (argc > 2) {
> > > +		url = argv[2];
> > > +	} else {
> > > +		url = remote->url[0];
> > > +	}
> > > +
> > > +	do {
> > > +		if (strbuf_getline(&buf, stdin, '\n') == EOF)
> > > +			break;
> > > +		if (!prefixcmp(buf.buf, "fetch ")) {
> > > +			char *obj = buf.buf + strlen("fetch ");
> > > +			if (!walker)
> > > +				walker = get_http_walker(url, remote);
> > > +			walker->get_all = 1;
> > > +			walker->get_tree = 1;
> > > +			walker->get_history = 1;
> > > +			walker->get_verbosely = 0;
> > > +			walker->get_recover = 0;
> > > +			if (walker_fetch(walker, 1, &obj, NULL, NULL))
> > > +				die("Fetch failed.");
> > > +			printf("\n");
> > > +			fflush(stdout);
> > > +		} else if (!strcmp(buf.buf, "list")) {
> > > +			struct ref *refs;
> > > +			struct ref *posn;
> > > +			if (!walker)
> > > +				walker = get_http_walker(url, remote);
> > > +			refs = get_refs(walker, url);
> > > +			for (posn = refs; posn; posn = posn->next) {
> > > +				if (posn->symref)
> > > +					printf("@%s %s\n", posn->symref, posn->name);
> > > +				else
> > > +					printf("%s %s\n", sha1_to_hex(posn->old_sha1), posn->name);
> > > +			}
> > > +			printf("\n");
> > > +			fflush(stdout);
> > > +		} else {
> > > +			return 1;
> > > +		}
> > > +		strbuf_reset(&buf);
> > > +	} while (1);
> > > +	return 0;
> > > +}
> > 
> > If you already start some infrastructure like this, you should go the 
> > whole nine yards and make helper functions in remote.c or transport.c that 
> > help implementing "git-remote-<protocol>" helpers.
> 
> I thought of that, but I couldn't think of any helper functions that 
> wouldn't be harder to use than to not use. In any case, they should be in 
> a separate file, since they'd only be used by a set of separate programs.

So every helper should implement the same parsing of the whole protocol?

I mean, the protocol _lends_ itself to an interface that implements 
handlers for the commands sent over the pipe, but with compile time errors 
when, say, a parameter type mistake happened.

> > > diff --git a/transport.c b/transport.c
> > > index de0d587..6d13b0e 100644
> > > --- a/transport.c
> > > +++ b/transport.c
> > > @@ -950,14 +818,12 @@ struct transport *transport_get(struct remote *remote, const char *url)
> > >  	} else if (!prefixcmp(url, "http://")
> > >  	        || !prefixcmp(url, "https://")
> > >  	        || !prefixcmp(url, "ftp://")) {
> > > +		transport_shim_init(ret, "curl");
> > 
> > Like I said, identifying the remote helper by anything else than the 
> > protocol is a design catastrophe.
> 
> But this helper supports all of the protocols supported by curl, and may 
> eventually not be the only available helper that supports some of these 
> protocols.

Yes, and in the near future my computer may understand what I say, and 
guess my thoughts.

Let's stay with the presence, okay?

It is _all_ too easy to hardlink git-remote-http to git-remote-https.

And if you have two different handlers for the same protocol, how should 
_Git_ decide which one to take?

No, I firmly believe that this design decision is too short-sighted.

> I think it's better to represent this fact by having transport.c 
> explicitly know when to use this helper, rather than linking the same 
> executable to git-remote-https, git-remote-http, git-remote-ftp, etc.

You really want to recompile Git whenever somebody writes a new protocol 
helper?  That's wrong.

> > >  #ifdef NO_CURL
> > >  		error("git was compiled without libcurl support.");
> > 
> > Why the heck does this have to be guarded by an #ifdef NO_CURL?  It is the 
> > helper's task to say, not transport.c's.
> 
> What helper? There is no helper at all if NO_CURL,

Again, you want to _require_ that the helpers and Git are compiled 
together.  I stand firmly against this idea.

> and:
> 
>   git: 'remote-curl' is not a git-command. See 'git --help'.
> 
> is not a user-friendly message.

Oh?  You would want to show the user that message?  I wouldn't.  I would 
want to show the user:

	No helper found to handle protocol 'https' (i.e. no 
	git-remote-http was found in the PATH)

> > >  #else
> > > -		ret->get_refs_list = get_refs_via_curl;
> > > -		ret->fetch = fetch_objs_via_curl;
> > >  		ret->push = curl_transport_push;
> > >  #endif
> > > -		ret->disconnect = disconnect_walker;
> > >  
> > >  	} else if (is_local(url) && is_file(url)) {
> > >  		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
> > 
> > I think the basic idea of yours is sound, but all I see is some incomplete 
> > separation between builtin git-fetch/-push and the helper.  As it stands, 
> > git-fetch/-push have to be compiled with the exact knowledge what helper 
> > is there, git-fetch/-push are _still_ aware if Git was compiled with http 
> > support (so that it is not possible to just install the helper 
> > afterwards), and the infrastructure forbids any extension of capabilities 
> > in the future.
> 
> In the long run, I want to have two methods for running an external 
> helper: one where the installation in some way knows when to run the 
> helper (either by having code in place or by having helpers with 
> particular names or something), and one where the user specifies something 
> explicit.

I am not sure I like that.

> That is, git shouldn't know that a remote with no url but some 
> "codeline" settings that start with "//" is p4,

What speaks against a URL "p4://..."?  That would be _totally_ intuitive 
and easy to handle.

> and the user shouldn't have to know that git repositories whose urls 
> start with http:// are done with an external helper, so no one mechanism 
> is sufficient.

Why on earth should the user need to know that http:// is handled by an 
external helper?

Of course, if the user wants to support, say, VSS, it is now easy (well, 
the Git part) to provide a simple git-remote-vss helper _and not having to 
recompile Git at all_.

> It would be nice if git supported querying its environment to see whether 
> a command is available and printing a message suitted to why it was 
> looking for it, but that's a separate topic.

We do have such a framework in place already.  You even mentioned it.  Our 
git-help can look in the PATH what is available.

But then, we do not have to do that at all.

We just try to handle the protocol internally.  If that is not possible, 
we extract the protocol from the URL and try to call a program called 
git-remote-<protocol>.  We inquire via the capabilities command if that 
helper can fetch/push and continue accordingly.  If the program could not 
be launched, with exit status 127, we know there was no helper and can 
tell the user that.

We do not need to do any discovery of the environment at all.  
start_command() is all we ever need.

Simple is beautiful,
Dscho
