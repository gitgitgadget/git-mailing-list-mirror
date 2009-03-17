From: Nicolas Pitre <nico@cam.org>
Subject: Re: git repack: --depth=100000 causing larger not smaler pack file?
Date: Tue, 17 Mar 2009 16:38:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903171608080.30483@xanadu.home>
References: <867i2ot1fu.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Tue Mar 17 21:40:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljg5G-0006Rr-In
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 21:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437AbZCQUix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 16:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754224AbZCQUix
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 16:38:53 -0400
Received: from relais.videotron.ca ([24.201.245.36]:42676 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702AbZCQUiw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 16:38:52 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KGO00EAT40LAYN0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 17 Mar 2009 16:38:45 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <867i2ot1fu.fsf@broadpark.no>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113524>

On Tue, 17 Mar 2009, Kjetil Barvik wrote:

>   aloha!
> 
>   Yesterday I run the following command on the updated GIT respository:
> 
>     git repack -adf --window=250000 --depth=100000
> 
>   After 280 minutes or so it finished, but the strange thing was that
>   the resulting pack-file was larger than before.  I had expected that
>   it should be smaler, or at least the same size as before.
> 
>   kjetil git (my_next)$ ls -l .git/objects/pack/*
> -r-------- 1 kjetil kjetil  2757280 2009-03-16 15:18 .git/objects/pack/pack-c5f15d5c48d6b3902a49046d7e8a8d717e167051.idx
> -r-------- 1 kjetil kjetil 19961120 2009-03-16 15:18 .git/objects/pack/pack-c5f15d5c48d6b3902a49046d7e8a8d717e167051.pack
> 
>   Before I started the pack file was around 19 250 000 bytes, and was
>   the result of the following commands:
> 
>   1) git repack -adf --window=250000 --depth=20000
>           - not completly sure about the --window number here
>           - the resulting pack file was a litle less than 19 100 000
> 
>   2) 'git fetch' to get the latest GIT patches
> 
>   3) since 'git fetch' always make an extra new "smal" pack file, I run
>      the command 'git repack -ad --window=40000 --depth=10000' to be
>      able to get one singel pack file of 19 250 000 bytes or so.
> 
>   I can think of one thing which is spesial with the "--depth=100000"
>   number, and that is that it is now larger than the total number of
>   objects in the pack, which is around 96000 to 97000, or so.

No, the depth should have zero negative influence on the pack size.  
For tight compression, the larger the better.  What this will impact 
though is runtime access to the pack data afterward.  The deeper a 
given object is, the slower its access will be.  But since the object 
recency order tend to put newer objects at the top of a delta chain, 
this should impact older objects more than recent ones.

>   I have run 'git fsck --strict --full' on the pack with no resulting
>   error/debug output or change in the file size.

There shouldn't be any.

>   Any help on how to debug this?

I doubt there is anything to debug.  In this case the window size is 
used to evaluate a threshold slope for matching objects in the delta 
search.  What we want is a broader delta tree more than a deep one in 
order to have more deltas with a lower depth limit.  Therefore a size 
threshold is applied, based on the object distance in the delta search 
window (see commit c83f032e and the other ones referenced therein).

By providing a big window value, the threshold slope becomes rather flat 
and ineffective, and this changes the delta match outcome.  While delta 
selection is based on the uncompressed delta result, the compressed size 
of different deltas with the same size may vary.  I suspect you might 
have been unlucky in that regard and this could explain the negative 
effect on the pack size.


Nicolas
