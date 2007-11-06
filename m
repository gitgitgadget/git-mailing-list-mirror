From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC PATCH] Reduce the number of connects when fetching
Date: Tue, 06 Nov 2007 09:13:12 +0100
Message-ID: <47302218.3060409@viscovery.net>
References: <Pine.LNX.4.64.0711041614390.7357@iabervon.org> <7v1wb4kuoc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 09:13:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpJZ0-0001F2-FP
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 09:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466AbXKFINT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 03:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754651AbXKFINT
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 03:13:19 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:38290 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754437AbXKFINS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 03:13:18 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IpJYE-0007vY-IX; Tue, 06 Nov 2007 09:12:46 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E18CB54D; Tue,  6 Nov 2007 09:13:12 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7v1wb4kuoc.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63639>

Junio C Hamano schrieb:
> Daniel Barkalow <barkalow@iabervon.org> writes:
>> ... In particular, I don't know if there's a way to have the 
>> connection end up in a state where objects for more refs can be requested 
>> after some refs have been requested and the resulting objects read.
> 
> The upload-pack protocol goes "S: here are what I have, C: I
> want these, C: I have these, S: ok, continue, C: I have these,
> S: ok, continue, C: I have these, S: ok, I've heard enough, C:
> done, S: packfile is here", so after packfile generation starts
> there is nothing further the downloader can say.
> 
> Otherwise you would be able to do the tag following using the
> same connection, but that is unfortunately not a case.

How about:

S: here are what I have
C: I want these
C: want tags   <-- new
C: I have these
S: ok, continue
C: I have these
S: ok, continue
C: I have these
S: ok, these are the tags  <-- new
S: I've heard enough
C: done
S: packfile is here

The tags that the server provides are those (and only those[*]) that 
reference objects in the packfile that it's going to send.

[*] This way the client doesn't have to figure out which tags it wants; as a 
side-effect it won't accidentally fetch tags for objects that it happens to 
have in the repository, but aren't reachable from any ref (like what used to 
happen).

-- Hannes
