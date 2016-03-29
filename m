From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix http-backend reading till EOF, ignoring
 CONTENT_LENGTH, violating rfc3875 -- WAS: Problem with git-http-backend.exe
 as iis cgi
Date: Tue, 29 Mar 2016 16:13:49 -0400
Message-ID: <20160329201349.GB9527@sigill.intra.peff.net>
References: <F0F5A56A22F20D4CB4A03BB8D6658797E261A3D6@SERVER2011.CS-SOFTWARE.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris Packham <judge.packham@gmail.com>,
	Konstantin Khomoutov <kostix+git@007spb.ru>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Florian Manschwetus <manschwetus@cs-software-gmbh.de>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:20:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al01g-0007mC-82
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 22:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758184AbcC2UN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 16:13:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:40144 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758178AbcC2UNw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 16:13:52 -0400
Received: (qmail 6841 invoked by uid 102); 29 Mar 2016 20:13:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 16:13:52 -0400
Received: (qmail 26080 invoked by uid 107); 29 Mar 2016 20:13:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 16:13:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2016 16:13:49 -0400
Content-Disposition: inline
In-Reply-To: <F0F5A56A22F20D4CB4A03BB8D6658797E261A3D6@SERVER2011.CS-SOFTWARE.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290183>

On Tue, Mar 29, 2016 at 10:38:23AM +0000, Florian Manschwetus wrote:

> > | A request-body is supplied with the request if the CONTENT_LENGTH is 
> > | not NULL.  The server MUST make at least that many bytes available 
> > | for the script to read.  The server MAY signal an end-of-file 
> > | condition after CONTENT_LENGTH bytes have been read or it MAY supply 
> > | extension data.  Therefore, the script MUST NOT attempt to read more 
> > | than CONTENT_LENGTH bytes, even if more data is available.  However, 
> > | it is not obliged to read any of the data.
> >
> > So yes, if Git currently reads until EOF, it's an error.
> > The correct way would be:
> >
> > 1) Check to see if the CONTENT_LENGTH variable is available in the
> >    environment.  If no, read nothing.
> >
> > 2) Otherwise read as many bytes it specifies, and no more.
> >
> > 1. https://www.ietf.org/rfc/rfc3875

I don't think the second part of (1) will work very well if the client
sends a chunked transfer-encoding (which git will do if the input is large). In
such a case the server would either have to buffer the entire input to
find its length, or stream the data to the CGI without setting
$CONTENT_LENGTH. At least some servers choose the latter (including
Apache).

> diff --git a/http-backend.c b/http-backend.c
> index 8870a26..94976df 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -277,16 +277,32 @@ static struct rpc_service *select_service(const char *name)
>   */
>  static ssize_t read_request(int fd, unsigned char **out)
>  {
> -	size_t len = 0, alloc = 8192;
> -	unsigned char *buf = xmalloc(alloc);
> +	unsigned char *buf = null;
> +	size_t len = 0;
> +	/* get request size */
> +	size_t req_len = git_env_ulong("CONTENT_LENGTH",
> +					   0);
> +
> +	/* check request size */
> +	if (max_request_buffer < req_len) {
> +		die("request was larger than our maximum size (%lu);"
> +			    " try setting GIT_HTTP_MAX_REQUEST_BUFFER",
> +			    max_request_buffer);
> +	}
> +
> +	if (req_len <= 0) {
> +		*out = null;
> +		return 0;
> +	}

git-am complained that your patch did not apply, but after writing
something similar locally, I found that t5551.25 hangs indefinitely.
Which is not surprising. Most tests are doing very limited ref
negotiation, so the content that hits read_request() here is small, and
we send it in a single write with a content-length header. But t5551.25
uses a much bigger workload, which causes the client to use a chunked
transfer-encoding, and this code to refuse to read anything (and then
the protocol stalls, as we are waiting for the client to say something).

So I think you'd want to take a missing CONTENT_LENGTH as a hint to read
until EOF.

That also raises another issue: what happens in the paths that don't hit
read_request()? We may also process input via:

  - inflate_request(), if the client gzipped it; for well-formed input,
    I think we'll stop reading when the gzip stream tells us there is no
    more data, but a malformed one would have us reading until EOF,
    regardless of what $CONTENT_LENGTH says.

  - for input which we expect to be large (like incoming packfiles for a
    push), buffer_input will be unset, and we will pass the descriptor
    directly to a sub-program like git-index-pack. Again, for
    well-formed input it would read just the packfile, but it may
    actually continue to EOF.

So I don't think your patch is covering all cases.

-Peff
