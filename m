From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] safecrlf: Add flag to convert_to_git() to disable safecrlf check
Date: Tue, 15 Jan 2008 21:52:53 +0100
Message-ID: <F825ADAF-036C-46FE-8E3D-540B9AA092A8@zib.de>
References: <004D2FB5-2CEA-4DB1-AF8D-D5ADEB0F0508@zib.de> <12003528401309-git-send-email-prohaska@zib.de> <7vk5mchsct.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: dpotapov@gmail.com, torvalds@linux-foundation.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 21:54:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEsnS-0001XK-Tw
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 21:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757784AbYAOUxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 15:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757726AbYAOUxG
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 15:53:06 -0500
Received: from mailer.zib.de ([130.73.108.11]:45819 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757727AbYAOUxE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 15:53:04 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0FKpsvQ015915;
	Tue, 15 Jan 2008 21:51:54 +0100 (CET)
Received: from [192.168.178.21] (brln-4db83608.pool.einsundeins.de [77.184.54.8])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0FKpm86024024
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 15 Jan 2008 21:51:48 +0100 (MET)
In-Reply-To: <7vk5mchsct.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70558>


On Jan 15, 2008, at 12:58 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> We want to verify if an autocrlf conversion is reversible only if
>> the converted data is actually written to the repository.  Only
>> in this case the file would be modified during the next checkout.
>> But convert_to_git() is used for some other purposes.
>> This commit adds a flag to convert_to_git() that controls if the
>> safecrlf check is enabled...
>
> At first this felt dirty to me as convert_to_git() is not
> limited to crlf, but about external vs canonical representation.
> The variable name being "checksafe" however makes it much more
> palatable.  It is clear that it is talking about irreversible
> conversion.
>
> When running diff with a work tree file and the index (or a
> named tree), we read the work tree file and run convert_to_git()
> on it before comparing it with what we have in the object store
> (either index or a named tree).  When running apply without
> touching the index, we also use convert_to_git() on the work
> tree file.  The patch file is supposed to record the data in
> canonical format, I think.
>
> Of course, "git add" on the path will warn or fail with your
> patch, but we may somehow want to be warned about the breakage
> before "git add" on that path triggers it.  Perhaps we can have
> a separate "check-work-tree" command that iterates over locally
> modified work tree files and runs convert_to_git() with checking
> enabled.

We could certainly have such a command, yet the question remains
when to call it.  Do you have in mind calling it when we enter
the work tree, such that all files in the work tree will always
be verified?  Running the check once during start up should be
sufficient and we could switch it off for the remainder of the
execution.

We would certainly print all paths with an irreversible conversion
and only die() afterwards if requested by core.safecrlf=true.
All information would be printed at once in an ordered way.  This
could be more user friendly than the current approach.

I'll work on this.

	Steffen
