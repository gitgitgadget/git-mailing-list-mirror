From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 4 Sep 2010 08:00:40 -0400
Message-ID: <5B5470E5-57E6-48D2-981B-CE77FA43546F@mit.edu>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com> <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com> <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com> <4C7FC3DC.3060907@gmail.com> <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com> <alpine.LFD.2.00.1009021249510.19366@xanadu.home> <AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com> <alpine.LFD.2.00.1009021624170.19366@xanadu.home> <B757A854-C7BF-4CBF-9132-91D205344606@mit.edu> <7voccezr7m.fsf@alter.siamese.dyndns.org> <20100903183120.GA4887@thunk.org> <alpine.LFD.2.00.1009031522590.19366@xanadu.home> <04755B03-EE1D-48FA-8894-33AA8E2661C0@mit.edu> <alpine.LFD.2.00.1009040040030.19366@xanadu.home>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 04 14:00:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrrQQ-0008HJ-JW
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 14:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175Ab0IDMAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 08:00:46 -0400
Received: from DMZ-MAILSEC-SCANNER-2.MIT.EDU ([18.9.25.13]:63693 "EHLO
	dmz-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751776Ab0IDMAp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Sep 2010 08:00:45 -0400
X-AuditID: 1209190d-b7b38ae000006976-5f-4c8234f73cf6
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	by dmz-mailsec-scanner-2.mit.edu (Symantec Brightmail Gateway) with SMTP id 7A.F5.26998.7F4328C4; Sat,  4 Sep 2010 08:00:55 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o84C0h35003882;
	Sat, 4 Sep 2010 08:00:43 -0400
Received: from [10.0.42.101] (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o84C0f0l012304
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 4 Sep 2010 08:00:42 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.1009040040030.19366@xanadu.home>
X-Mailer: Apple Mail (2.1081)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155319>


On Sep 4, 2010, at 1:40 AM, Nicolas Pitre wrote:
>> What about the order of the objects in the pack?  Well, ordering 
>> doesn't matter, right?  So let's assume the pack is sorted by hash id.  
>> Is there any downside to that?  I can't think of any, but you're the 
>> pack expert...
> 
> Ordering does matter a big deal.  Since object IDs are the SHA1 of their 
> content, those IDs are totally random.  So if you store objects 
> according to their sorted IDs, then the placement of objects belonging 
> to, say, the top commit will be totally random.  And since you are the 
> filesystem expert, I don't have to tell you what performance impacts 
> this random access of small segments of data scattered throughout a 
> 400MB file will have on a checkout operation.

Does git repack optimize the order so that certain things (like checkouts for example) are really fast?  I admit I hadn't noticed.  Usually until the core packs are in my page cache, it has always seemed to me that things are pretty slow.   And of course, the way objects and grouped together and ordered for "gitk" or "git log" to be fast won't be the safe as a checkout operation...

> Sure.  But I don't think it is worth making Git less flexible just for 
> the purpose of ensuring that people could independently create identical 
> packs.  I'd advocate for "no code to write at all" instead, and simply 
> have one person create and seed the reference pack.

I don't think it's a matter of making Git "less flexible", it's just simply a code maintenance headache of needing to be able to support encoding both a canonical format as well as the latest bleeding-edge, most efficient encoding format.   And how often are you changing/improving the encoding process, anyway?  It didn't seem to me like that part fo the code was constantly being tweaked/improved. 

Still, you're right, it might not be worth it.  To be honest, I was more interested about the fact that this might also be used to give people hints about how to better repack their local repositories so that they didn't have to run git repack with large --window and --depth arguments.  But that would only provide very small improvements in storage space in most cases, so it's probably not even worth it for that.

Quite frankly, I'm a little dubious about how critical peer2peer really is, for pretty much any use case.  Most of the time, I can grab the base "reference" tree and drop it on my laptop before I go off the grid and have to rely on EDGE or some other slow networking technology.  And if the use case is some small, but illegal-in-some-jurisdiction code, such as ebook DRM liberation scripts (the kind which today are typically distributed via pastebin's :-), my guess is that zipping up a git repository and dropping it on a standard bittorrent server run by the Swedish Pirate party is going to be much more effective.   :-)

-- Ted
