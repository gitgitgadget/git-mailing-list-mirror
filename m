From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Decompression speed: zip vs lzo
Date: Thu, 10 Jan 2008 12:45:36 +0100
Message-ID: <e5bfff550801100345i20cb3030mf04a11d610fda6f7@mail.gmail.com>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com>
	 <7v4pdmfw27.fsf@gitster.siamese.dyndns.org>
	 <47855765.9090001@vilain.net>
	 <alpine.LSU.1.00.0801092328580.31053@racer.site>
	 <alpine.LFD.1.00.0801092234130.3054@xanadu.home>
	 <e5bfff550801092255wc852252m9086567a88b1ae99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sam Vilain" <sam@vilain.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 12:46:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCvrL-0001mW-46
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 12:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbYAJLpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 06:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752564AbYAJLpi
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 06:45:38 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:55072 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbYAJLph (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 06:45:37 -0500
Received: by rv-out-0910.google.com with SMTP id k20so558137rvb.1
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 03:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=taOL5H4pP2ABW2Z1jdO9yCHhu6CDSi75nYEDFdzCWvE=;
        b=n8HtJPy8PuJ8xwzaa2PBPwflKV9U2D0O3t5TnhQl+KTsptnC7isQ7Zbebd4SQ5l1KIZAGQ1OqgTprwmBVTM5oh9l7NzXZGeUrFEpay/jDwsMwkGYXi2FYy2rvgPfXdE4hI2PxTsV5vSiHoA6C+POFVK/Cuzh7rbOu6eFgvgZiT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qEqlGFQ0iUC5U948BQEtWkI3qb18Nk+7NLPSgvAHSwgN7GYticPPZzmB2yHEaD0xIs6XC8OQEfqyeribyf4MLez/6IYbz5ib2Fehs6AOLOOAem9kHs8B30o8XZy13rVL+qgsQ3mEbkI2VNYQcBkfQCfugXQ2dwJS7VTKXfenYvk=
Received: by 10.140.158.4 with SMTP id g4mr1124896rve.64.1199965536670;
        Thu, 10 Jan 2008 03:45:36 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Thu, 10 Jan 2008 03:45:36 -0800 (PST)
In-Reply-To: <e5bfff550801092255wc852252m9086567a88b1ae99@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70060>

On Jan 10, 2008 7:55 AM, Marco Costalba <mcostalba@gmail.com> wrote:
>
> [1] where inflate() is called:
>
> -inflate_it() in builtin-apply.c
> -check_pack_inflate() in builtin-pack-objects.c
> -get_data() in builtin-unpack-objects.c
> -fwrite_sha1_file() in http-push.c and http-walker.c  [mmm interesting
> same function in two files, also the signature and the contents seems
> the same....]
> -unpack_entry_data() in index-pack.c
> -unpack_sha1_header(), unpack_sha1_rest(), get_size_from_delta(),
> unpack_compressed_entry, write_sha1_from_fd() in sha1_file.c
>

Looking at the git sources I have found that zip routines are
candidate for a cleaning up, as example the more or less very similar
lines of code are repeated many times in git files:

memset(&stream, 0, sizeof(stream));
deflateInit(&stream, pack_compression_level);
maxsize = deflateBound(&stream, size);
out = xmalloc(maxsize);
stream.next_out = out;
stream.avail_out = maxsize;


So what I'm planning to do to test with different algorithms is first
a cleanup work that is more or less the following

- Remove #include <zlib.h> from cache.h and substitute with #include
"compress.h"

- Add #include <zlib.h> where it is "really" intended as example archive-zip.c

- Rename inflate()/deflate() and other zlib calls with corresponding
  zlib_inflate()
  zlib_deflate()

and declared in compress.h

- Define zlib_inflate() and friends as simple wrappers to
corresponding zlib function

- Test if everything is ok (should be only code shuffling/renaming until now)

- Start cleaning up as example adding a do_deflateInit() that wraps
all the code I have reported above and that involves deflateInit()

- When compression routines are cleaned up add new functions

do_inflate(), do_deflate() instead of zlib_* ones that wrap the
compression alghorithm dispatching logic.

Dispatching could be choose in different ways going from

- compile time (at #define level)
- config (some configuration value stored in some global variable)
- dynamic (at run time, with no configuration needed, I have some
ideas on this ;-)


Comments?

Thanks
Marco
