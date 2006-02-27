From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] First cut at libifying revlist generation
Date: Sun, 26 Feb 2006 19:19:13 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602261914270.22647@g5.osdl.org>
References: <Pine.LNX.4.64.0602251608160.22647@g5.osdl.org>
 <7vpsl93395.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 27 04:19:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDYv8-0007El-3N
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 04:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWB0DTX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 22:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWB0DTX
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 22:19:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32398 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750849AbWB0DTX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 22:19:23 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1R3JIDZ026709
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Feb 2006 19:19:19 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1R3JDTS004580;
	Sun, 26 Feb 2006 19:19:16 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsl93395.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16824>



On Sun, 26 Feb 2006, Junio C Hamano wrote:
> 
> I am clueless about the "limited = (list && list->next)" part,
> but there is only one commit involved hence the test is false
> with my testcase "git-rev-list --objects v1.0.0^0..v1.0.0"; I
> think the old code said dotdot is a limited case.

dotdot should insert _two_ commits onto the list - the positive and 
the negative one.  Doesn't it? 

So the

	if (list && list->next)

check should be correct. If we have just one entry, there's no reason to 
do everything up-front, we can just run with it (and get the nice 
streaming behaviour).

> -static struct object_list *pending_objects = NULL;
> -
> -	for (pending = pending_objects; pending; pending = pending->next) {
> +	for (pending = revs.pending_objects; pending; pending = pending->next) {

But this part is obviously correct. I already sent out the same patch a 
minute ago ;)

> -	if (revs.max_age || revs.min_age)
> +	if (revs.max_age != -1 || revs.min_age != -1)

As is this. I for a while had zero meaning "no age", and I actually think 
it probably should be that way, but then we'd have to switch the 
date-related functions around, which is why I decided not to do it after 
all (but missed this one that I had already written for that case).

		Linus
