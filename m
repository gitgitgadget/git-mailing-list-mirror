From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] pack-objects: reuse data from existing pack.
Date: Thu, 16 Feb 2006 09:32:42 +0100
Message-ID: <43F438AA.1040508@op5.se>
References: <7vd5hpm2x0.fsf@assigned-by-dhcp.cox.net> <7vbqx8m62q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 09:32:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9eZD-0003hl-Dr
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 09:32:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbWBPIco (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 03:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWBPIco
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 03:32:44 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:7827 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S932520AbWBPIcn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Feb 2006 03:32:43 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id D37346BCBE; Thu, 16 Feb 2006 09:32:42 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqx8m62q.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16284>

Junio C Hamano wrote:
> When generating a new pack, notice if we have already the wanted
> object in existing packs.  If the object has a delitified
> representation, and its base object is also what we are going to
> pack, then reuse the existing deltified representation
> unconditionally, bypassing all the expensive find_deltas() and
> try_deltas() routines.
> 
> Also, when writing out such deltified representation and
> undeltified representation, if a matching data already exists in
> an existing pack, just write it out without uncompressing &
> recompressing.
> 
> Without this patch:
> 
>     $ git-rev-list --objects v1.0.0 >RL
>     $ time git-pack-objects p <RL
> 
>     Generating pack...
>     Done counting 12233 objects.
>     Packing 12233 objects....................
>     60a88b3979df41e22d1edc3967095e897f720192
> 
>     real    0m32.751s
>     user    0m27.090s
>     sys     0m2.750s
> 
> With this patch:
> 
>     $ git-rev-list --objects v1.0.0 >RL
>     $ time ../git.junio/git-pack-objects q <RL
> 
>     Generating pack...
>     Done counting 12233 objects.
>     Packing 12233 objects.....................
>     60a88b3979df41e22d1edc3967095e897f720192
>     Total 12233, written 12233, reused 12177
> 
>     real    0m4.007s
>     user    0m3.360s
>     sys     0m0.090s
> 

Whoa! Columbus and the egg. Strange noone saw it before. It's so obvious 
when you shove it under the nose like that. :)

Now that pack-creation went from bizarrely expensive to insanely cheap 
(well, comparable to "tar czf" anyways), what's BCP for packing a public 
repository? Always one mega-pack and never worry, or should one still 
use incremental and sometimes overlapping pack-files?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
