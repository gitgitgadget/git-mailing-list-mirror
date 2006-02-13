From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling large files with GIT
Date: Sun, 12 Feb 2006 21:05:55 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602122058260.3691@g5.osdl.org>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com> 
 <87slqty2c8.fsf@mid.deneb.enyo.de> <46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com>
 <Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk>
 <Pine.LNX.4.64.0602121939070.3691@g5.osdl.org> <Pine.LNX.4.64.0602122049010.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 06:06:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8Vv4-0005A9-Lm
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 06:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbWBMFG3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 00:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbWBMFG3
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 00:06:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14986 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751571AbWBMFG2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 00:06:28 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1D55uDZ009592
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Feb 2006 21:05:56 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1D55tFe002948;
	Sun, 12 Feb 2006 21:05:55 -0800
To: Ben Clifford <benc@hawaga.org.uk>
In-Reply-To: <Pine.LNX.4.64.0602122049010.3691@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16045>



On Sun, 12 Feb 2006, Linus Torvalds wrote:
> 
> This is a large part of why git performs well on the kernel. Most merges 
> don't actually touch all - or even a very big percentage - of the over 
> thousand subdirectories in the kernel. Git can quickly see and ignore the 
> whole subdirectory when that happens - the SHA1 is exactly the same, so 
> git knows that every file under that subdirectory (and every recursive 
> directory) is the same.

Final note: this means, for example, that git is relatively bad at 
tracking a "hashed" nested file directory (like the one git itself uses), 
because new files will end up randomly appearing in every directory, and 
no directory is ever "stable".

In contrast, if the directory structure is - for example - something where 
you index files by date, and subdirectories with older dates are thus much 
more naturally likely to be quiescent, the "this tree is the same" 
optimizations work very well.

Basically, a lot of the git speed optimizations depend on "on average, 
things stay the same". We may have 18,000+ files in the kernel, but most 
patches will change maybe five of them. There's a lot of fairly static 
content and the changes have a certain level of "locality". It's normally 
a hundred-line patch to one file, not a hundred files that had one-liners. 
And when 20 files are changed, most of them tend to be in the same 
subdirectory, etc etc.

Taking advantage of those kinds of things is what makes git good at 
handling software projects. But it wouldn't necessarily be how you lay out 
a mail directory, for example. An automated file store might want to 
spread out the changes on purpose.

		Linus
