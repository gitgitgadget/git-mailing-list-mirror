From: Morgan Christiansson <git@mog.se>
Subject: Re: git-svn: File was not found in commit
Date: Mon, 12 Jan 2009 14:45:35 +0100
Message-ID: <496B497F.30109@mog.se>
References: <49678705.4040506@mog.se> <20090111215526.GA15533@atjola.homenet> <496A890C.8080208@mog.se> <20090112023211.GA21462@dcvr.yhbt.net> <20090112051409.GB14992@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020303050704090507080107"
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jan 12 14:47:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMN8K-0002Ub-QD
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 14:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbZALNpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 08:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbZALNpt
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 08:45:49 -0500
Received: from mog.vm.bytemark.co.uk ([80.68.94.200]:49663 "EHLO mog.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690AbZALNps (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 08:45:48 -0500
Received: from [192.168.1.182] (81-226-238-170-no61.tbcn.telia.com [81.226.238.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mog.se (Postfix) with ESMTP id 24DD580CC4;
	Mon, 12 Jan 2009 13:45:46 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.18 (X11/20081125)
In-Reply-To: <20090112051409.GB14992@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105343>

This is a multi-part message in MIME format.
--------------020303050704090507080107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Eric Wong wrote:
> Eric Wong <normalperson@yhbt.net> wrote:
>   
>> Morgan Christiansson <git@mog.se> wrote:
>>     
>>> The "Ignoring path" message appears to be coming from git which is  
>>> refusing to commit the .git directory. Which leads to git-svn being  
>>> unaware of the files being ignored and giving an error when it can't  
>>> find them.
>>>       
>>> I'm personally fine with these files being ignored by git, but git-svn  
>>> needs to be aware that they are not added to the repository.
>>>       
>> Hi Morgan,
>> Can you try the following rough patch and see it it fixes things
>> for you?  Thanks!
>>     
>
> Actually, I think this patch is broken (my quickly put together test
> case was insufficient)...
>   

Yes it was. apply_textdelta() is never called for my repo so it has no 
effect.

I've attached an updated and simplified version of the testcase you sent 
that correctly triggers the bug i reported.

I'm not a native perl coder though so I don't think I would be able to 
provide a clean fix for this. But I've traced through enough of the 
program to see that the .git directories should be filtered out as early 
as possible to mimick the behaviour of git.

get_log() has a callback as it's last argument which gets called once 
per commit, nesting this callback in a new callback which filters the 
illegal paths out would work.

Also in gs_do_fetch_loop_common() after get_log() and before 
do_git_commit() it's possible to filter them.

Regards,
Morgan

--------------020303050704090507080107
Content-Type: application/x-sh;
 name="t9133-git-svn-nested-git-repo.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="t9133-git-svn-nested-git-repo.sh"

#!/bin/sh
#
# Copyright (c) 2009 Eric Wong
#

test_description='git svn property tests'
. ./lib-git-svn.sh

test_expect_success 'setup SVN repo with a file added & modified inside a .git dir' '
	svn co "$svnrepo" s &&
	(
		cd s &&
		mkdir .git &&
		touch .git/a &&
		svn add .git &&
		svn commit -m "add .git/a file" &&
		echo a >> .git/a &&
		svn commit -m "modify .git/a file"
	)
'


test_expect_success 'clone SVN repo containing a .git directory' '
	git svn clone "$svnrepo" g
'

test_done


--------------020303050704090507080107--
