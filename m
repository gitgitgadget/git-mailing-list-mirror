From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 13:23:14 -0700
Message-ID: <42C454B2.6090307@zytor.com>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org> <Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 22:18:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do5UP-0001bC-IP
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 22:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbVF3UZX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 16:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbVF3UYf
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 16:24:35 -0400
Received: from terminus.zytor.com ([209.128.68.124]:1964 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263107AbVF3UYF
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 16:24:05 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j5UKNJcM018340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 30 Jun 2005 13:23:21 -0700
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> It won't _really_ solve the problem, since the pushed pack objects will
> grow at a proportional rate to the current objects - it's just a constant
> factor (admittedly a potentially fairly _big_ constant factor)  
> improvement both in size and in number of files.
> 

If I've understood this correctly, it's not a constant factor 
improvement in the number of files (in the size, yes); it's changing it 
from O(t*c) to O(t) where t is number of trees and c is number of 
changesets.  That's key.

The problem we're having (on kernel.org) right now is that there isn't a 
hierarchial time stamp in Unix, so we have to compare on a file-by-file 
level.  rsync is quite good at discovering an invariant beginning of a 
file, but when it comes to a mass of files it has to compare the stamps 
on each and every one, each time.  It will only descend into a single 
file, however, if that file has had its timestamp changed.

For the purposes of rsync, storing the objects in a single append-only 
file would be a very efficient method, since the rsync algorithm will 
quickly discover an invariant head and only transmit the tail.  It's not 
ideal, and having something git-aware would be better, but I think it's 
really would be nice to have something which also plays well with rsync. 
  There is a *lot* of infrastructure in rsync which is actually hard to 
replicate with another tool (including the server architecture); in many 
ways it would be easier to convince the rsync developers to create a 
plugin architecture and re-use all that code rather than developing an 
equivalent tool from scratch.

	-hpa
