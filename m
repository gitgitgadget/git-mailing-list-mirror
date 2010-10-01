From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 1/3] Add bidirectional_transfer_loop()
Date: Fri, 1 Oct 2010 00:11:25 -0500
Message-ID: <20101001051125.GA6184@burratino>
References: <1285866422-23964-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1285866422-23964-2-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Oct 01 07:14:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1XxE-0003Bx-P4
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 07:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399Ab0JAFOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 01:14:39 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63511 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab0JAFOi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 01:14:38 -0400
Received: by yxp4 with SMTP id 4so1028607yxp.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 22:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=awuyHOUuJLHGFk3inM8W/9+pWj7zsGRZ4093OwvT/5s=;
        b=QowaKg47sDsW9dqZk0UOomFev3uUWVG/4qjCS0jMJDklqgeJLg0DkJzO/15dlrzgio
         WQ4HSLoNfaxsb44mUSZV+WVBaRqlmuTU9M0DsR9C0/+7GKyr5/M+AY/M8xGYugrteukF
         sLIetXbj0Ofd3u/KIDJCDeZ6TiaVuMT7VsRIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iTXfLst+Iyrueob4w62eOQ/77U2eeQC8wj8/FdWbERXfrnQhc8c7PeT92dEgeQNaWf
         fI/gzVMHswGou6/hNNR+6yPE74sF29CJ2cCV7fV9GIeGHZEpFmHP7lvYFiPaBviAlO3v
         x/XPNJ4yt9cUkKLJSKhIXyaj7Yku/qc/KgYNQ=
Received: by 10.101.49.20 with SMTP id b20mr115232ank.213.1285910077503;
        Thu, 30 Sep 2010 22:14:37 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id w10sm1074954ank.14.2010.09.30.22.14.35
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 22:14:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285866422-23964-2-git-send-email-ilari.liusvaara@elisanet.fi>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157730>

Hi,

Ilari Liusvaara wrote:

> This helper function copies bidirectional stream of data between
> stdin/stdout and specified file descriptors.

>From this description, I am expecting something to the effect of

 sendfile(output, input, NULL, SIZE_MAX);

but this is much longer than that.  Why?  Let's see...

> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -862,3 +862,257 @@ int transport_helper_init(struct transport *transport, const char *name)
>  	transport->smart_options = &(data->transport_options);
>  	return 0;
>  }
> +
> +
> +#define BUFFERSIZE 4096
> +#define PBUFFERSIZE 8192

Magic numbers.  Where do these come from?  Were they tuned or are they
off the top of the head?  (Either is fine; it just is nice to know.)

> +/* Print bidirectional transfer loop debug message. */
> +static void transfer_debug(const char *fmt, ...)
> +{
> +	va_list args;
> +	char msgbuf[PBUFFERSIZE];
> +	static int debug_enabled = -1;
> +
> +	if (debug_enabled < 0)
> +		debug_enabled = getenv("GIT_TRANSLOOP_DEBUG") ? 1 : 0;
> +	if (!debug_enabled)
> +		return;
> +
> +	sprintf(msgbuf, "Transfer loop debugging: ");
> +	va_start(args, fmt);
> +	vsprintf(msgbuf + strlen(msgbuf), fmt, args);
> +	va_end(args);
> +	fprintf(stderr, "%s\n", msgbuf);
> +}

Why this instead of just vfprintf?  (vreportf() in usage.c
does the same thing; maybe there is some portability reason?)

This can overflow if the caller is not careful.

Might be clearer to write

	va_start(args, fmt);
	vsnprintf(msgbuf, sizeof(msgbuf), fmt, args);
	va_end(args);
	vfprintf(stderr, "Transfer loop debugging: %s\n", msgbuf);

like vreportf() does.

> +/* Load the parameters into poll structure. Return number of entries loaded */

Not clear to me what this comment means.  What is this function used for?

> +static int load_poll_params(struct pollfd *polls, size_t inbufuse,
> +	size_t outbufuse, int in_hup, int out_hup, int in_closed,
> +	int out_closed, int socket_mode, int input_fd, int output_fd)

Scary.  Maybe a params struct would make callers easier to understand?

