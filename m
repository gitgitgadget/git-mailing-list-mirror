From: Andreas Ericsson <ae@op5.se>
Subject: Re: pack operation is thrashing my server
Date: Thu, 14 Aug 2008 12:15:02 +0200
Message-ID: <48A405A6.7000405@op5.se>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <alpine.LFD.1.10.0808131228270.4352@xanadu.home> <48A3D1D7.5030805@op5.se> <200808141204.07530.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Aug 14 12:16:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTZsz-0003iR-WA
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 12:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949AbYHNKPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 06:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753956AbYHNKPv
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 06:15:51 -0400
Received: from mail.op5.se ([193.201.96.20]:56561 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582AbYHNKPu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 06:15:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 4C0931B80087;
	Thu, 14 Aug 2008 12:19:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mr9LBDgICNXS; Thu, 14 Aug 2008 12:19:08 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id 842071B8036C;
	Thu, 14 Aug 2008 12:19:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <200808141204.07530.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92351>

Thomas Rast wrote:
> Andreas Ericsson wrote:
>> Nicolas Pitre wrote:
>>> |nico@xanadu:linux-2.6> time git rev-list --objects --all > /dev/null
>>> |
>>> |real    0m21.742s
>>> |user    0m21.379s
>>> |sys     0m0.360s
>>>
>>> That's way too long for 1030198 objects (roughly 48k objects/sec).  And 
>>> it gets even worse with the gcc repository:
>>>
>>> |nico@xanadu:gcc> time git rev-list --objects --all > /dev/null
>>> |
>>> |real    1m51.591s
>>> |user    1m50.757s
>>> |sys     0m0.810s
>>>
>>> That's for 1267993 objects, or about 11400 objects/sec.
>>>
>>> Clearly something is not scaling here.
>>>
>> What are the different packing options for the two repositories?
>> A longer deltachain and larger packwindow would increase the
>> enumeration time, wouldn't it?
> 
> For the fun of it, I ran a test without deltas.  Here's my normal
> git.git:
> 
>   $ du -h .git/objects/pack
>   26M     .git/objects/pack
>   $ git rev-list --all | wc -l
>   17638
>   $ git rev-list --all --objects | wc -l
>   82194
> 
> On a hot cache I get about 61800 objects/sec:
> 
>   $ /usr/bin/time git rev-list --all --objects >/dev/null
>   1.33user 0.04system 0:01.39elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
>   0inputs+0outputs (0major+8087minor)pagefaults 0swaps
> 
> I then made a copy of that and repacked it without deltas (remember to
> remove *.keep, I tripped over that twice):
> 
>   $ git repack --depth=0 --window=0 -a -f -d
>   Counting objects: 82906, done.
>   Writing objects: 100% (82906/82906), done.
>   Total 82906 (delta 0), reused 0 (delta 0)
>   $ du -h .git/objects/pack
>   339M    .git/objects/pack
> 
> Which results in only 28739 objects/sec:
> 

Well, if the objects are, on average, >twice the size, would that
explain it? I'd hate to see some of the sharper git minds hop off
on a wild goose chase if it's not necessary.

How does one go about getting the object sizes? rev-list appears
to have no option for it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
