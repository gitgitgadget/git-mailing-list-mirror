From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] recover from "failed to apply delta"
Date: Fri, 14 Jun 2013 17:56:18 -0400
Message-ID: <20130614215618.GB29138@sigill.intra.peff.net>
References: <20130613232608.GA9844@sigill.intra.peff.net>
 <alpine.LFD.2.03.1306132004090.18597@syhkavp.arg>
 <20130614214943.GA29138@sigill.intra.peff.net>
 <7vsj0kmkd4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 23:56:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Unbyu-0002Yi-3X
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 23:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163Ab3FNV4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 17:56:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:59450 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176Ab3FNV4X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 17:56:23 -0400
Received: (qmail 22967 invoked by uid 102); 14 Jun 2013 21:57:17 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Jun 2013 16:57:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jun 2013 17:56:18 -0400
Content-Disposition: inline
In-Reply-To: <7vsj0kmkd4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227924>

On Fri, Jun 14, 2013 at 02:51:35PM -0700, Junio C Hamano wrote:

> > Here is a re-roll; the first patch is a small cleanup in t5303 that is
> > required for the new tests to work.
> 
> Heh, I was doing the same, but I cheated ;-)
> 
> diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
> index 5b1250f..57436db 100755
> --- a/t/t5303-pack-corruption-resilience.sh
> +++ b/t/t5303-pack-corruption-resilience.sh
> @@ -51,7 +51,7 @@ do_corrupt_object() {
>      ofs=`git show-index < ${pack}.idx | grep $1 | cut -f1 -d" "` &&
>      ofs=$(($ofs + $2)) &&
>      chmod +w ${pack}.pack &&
> -    dd of=${pack}.pack count=1 bs=1 conv=notrunc seek=$ofs &&
> +    dd of=${pack}.pack count=${3-1} bs=1 conv=notrunc seek=$ofs &&
>      test_must_fail git verify-pack ${pack}.pack

Yeah, I almost did that, but then I realized that dd will simply read
all of its input, anyway.

>  test_expect_success \
> +    'corrupt delta-part of a packed object, fall back to loose' \
> +    'create_new_pack &&
> +     path=$(echo "$blob_3" | sed -e "s|^\(..\)|\1/|") &&
> +     cat ".git/objects/$path" >saved &&
> +     git prune-packed &&
> +
> +     dd if=${pack}.idx bs=1 count=20 skip=1032 >blob1-bin &&
> +     dd if=${pack}.pack bs=1 count=20 skip=2233 >blob3-delta-base-bin &&
> +
> +     # At the beginning of the REF_DELTA representation of $blob_3,
> +     # write 20-byte base object name for $blob_1, instead of $blob_2.
> +     # The binary representation of object name for $blob_1 is found
> +     # at offset 4 + 4 + 256*4 = 1032 for 20 bytes.
> +     dd if=${pack}.idx bs=1 count=20 skip=1032 | do_corrupt_object $blob_3 2 20 &&
> +     test_must_fail git cat-file blob $blob_3 >/dev/null &&

I didn't want to bother coming up with the binary version of the
REF_DELTA sha1, so I used OFS_DELTA. :)

-Peff
