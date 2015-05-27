From: Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP PATCH 04/11] upload-pack-2: Implement the version 2 of
 upload-pack
Date: Wed, 27 May 2015 02:35:58 -0400
Message-ID: <20150527063558.GB885@peff.net>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
 <1432677675-5118-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 27 08:36:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxUwj-000462-1z
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 08:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281AbbE0GgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 02:36:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:36466 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752181AbbE0GgB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 02:36:01 -0400
Received: (qmail 31305 invoked by uid 102); 27 May 2015 06:36:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 01:36:01 -0500
Received: (qmail 4856 invoked by uid 107); 27 May 2015 06:36:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 02:36:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 02:35:58 -0400
Content-Disposition: inline
In-Reply-To: <1432677675-5118-5-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270023>

On Tue, May 26, 2015 at 03:01:08PM -0700, Stefan Beller wrote:

> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -716,10 +716,47 @@ static void format_symref_info(struct strbuf *buf, struct string_list *symref)
>  		strbuf_addf(buf, " symref=%s:%s", item->string, (char *)item->util);
>  }
>  
> -static const char *advertise_capabilities = "multi_ack thin-pack side-band"
> +static char *advertise_capabilities = "multi_ack thin-pack side-band"
>  		" side-band-64k ofs-delta shallow no-progress"
>  		" include-tag multi_ack_detailed";

If we are upload-pack-2, should we advertise that in the capabilities? I
think it may make things easier later if we try to provide some
opportunistic out-of-band data. E.g., if see tell git-daemon:

  git-upload-pack repo\0host=whatever\0\0version=2

how do we know whether version=2 was understood and kicked us into v2
mode, versus an old server that ignored it?

It also just makes the protocol more self-describing; from the
conversation you can see which version is in use.

> +static void send_capabilities(void)
> +{
> +	char buf[100];
> +
> +	while (next_capability(buf))
> +		packet_write(1, "capability:%s\n", buf);

Having a static-sized buffer and then passing it to a function which has
no idea of the buffer size seems like a recipe for a buffer overflow. :)

You are fine here because you are parsing the hard-coded capabilities
string, and we know 100 is enough there. But it's nice to avoid such
magic.

Like Eric, I find the whole next_capability thing a little ugly. His
suggestion to pass in the parsing state is an improvement, but I wonder
why we need to parse at all. Can we keep the capabilities as:

  const char *capabilities[] = {
	"multi_ack",
	"thin-pack",
	... etc ...
  };

and then loop over the array? The v1 writer will need to be modified,
but it should be fairly straightforward (loop and add them to the buffer
rather than dumping the whole string).

Also, do we need the capability noise-word? They all have it, except
for:

> +	packet_write(1, "agent:%s\n", git_user_agent_sanitized());

But isn't that basically a capability, too (I agree it is stretching the
definition of "capability", but I think that ship has sailed; the
client's response is not "I support this, too" but "I want to enable
this").

IOW, is there a reason that the initial conversation is not just:

  pkt-line("multi_ack");
  pkt-line("thin-pack");
  ...
  pkt-line("agent=v2.5.0");
  pkt-line(0000);

We already have framing for each capability due to the use of pkt-line.
The "capability:" is just one more thing the client has to parse past.
The keys are already unique up to any "=", so I don't think there is any
ambiguity (e.g., we don't care about "capability:agent"; we have already
assigned a meaning to the term "agent", and will never introduce a
standalone capability with the same name).

Likewise, if we introduce new protocol items here, the client should
either ignore them (if it does not understand them) or know what to do
with them.

> +static void receive_capabilities(void)
> +{
> +	int done = 0;
> +	while (1) {
> +		char *line = packet_read_line(0, NULL);
> +		if (!line)
> +			break;
> +		if (starts_with(line, "capability:"))
> +			parse_features(line + strlen("capability:"));
> +	}

Use:

  const char *cap;
  if (skip_prefix(line, "capability:", &cap))
	parse_features(cap);

Or better yet, if you take my suggestion above:

  parse_features(line);

:)

> +static int endswith(const char *teststring, const char *ending)
> +{
> +	int slen = strlen(teststring);
> +	int elen = strlen(ending);
> +	return !strcmp(teststring + slen - elen, ending);
> +}

Eric mentioned the underflow problems here, but I wonder even more:
what's wrong with the global ends_with() that we already provide?

-Peff
