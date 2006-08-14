From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Compression and dictionaries
Date: Mon, 14 Aug 2006 14:33:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608141415560.10541@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910608132037t4297c3bbq9b0cd6ebaa03b979@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 14 14:33:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCbda-0002RV-2p
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 14:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbWHNMdm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 08:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbWHNMdm
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 08:33:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:54251 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1752031AbWHNMdm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Aug 2006 08:33:42 -0400
Received: (qmail invoked by alias); 14 Aug 2006 12:33:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 14 Aug 2006 14:33:40 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910608132037t4297c3bbq9b0cd6ebaa03b979@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25351>

Hi,

On Sun, 13 Aug 2006, Jon Smirl wrote:

> > From what I remember from long ago most compression schemes build
> dictionaries as a way of achieving significant compression. If so,
> since we zlib compress each entry in a pack individually, are there
> many copies of very similar dictionaries in the pack?

No, there are no dictionaries in the pack. At least no explicit ones.

The trick is that the dictionary builds up with the data incrementally: 
both the encoding process and the decoding process construct it 
identically, on the fly.

Example: A very primitive example of compression is the arithmetic coder 
of single characters. Given a probability distribution of the characters, 
each character is encoded such that the length of the encoding of one 
character is reciprocal to its probability *Footnote 1*. If you want to 
compress context-free, i.e. without looking at the characters before or 
after the current character when encoding or decoding, this is provably 
optimal.

Now, if you do not have a probability distribution (because you haven't 
looked at the file yet), you can build an histogram as approximation on 
the fly. Whenever a character is encoded, you take the current histogram 
to approximate the probability distribution, and adjust the histogram for 
that character.

For zlib, it is a little more involved (it is not a simple histogram), but 
the principle holds: if you do not have a dictionary, you just build one 
from the data seen so far.

BTW I doubt that an explicit dictionary would be good: Either you 
distribute it with git, and have many people complaining that it is either 
too small, or too big, and in most cases does not fit their data well, or 
you have to create it for each local repository, which takes time.

Further, if the pack-file becomes corrupt, you usually still have the 
pack index, or the start of the pack-file, and can reconstruct most of the 
objects. If you use a dictionary, and just one bit flips in it, you're 
screwed.

Ciao,
Dscho

Footnote 1: If the probabilities are all powers of two (with negative 
exponent), the encodings can be fixed bit strings (because the lengths are 
integer numbers); if that is not the case, it gets a little more 
complicated; basically, you store a fractional bit as a state; that is why 
it is called arithmetic coding.
