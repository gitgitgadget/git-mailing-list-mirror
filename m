From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix in Git.pm cat_blob crashes on large files
Date: Thu, 21 Feb 2013 17:43:20 -0500
Message-ID: <20130221224319.GA19021@sigill.intra.peff.net>
References: <CAMB+bfKYLjmDavcLaO7scBPfTLmzqAmH+k9uBj0WJ+dzj9vuyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joshua Clayton <stillcompiling@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 23:43:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8erm-0007xo-TZ
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 23:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758000Ab3BUWnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 17:43:23 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56474 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756122Ab3BUWnW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 17:43:22 -0500
Received: (qmail 31754 invoked by uid 107); 21 Feb 2013 22:44:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Feb 2013 17:44:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Feb 2013 17:43:20 -0500
Content-Disposition: inline
In-Reply-To: <CAMB+bfKYLjmDavcLaO7scBPfTLmzqAmH+k9uBj0WJ+dzj9vuyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216801>

On Thu, Feb 21, 2013 at 02:13:32PM -0800, Joshua Clayton wrote:

> Greetings.
> This is my first patch here. Hopefully I get the stylistic & political
> details right... :)
> Patch applies against maint and master

I have some comments. :)

The body of your email should contain the commit message (i.e., whatever
people reading "git log" a year from now would see). Cover letter bits
like this should go after the "---". That way "git am" knows which part
is which.

>         Developer's Certificate of Origin 1.1

You don't need to include the DCO. Your "Signed-off-by" is an indication
that you agree to it.

> Affects git svn clone/fetch
> Original code loaded entire file contents into a variable
> before writing to disk. If the offset within the variable passed
> 2 GiB, it becrame negative, resulting in a crash.

Interesting. I didn't think perl had signed wrap-around issues like
this, as its numeric variables are not strictly integers. But I don't
have a 32-bit machine to test on (and numbers larger than 2G obviously
work on 64-bit machines). At any rate, though:

> On a 32 bit system, or a system with low memory it may crash before
> reaching 2 GiB due to memory exhaustion.

Yeah, it is stupid to read the whole thing into memory if we are just
going to dump it to another filehandle.

> @@ -949,13 +951,21 @@ sub cat_blob {
>  		last unless $bytesLeft;
> 
>  		my $bytesToRead = $bytesLeft < 1024 ? $bytesLeft : 1024;
> -		my $read = read($in, $blob, $bytesToRead, $bytesRead);
> +		my $read = read($in, $blob, $bytesToRead, $blobSize);
>  		unless (defined($read)) {
>  			$self->_close_cat_blob();
>  			throw Error::Simple("in pipe went bad");
>  		}

Hmph. The existing code already reads in 1024-byte chunks. For no
reason, as far as I can tell, since we are just loading the blob buffer
incrementally into memory, only to then flush it all out at once.

Why do you read at the $blobSize offset? If we are just reading in
chunks, we be able to just keep writing to the start of our small
buffer, as we flush each chunk out before trying to read more.

IOW, shouldn't the final code look like this:

  my $bytesLeft = $size;
  while ($bytesLeft > 0) {
          my $buf;
          my $bytesToRead = $bytesLeft < 1024 ? $bytesLeft : 1024;
          my $read = read($in, $buf, $bytesToRead);
          unless (defined($read)) {
                  $self->_close_cat_blob();
                  throw Error::Simple("unable to read cat-blob pipe");
          }
          unless (print $fh $buf) {
                  $self->_close_cat_blob();
                  throw Error::Simple("unable to write blob output");
          }

          $bytesLeft -= $read;
  }

By having the read and flush size be the same, it's much simpler.

Your change (and my proposed code) do mean that an error during the read
operation will result in a truncated output file, rather than an empty
one. I think that is OK, though. That can happen anyway in the original
due to a failure in the "print" step. Any caller who wants to be careful
that they leave only a full file in place must either:

  1. Check the return value of cat_blob and verify that the result has
     $size bytes, and otherwise delete it.

  2. Write to a temporary file, then once success has been returned from
     cat_blob, rename the result into place.

Neither of which is affected by this change.

-Peff
