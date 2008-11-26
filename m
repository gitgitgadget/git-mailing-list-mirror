From: Jeff Mitchell <kde-dev@emailgoeshere.com>
Subject: Problem deleting remote branches
Date: Tue, 25 Nov 2008 23:04:39 -0500
Message-ID: <492CCAD7.5000807@emailgoeshere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 05:13:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5BmX-0002MN-F3
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 05:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbYKZELO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 23:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbYKZELO
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 23:11:14 -0500
Received: from qmta08.westchester.pa.mail.comcast.net ([76.96.62.80]:53264
	"EHLO QMTA08.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751494AbYKZELN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2008 23:11:13 -0500
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Nov 2008 23:11:12 EST
Received: from OMTA01.westchester.pa.mail.comcast.net ([76.96.62.11])
	by QMTA08.westchester.pa.mail.comcast.net with comcast
	id jfgh1a00L0EZKEL58g4jYX; Wed, 26 Nov 2008 04:04:44 +0000
Received: from bookcase.emailgoeshere.com ([75.150.71.53])
	by OMTA01.westchester.pa.mail.comcast.net with comcast
	id jg4h1a00718yM6K3Mg4hGs; Wed, 26 Nov 2008 04:04:42 +0000
X-Authority-Analysis: v=1.0 c=1 a=74_OhrOYAAAA:8 a=EV2SLBx42_6--u_Vd04A:9
 a=_3cSPdLdMlkXtlweDCMA:7 a=lzl3UZvb8BF8zdJjoFGu7OQ2-SYA:4 a=FuQyZJJIGNYA:10
 a=w-OOvZ7n2QUA:10 a=CWfAmLVWKswA:10
Received: from localhost (bookcase.emailgoeshere.com [127.0.0.1])
	by bookcase.emailgoeshere.com (Postfix) with ESMTP id 482C5103058C
	for <git@vger.kernel.org>; Wed, 26 Nov 2008 04:04:41 +0000 (UTC)
X-Virus-Scanned: on 20080629 by amavisd-new using ClamAV at emailgoeshere.com
Received: from bookcase.emailgoeshere.com ([127.0.0.1])
	by localhost (bookcase.emailgoeshere.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2sLM5Hi61bjb for <git@vger.kernel.org>;
	Wed, 26 Nov 2008 04:04:39 +0000 (UTC)
Received: from [192.168.8.5] (macncheese.emailgoeshere.com [192.168.8.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bookcase.emailgoeshere.com (Postfix) with ESMTPSA id 2AB63B03480
	for <git@vger.kernel.org>; Wed, 26 Nov 2008 04:04:38 +0000 (UTC)
User-Agent: Thunderbird 2.0.0.18 (X11/20081124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101701>

I'm running into a problem where it seems that you can't delete branches
from a remote WebDAV/HTTP repository (at least, not using the methods
you would use for a git protocol-based repo).  It seems to be looking
for the wrong ref head.


Here's a log of running the commands against github, using the native
git protocol:

$ git checkout --track -b gittest jefferai
Branch gittest set up to track local branch refs/heads/jefferai.
Switched to a new branch "gittest"

$ git push origin gittest
Total 0 (delta 0), reused 0 (delta 0)
To git@github.com:jefferai/portage.git
 * [new branch]      gittest -> gittest

$ git checkout jefferai
Switched to branch "jefferai"

$ git branch -d -r origin/gittest
Deleted remote branch origin/gittest.

$ git push origin :gittest
To git@github.com:jefferai/portage.git
 - [deleted]         gittest


Here's the same (near as I could get it) commands against my http-based
server.  Note that because of some other weirdness, I delete the local
branch that I push up, then re-fetch it as a remote tracking branch,
then try to do the delete:

$ git checkout --track -b gittest jefferai
Branch gittest set up to track local branch refs/heads/jefferai.         
Switched to a new branch "gittest"                                       

$ git push myremote gittest
Fetching remote heads...                             
  refs/                                              
  refs/tags/                                         
  refs/heads/                                        
updating 'refs/heads/gittest'                        
  from 0000000000000000000000000000000000000000      
  to   a4641f663ae86739b623a4b5bba7b284e5999549      
                               
done                       
Updating remote server info                         

$ git checkout jefferai
Switched to branch "jefferai"

$ git branch -d gittest
Deleted branch gittest.                               

$ git fetch myremote
From https://[my,server.com]/amarok                  
 * [new branch]      gittest    -> myremote/gittest        

$ git checkout --track -b gittest myremote/gittest
Branch gittest set up to track remote branch refs/remotes/myremote/gittest.
Switched to a new branch "gittest"

$ git checkout jefferai
Switched to branch "jefferai"

$ git branch -r -d myremote/gittest
Deleted branch gittest.

$ git push myremote :gittest
Fetching remote heads...
  refs/
  refs/tags/
  refs/heads/
fatal: Couldn't get https://[my.server.com]/amarok.git/refs/heads/master
for remote symref
The requested URL returned error: 404
error: failed to push some refs to 'https://[my.server.com]/amarok.git'


Note the third to last line:

Couldn't get https://[my.server.com]/amarok.git/refs/heads/master

On my webserver, in the repository, I have the following in refs/heads:

bookcase amarok.git # ls refs/heads/
gittest  jefferai


I do have a "master" branch -- that's where the "jefferai" branch was
spawned from, which the "gittest" branch was spawned from -- but I have
no idea why it's looking for it.


My remote ref for github looks like:

[remote "origin"]
        url = git@github.com:jefferai/portage.git
        fetch = +refs/heads/*:refs/remotes/origin/*

and my remote ref for my server looks like:

[remote "myremote"]
        url = https://[my.server.com]/amarok.git
        fetch = +refs/heads/*:refs/remotes/myremote/*


This smells like a bug, unless there's something I'm doing wrong that I
can't figure out.

Help much appreciated.

Thanks,
Jeff
