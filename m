Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 17085 invoked by uid 107); 21 Feb 2010 21:27:14 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 21 Feb 2010 16:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175Ab0BUV0x (ORCPT <rfc822;peff@peff.net>);
	Sun, 21 Feb 2010 16:26:53 -0500
Received: from relais.videotron.ca ([24.201.245.36]:53629 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990Ab0BUV0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 16:26:52 -0500
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: TEXT/PLAIN; charset=US-ASCII
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KY7006YINKRRO60@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 21 Feb 2010 16:26:51 -0500 (EST)
Date:	Sun, 21 Feb 2010 16:26:51 -0500 (EST)
From:	Nicolas Pitre <nico@fluxnic.net>
X-X-Sender: nico@xanadu.home
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] sha1_file: don't malloc the whole compressed result when
 writing out objects
In-reply-to: <7vd3zys79d.fsf@alter.siamese.dyndns.org>
Message-id: <alpine.LFD.2.00.1002211522120.1946@xanadu.home>
References: <alpine.LFD.2.00.1002202323500.1946@xanadu.home>
 <7vd3zys79d.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, 21 Feb 2010, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > I think this is worth doing independently of the paranoid mode being 
> > discussed.
> 
> While I agree it might be worth doing, I can see that you really hate
> "paranoia".  Now your loop is letting deflate() decide how much it happens
> to like to consume in a given round, it is much trickier to plug the
> paranoia in without majorly rewriting the loop this patch introduces.

I disagree.

Here's my take on the paranoia issue.  Now the question is whether or 
not this should really be optional.  I would think no.

FWIW, we already have that double SHA1 protection when dealing with pack 
files with fixup_pack_header_footer() (see commit abeb40e5aa).

---------- >8
From: Nicolas Pitre <nico@fluxnic.net>
Date: Sun, 21 Feb 2010 15:48:06 -0500
Subject: [PATCH] sha1_file: be paranoid when creating loose objects

We don't want the data being deflated and stored into loose objects
to be different from what we expect.  While the deflated data is
protected by a CRC which is good enough for safe data retrieval
operations, we still want to be doubly sure that the source data used
at object creation time is still what we expected once that data has
been deflated and its CRC32 computed.

The most plausible data corruption may occur if the source file is
modified while Git is deflating and writing it out in a loose object.
Or Git itself could have a bug causing memory corruption.  Or even bad
RAM could cause trouble.  So it is best to make sure everything is
coherent and checksum protected from beginning to end.

To do so we compute the SHA1 of the data being deflated _after_ the
deflate operation has consumed that data, and make sure it matches
with the expected SHA1.  This way we can rely on the CRC32 checked by
the inflate operation to provide a good indication that the data is still
coherent with its SHA1 hash.

There is some overhead of course. Using 'git add' on a set of large files:

Before:

	real    0m25.210s
	user    0m23.783s
	sys     0m1.408s

After:

	real    0m26.537s
	user    0m25.175s
	sys     0m1.358s

The overhead is around 5% for full data coherency guarantee.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>

diff --git a/sha1_file.c b/sha1_file.c
index 9196b57..c0214d7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2283,6 +2283,8 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	int fd, ret;
 	unsigned char compressed[4096];
 	z_stream stream;
+	git_SHA_CTX c;
+	unsigned char parano_sha1[20];
 	char *filename;
 	static char tmpfile[PATH_MAX];
 
@@ -2302,18 +2304,22 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	deflateInit(&stream, zlib_compression_level);
 	stream.next_out = compressed;
 	stream.avail_out = sizeof(compressed);
+	git_SHA1_Init(&c);
 
 	/* First header.. */
 	stream.next_in = (unsigned char *)hdr;
 	stream.avail_in = hdrlen;
 	while (deflate(&stream, 0) == Z_OK)
 		/* nothing */;
+	git_SHA1_Update(&c, hdr, hdrlen);
 
 	/* Then the data itself.. */
 	stream.next_in = buf;
 	stream.avail_in = len;
 	do {
+		unsigned char *in0 = stream.next_in;
 		ret = deflate(&stream, Z_FINISH);
+		git_SHA1_Update(&c, in0, stream.next_in - in0);
 		if (write_buffer(fd, compressed, stream.next_out - compressed) < 0)
 			die("unable to write sha1 file");
 		stream.next_out = compressed;
@@ -2325,6 +2331,9 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	ret = deflateEnd(&stream);
 	if (ret != Z_OK)
 		die("deflateEnd on object %s failed (%d)", sha1_to_hex(sha1), ret);
+	git_SHA1_Final(parano_sha1, &c);
+	if (hashcmp(sha1, parano_sha1) != 0)
+		die("confused by unstable object source data for %s", sha1_to_hex(sha1));
 
 	close_sha1_file(fd);
 
