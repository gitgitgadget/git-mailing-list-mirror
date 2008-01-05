From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git diff -B: splitting up complete renames
Date: Sat, 5 Jan 2008 09:37:20 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801050926180.2811@woody.linux-foundation.org>
References: <200801051818.40009.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 18:38:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBCy6-0003jV-TB
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 18:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291AbYAERh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 12:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755403AbYAERh1
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 12:37:27 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43068 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755009AbYAERh0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jan 2008 12:37:26 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m05HbKGg021514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 5 Jan 2008 09:37:21 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m05HbKTf004164;
	Sat, 5 Jan 2008 09:37:20 -0800
In-Reply-To: <200801051818.40009.jnareb@gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69679>



On Sat, 5 Jan 2008, Jakub Narebski wrote:
> 
> Shouldn't the last block read for the modern git read:
> 
>   ------------------------------------------------
>   :100644 000000 bcd1234... 0123456... M99 file0
>   ------------------------------------------------
> 
> or is it only for '-B' togehter with '-M' or '-C'?

Without -M/C, git re-joins them, so yeah, either the documentation (or 
that re-joining logic) is wrong.

> Second: do you have per chance good examples of broken (and perhaps 
> merged together) pair, such that it is affected by --diff-filter=B;
> with -B<num> or -B<num1>/<num2> parameters needed, if required. COPYING 
> and Makefile are one good example, but do you have literal files with 
> similar behavior? 

Hmm. A kernel example that shows *something* is

	git show -B --raw -r acbbbe9f5ab52da90a8edec02ec973e7f44dae81

which shows 

	:100644 100644 eb14b18... 1f2d6d5... M093       include/asm-x86/byteorder.h

even though that 093 is the *dissimilarity* index, so according to the 
documentation you quote you'd expect it to be

	:100644 000000 eb14b18... 0000000... D	include/asm-x86/byteorder.h
	:000000 100644 0000000... 1f2d6d5... A	include/asm-x86/byteorder.h

instead of a M. Whether it's the docs or the behavior that should be 
changed, I dunno.

Especially as using -B -M makes it all sane again, because then it shows 
it as the real rename:

	:100644 100644 435074a... 26b0dcd... M  include/asm-x86/Kbuild
	:100644 100644 a45470a... 1f2d6d5... R061       include/asm-x86/byteorder_32.h  include/asm-x86/byteorde
	:100644 000000 5e86c86... 0000000... D  include/asm-x86/byteorder_64.h

and it's all good.

My personal opinion is that -B doesn't make much sense without M (or C), 
but at least you can see an example of the breaking behaviour in the 
kernel for a real case.

			Linus
