From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Mon, 16 Jul 2007 12:58:14 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707161252330.20061@woody.linux-foundation.org>
References: 469B821E.85E5EDA9@eudaptics.com
 <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
X-From: git-owner@vger.kernel.org Mon Jul 16 21:58:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAWiL-0000Ke-7D
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 21:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755651AbXGPT6e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 15:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbXGPT6e
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 15:58:34 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39947 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754094AbXGPT6d (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 15:58:33 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6GJwKst014767
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2007 12:58:21 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6GJwEl2030533;
	Mon, 16 Jul 2007 12:58:14 -0700
In-Reply-To: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de>
X-Spam-Status: No, hits=-4.628 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52711>



On Mon, 16 Jul 2007, Thomas Glanzmann wrote:
>
> Calling unlink on a directory on a Solaris UFS filesystem as root makes it
> inconsistent. Thanks to Johannes Sixt for the obvious fix.

Ack, I think this is the right thing to do.

As pointed out, it doesn't _guarantee_ that git won't call "unlink()" on a 
directory (race conditions etc), but that's fundamentally true (there is 
no "funlink()" like there is "fstat()"), and besides, that is in no way 
git-specific (ie it's true of *any* application that gets run as root).

The theoretical race would only happen if somebody on purpose tries to 
screw things over, it would never happen under any reasonable usage. 

The old ordering of those tests was designed for sane operating systems, 
so that you could basically do the unlink() without bothering, but 
switching the order around is certainly not a disaster either, and if it 
avoids the nasty bug in Solaris it's worth doing.

I have to say that I'm still a bit shocked that Solaris would have that 
kind of behaviour. And they call that pile of sh*t "enterprise class"..

		Linus
