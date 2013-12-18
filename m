From: Jeff King <peff@peff.net>
Subject: Re: "git fsck" fails on malloc of 80 G
Date: Wed, 18 Dec 2013 16:58:21 -0500
Message-ID: <20131218215821.GA14276@sigill.intra.peff.net>
References: <201312161605.rBGG5Wm5027739@hobgoblin.ariadne.com>
 <20131216191500.GD29324@sigill.intra.peff.net>
 <201312180306.rBI36KCm016209@hobgoblin.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Dec 18 22:58:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtP8n-0000SC-E2
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 22:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051Ab3LRV6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 16:58:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:46943 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755766Ab3LRV6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 16:58:25 -0500
Received: (qmail 10134 invoked by uid 102); 18 Dec 2013 21:58:25 -0000
Received: from va-71-48-137-223.dhcp.embarqhsd.net (HELO sigill.intra.peff.net) (71.48.137.223)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Dec 2013 15:58:25 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Dec 2013 16:58:21 -0500
Content-Disposition: inline
In-Reply-To: <201312180306.rBI36KCm016209@hobgoblin.ariadne.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239494>

On Tue, Dec 17, 2013 at 10:06:20PM -0500, Dale R. Worley wrote:

> Here's the basic backtrace information, and the values of the "size"
> variables, which seem to be the immediate culprits:
> [...]
>     #1  0x00000000004f3633 in xmallocz (size=size@entry=80530636800)
> 	at wrapper.c:73
>     #2  0x00000000004d922f in unpack_compressed_entry (p=p@entry=0x7e4020, 
> 	w_curs=w_curs@entry=0x7fffffffc9f0, curpos=654214694, size=80530636800)
> 	at sha1_file.c:1797
>     #3  0x00000000004db4cb in unpack_entry (p=p@entry=0x7e4020, 
> 	obj_offset=654214688, final_type=final_type@entry=0x7fffffffd088, 
> 	final_size=final_size@entry=0x7fffffffd098) at sha1_file.c:2072
>     #4  0x00000000004b1e3f in verify_packfile (base_count=0, progress=0x9bdd80, 
> 	fn=0x42fc00 <fsck_obj_buffer>, w_curs=0x7fffffffd090, p=0x7e4020)
> 	at pack-check.c:119

Thanks, that's helpful. Unfortunately the patch I mentioned before won't
help you. The packfile format (like the experimental loose format that my patch
dropped) stores the size outside of the zlib crc. So it has the same
problem: we want to allocate the buffer up front to store the zlib
results.

The pack index does store a crc (calculated when we made or received
the pack) over each object's on-disk representation. So we could check
that, though doing it on every access has performance implications.

The pack data itself also has a SHA-1 checksum over the whole thing. We
should probably do a better job in verify-pack of:

  1. Check the whole sha1 checksum before doing anything else.

  2. In the uncommon case that it fails, check each individual object
     crc to find the broken object (and if none, assume either the
     header or the checksum itself is what got munged).

In the meantime, you should be able to do step 1 manually like:

  # check first N-20 bytes of packfile against the checksum in the
  # final 20 bytes. NB: pretty sure this use of "head" is a GNU-ism,
  # and of course you need openssl
  for i in objects/pack/*.pack; do
    tail -c 20 "$i" >want.tmp &&
    head -c -20 "$i" | openssl sha1 -binary >have.tmp &&
    cmp want.tmp have.tmp ||
    echo >&2 "broken: $i"
  done

git-fsck should be doing this check itself, but I wonder if you are not
making it that far.

> If I understand the code correctly, the object header buffer
> \260\200\200\200\340\022x\234\354\301\001\001
> really does encode the size value 0x12c0000000.

If it does, and you do not have an 80G file, then it sounds like you may
have a corrupt packfile.

-Peff
