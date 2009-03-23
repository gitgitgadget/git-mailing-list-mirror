From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: git repack: --depth=100000 causing larger not smaler pack file?
Date: Mon, 23 Mar 2009 11:11:07 +0100
Organization: private
Message-ID: <86y6uwzgzo.fsf@broadpark.no>
References: <867i2ot1fu.fsf@broadpark.no>
 <alpine.LFD.2.00.0903171608080.30483@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Mar 23 11:14:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlhAZ-0007cY-L4
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 11:14:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757802AbZCWKLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 06:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757943AbZCWKLg
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 06:11:36 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:64351 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757915AbZCWKLf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 06:11:35 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KGY0070TEYKWU80@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Mon, 23 Mar 2009 11:11:08 +0100 (CET)
Received: from localhost ([80.202.166.137]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KGY00BN1EYJM1A0@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Mon, 23 Mar 2009 11:11:08 +0100 (CET)
In-reply-to: <alpine.LFD.2.00.0903171608080.30483@xanadu.home>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114268>

Nicolas Pitre <nico@cam.org> writes:

> On Tue, 17 Mar 2009, Kjetil Barvik wrote:
>
>>   aloha!
>> 
>>   Yesterday I run the following command on the updated GIT respository:
>> 
>>     git repack -adf --window=250000 --depth=100000
>> 
>>   After 280 minutes or so it finished, but the strange thing was that
>>   the resulting pack-file was larger than before.  I had expected that
>>   it should be smaler, or at least the same size as before.
  [snip]
>>   I can think of one thing which is spesial with the "--depth=100000"
>>   number, and that is that it is now larger than the total number of
>>   objects in the pack, which is around 96000 to 97000, or so.
>
> No, the depth should have zero negative influence on the pack size.  
> For tight compression, the larger the better.  What this will impact 
> though is runtime access to the pack data afterward.  The deeper a 
> given object is, the slower its access will be.  But since the object 
> recency order tend to put newer objects at the top of a delta chain, 
> this should impact older objects more than recent ones.

  I have done some more tests, and have copied the whole git/ directory
  to a new directory (such that I do not accidentally add or delete any
  objects/commits), and have made the following table:

  All pack file sizes, F, below was computed with the following git
  command:

      git repack -adf --window=250000 --depth=D

     D   |     F      | (F - F_prev) / (D - D_prev)
  -------|------------|----------------------------
    5000 |  19129934  |
   10000 |  19128956  |    -978 /  5000 =  -0.1956
   15000 |  19126077  |   -2879 /  5000 =  -0.5758
   20000 |  19126077  |       0 /  5000 =   0
   25000 |  19126077  |       0 /  5000 =   0
   30000 |  19197575  |   71498 /  5000 =  14.2996
   45000 |  19312240  |  114665 / 15000 =   7.6443
   60000 |  19560083  |  247843 / 15000 =  16.5229
   75000 |  19803043  |  242960 / 15000 =  16.1973
   90000 |  19669923  | -133120 / 15000 =  -8.8746
   95000 |  20463780  |  793857 /  5000 = 155.7714

  From the table it seems that you get the smallest pack file (for this
  particular repository) when --depth value is somewhere between 15000
  and 25000.  And, when the --depth value was 95000 the resulting pack
  file was (- 20463780 19126077) = 1 337 703 bytes, 1.25 MiB, or 7%
  larger than this.

> I doubt there is anything to debug.  In this case the window size is 
> used to evaluate a threshold slope for matching objects in the delta 
> search.  What we want is a broader delta tree more than a deep one in 
> order to have more deltas with a lower depth limit.  Therefore a size 
> threshold is applied, based on the object distance in the delta search 
> window (see commit c83f032e and the other ones referenced therein).
>
> By providing a big window value, the threshold slope becomes rather flat 
> and ineffective, and this changes the delta match outcome.  While delta 
> selection is based on the uncompressed delta result, the compressed size 
> of different deltas with the same size may vary.  I suspect you might 
> have been unlucky in that regard and this could explain the negative 
> effect on the pack size.

  From the table above it seems that I have been unlucky with _all_
  --depth values above 25000 or so.

  Question: is there some low level GIT command I can run to compare 2
  pack files to maybe be able to see the reason behind the above table?
  Maybe to see some details about how many delta's, how big each are,
  total sizes, etc..

  -- kjetil

  PS!  I have the following in my $HOME/.gitconfig file:

[repack]
	UseDeltaBaseOffset = true
[gc]
	auto = 25
	autopacklimit = 1
