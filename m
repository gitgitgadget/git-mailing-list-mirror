From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: tree corrupted on disk quota full
Date: Thu, 11 Jan 2007 13:43:30 +0000
Message-ID: <45A63F02.5010600@shadowen.org>
References: <20070111125726.GJ1759@mellanox.co.il> <45A63E59.7030009@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 14:43:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H50Dl-0004jU-3E
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 14:43:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030443AbXAKNnz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 08:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030444AbXAKNny
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 08:43:54 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:3032 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030443AbXAKNny (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 08:43:54 -0500
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1H50CS-0006OT-I5; Thu, 11 Jan 2007 13:42:36 +0000
User-Agent: Icedove 1.5.0.9 (X11/20061220)
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <45A63E59.7030009@op5.se>
X-Enigmail-Version: 0.94.1.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36590>

Andreas Ericsson wrote:
> Michael S. Tsirkin wrote:
>> I hit a quota limit on a disk my tree was on, but did not notice.
>> Doing git pull on a tree seems to have corrupted it.
>> Now I have:
>>
>> $ git-fsck-objects
>> error: 4d4d30be967d3284cbf59afd4fba6ab536e295f5: object not found
>> error: c03590b581d51d5fa43adbef9415e935d0229412: object not found
>> missing tree 10147d79b2418168d9433067b6439971bd4f1261
>> broken link from  commit 322a6c93ad86d2a151dd97a4c6b0e014a4893437
>>               to    tree 10147d79b2418168d9433067b6439971bd4f1261
>> dangling commit 322a6c93ad86d2a151dd97a4c6b0e014a4893437
>>
>> The tree can not be pulled into, or from.
>>
> 
> Can you do a "git rev-list" on the commit pointing to this tree? If so,
> you should be able to do "git reset HEAD~1" and re-do the fetch.
> 
> Otoh, this is curious. Aren't tree- and blob-objects written to disk
> before the commit object pointing to them? If not, how can we claim to
> support atomic commits? I imagined things were written in this order
> 
>     blob -> tree -> commit
> 
> seeing as the dependency chain goes the other way.
> 
> "git repair" could easily be cooked up by finding the first complete
> commit and resetting current HEAD and all branches pointing to it to
> that first complete commit. Issuing a fresh "fetch" after that should
> automagically fix everything for you.

Well we do have some dubious code which can fail in the face of short
writes when the disk is full.  Those I believe are now plugged following
my short i/o series which is in master as far as I know.

I wonder if we can cook up a test with a loop back mount on a tiny ramfs
that will fail in this way.

-apw
