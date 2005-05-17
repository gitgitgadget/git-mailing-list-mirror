From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Make object contents optionally available
Date: Tue, 17 May 2005 08:29:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505170826061.18337@ppc970.osdl.org>
References: <Pine.LNX.4.21.0505170049480.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 17 17:30:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY407-0006mQ-Fj
	for gcvg-git@gmane.org; Tue, 17 May 2005 17:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVEQP2n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 11:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVEQP2m
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 11:28:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:62110 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261631AbVEQP1n (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 11:27:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4HFRYU3002654
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 May 2005 08:27:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4HFRX7r005154;
	Tue, 17 May 2005 08:27:33 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505170049480.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.39__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 17 May 2005, Daniel Barkalow wrote:
>
> This adds contents and size fields to struct object. If unpack_object is
> called on an object, it will fill in the contents field with the complete
> raw contents of the object. If free_object_contents is called on an
> object, the contents will be freed. If contents is filled when an object
> is parsed, it is not unpacked an extra time, but the contents are not
> retained if they were not unpacked before parsing.

I really hate magic interfaces like that. It's just a bug waiting to 
happen.

I'd actually prefer it if "parse_object()" just always unpacks it, and 
leaves the unpacked thing in memory. 

Then, the _few_ programs that really care about memory use because they
parse potentially millions of objects (especially blobs, which obviously
can be very large) can be updated to just do a manual
"free_object_contents()". That's primarily things like fsck and
convert-cache, I suspect.

That would leave a lot less special cases and strange rules..

		Linus
