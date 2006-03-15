From: Andreas Ericsson <ae@op5.se>
Subject: Re: seperate commits for objects already updated in index?
Date: Wed, 15 Mar 2006 15:00:30 +0100
Message-ID: <44181DFE.7080204@op5.se>
References: <Pine.LNX.4.64.0603141634010.5276@sheen.jakma.org>	<Pine.LNX.4.64.0603140856120.3618@g5.osdl.org>	<Pine.LNX.4.64.0603141703080.5276@sheen.jakma.org>	<Pine.LNX.4.64.0603140915290.3618@g5.osdl.org>	<7vwtewk2jp.fsf@assigned-by-dhcp.cox.net> <7vy7zcie5c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Jakma <paul@clubi.ie>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Mar 15 15:00:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJWYO-00054U-5H
	for gcvg-git@gmane.org; Wed, 15 Mar 2006 15:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWCOOAc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Mar 2006 09:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWCOOAc
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Mar 2006 09:00:32 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:59597 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751271AbWCOOAb
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Mar 2006 09:00:31 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 6D4B06BD32; Wed, 15 Mar 2006 15:00:30 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7zcie5c.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17609>

Junio C Hamano wrote:
> The background behind this is around beginning of February 2006,
> the thread "Two ideas" by Carl Worth.  And the current behaviour
> is defined by this commit.  I'll talk about a possible
> improvement but first, here is what it does:
> 
> commit 130fcca63fe8e7e087e7419907e018cbbaf434a3
> Author: Junio C Hamano <junkio@cox.net>
> Date:   Sun Feb 5 00:07:44 2006 -0800
> 
>     
>        2. refuses to run if named paths... are different in HEAD and
>           the index (ditto about reminding).  Added paths are OK.
>     
> 
> The check that prevents you from doing
> 
> 	$ edit A B
> 	$ git update-index A B
>         $ git commit -o B
> 
> is the rule #2, which I think could use further improvement.  It
> is to address the "committing skewed files" issue Carl brought
> up in that thread.
> 
> It might be better to further check if the working tree file is
> the same as the index, and to allow a commit in such a case.
> 
> The intent of rule #2 is to prevent this from happening:
> 
> 	$ edit A B
>         $ git update-index A B
>         $ edit B again
>         $ git commit -o B
> 
> When this happens, the real index will have _old_ contents of B
> that never was committed, and does not match what is in the
> index.  But after the commit, we will match the real index to
> what was committed, so we will _lose_ the index entry for B
> before the second edit you explicitly told git to remember by
> saying 'update-index'.
> 

Can't this be done by updating .git/index first and then use the 
temporary index to commit? Then .git/index would match the current tree 
and everybody would be happy with very little tweaking. Doing the 
temporary index commit first could cause data-loss as described above if 
the updating of .git/index somehow fails and the user is unaware of it 
(or what to do to fix it).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
