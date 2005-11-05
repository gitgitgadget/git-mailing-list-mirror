From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [GIT PATCH] SCSI updates for 2.6.14
Date: Sat, 5 Nov 2005 11:32:47 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511051119080.3316@g5.osdl.org>
References: <1131207491.3614.5.camel@mulgrave>  <Pine.LNX.4.64.0511050942490.3316@g5.osdl.org>
  <1131214408.3614.11.camel@mulgrave>  <Pine.LNX.4.64.0511051031250.3316@g5.osdl.org>
 <1131216913.3614.15.camel@mulgrave>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 05 20:33:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYTml-0003vW-Qn
	for gcvg-git@gmane.org; Sat, 05 Nov 2005 20:33:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbVKETc4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Nov 2005 14:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbVKETc4
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Nov 2005 14:32:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49836 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932296AbVKETcz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Nov 2005 14:32:55 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA5JWmnO027037
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 5 Nov 2005 11:32:49 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA5JWl0F029490;
	Sat, 5 Nov 2005 11:32:47 -0800
To: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <1131216913.3614.15.camel@mulgrave>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11180>



On Sat, 5 Nov 2005, James Bottomley wrote:
>
> On Sat, 2005-11-05 at 10:42 -0800, Linus Torvalds wrote:
> > James: what's your umask on master? Maybe you've set it to 0077, from the 
> > default 0002?
> 
> I set it to 0022 ... could that be the problem?

No, 0022 should still be perfectly fine, and should result in drwxr-xr-x, 
not your strange things.

Looking at things, I can't imagine it being anything else than a cpio bug 
(or misfeature - I don't know where cpio _could_ get the permissions for 
the intermediate directories from). But that implies that the system git 
shouldn't have mattered, and if you used "git clone -l" with your old git 
it should have done exactly the same thing.

Junio: I just confirmed this. Do a

	git clone -l src dst

with any git, and you'll end up with

	...
	drwx------  2 torvalds torvalds 4096 Nov  5 11:22 de
	drwx------  2 torvalds torvalds 4096 Nov  5 11:22 df
	drwx------  2 torvalds torvalds 4096 Nov  5 11:22 e0
	...
	drwx------  2 torvalds torvalds 4096 Nov  5 11:22 ff
	drwxrwxr-x  2 torvalds torvalds 4096 Nov  5 11:22 info
	drwxrwxr-x  2 torvalds torvalds 4096 Nov  5 11:22 pack

regardless of umask.

Happens with both cpio 2.5 and 2.6. 

I _think_ it's this:

	...
            find objects -type f -print |
            cpio -puamd$l "$D/.git/" || exit 1
	...

and I suspect that if you remove the "-type f" it will just work (because 
it will get the directory permissions from the source). But cpio is black 
magic to me (very un-unixy feel to it, I'd guess it comes from some odd 
other pre-unix OS).

			Linus
