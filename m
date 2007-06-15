From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: Feature request: thin checkout
Date: Fri, 15 Jun 2007 11:49:00 +0200
Message-ID: <4672608C.7090908@dawes.za.net>
References: <20070615085346.8027.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: linux@horizon.com
X-From: git-owner@vger.kernel.org Fri Jun 15 11:49:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz8R0-0003ht-5e
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 11:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbXFOJth (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 05:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbXFOJth
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 05:49:37 -0400
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:48782 "EHLO
	spunkymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751324AbXFOJtg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jun 2007 05:49:36 -0400
Received: from [192.168.201.100] (dsl-146-24-147.telkomadsl.co.za [165.146.24.147])
	by spunkymail-a1.g.dreamhost.com (Postfix) with ESMTP id 5C4BAFFC5E;
	Fri, 15 Jun 2007 02:49:34 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
In-Reply-To: <20070615085346.8027.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50256>

linux@horizon.com wrote:
> Git packs so well that it's very common for the unpacked source to be much
> larger than the history in .git.  The linux-kernel archive is a prime example.
> 
> I've also started using git-svn (awesome tool, BTW) and have discovered
> the impressive disk space costs associated with SVN's tags/ directories
> if I actually want to download the full history.
> 
> If you have multiple cloned repositories on one system, git can share
> the history, but the working directory problem is exacerbated.
> (Disk is cheap, but the RAM to cache it is limited.)
> 
> This got me thinking...
> Wouldn't it be nice if there were a way to tell git-update-index and
> git-checkout index that certain directories are not in the working
> directory, but don't worry.  Just pretend they exist and match the index.
> 

I think that update-index is able to do (some of) this already:

$ man git-update-index

SYNOPSIS
        git-update-index

                     [--cacheinfo <mode> <object> <file>]*


        --cacheinfo <mode> <object> <path>
               Directly insert the specified info into the index.


USING --CACHEINFO OR --INFO-ONLY
        --cacheinfo is used to register a file that is not in the current
        working directory. This is useful for minimum-checkout merging.

        To pretend you have a file with mode and sha1 at path, say:

        $ git-update-index --cacheinfo mode sha1 path
        --info-only is used to register files without placing them in the
        object database. This is useful for status-only repositories.

        Both --cacheinfo and --info-only behave similarly: the index is 
updated
        but the object database isn't. --cacheinfo is useful when the 
object is
        in the database but the file isn't available locally. --info-only is
        useful when the file is available, but you do not wish to update the
        object database.

At any rate, it looks like some of the infrastructure is existing 
already, even if the complete solution doesn't exist.

I *guess* it might even be as simple as maintaining a list of 
"uncheckedout files with mode and sha" in the .git directory, and 
merging that with what has actually been checked out when updating the 
index.

i.e.

$ git checkout master:src/drivers

Get the <tree> object for master. Step through each entry. If the 
requested path falls under the entry, recurse into it, checking out the 
required files, otherwise write the <tree/file> info into 
.git/partialcheckout.

Hack, hack, hack in src/drivers.

When you want to check what part of the tree is dirty, check if 
.git/partialcheckouts exists. If it does, read through each entry, 
comparing them to the index. Then, for the entries that are not in 
partialcheckout, but are in the index, actually go to the filesystem to 
check stat for each file.

Not quite sure how to handle something like:

$ git checkout master:src/drivers/scsi
$ git checkout master:src/drivers/usb

I guess one would have to trim entries from .git/partialcheckout as they 
are actually fully checked out.

Rogan
