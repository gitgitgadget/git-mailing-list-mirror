From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] index-pack: --clone-bundle option
Date: Fri, 4 Mar 2016 10:34:00 -0500
Message-ID: <20160304153359.GA16300@sigill.intra.peff.net>
References: <xmqq1t7r2x21.fsf@gitster.mtv.corp.google.com>
 <xmqqsi071bw1.fsf@gitster.mtv.corp.google.com>
 <20160303222902.GB26712@sigill.intra.peff.net>
 <xmqqfuw7186z.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 16:34:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abrk2-00062Y-Vq
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 16:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758909AbcCDPeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 10:34:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:54790 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758892AbcCDPeD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 10:34:03 -0500
Received: (qmail 9366 invoked by uid 102); 4 Mar 2016 15:34:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Mar 2016 10:34:02 -0500
Received: (qmail 2264 invoked by uid 107); 4 Mar 2016 15:34:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Mar 2016 10:34:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Mar 2016 10:34:00 -0500
Content-Disposition: inline
In-Reply-To: <xmqqfuw7186z.fsf_-_@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288258>

On Thu, Mar 03, 2016 at 02:57:08PM -0800, Junio C Hamano wrote:

> Teach a new option "--clone-bundle" to "git index-pack" to create a
> split bundle file that uses an existing packfile as its data part.
> 
> The expected "typical" preparation for helping initial clone would
> start by preparing a packfile that contains most of the history and
> add another packfile that contains the remainder (e.g. the objects
> that are only reachable from reflog entries).  The first pack can
> then be used as the data part of a split bundle and these two files
> can be served as static files to bootstrap the clients without
> incurring any more CPU cycles to the server side.

Just FYI, because I know our setup is anything but typical, but this
probably _won't_ be what we do at GitHub. We try to keep everything in a
single packfile that contains many "islands", which are not allowed to
delta between each other[1]. Individual forks of a repo get their own
islands, unreachable objects are in another one, and so forth. So we'd
probably never want to provide a whole packfile, as it has way too much
data. But we _would_ be able to take a bitmap over the set of packed
objects such that if you blindly spew out every object with its bit set,
the resulting pack has the desired objects.

That's not as turn-key for serving with a dumb http server, obviously.
And I don't expect you to write that part. I just wanted to let you know
where I foresee having to take this for GitHub to get it deployed.

[1] It's a little more complicated than "don't delta with each other".
    Each object has its own bitmap of which islands it is in, and the
    rule is that you can use a delta base iff it is in a subset of your
    own islands. The point is that a clone of a particular island should
    never have to throw away on-disk deltas.

    Cleaning up and sharing that code upstream has been on my todo list
    for about 2 years, but somehow there's always new code to be
    written. :-/ I'm happy to share if people want to look at the messy
    state.

> Among the objects in the packfile, the ones that are not referenced
> by no other objects are identified and recorded as the "references"

s/no/any/ (double negative)

> in the resulting bundle.  As the packfile does not record any ref
> information, however, the names of the "references" recorded in the
> bundle need to be synthesized; we arbitrarily choose to record the
> object whose name is $SHA1 as refs/objects/$SHA1.

Makes sense. In an "island" world I'd want to write one bitmap per
island, and then reconstruct that list on the fly by referencing the
island bitmap with the sha1 names in the pack revidx.

> +static void write_bundle_file(const char *filename, unsigned char *sha1,
> +			      const char *packname)
> +{
> +	int fd = open(filename, O_CREAT|O_EXCL|O_WRONLY, 0600);
> +	struct strbuf buf = STRBUF_INIT;
> +	struct stat st;
> +	int i;
> +

We should probably bail here if "fd < 0", though I guess technically we
will notice in write_in_full(). :)

> +	if (stat(packname, &st))
> +		die(_("cannot stat %s"), packname);
> +
> +	strbuf_addstr(&buf, "# v3 git bundle\n");
> +	strbuf_addf(&buf, "size: %lu\n", (unsigned long) st.st_size);
> +	strbuf_addf(&buf, "sha1: %s\n", sha1_to_hex(sha1));
> +	strbuf_addf(&buf, "data: %s\n\n", packname);

This "sha1" field is the sha1 of the packfile, right? If so, I think
it's redundant with the pack trailer found in the pack at "packname".
I'd prefer not to include that here, because it makes it harder to
generate these v3 bundle headers dynamically (you have to actually
checksum the pack subset to come up with sha1 up front, as opposed to
checksumming as you stream the pack out).

It _could_ be used as an http etag, but I think it would make more sense
to push implementations toward using a unique value for the "packname"
(i.e., so that fetching "https://example.com/foo/1234abcd.pack" is
basically immutable). And I think that comes basically for free, because
the packname has that same hash in it already.

-Peff
