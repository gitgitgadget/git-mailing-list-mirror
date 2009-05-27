From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Problem with large files on different OSes
Date: Wed, 27 May 2009 09:30:18 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905270922250.3435@localhost.localdomain>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk> <m3y6siboij.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christopher Jefferson <caj@cs.st-andrews.ac.uk>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 27 18:31:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9M1s-0003Db-S2
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 18:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759449AbZE0Qat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 12:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758522AbZE0Qas
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 12:30:48 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46428 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758701AbZE0Qar (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2009 12:30:47 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4RGUJeO016511
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 May 2009 09:30:20 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4RGUIKO001831;
	Wed, 27 May 2009 09:30:19 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <m3y6siboij.fsf@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120076>



On Wed, 27 May 2009, Jakub Narebski wrote:
> 
> Do seting `pack.packSizeLimit`, or adjusting values of
> `core.packedGitWindowSize` and/or `core.packedGitLimit`
> (see git-config(1)) help in your situation?

No, that will help just the packfile mmap (and even there, it won't help 
with things like index file size - we'll always mmap the whole index 
file). It's definitely worth doing, though - but I think we already 
default to 32MB pack-file windows on 32-bit architectures.

Individual files we always handle in one go. It's what git was designed 
for, after all - fairly small files. And so git is limited to files 
smaller than the virtual address space.

On a 32-bit setup, that often limits you to roughly a gigabyte. You have 
4GB of virtual address space, of which one or two is used for the OS 
kernel. So say you have 2GB for user mode - you then have the executable 
mapping and libraries and stack, all spread out in that 2GB virtual 
address space.

In fact, even if it's 3GB for user (I don't know what OS X does), getting 
one contiguous area may well be limited to ~1GB depending on layout of 
shared library mappings etc VM fragmentation. Older Linux systems tended 
to map things in ways that made it hard to get more than 1GB of contiguous 
data mapping if you compiled with dynamic libraries.

64-bit mostly makes this a non-issue.

In fact, if you do "diff", you're going to be even _more_ limited, since 
for simplicity, our version of xdiff really wants both sources in memory 
at a time. So you can't really diff >500MB files. Not that you generally 
want to, of course.

I'll see if I can make us handle the "big file without diff" case better 
by chunking.

		Linus
