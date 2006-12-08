X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Rogan Dawes <discard@dawes.za.net>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Fri, 08 Dec 2006 14:57:03 +0200
Message-ID: <4579611F.5010303@dawes.za.net>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <45744FA3.7020908@zytor.com> <Pine.LNX.4.64.0612061847190.3615@woody.osdl.org> <45778AA3.7080709@zytor.com> <Pine.LNX.4.64.0612061940170.3615@woody.osdl.org> <4577A84C.3010601@zytor.com> <Pine.LNX.4.64.0612070953290.3615@woody.osdl.org> <45785697.1060001@zytor.com> <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org> <457868AA.2030605@zytor.com> <20061207193012.GA84678@dspnet.fr.eu.org> <4578722E.9030402@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 12:57:37 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4578722E.9030402@zytor.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33694>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsfHq-0001d2-Rn for gcvg-git@gmane.org; Fri, 08 Dec
 2006 13:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425500AbWLHM5I (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 07:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425499AbWLHM5H
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 07:57:07 -0500
Received: from sd-green-bigip-119.dreamhost.com ([208.97.132.119]:33117 "EHLO
 spunkymail-a1.dreamhost.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
 with ESMTP id S1425500AbWLHM5F (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8
 Dec 2006 07:57:05 -0500
Received: from [192.168.201.102] (dsl-146-24-82.telkomadsl.co.za
 [165.146.24.82]) by spunkymail-a1.dreamhost.com (Postfix) with ESMTP id
 E9FDDFEDD5; Fri,  8 Dec 2006 04:56:58 -0800 (PST)
To: "H. Peter Anvin" <hpa@zytor.com>
Sender: git-owner@vger.kernel.org

H. Peter Anvin wrote:
> Olivier Galibert wrote:
>> On Thu, Dec 07, 2006 at 11:16:58AM -0800, H. Peter Anvin wrote:
>>> Unfortunately, the most common queries are also extremely expensive.
>>
>> Do you have a top-ten of queries ?  That would be the ones to optimize
>> for.
> 
> The front page, summary page of each project, and the RSS feed for each 
> project.
> 
>     -hpa

How about extending gitweb to check to see if there already exists a 
cached version of these pages, before recreating them?

e.g. structure the temp dir in such a way that each project has a place 
for cached pages. Then, before performing expensive operations, check to 
see if a file corresponding to the requested page already exists. If it 
does, simply return the contents of the file, otherwise go ahead and 
create the page dynamically, and return it to the user. Do not create 
cached pages in gitweb dynamically.

Then, in a post-update hook, for each of the expensive pages, invoke 
something like:

# delete the cached copy of the file, to force gitweb to recreate it
rm -f $git_temp/$project/rss
# get gitweb to recreate the page appropriately
# use a tmp file to prevent gitweb from getting confused
wget -O $git_temp/$project/rss.tmp \
   http://kernel.org/gitweb.cgi?p=$project;a=rss
# move the tmp file into place
mv $git_temp/$project/rss.tmp $git_temp/$project/rss

This way, we get the exact output returned from the usual gitweb 
invocation, but we can now cache the result, and only update it when 
there is a new commit that would affect the page output.

This would also not affect those who do not wish to use this mechanism. 
If the file does not exist, gitweb.cgi will simply revert to its usual 
behaviour.

Possible complications are the content-type headers, etc, but you could 
use the -s flag to wget, and store the server headers as well in the 
file, and get the necessary headers from the file as you stream it.

i.e. read the headers looking for ones that are "interesting" 
(Content-Type, charset, expires) until you get a blank line, print out 
the interesting headers using $cgi->header(), then just dump the 
remainder of the file to the caller via stdout.

