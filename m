X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Sun, 10 Dec 2006 10:16:40 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612101009040.12500@woody.osdl.org>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 10 Dec 2006 18:16:59 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33912>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtTEO-0001Ui-PT for gcvg-git@gmane.org; Sun, 10 Dec
 2006 19:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762298AbWLJSQv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 13:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762327AbWLJSQv
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 13:16:51 -0500
Received: from smtp.osdl.org ([65.172.181.25]:45820 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1762298AbWLJSQu
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 13:16:50 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBAIGgID010902
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 10
 Dec 2006 10:16:43 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBAIGeVL031246; Sun, 10 Dec
 2006 10:16:41 -0800
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org



On Sun, 10 Dec 2006, Marco Costalba wrote:
> 
> The averaged results on linux tree (about 30MB of data) and CPU set at
> 1.2GHz are:
> 
> - QProcess 6734ms
> 
> - pipe and fread() with 64KB blocks 4832ms (38% faster then QProcess)
> 
> - temporary file and read() with 64KB blocks 4321ms (10% faster then pipe)
> 
> I have not enough knowledge to understand why temporary file is faster
> then pipe. My guess is, after reading some docs around, fread() uses a
> C standard I/O buffer, while read() is unbuffered.

Why don't you use the pipe and standard read()?

Even if you use "popen()" and get a "FILE *" back, you can still do

	int fd = fileno(file);

and use the raw IO capabilities.

The thing is, temporary files can actually be faster under Linux just 
because the Linux page-cache simply kicks ass. But it's not going to be 
_that_ big of a difference, and you need all that crazy "wait for rev-list 
to finish" and the "clean up temp-file on errors" etc crap, so there's no 
way it's a better solution.

If it really is stdio overhead (possibly locking), using "fileno()" and 
the raw unistd.h interfaces is going to avoid it.

(You still need to use "fclose()" to close the struct file afterwards, 
otherwise you'll leak memory, so you shouldn't _forget_ the original 
"struct FILE *", but you don't need to use it for anything else).

Using popen() and pipes also means that if the parent dies, the child will 
get a nice EPIPE on the writing side, which is what you want.

