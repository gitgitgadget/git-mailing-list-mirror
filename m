From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Compression and dictionaries
Date: Mon, 14 Aug 2006 10:08:33 -0400
Message-ID: <9e4733910608140708i45e3d6day6b87676783fd6511@mail.gmail.com>
References: <9e4733910608132037t4297c3bbq9b0cd6ebaa03b979@mail.gmail.com>
	 <Pine.LNX.4.63.0608141415560.10541@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 14 16:08:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCd7P-00079X-C5
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 16:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWHNOIg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 10:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWHNOIg
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 10:08:36 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:8529 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751220AbWHNOIg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 10:08:36 -0400
Received: by wr-out-0506.google.com with SMTP id i21so157103wra
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 07:08:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UEboioLoiFuxhUpl0dwB2pAr+xcqtdks+dhfZY/8mRGlzm0juqaU16IEzmaVQa1Fl39hlmiM/MtxL9dcGFlEgF3USPk6l1f8cI+KLUoyb4vtyQ8VwjcE/OS4V/s6Ywe1v/ZmC//6S0pG1IZJVp3ax/718wjw1XjU9DeyYDBoB+U=
Received: by 10.78.118.19 with SMTP id q19mr3247725huc;
        Mon, 14 Aug 2006 07:08:34 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Mon, 14 Aug 2006 07:08:33 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608141415560.10541@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25354>

On 8/14/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 13 Aug 2006, Jon Smirl wrote:
>
> > > From what I remember from long ago most compression schemes build
> > dictionaries as a way of achieving significant compression. If so,
> > since we zlib compress each entry in a pack individually, are there
> > many copies of very similar dictionaries in the pack?
>
> No, there are no dictionaries in the pack. At least no explicit ones.
>
> The trick is that the dictionary builds up with the data incrementally:
> both the encoding process and the decoding process construct it
> identically, on the fly.
>
> Example: A very primitive example of compression is the arithmetic coder
> of single characters. Given a probability distribution of the characters,
> each character is encoded such that the length of the encoding of one
> character is reciprocal to its probability *Footnote 1*. If you want to
> compress context-free, i.e. without looking at the characters before or
> after the current character when encoding or decoding, this is provably
> optimal.
>
> Now, if you do not have a probability distribution (because you haven't
> looked at the file yet), you can build an histogram as approximation on
> the fly. Whenever a character is encoded, you take the current histogram
> to approximate the probability distribution, and adjust the histogram for
> that character.
>
> For zlib, it is a little more involved (it is not a simple histogram), but
> the principle holds: if you do not have a dictionary, you just build one
> from the data seen so far.

Does a zlib dictionary just changes the probabilities in the histogram
or does it turn the dictionary into a pre-loaded encoding tree?

The other compression schemes I looked at let you load in a
precomputed huffman/arithmetic encoding tree. By preloading an
encoding tree you avoid storing the encoding of "void => 010101' in
every  item. Removing 1M encoding maps and using one common one should
be a win. Items not in the map would still be stored using internal
additions to the map.

Changing the probabilities probably won't help much, but there may be
good gains from partially eliminating 1M encoding maps.

>
> BTW I doubt that an explicit dictionary would be good: Either you
> distribute it with git, and have many people complaining that it is either
> too small, or too big, and in most cases does not fit their data well, or
> you have to create it for each local repository, which takes time.
>
> Further, if the pack-file becomes corrupt, you usually still have the
> pack index, or the start of the pack-file, and can reconstruct most of the
> objects. If you use a dictionary, and just one bit flips in it, you're
> screwed.
>
> Ciao,
> Dscho
>
> Footnote 1: If the probabilities are all powers of two (with negative
> exponent), the encodings can be fixed bit strings (because the lengths are
> integer numbers); if that is not the case, it gets a little more
> complicated; basically, you store a fractional bit as a state; that is why
> it is called arithmetic coding.
>


-- 
Jon Smirl
jonsmirl@gmail.com
