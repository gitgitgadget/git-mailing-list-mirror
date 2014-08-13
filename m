From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] git-imap-send: use libcurl for implementation
Date: Tue, 12 Aug 2014 18:59:17 -0700
Message-ID: <20140813015917.GA30756@google.com>
References: <53EA8C3E.1080500@raz.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, 434599@bugs.debian.org
To: Bernhard Reiter <ockham@raz.or.at>
X-From: git-owner@vger.kernel.org Wed Aug 13 03:59:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHNqc-0004XW-88
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 03:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099AbaHMB7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 21:59:25 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:61832 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867AbaHMB7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 21:59:24 -0400
Received: by mail-pd0-f172.google.com with SMTP id y13so7677773pdi.31
        for <git@vger.kernel.org>; Tue, 12 Aug 2014 18:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=YygQqvFO4kns7O0Ho7wP5C1BTZnBgIq6q525Zmc3cXc=;
        b=b7Mx9wTDao1lJ1uJVfEx76Ecfcay/TwoqoL9JLOBeXhTaigQ3lcVRvPFyvGmiI2dNe
         XaDG7H+Bje/tOsfb0ACUG75QXf9Zpu49zMTERrDnk/Bklk5TnXrtO3/+Asi1gTRR+EKs
         +eaA0jNyb37NCrXQInpkcTsOYbIJq8wBWaBd9L1GFapT5+GOr70iugD0IgGoAroUj3+j
         GOiLSOMVli/CwF0TyHXDyQTTLUwHZ7WmGrMJmBI5NCLfzyVRp6HAw9Ok6tSAv+IfjY3v
         EKBaeKi6H/KcKZRGmrM3t2ngLiIU3XCAcNh+pAGifaH8IYk7rqojlrRJbgNe+ar/2VTs
         G64Q==
X-Received: by 10.70.41.136 with SMTP id f8mr1344802pdl.46.1407895163689;
        Tue, 12 Aug 2014 18:59:23 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b597:b557:1d91:6675])
        by mx.google.com with ESMTPSA id w7sm557938pds.23.2014.08.12.18.59.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 Aug 2014 18:59:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53EA8C3E.1080500@raz.or.at>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255183>

Bernhard Reiter wrote:

> Use libcurl's high-level API functions to implement git-imap-send
> instead of the previous low-level OpenSSL-based functions.

Wow!  This sounds lovely.  Thanks for working on this.

