From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] http-backend: spool ref negotiation requests to buffer
Date: Fri, 15 May 2015 11:22:42 -0700
Message-ID: <xmqqegmhhf9p.fsf@gitster.dls.corp.google.com>
References: <20150515062901.GA30768@peff.net>
	<20150515063339.GB30890@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 15 20:22:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtKG1-0004mV-TY
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 20:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754359AbbEOSWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 14:22:45 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36673 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754290AbbEOSWo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 14:22:44 -0400
Received: by igbpi8 with SMTP id pi8so232059266igb.1
        for <git@vger.kernel.org>; Fri, 15 May 2015 11:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=F2x3TD9LTAqo0SN9G83ZS7k/Q1N6I/8hDnvIQZbqmJQ=;
        b=Mvdz/aUiZ8hZFzKf7TGU6EIrT4gY2shU/jirLAiSgOPhn+kvJxzDYlHjLktdhflZr3
         D41IU+C2eSx7gdXCR56i8ftyH9mqcfjHqQpzokzgwaQA4ZY12bp6WudikuIaEElBnuhv
         RZrGzQixH9xBLgDcwv7ZoMWfuS/8EqQUJ3tkiypp3eOxavcYCMEwZe9Ny1YEPus1NLx5
         +AHKHmfSJg9EptAj5aR1DkyUV4gBvcfYIHKZ7Yyts9+AJl/OnQuzB0kW+r0WAHhJXJ8k
         h+aUvYMDBU8Hsg47mXQiSmLblUXRsPfH5GL+beAtTy8YHFLdg9dSqWI3+guNHpUSk59o
         Gy2g==
X-Received: by 10.43.60.76 with SMTP id wr12mr22703261icb.83.1431714164329;
        Fri, 15 May 2015 11:22:44 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1148:d596:44de:a92d])
        by mx.google.com with ESMTPSA id d186sm66172ioe.42.2015.05.15.11.22.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 15 May 2015 11:22:43 -0700 (PDT)
In-Reply-To: <20150515063339.GB30890@peff.net> (Jeff King's message of "Fri,
	15 May 2015 02:33:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269164>

Jeff King <peff@peff.net> writes:

> The solution is fairly straight-forward: we read the request
> body into an in-memory buffer in http-backend, freeing up
> Apache, and then feed the data ourselves to upload-pack. But
> there are a few important things to note:
>
>   1. We limit in-memory buffer to no larger than 1 megabyte
>      to prevent an obvious denial-of-service attack. This
>      is a new hard limit on requests, but it's likely that
>      requests of this size didn't work before at all (i.e.,
>      they would have run into the pipe buffer thing and
>      deadlocked).
>
>   2. We must take care only to buffer when we have to. For
>      pushes, the incoming packfile may be of arbitrary
>      size, and we should connect the input directly to
>      receive-pack. There's no deadlock problem here, though,
>      because we do not produce any output until the whole
>      packfile has been read.
>
>      For upload-pack's initial ref advertisement, we
>      similarly do not need to buffer. Even though we may
>      generate a lot of output, there is no request body at
>      all (i.e., it is a GET, not a POST).

Thanks.

One unrelated thing I noticed was that three codepaths independently
have close(0) in run_service() now, and made me follow the two
helper functions to see they both do the close at the end.  It might
have made the flow easier to follow if run_service() were

    ...
    close(1);
    if (gzip)
    	inflate();
    else if (buffer)
        copy();
    close(0);
    ...

But that is minor.

Also, is it worth allocating small and then growing up to the maximum?
I think this only relays one request at a time anyway, and I suspect
that a single 1MB allocation at the first call kept getting reused
may be sufficient (and much simpler).

