From: Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP PATCH 06/11] remote.h: add get_remote_capabilities,
 request_capabilities
Date: Wed, 27 May 2015 02:45:21 -0400
Message-ID: <20150527064521.GD885@peff.net>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
 <1432677675-5118-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 27 08:45:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxV5k-0008SH-MF
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 08:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbbE0GpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 02:45:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:36478 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751194AbbE0GpX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 02:45:23 -0400
Received: (qmail 31835 invoked by uid 102); 27 May 2015 06:45:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 01:45:23 -0500
Received: (qmail 4915 invoked by uid 107); 27 May 2015 06:45:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 02:45:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 02:45:21 -0400
Content-Disposition: inline
In-Reply-To: <1432677675-5118-7-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270025>

On Tue, May 26, 2015 at 03:01:10PM -0700, Stefan Beller wrote:

> +void get_remote_capabilities(int in, char *src_buf, size_t src_len)
> +{
> +	struct strbuf capabilities_string = STRBUF_INIT;
> +	for (;;) {
> +		int len;
> +		char *line = packet_buffer;
> +		const char *arg;
> +
> +		len = packet_read(in, &src_buf, &src_len,
> +				  packet_buffer, sizeof(packet_buffer),
> +				  PACKET_READ_GENTLE_ON_EOF |
> +				  PACKET_READ_CHOMP_NEWLINE);
> +		if (len < 0)
> +			die_initial_contact(0);
> +
> +		if (!len)
> +			break;
> +
> +		if (len > 4 && skip_prefix(line, "ERR ", &arg))
> +			die("remote error: %s", arg);
> +
> +		if (starts_with(line, "capability:")) {
> +			strbuf_addstr(&capabilities_string, line + strlen("capability:"));
> +			strbuf_addch(&capabilities_string, ' ');
> +		}
> +	}

I think this is the reverse case of next_capabilities in the upload-pack
side, so I'll make the reverse suggestion. :) Would it make things nicer
if both v1 and v2 parsed the capabilities into a string_list?

> +	free(server_capabilities);
> +	server_capabilities = xmalloc(capabilities_string.len + 1);
> +	server_capabilities = strbuf_detach(&capabilities_string, NULL);

Is this xmalloc line left over? The strbuf_detach will write over it.

> +	strbuf_release(&capabilities_string);

No need to release if we just detached.

> +int request_capabilities(int out)
> +{
> +	fprintf(stderr, "request_capabilities\n");

Debug cruft, I presume.

> +	// todo: send our capabilities
> +	packet_write(out, "capability:foo");

No C99 comments. But I think this is just a placeholder. :)

-Peff
