From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: fatal: serious inflate inconsistency
Date: Fri, 8 Jun 2007 11:52:14 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706081136480.4205@woody.linux-foundation.org>
References: <20070608110536.GD2335@cip.informatik.uni-erlangen.de>
 <alpine.LFD.0.99.0706080931330.12885@xanadu.home>
 <20070608135054.GK2335@cip.informatik.uni-erlangen.de>
 <20070608153722.GL2335@cip.informatik.uni-erlangen.de>
 <alpine.LFD.0.98.0706080959570.4205@woody.linux-foundation.org>
 <20070608182412.GQ2335@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, GIT <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Fri Jun 08 20:53:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwjaJ-00070e-AS
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 20:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031806AbXFHSxJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 14:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031801AbXFHSxI
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 14:53:08 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35035 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031073AbXFHSxE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2007 14:53:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l58IqbfG003131
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 Jun 2007 11:52:38 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l58IqEOc008526;
	Fri, 8 Jun 2007 11:52:23 -0700
In-Reply-To: <20070608182412.GQ2335@cip.informatik.uni-erlangen.de>
Received-SPF: neutral (207.189.120.55 is neither permitted nor denied by domain of torvalds@linux-foundation.org)
X-Spam-Status: No, hits=-2.749 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.180 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49493>



On Fri, 8 Jun 2007, Thomas Glanzmann wrote:
>
>         fatal: serious inflate inconsistency: -3 (invalid distance too far back)

Whee. That's Z_DATA_ERROR, and yeah, I think the only thing that causes it 
is a corrupt zlib input stream.

> I talked to Michael and he is certain that the machine has a memory
> corruption the next thing I am going to do is compiling a kernel in an
> endless loop. Again if somone needs shell access just send me your ssh
> key.

I'd not expect memory corruption to be that *repeatable*. But the message 
certainly implies zlib data stream corruption _somewhere_, although the 
fact that it seems to be so repeatable does make me suspect program error.

Of course, it could be a hard bit-error in memory, but even then it would 
kind of have to hit the same page allocation history each time to be 
repeatable. And the page cache is the only thing that is that sticky under 
Linux, so it would have to be something like the zlib static data or code 
that had hit the memory corruption.

Sounds strange. I wonder if we might have finally hit a case of different 
versions of zlib acting differently?

But it _could_ just be a git bug too.

I don't think it's on the kernel.org side (or we would have had more 
reports of this), but maybe there is some wild pointer thing inside git, 
and nobody else noticed because it depends on some specific memory 
allocation pattern (which in turn depends on things like kernel memory 
layout choices, and on libc 'malloc()' implementation etc).

I'll build with ElectricFence, and see if it says anything for me. It 
passes all the tests, but fetching the kernel is almost certainly going to 
do things that we don't test for..

			Linus