> [1] http://article.gmane.org/gmane.comp.version-control.git/269020
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  http-backend.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 77 insertions(+), 11 deletions(-)
>
> diff --git a/http-backend.c b/http-backend.c
> index 3ad82a8..7cc2e8c 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -19,12 +19,13 @@ static struct string_list *query_params;
>  struct rpc_service {
>  	const char *name;
>  	const char *config_name;
> +	unsigned buffer_input : 1;
>  	signed enabled : 2;
>  };
>  
>  static struct rpc_service rpc_service[] = {
> -	{ "upload-pack", "uploadpack", 1 },
> -	{ "receive-pack", "receivepack", -1 },
> +	{ "upload-pack", "uploadpack", 1, 1 },
> +	{ "receive-pack", "receivepack", 0, -1 },
>  };
>  
>  static struct string_list *get_parameters(void)
> @@ -266,9 +267,49 @@ static struct rpc_service *select_service(const char *name)
>  	return svc;
>  }
>  
> -static void inflate_request(const char *prog_name, int out)
> +/*
> + * This is basically strbuf_read(), except that if we
> + * hit MAX_REQUEST_BUFFER we die (we'd rather reject a
> + * maliciously large request than chew up infinite memory).
> + */
> +#define MAX_REQUEST_BUFFER (1024 * 1024)
> +static ssize_t read_request(int fd, unsigned char **out)
> +{
> +	size_t len = 0, alloc = 8192;
> +	unsigned char *buf = xmalloc(alloc);
> +
> +	while (1) {
> +		ssize_t cnt;
> +
> +		cnt = read_in_full(fd, buf + len, alloc - len);
> +		if (cnt < 0) {
> +			free(buf);
> +			return -1;
> +		}
> +
> +		/* partial read from read_in_full means we hit EOF */
> +		len += cnt;
> +		if (len < alloc) {
> +			*out = buf;
> +			return len;
> +		}
> +
> +		/* otherwise, grow and try again (if we can) */
> +		if (alloc == MAX_REQUEST_BUFFER)
> +			die("request was larger than our maximum size (%lu)",
> +			    (unsigned long)(MAX_REQUEST_BUFFER-1));
> +
> +		alloc = alloc_nr(alloc);
> +		if (alloc > MAX_REQUEST_BUFFER)
> +			alloc = MAX_REQUEST_BUFFER;
> +		REALLOC_ARRAY(buf, alloc);
> +	}
> +}
> +
> +static void inflate_request(const char *prog_name, int out, int buffer_input)
>  {
>  	git_zstream stream;
> +	unsigned char *full_request = NULL;
>  	unsigned char in_buf[8192];
>  	unsigned char out_buf[8192];
>  	unsigned long cnt = 0;
> @@ -277,11 +318,21 @@ static void inflate_request(const char *prog_name, int out)
>  	git_inflate_init_gzip_only(&stream);
>  
>  	while (1) {
> -		ssize_t n = xread(0, in_buf, sizeof(in_buf));
> +		ssize_t n;
> +
> +		if (buffer_input) {
> +			if (full_request)
> +				n = 0; /* nothing left to read */
> +			else
> +				n = read_request(0, &full_request);
> +			stream.next_in = full_request;
> +		} else {
> +			n = xread(0, in_buf, sizeof(in_buf));
> +			stream.next_in = in_buf;
> +		}
> +
>  		if (n <= 0)
>  			die("request ended in the middle of the gzip stream");
> -
> -		stream.next_in = in_buf;
>  		stream.avail_in = n;
>  
>  		while (0 < stream.avail_in) {
> @@ -307,9 +358,22 @@ static void inflate_request(const char *prog_name, int out)
>  done:
>  	git_inflate_end(&stream);
>  	close(out);
> +	free(full_request);
>  }
>  
> -static void run_service(const char **argv)
> +static void copy_request(const char *prog_name, int out)
> +{
> +	unsigned char *buf;
> +	ssize_t n = read_request(0, &buf);
> +	if (n < 0)
> +		die_errno("error reading request body");
> +	if (write_in_full(out, buf, n) != n)
> +		die("%s aborted reading request", prog_name);
> +	close(out);
> +	free(buf);
> +}
> +
> +static void run_service(const char **argv, int buffer_input)
>  {
>  	const char *encoding = getenv("HTTP_CONTENT_ENCODING");
>  	const char *user = getenv("REMOTE_USER");
> @@ -334,7 +398,7 @@ static void run_service(const char **argv)
>  				 "GIT_COMMITTER_EMAIL=%s@http.%s", user, host);
>  
>  	cld.argv = argv;
> -	if (gzipped_request)
> +	if (buffer_input || gzipped_request)
>  		cld.in = -1;
>  	cld.git_cmd = 1;
>  	if (start_command(&cld))
> @@ -342,7 +406,9 @@ static void run_service(const char **argv)
>  
>  	close(1);
>  	if (gzipped_request)
> -		inflate_request(argv[0], cld.in);
> +		inflate_request(argv[0], cld.in, buffer_input);
> +	else if (buffer_input)
> +		copy_request(argv[0], cld.in);
>  	else
>  		close(0);
>  
> @@ -392,7 +458,7 @@ static void get_info_refs(char *arg)
>  		packet_flush(1);
>  
>  		argv[0] = svc->name;
> -		run_service(argv);
> +		run_service(argv, 0);
>  
>  	} else {
>  		select_getanyfile();
> @@ -496,7 +562,7 @@ static void service_rpc(char *service_name)
>  	end_headers();
>  
>  	argv[0] = svc->name;
> -	run_service(argv);
> +	run_service(argv, svc->buffer_input);
>  	strbuf_release(&buf);
>  }
