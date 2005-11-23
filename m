From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-mv is not able to handle directory with one file in it
Date: Wed, 23 Nov 2005 08:57:00 +0100
Message-ID: <438420CC.4050303@op5.se>
References: <200511231141.57683.lan@ac-sw.com> <7voe4b7uw7.fsf@assigned-by-dhcp.cox.net> <200511231326.27972.lan@ac-sw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 23 08:58:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EepV7-0001vB-3E
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 08:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbVKWH5F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 02:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030353AbVKWH5F
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 02:57:05 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:15246 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030354AbVKWH5B
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 02:57:01 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 956DD6BCBE
	for <git@vger.kernel.org>; Wed, 23 Nov 2005 08:57:00 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <200511231326.27972.lan@ac-sw.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12612>

Alexander Litvinov wrote:
> I have found one error during directory movig: If I move directory with one 
> file somewhere in it this script will try to add target directory instead of 
> file.

Are you saying this setup
	foodir/somefile.c     <--file
	newdir/               <--directory

with this command
	git-mv foodir/ newdir

tries to create
	newdir/foodir/somefile.c  <-- directory

or does it create
	newdir/somefile.c         <-- file

?

It should create
	newdir/foodir/somefile.c  <-- file

Otherwise it's misbehaving.

Try running it with the -v switch to make it shout out loud what it's 
trying to do, and then paste the output here.

> Commenting lines starting from 190 solve this error. But I don't 
> understand what is the logic behind this case ? Why do target directory 
> checked instead of target file ? Should we replace $dst my $destfiles[0] ?
> 
> at line 190 in git-mv:
>     if (scalar @srcfiles == 1) {
> 	if ($overwritten{$dst} ==1) {
> 	    push @changedfiles, $dst;
> 	} else {
> 	    push @addedfiles, $dst;
> 	}
>     }
>     else {
> 	push @addedfiles, @dstfiles;
>     }

This is broken. It only checks if there's just one source-file 
regardless of whether or not it resided in a subdirectory. I'm not 
exactly fluent in perl so I can't submit a patch, but the src option 
needs to be directory aware, traverse all source directories and then 
move the files axing everything but the bottom-most dirname to the 
destination directory.

Any takers?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
