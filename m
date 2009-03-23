From: Nicolas Pitre <nico@cam.org>
Subject: Re: git repack: --depth=100000 causing larger not smaler pack file?
Date: Mon, 23 Mar 2009 10:14:13 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903230929300.30483@xanadu.home>
References: <867i2ot1fu.fsf@broadpark.no>
 <alpine.LFD.2.00.0903171608080.30483@xanadu.home> <86y6uwzgzo.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Mon Mar 23 15:17:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llky1-0001Cm-IY
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 15:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756698AbZCWOO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 10:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755978AbZCWOO2
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 10:14:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:48092 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756076AbZCWOO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 10:14:27 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KGY00G5LQ7P0VW0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 23 Mar 2009 10:14:13 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <86y6uwzgzo.fsf@broadpark.no>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114311>

On Mon, 23 Mar 2009, Kjetil Barvik wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Tue, 17 Mar 2009, Kjetil Barvik wrote:
> >
> >>   aloha!
> >> 
> >>   Yesterday I run the following command on the updated GIT respository:
> >> 
> >>     git repack -adf --window=250000 --depth=100000
> >> 
> >>   After 280 minutes or so it finished, but the strange thing was that
> >>   the resulting pack-file was larger than before.  I had expected that
> >>   it should be smaler, or at least the same size as before.
>   [snip]
> >>   I can think of one thing which is spesial with the "--depth=100000"
> >>   number, and that is that it is now larger than the total number of
> >>   objects in the pack, which is around 96000 to 97000, or so.
> >
> > No, the depth should have zero negative influence on the pack size.  
> > For tight compression, the larger the better.  What this will impact 
> > though is runtime access to the pack data afterward.  The deeper a 
> > given object is, the slower its access will be.  But since the object 
> > recency order tend to put newer objects at the top of a delta chain, 
> > this should impact older objects more than recent ones.
> 
>   I have done some more tests, and have copied the whole git/ directory
>   to a new directory (such that I do not accidentally add or delete any
>   objects/commits), and have made the following table:
> 
>   All pack file sizes, F, below was computed with the following git
>   command:
> 
>       git repack -adf --window=250000 --depth=D
> 
>      D   |     F      | (F - F_prev) / (D - D_prev)
>   -------|------------|----------------------------
>     5000 |  19129934  |
>    10000 |  19128956  |    -978 /  5000 =  -0.1956
>    15000 |  19126077  |   -2879 /  5000 =  -0.5758
>    20000 |  19126077  |       0 /  5000 =   0
>    25000 |  19126077  |       0 /  5000 =   0
>    30000 |  19197575  |   71498 /  5000 =  14.2996
>    45000 |  19312240  |  114665 / 15000 =   7.6443
>    60000 |  19560083  |  247843 / 15000 =  16.5229
>    75000 |  19803043  |  242960 / 15000 =  16.1973
>    90000 |  19669923  | -133120 / 15000 =  -8.8746
>    95000 |  20463780  |  793857 /  5000 = 155.7714
> 
>   From the table it seems that you get the smallest pack file (for this
>   particular repository) when --depth value is somewhere between 15000
>   and 25000.  And, when the --depth value was 95000 the resulting pack
>   file was (- 20463780 19126077) = 1 337 703 bytes, 1.25 MiB, or 7%
>   larger than this.

This is a bit intriguing.

Of course, before going any further, you must realize that having a 
depth of 15000 is a bit excessive.  That means that, if you have a delta 
chain with a depth of 15000 that means access to the object at the end 
of the chain will require that 14999 other objects be accessed before 
the 15000th one is retrieved.  This will have horrible runtime 
performances for something like 10% reduction in the best cases which is 
probably not a good tradeoff.

This being said, I still stand by my assertion that, in theory, greater 
delta depth should not make the pack bigger.  And your table appears to 
confirm that, even to the point of reaching a stable size as one would 
expect, until a breaking point is reached after which results tend to 
become rather random.

What I'm suspecting in that case is some computation overflow in 
try_delta().  Consider for instance this piece:

    max_size = max_size * (max_depth - src->depth) /
                                            (max_depth - ref_depth + 1);

[ This is the treshold slope I was talking about, but contrary to
  what I said before, it is affected by the depth not the window size. ]

In this case, if you have a max_depth of 95000, then any object larger 
than 90461 bytes will cause a multiplication overflow, and the resulting 
max_size will be capped to some random smaller value than expected 
depending on the remaining bits. For example, suppose max_size = 45211, 
max_depth = 95000 and src->depth = 0 then you should have max_size still 
equal to 45211, but in this case it'll become 0 and no delta will be 
attempted at all.  The number of deltas reported at the end of the 
repack process probably reflects that.

> > I doubt there is anything to debug.  In this case the window size is 
> > used to evaluate a threshold slope for matching objects in the delta 
> > search.  What we want is a broader delta tree more than a deep one in 
> > order to have more deltas with a lower depth limit.  Therefore a size 
> > threshold is applied, based on the object distance in the delta search 
> > window (see commit c83f032e and the other ones referenced therein).
> >
> > By providing a big window value, the threshold slope becomes rather flat 
> > and ineffective, and this changes the delta match outcome.  While delta 
> > selection is based on the uncompressed delta result, the compressed size 
> > of different deltas with the same size may vary.  I suspect you might 
> > have been unlucky in that regard and this could explain the negative 
> > effect on the pack size.
> 
>   From the table above it seems that I have been unlucky with _all_
>   --depth values above 25000 or so.

See explanation (and self correction) above.

>   Question: is there some low level GIT command I can run to compare 2
>   pack files to maybe be able to see the reason behind the above table?
>   Maybe to see some details about how many delta's, how big each are,
>   total sizes, etc..

Yes -- see the -v option of 'git verify-pack'.


Nicolas
