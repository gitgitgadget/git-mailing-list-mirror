From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] drop support for "experimental" loose objects
Date: Wed, 27 Nov 2013 04:30:43 -0500
Message-ID: <20131127093043.GA23429@sigill.intra.peff.net>
References: <20131120203350.GA31139@kitenet.net>
 <20131120213348.GA29004@sigill.intra.peff.net>
 <20131120222805.GC26468@kitenet.net>
 <20131121114157.GA7171@sigill.intra.peff.net>
 <20131121160426.GA21843@kitenet.net>
 <20131122020911.GA12042@sigill.intra.peff.net>
 <20131122172859.GA703@kitenet.net>
 <20131124084444.GA23238@sigill.intra.peff.net>
 <20131124090743.GA495@sigill.intra.peff.net>
 <xmqq7gbwz5w8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 27 10:31:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlbSf-0001Je-2Z
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 10:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430Ab3K0Jat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 04:30:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:46471 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751106Ab3K0Jap (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 04:30:45 -0500
Received: (qmail 11686 invoked by uid 102); 27 Nov 2013 09:30:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Nov 2013 03:30:45 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Nov 2013 04:30:43 -0500
Content-Disposition: inline
In-Reply-To: <xmqq7gbwz5w8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238409>

On Mon, Nov 25, 2013 at 10:35:19AM -0800, Junio C Hamano wrote:

> >  	if (type == OBJ_BLOB) {
> >  		if (stream_blob_to_fd(fd, sha1, NULL, 0) < 0)
> >  			die("unable to stream %s to stdout", sha1_to_hex(sha1));
> > +		if (check_sha1_signature(sha1, NULL, 0, NULL) < 0)
> > +			die("object %s sha1 mismatch", sha1_to_hex(sha1));
> 
> check_sha1_signature() opens the object again and streams the data.
> Essentially the read side is doing twice the work with that patch,
> isn't it?

Yes. I considered that, but I also got ~20% slow-down when just doing
commits/trees, which are in-core and can re-hash the same buffer. So
since my with-blobs numbers backed that up, I didn't think too much
further on it.

But there is something curious about the numbers I posted. It takes 12s
without the check, and 15s with the check. So the extra hashing adds 3s.
But if we are reading each blob twice, and we would expect blob reading
to be a significant chunk of that 12s, then shouldn't we expect much
more than 3s increase?

The answer must be that either we are not streaming as much as I think,
or re-reading the data is much cheaper than I expect. And I think it is
the latter.

The vast majority of blobs in git.git will be stored as packed deltas.
That means the streaming code will fall back to doing the regular
in-core access. We _could_ therefore use that in-core copy to do our
sha1 check rather than streaming; but of course we never get access to
it outside of stream_blob_to_fd, and it is discarded. However, we do
keep a copy in the delta base cache. When we immediately ask to unpack
the exact same entry for check_sha1_signature, we can pull the copy
straight out of the cache without having to re-inflate the object.

After applying the patch below on top of yours, my numbers remain the
same:

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b2ca775..e3ff677 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -197,7 +197,7 @@ static void print_object_or_die(int fd, const unsigned char *sha1,
 				enum object_type type, unsigned long size)
 {
 	if (type == OBJ_BLOB) {
-		if (stream_blob_to_fd(fd, sha1, NULL, 0) < 0)
+		if (stream_blob_to_fd(fd, sha1, NULL, STREAMING_VERIFY_OBJECT_NAME) < 0)
 			die("unable to stream %s to stdout", sha1_to_hex(sha1));
 	}
 	else {
@@ -208,6 +208,8 @@ static void print_object_or_die(int fd, const unsigned char *sha1,
 		contents = read_sha1_file(sha1, &rtype, &rsize);
 		if (!contents)
 			die("object %s disappeared", sha1_to_hex(sha1));
+		if (check_sha1_signature(sha1, contents, rsize, typename(rtype)) < 0)
+			die("object %s sha1 mismatch", sha1_to_hex(sha1));
 		if (rtype != type)
 			die("object %s changed type!?", sha1_to_hex(sha1));
 		if (rsize != size)

> I wonder if we want to extend the stream_blob_to_fd() API to
> optionally allow the caller to ask to validate that the returned
> data is consistent with the object name the caller asked the data
> for.  Something along the lines of the attached weatherbaloon patch?

Yes, I think it is a reasonable addition to the streaming API. However,
I do not think there are any callsites which would currently want it.
All of the current users of stream_blob_to_fd use read_sha1_file as
their alternative, and not parse_object. So we are not verifying the
sha1 in either case (we may want to change that, of course, but that is
a bigger decision than just trying to bring streaming and non-streaming
code-paths into parity).

I also wondered if parse_object itself had problems with double-reading
or failing to verify. But its use goes the opposite direction; it wants
to verify the sha1 of the blob object, but it knows that it does not
actually need the data. So it streams (as of 090ea12) to check the
signature, but then discards each buffer-full after hashing it.

-Peff