[...]
> Since version 7.30.0, libcurl's API has been able to communicate with
> IMAP servers. Using those high-level functions instead of the current
> ones reduces imap-send.c by some 1200 lines of code.
>
> As I don't have access to that many IMAP servers, I haven't been able to
> test a variety of parameter combinations. I did test both secure and
> insecure (imaps:// and imap://) connections -- this e-mail was generated
> that way -- but could e.g. neither test the authMethod nor the tunnel
> parameter.

The above two paragraphs belong in the commit message, too, since
they'll be just as useful for someone looking back through the history
as for someone reading the patch on-list today.

[...]
> --- a/INSTALL
> +++ b/INSTALL
[...]
> -	- "libcurl" library is used by git-http-fetch and git-fetch.  You
> +	- "libcurl" library is used by git-http-fetch, git-fetch, and
> +	  git-impap-send.  You might also want the "curl" executable for

Typo: s/impap-send/imap-send/

> --- a/Makefile
> +++ b/Makefile
> @@ -2067,9 +2067,9 @@ endif
>  git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
>  
> -git-imap-send$X: imap-send.o GIT-LDFLAGS $(GITLIBS)
> +git-imap-send$X: imap-send.o http.o GIT-LDFLAGS $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> -		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
> +		$(LIBS) $(CURL_LIBCURL)

7.30.0 is only ~1 year old.  Does this mean users would need to update
curl in order to build imap-send?

For example, Debian 7.6 ships curl 7.26.0 and CentOS 7 has curl 7.29.0.

Ideally this could be done as an optional feature:

 1. Introduce a USE_CURL_FOR_IMAP_SEND makefile variable to take
    advantage of the nice new API.

 2. (optional) Use the curl_check makefile variable to turn on
    USE_CURL_FOR_IMAP_SEND automatically when appropriate.

 3. In a few years, when everyone has upgraded, we could simplify by
    getting rid of the USE_OPENSSL_FOR_IMAP_SEND code path.

What do you think?

[...]
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -22,47 +22,13 @@
>   *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>   */
>  
> -#include "cache.h"

Usual style is to start with a #include of "cache.h" or
"git-compat-util.h".  "http.h" including cache.h for itself was an
old mistake.  (I'll reply with a patch to fix that.)

[...]
> +#include <curl/curl.h>

http.h already #includes this.  Do you use other helpers from
http.h/http.c or do you use libcurl directly?  (Just curious.)

Some style nits:

[...]
> +static curl_socket_t opensocket(void *clientp, curlsocktype purpose,
> +								struct curl_sockaddr *address)

Long line.  Do you have ts=4?  (Git uses 8-space tabs.  There's some
emacs magic in Documentation/CodingGuidelines.  It should be possible
to add similar hints there for other editors if they don't do the
right thing by default.)

> +{
> +	curl_socket_t sockfd;
> +	(void)purpose;
> +	(void)address;

Elsewhere git lets unused parameters be.  The unused parameter warning
is too noisy in callback-heavy code (e.g., for_each_ref) so we don't
turn it on.

> +	sockfd = *(curl_socket_t *)clientp;
> +	/* the actual externally set socket is passed in via the OPENSOCKETDATA
> +	   option */

(style nit) Comments in git look like this:

	/*
	 * The actual, externally set socket is passed in via the
	 * OPENSOCKETDATA option.
	 */
	return sockfd;

[...]
> +static int sockopt_callback(void *clientp, curl_socket_t curlfd,
> +							curlsocktype purpose)
> +{
> +	/* This return code was added in libcurl 7.21.5 */
> +	return CURL_SOCKOPT_ALREADY_CONNECTED;

I'd drop the comment, unless there's some subtlety involved.  (E.g.,
is there some other return code that would be more appropriate but was
introudced later or something?)

[...]
> @@ -1368,12 +218,14 @@ static int git_imap_config(const char *key, const char *val, void *cb)
>  int main(int argc, char **argv)
>  {
>  	struct strbuf all_msgs = STRBUF_INIT;
> -	struct strbuf msg = STRBUF_INIT;
> +	struct buffer msg = { STRBUF_INIT, 0 };

Ah, ok --- we do use http.c stuff.

[...]
> +	char path[8192];
> +	int pathlen;

I realize the old code only had 8192 for the IMAP command buffer,
but could this be a strbuf now, or is there some underlying limit
somewhere else?

[...]
> @@ -1417,31 +269,89 @@ int main(int argc, char **argv)
>  		return 1;
>  	}
>  
> +	curl_global_init(CURL_GLOBAL_ALL);

http.c seems to make the same mistake, but should the return value
from this be checked?

> -	/* write it to the imap server */
> -	ctx = imap_open_store(&server);
> -	if (!ctx) {
> -		fprintf(stderr, "failed to open store\n");
> +	curl = curl_easy_init();
> +
> +	if (!curl) {
> +		fprintf(stderr, "failed to init curl\n");
>  		return 1;

Could do

		die("failed to init curl");

for more consistent message format and exit codes (128 for internal
errors, with an error message starting with 'fatal: ').

[...]
> +	if (ends_with(server.host, "/"))
> +		pathlen = snprintf (path, sizeof(path), "%s%s", server.host, imap_folder);
> +	else
> +		pathlen = snprintf (path, sizeof(path), "%s/%s", server.host, imap_folder);
> +
> +	if (pathlen < 0)
> +		die("Fatal: Out of memory");
> +	if (pathlen >= sizeof(path))
> +		die("imap URL overflow!");

With a strbuf, this could be something like

	strbuf_addstr(&path, server.host);
	if (!path.len || path.buf[path.len - 1] != '/')
		strbuf_addch(&path, '/');
	strbuf_addstr(&path, imap_folder);

or

	if (ends_with(...))
		strbuf_addf(&path, "%s%s", ...);
	else
		strbuf_addf(...);

Killing the unused ctx->prefix handling is nice. :)

[...]
> +	if (server.tunnel) {
> +		const char *argv[] = { server.tunnel, NULL };
> +		struct child_process tunnel = {NULL};

(not about this patch) Could use the child_proccess's internal
argv_array:

		struct child_process tunnel = {NULL};
		argv_array_push(&tunnel.args, server.tunnel);

(about this patch) Would there be a way to make this part reuse the
existing code?  The only difference I see is that *srvc has been
renamed to server, which doesn't seem to be related to the change of
transport API from OpenSSL to libcurl.

[...]
> +		curl_socket_t sockfd = tunnel.out; // what about tunnel.in ?

Hmm.  curl expects to get a socket it can send(), recv(), setsockopt(),
etc on instead of a pair of fds to read() and write().

I wonder why someone would want to use SSL through a tunnel, though.
Currently it's impossible to get to the SSL codepath when a tunnel
is active (it's in the 'else' block an 'if (srvc->tunnel)').  If that
property is preserved, then we should be safe.

To summarize:

 * I like this idea a lot!  Using libcurl's imaps:// support directly
   means one less dependency to worry about, and using alternate SSL
   libraries like gnutls or nss becomes much easier (e.g., see
   http://fedoraproject.org/wiki/FedoraCryptoConsolidation for how
   that makes configuring certificate trust simpler).

 * This would be easier to take if guarded by an #ifdef, so people
   stuck on ancient libcurl would still be able to use git (and
   ideally still use imap over SSL).

 * This shouldn't have to touch the imap.tunnel support.  imap-send's
   imap.tunnel configuration expects the tunnel to take care of
   securing the channel (e.g. by using 'openssl s_client').

 * Any potential cleanups noticed along the way are very welcome,
   as separate patches.

 * As soon as you're ready to roll this out to a wider audience of
   testers, let me know, and we can try to get it into shape for
   Junio's "next" branch (and hence Debian experimental).

Thanks and hope that helps,
Jonathan