What the parameters mean (I'm guessing):

	polls - buffer for file descriptors to poll on.  There should
	        be room for 4.
	inbufuse - < BUFFERSIZE if we can handle more input on stdin
	outbufuse - < BUFFERSIZE if we can handle more input on input_fd
		--- why is this called "out"?
	in_hup - whether the other end of stdin has already hung up
	out_hup - whether the other end of input_fd has already hung up
	in_closed - ???
	out_closed - ???
	socket_mode - true if input_fd == output_fd
	input_fd, output_fd - file descriptors

[...]
> +	if (!in_hup && inbufuse < BUFFERSIZE) {
> +		stdin_index = nextindex++;
> +		polls[stdin_index].fd = 0;
> +		transfer_debug("Adding stdin to fds to wait for");
> +	}
> +	if (!out_hup && outbufuse < BUFFERSIZE) {
> +		input_index = nextindex++;
> +		polls[input_index].fd = input_fd;
> +		transfer_debug("Adding remote input to fds to wait for");
> +	}
> +	if (!out_closed && outbufuse > 0) {
> +		stdout_index = nextindex++;
> +		polls[stdout_index].fd = 1;
> +		transfer_debug("Adding stdout to fds to wait for");
> +	}

Repetitive.  Maybe this could be factored out as a mini-function:

	consider_waiting_for(in_hup, inbufuse, &stdin_index,
	                     nextindex, polls, 0, "stdin");

Hmm, never mind.

[...]
> +}
> +
> +static int transfer_handle_events(struct pollfd* polls, char *in_buffer,
> +	char *out_buffer, size_t *in_buffer_use, size_t *out_buffer_use,
> +	int *in_hup, int *out_hup, int *in_closed, int *out_closed,
> +	int socket_mode, int poll_count, int input, int output)

Scarier.

> +{
> +	int i, r;
> +	for(i = 0; i < poll_count; i++) {

Long loop.  What is it for?  (A comment might help.)  Maybe the body
could get its own function?

> +		/* Handle stdin. */
> +		if (polls[i].fd == 0 && polls[i].revents & (POLLIN | POLLHUP)) {

Or better, the code to handle each event might get its own function.

This one reads as much data as possible into in_buffer[], taking
care to handle EOF appropriately.

[...]
> +		}
> +
> +		/* Handle remote end input. */
> +		if (polls[i].fd == input &&
> +			polls[i].revents & (POLLIN | POLLHUP)) {

This one reads as much data as possible into out_buffer[], taking
care to handle EOF appropriately.  Presumably out_buffer[] means
data scheduled for output.

> +			transfer_debug("remote input is readable");
> +			r = read(input, out_buffer + *out_buffer_use,
> +				BUFFERSIZE - *out_buffer_use);
> +			if (r < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
> +				errno != EINTR) {
> +				perror("read(connection) failed");
> +				return 1;

Why use perror() instead of error() which can be overridden by
setting error_routine?  Why return 1 instead of the usual -1
for error?

> +			} else if (r == 0) {
> +				transfer_debug("remote input EOF");
> +				*out_hup = 1;
> +				if (!*out_buffer_use) {
> +					close(1);
> +					*out_closed = 1;
> +					transfer_debug("Closed stdout");
> +				} else
> +					transfer_debug("Delaying stdout close because output buffer has data");

Why is stdout closed here?  Could that be taken care of later
by checking *out_hup?

[...]
> +			r = write(1, out_buffer, *out_buffer_use);
[...]
> +				if (*out_buffer_use > 0)
> +					memmove(out_buffer, out_buffer + r,
> +						*out_buffer_use);

This only writes as much data to stdout as one write() allows,
to avoid deadlock, presumably.

> +				if (*out_hup && !*out_buffer_use) {
> +					close(1);

After each write() we check *out_hup, but only after a write.  Would
be simpler to unconditionally check *out_hup and avoid the duplicate
code before; would that slow this down?

> +		/* Handle remote end output. */

Dual to the above.

[...]
> +/* Copy data from stdin to output and from input to stdout. */

Ah.  I think this belongs in the commit message, too. :)

Still I wonder "why".  What is the motivational example?

> +int bidirectional_transfer_loop(int input, int output)
> +{
[...]
> +	while (1) {

A typical poll loop.  Nothing scary here.

> +		int r;
> +		poll_count = load_poll_params(polls, in_buffer_use,
> +			out_buffer_use, in_hup, out_hup, in_closed, out_closed,
> +			socket_mode, input, output);
> +		if (!poll_count) {
> +			transfer_debug("Transfer done");
> +			break;

			return 0;

would avoid the reader having to scroll down, I think.

Okay, so we actually have the effect of

 sendfile(output_fd, 0, NULL, SIZE_MAX);
 sendfile(1, input_fd, NULL, SIZE_MAX);

interleaved to avoid deadlock.  In other words, this interchanges
input for output file descriptors.  The main application is remote-fd,
which needs to do this to forward input to and output from a parent
process.

For remote-ext, for a moment one might imagine one could avoid the
trouble by letting the child inherit stdin and stdout.  Unfortunately,
remote-ext needs to be able to prepend some data to its child's
input stream.  So the effect of

 sendfile(output_fd, 0, NULL, SIZE_MAX);

is still necessary (output_fd is a pipe pointing to the child's
standard input), and to time this to avoid deadlock, it still needs
to be interleaved with

 sendfile(1, input_fd, NULL, SIZE_MAX);

Hope that helps.
