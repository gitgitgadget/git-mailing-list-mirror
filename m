From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: restriction of pulls
Date: Fri, 09 Feb 2007 17:32:46 +0200
Message-ID: <45CC941E.9030808@dawes.za.net>
References: <200702091149.12462.duelli@melosgmbh.de> <Pine.LNX.4.63.0702091554160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christoph Duelli <duelli@melosgmbh.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 09 16:34:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFXlR-00089P-Gw
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 16:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946526AbXBIPeO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 10:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946536AbXBIPeO
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 10:34:14 -0500
Received: from sumo.dreamhost.com ([66.33.216.29]:40186 "EHLO
	sumo.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946526AbXBIPeN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 10:34:13 -0500
Received: from spunkymail-a9.g.dreamhost.com (sd-green-bigip-145.dreamhost.com [208.97.132.145])
	by sumo.dreamhost.com (Postfix) with ESMTP id E1B98277D67
	for <git@vger.kernel.org>; Fri,  9 Feb 2007 07:34:11 -0800 (PST)
Received: from [192.168.201.100] (dsl-146-24-208.telkomadsl.co.za [165.146.24.208])
	by spunkymail-a9.g.dreamhost.com (Postfix) with ESMTP id C164F20D0B;
	Fri,  9 Feb 2007 07:32:49 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
In-Reply-To: <Pine.LNX.4.63.0702091554160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39182>

Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 9 Feb 2007, Christoph Duelli wrote:
> 
>> Is it possible to restrict a chechout, clone or a later pull to some 
>> subdirectory of a repository?
> 
> No. In git, a revision really is a revision, and not a group of file 
> revisions.
> 
> Ciao,
> Dscho
> 

I thought about how this might be implemented, although I'm not entirely 
sure how efficient this will be.

One obstacle to implementing partial checkouts is that one does not know 
which objects have changed or been deleted. One way of addressing this 
is to keep a record of the hashes of all the objects that were NOT 
checked out. (If one does not check out part of a directory, simply 
store the hash of the top level, and you do not need to store the child 
hashes.) This record would be a kind of "negative index".

When deciding what to check in, or which files are modified, one would 
check the "negative index" first to see if an entry exists. If not, only 
then would you check the filesystem to see if modification times have 
changed. With the "negative index", and the files in the file system, 
one would be able to construct new commits, without any problem.

It would also require an updated transfer protocol, which would allow 
the client to specify a tag/commit, then walk the tree that it points to 
to find the portion that the client is looking for, then pull only those 
objects (and possibly their history). This is likely to be VERY 
inefficient in terms of round trips, at least initially.

This might be able to benefit from the shallow checkout support that was 
recently implemented.

Comments?

Rogan
