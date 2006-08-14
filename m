From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Compression and dictionaries
Date: Mon, 14 Aug 2006 12:15:29 -0400
Message-ID: <9e4733910608140915i728004c1p216bf3d74fcc6ab7@mail.gmail.com>
References: <9e4733910608132037t4297c3bbq9b0cd6ebaa03b979@mail.gmail.com>
	 <Pine.LNX.4.63.0608141415560.10541@wbgn013.biozentrum.uni-wuerzburg.de>
	 <9e4733910608140708i45e3d6day6b87676783fd6511@mail.gmail.com>
	 <Pine.LNX.4.63.0608141641330.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 14 18:16:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCf6P-0001q7-V0
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 18:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWHNQPb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 12:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWHNQPb
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 12:15:31 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:63726 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751134AbWHNQPa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 12:15:30 -0400
Received: by wr-out-0506.google.com with SMTP id i21so186072wra
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 09:15:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pkMVvsWQVeePuzFkKjzNr87b4eMXpdmgmPkRktrK6gIH7j+iGp7OrCRbHytsTDnHGFIS2NMrhUwN0tW3EwCHnhtJyURoulb7AssYiBlaGQssq2980mte9sa8/t2IEhhMSZkMPCEAdUKarNDfb/0up6pj3WHTP4cjI82YZkaCFro=
Received: by 10.78.120.6 with SMTP id s6mr3322480huc;
        Mon, 14 Aug 2006 09:15:29 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Mon, 14 Aug 2006 09:15:28 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608141641330.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25361>

On 8/14/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> I still think that this is important to think through: Is it worth a
> couple of kilobytes (I doubt that it would be as much as 1MB in _total_),
> and be on the unsafe side?

The maps look something like this:
void => 10101010
char => 111101
int => 1110101
tree => 11010111
commit => 101011001

These maps are repeated in every one of my 1M revisions including the
deltas. I have 1GB pack files with 1M entries in them - 1K each entry.
Each byte saved out of a zlib entry take 1MB off my pack.

Note that the current internal maps aren't the same in each of each of
the zlib blobs since the algorithm that builds the internal maps
depends on the order the identifiers were encountered.

If the git tools add a global dictionary the tools would still be able
to read existing packs. If old tools try to read a new dictionary
based pack they will get the zlib NEED_DICT error.

If the entire file was one big zlib blob there would only be one
dictionary and adding a fixed dictionary wouldn't make any difference.
But since it is 1M little zlib blobs it is has 1M dictionaries.

The only "unsafe" aspect I see to this is if the global dictionary
doesn't contain any of the words in the documents being encoded. In
that case the global dictionary will occupy the short huffman keys
forcing longer internal keys.  The keys for the words in the document
would be longer by a about a bit on average.

A solution for making this work over time would be to store the global
dictionary at the front of the pack file and for the unpack tools to
use the stored copy. This would let us change the global dictionary in
the pack tool with no downside, you could even support multiple
dictionaries in the pack tool.

If someone wants to get fancy you could write a tool that would scan a
pack file and compute an optimal fixed dictionary. Store it at the
front of the pack file and repack using it.

Global dictionaries are common in full text searching. I seem to
recall an article stating that Google's global dictionary has about
250K entries in it. If git packs switch to a global dictionary model
it's not a big leap to add a full text search index. You just need
objects for each word in the dictionary pointing to the revisions that
contain it.

-- 
Jon Smirl
jonsmirl@gmail.com
