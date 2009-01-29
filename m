From: David Abrahams <dave@boostpro.com>
Subject: Re: "malloc failed"
Date: Thu, 29 Jan 2009 08:10:05 -0500
Message-ID: <87pri6qmvm.fsf@mcbain.luannocracy.com>
References: <878wow7pth.fsf@mcbain.luannocracy.com>
	<20090128050225.GA18546@coredump.intra.peff.net>
	<c26bbb3fe074f6f6e0634a4ae8611239@206.71.190.141>
	<87skn3rn5n.fsf@mcbain.luannocracy.com>
	<20090129052041.GB31507@coredump.intra.peff.net>
	<20090129055633.GA32609@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 29 14:11:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSWgC-0004Ys-6B
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 14:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbZA2NKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 08:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752269AbZA2NKJ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 08:10:09 -0500
Received: from boost-consulting.com ([206.71.190.141]:52137 "EHLO
	boost-consulting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbZA2NKI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 08:10:08 -0500
Received: from mcbain.luannocracy.com.boostpro.com (207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com [207.172.223.249])
	(Authenticated sender: dave)
	by boost-consulting.com (Postfix) with ESMTPSA id 8E6451CC1E;
	Thu, 29 Jan 2009 04:59:18 -0800 (PST)
In-Reply-To: <20090129055633.GA32609@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 29 Jan 2009 00:56:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107670>


on Thu Jan 29 2009, Jeff King <peff-AT-peff.net> wrote:

> On Thu, Jan 29, 2009 at 12:20:41AM -0500, Jeff King wrote:
>
>> Ok, that _is_ big. ;) I wouldn't be surprised if there is some corner of
>> the code that barfs on a single object that doesn't fit in a signed
>> 32-bit integer; I don't think we have any test coverage for stuff that
>> big.
>
> Sure enough, that is the problem. With the patch below I was able to
> "git add" and commit a 3 gigabyte file of random bytes (so even the
> deflated object was 3G).
>
> I think it might be worth applying as a general cleanup, but I have no
> idea if other parts of the system might barf on such an object.
>
> -- >8 --
> Subject: [PATCH] avoid 31-bit truncation in write_loose_object
>
> The size of the content we are adding may be larger than
> 2.1G (i.e., "git add gigantic-file"). Most of the code-path
> to do so uses size_t or unsigned long to record the size,
> but write_loose_object uses a signed int.
>
> On platforms where "int" is 32-bits (which includes x86_64
> Linux platforms), we end up passing malloc a negative size.


Good work.  I don't know if this matters to you, but I think on a 32-bit
platform you'll find that size_t, which is supposed to be able to hold
the size of the largest representable *memory block*, is only 4 bytes
large:

  #include <limits.h>
  #include <stdio.h>

  int main()
  {
    printf("sizeof(size_t) = %d", sizeof(size_t));
  }

Prints "sizeof(size_t) = 4" on my core duo.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  sha1_file.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 360f7e5..8868b80 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2340,7 +2340,8 @@ static int create_tmpfile(char *buffer, size_t bufsiz, const
> char *filename)
>  static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
>  			      void *buf, unsigned long len, time_t mtime)
>  {
> -	int fd, size, ret;
> +	int fd, ret;
> +	size_t size;
>  	unsigned char *compressed;
>  	z_stream stream;
>  	char *filename;

-- 
Dave Abrahams
BoostPro Computing
http://www.boostpro.com
