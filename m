From: Jeff King <peff@peff.net>
Subject: Re: Using gpg and gitattributes together
Date: Fri, 29 Feb 2008 15:02:37 -0500
Message-ID: <20080229200237.GA6892@coredump.intra.peff.net>
References: <alpine.LSU.1.00.0802270008550.22527@racer.site> <alpine.LSU.1.00.0802291455120.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 29 21:03:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVBRt-00023J-El
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 21:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757886AbYB2UCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 15:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757200AbYB2UCl
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 15:02:41 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1204 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755255AbYB2UCk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 15:02:40 -0500
Received: (qmail 30093 invoked by uid 111); 29 Feb 2008 20:02:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 29 Feb 2008 15:02:38 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Feb 2008 15:02:37 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802291455120.22527@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75555>

On Fri, Feb 29, 2008 at 02:59:43PM +0000, Johannes Schindelin wrote:

> When encrypting, gpg uses a random element (to make the encryption harder 
> to break, I guess).  So when I update netrc with "git add" (and nothing 
> was changed), git will have a _different_ blob.

This is probably due to two things:

  1. random salting of the passphrase when generating a key

     To turn a passphrase into a key, you usually do something like

       salt = some random data
       K = hash(salt + passphrase)

     and then include the salt in your message (since the decrypter
     needs to know it). The point is to avoid dictionary attacks against
     common passphrases (IOW, if "foobar" always becomes 0xabcdef, then
     I can just build a table lookup to make brute forcing faster).

     So you can turn this off at the price of lessened security against
     dictionary attacks.

  2. CBC mode with a random IV

     Most symmetric algorithms are block ciphers. There are many "modes"
     for encrypting a stream; a common one is CBC, which works like
     this:

       C[0] = random initial vector
       C[i] = E(K, P[i] ^ C[i-1])

     so each block depends on the block before, and the first block
     depends on some randomly selected data.

     You can switch to ECB mode, where C[i] = E(P[i]), but it can reveal
     patterns in the data (there is a nice graphical example on the
     wikipedia page:

       http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation

     You can also use the same IV over and over again, but that does
     leak some information: you can tell up to which block two messages
     encrypted with the same key and IV are the same.

     In the case of your netrc, either of these is probably OK. You are
     only trying to keep secret one fixed string within the file.

I don't think gpg's command-line interface is flexible enough to change
any of these options, but I might be wrong. You can definitely use
openssl like this:

  openssl aes-256-ecb -nosalt

If you wanted to implement higher quality encryption in git, you could
just encrypt/decrypt objects going into the object database (like how we
do zlib compression), but still name them by hash. The downside, though,
is that if objects are named by their contents, there is an obvious
"guessing" attack where I can see if your repo contains an object with
particular content. There might be a way around that, but I'd have to
give it some thought.

-Peff
