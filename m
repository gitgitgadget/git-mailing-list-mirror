From: Jeff King <peff@peff.net>
Subject: Re: [RFC 4/4] Add cat-blob report pipe from fast-import to
 remote-helper.
Date: Tue, 5 Jun 2012 02:56:28 -0400
Message-ID: <20120605065628.GA25809@sigill.intra.peff.net>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1338830455-3091-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1338830455-3091-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1338830455-3091-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1338830455-3091-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 08:56:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbnhA-0001BR-2N
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 08:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324Ab2FEG4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 02:56:32 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:43068
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134Ab2FEG4a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 02:56:30 -0400
Received: (qmail 14229 invoked by uid 107); 5 Jun 2012 06:56:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Jun 2012 02:56:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jun 2012 02:56:28 -0400
Content-Disposition: inline
In-Reply-To: <1338830455-3091-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199205>

On Mon, Jun 04, 2012 at 07:20:55PM +0200, Florian Achleitner wrote:

> On invocation of a helper a new pipe is opened.
> To close the other end after fork, the prexec_cb feature
> of the run_command api is used.
> If the helper is not used with fast-import later the pipe
> is unused.
> The FD is passed to the remote-helper via it's environment,
> helpers that don't use fast-import can simply ignore it.
> fast-import has an argv for that.

I don't keep up on fast-import development, so I have no clue how useful
this extra pipe is, or whether this patch is a good idea overall. But a
few comments on the transport.c half of things:

> +static int fd_to_close;
> +void close_fd_prexec_cb(void)
> +{
> +	if(debug)
> +		fprintf(stderr, "close_fd_prexec_cb closing %d\n", fd_to_close);
> +	close(fd_to_close);
> +}

Note that preexec_cb does not work at all on Windows, as it assumes a
forking model (rather than a spawn, which leaves no room to execute
arbitrary code in the child). If all you want to do is open an extra
pipe, then probably run-command should be extended to handle this
(though I have no idea how complex that would be for the Windows side of
things, it is at least _possible_, as opposed to preexec_cb, which will
never be possible).

> @@ -376,13 +411,20 @@ static int fetch_with_fetch(struct transport *transport,
>  static int get_importer(struct transport *transport, struct child_process *fastimport)
>  {
>  	struct child_process *helper = get_helper(transport);
> +	struct helper_data *data = transport->data;
> +	struct strbuf buf = STRBUF_INIT;
>  	memset(fastimport, 0, sizeof(*fastimport));
>  	fastimport->in = helper->out;
>  	fastimport->argv = xcalloc(5, sizeof(*fastimport->argv));
>  	fastimport->argv[0] = "fast-import";
>  	fastimport->argv[1] = "--quiet";
> +	strbuf_addf(&buf, "--cat-blob-fd=%d", data->fast_import_backchannel_pipe[1]);
> +	fastimport->argv[2] = strbuf_detach(&buf, NULL);

Consider converting this to use argv_array. You can drop the magic
numbers, and "argv_array_pushf" handles the strbuf bits for you
automatically.

And this grossness can go away:

> @@ -441,6 +488,7 @@ static int fetch_with_import(struct transport *transport,
>  
>  	if (finish_command(&fastimport))
>  		die("Error while running fast-import");
> +	free((void*)fastimport.argv[2]);
>  	free(fastimport.argv);
>  	fastimport.argv = NULL;

(you'd instead want to free everything; it would probably make sense to
add an argv_array_free_detached() function to do so).

> @@ -427,6 +469,11 @@ static int fetch_with_import(struct transport *transport,
>  	if (get_importer(transport, &fastimport))
>  		die("Couldn't run fast-import");
>  
> +
> +	/* in the parent process we close both pipe ends. */
> +	close(data->fast_import_backchannel_pipe[0]);
> +	close(data->fast_import_backchannel_pipe[1]);

I'm confused. We close both ends? Who is actually reading and writing to
this pipe, then?

-Peff
