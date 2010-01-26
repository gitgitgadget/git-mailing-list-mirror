From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4] Threaded grep
Date: Tue, 26 Jan 2010 07:28:41 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001260728260.3574@localhost.localdomain>
References: <20100125225139.GA3048@fredrik-laptop>  <alpine.LFD.2.00.1001251542100.3574@localhost.localdomain> <4c8ef71001260410l2afd2dbx17b6e216bd9e5d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 16:30:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZnMl-0000qr-T1
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 16:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547Ab0AZPaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 10:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752477Ab0AZPaA
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 10:30:00 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46949 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752140Ab0AZP37 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jan 2010 10:29:59 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0QFSgaS024864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Jan 2010 07:28:43 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0QFSfA3000653;
	Tue, 26 Jan 2010 07:28:41 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4c8ef71001260410l2afd2dbx17b6e216bd9e5d8@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.946 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138040>


On Tue, 26 Jan 2010, Fredrik Kuivinen wrote:
> 
> I see the strlen in my profiles as well, but I haven't figured out
> where it comes from.

Looks like this in gdb:

#0  0x0000003e3687f2e0 in __strlen_sse2 () from /lib64/libc.so.6
#1  0x0000003e368c04c5 in regexec@@GLIBC_2.3.4 () from /lib64/libc.so.6
#2  0x000000000047677a in look_ahead (opt=<value optimized out>, 
    name=<value optimized out>, buf=<value optimized out>, 
    size=<value optimized out>, collect_hits=<value optimized out>)
    at grep.c:679
#3  grep_buffer_1 (opt=<value optimized out>, name=<value optimized out>, 
    buf=<value optimized out>, size=<value optimized out>, 
    collect_hits=<value optimized out>) at grep.c:790

so it's sadly internal to regex. It would be nice if there was a 
non-string interface to regexec (ie a "buffer + length" instead of a 
NUL-terminated string).

> If I use perf record -g I get

I suspect that libc isn't compiled with frame pointers, so call chains end 
up being unreliable.

		Linus
